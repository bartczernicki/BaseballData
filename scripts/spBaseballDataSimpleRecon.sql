if object_id('spBaseballDataSimpleRecon') is NOT NULL
drop proc spBaseballDataSimpleRecon
go

create proc spBaseballDataSimpleRecon
as

set nocount on;


-- Config
DECLARE @ba_scale      int = 3;        -- compare BA rounded to 3 decimals
DECLARE @slg_scale     int = 3;        -- compare SLG rounded to 3 decimals
DECLARE @epsilon       decimal(10,6) = 0.0005;  -- tolerance for float compares

;WITH base AS (
  SELECT
      ID,
      FullPlayerName,
      YearsPlayed,
      AB,
      R,
      H,
      Doubles,
      Triples,
      HR,
      RBI,
      SB,
      BattingAverage       AS BA_stored,
      SluggingPct          AS SLG_stored,
      TB                   AS TB_stored,
      TotalPlayerAwards,
      AllStarAppearances,
      LastYearPlayed,

      -- Components
      CASE 
        WHEN H IS NULL OR Doubles IS NULL OR Triples IS NULL OR HR IS NULL THEN NULL
        ELSE H - (Doubles + Triples + HR)
      END                                      AS Singles,

      -- Recompute Hits from components (Singles + 2B + 3B + HR)
      CASE 
        WHEN H IS NULL OR Doubles IS NULL OR Triples IS NULL OR HR IS NULL THEN NULL
        ELSE (H - (Doubles + Triples + HR)) + Doubles + Triples + HR
      END                                      AS H_recalc_from_parts
  FROM dbo.MLBBaseballBattersHistorical
),
calc AS (
  SELECT
      *,
      -- Recompute TB = 1B + 2*2B + 3*3B + 4*HR = H + 2B + 2*3B + 3*HR? (Simplifies to H + D + 2*T + 3*HR)
      CASE
        WHEN H IS NULL OR Doubles IS NULL OR Triples IS NULL OR HR IS NULL THEN NULL
        ELSE H + Doubles + (2 * Triples) + (3 * HR)
      END                                      AS TB_calc,

      -- Recompute BA, SLG (handle AB = 0)
      CASE
        WHEN AB IS NULL OR AB = 0 OR H IS NULL THEN 0.0
        ELSE CAST(H AS decimal(18,10)) / NULLIF(CAST(AB AS decimal(18,10)), 0)
      END                                      AS BA_calc_raw,

      CASE
        WHEN AB IS NULL OR AB = 0 OR H IS NULL OR Doubles IS NULL OR Triples IS NULL OR HR IS NULL THEN 0.0
        ELSE 
          CAST( (H + Doubles + (2 * Triples) + (3 * HR)) AS decimal(18,10))
          / NULLIF(CAST(AB AS decimal(18,10)), 0)
      END                                      AS SLG_calc_raw
  FROM base
),
rounded AS (
  SELECT
      *,
      -- Rounded values for comparison/display
      ROUND(BA_calc_raw,  @ba_scale)  AS BA_calc,
      ROUND(SLG_calc_raw, @slg_scale) AS SLG_calc
  FROM calc
)
SELECT
    ID,
    FullPlayerName,
    YearsPlayed,
    AB, R, H, Doubles, Triples, HR, RBI, SB,
    TB_stored,
    TB_calc,
    (TB_calc - TB_stored)                          AS TB_delta,

    BA_stored,
    BA_calc,
    CAST( CASE 
            WHEN BA_stored IS NULL AND BA_calc = 0 THEN 1
            WHEN BA_stored IS NULL OR BA_calc IS NULL THEN 0
            WHEN ABS(BA_stored - BA_calc) <= @epsilon THEN 1
            ELSE 0
          END AS bit)                               AS BA_match,

    SLG_stored,
    SLG_calc,
    CAST( CASE 
            WHEN SLG_stored IS NULL AND SLG_calc = 0 THEN 1
            WHEN SLG_stored IS NULL OR SLG_calc IS NULL THEN 0
            WHEN ABS(SLG_stored - SLG_calc) <= @epsilon THEN 1
            ELSE 0
          END AS bit)                               AS SLG_match,

    Singles,
    H_recalc_from_parts,
    (H_recalc_from_parts - H)                      AS H_from_parts_delta,

    -- Sanity checks
    CAST(CASE WHEN AB < 0 OR H < 0 OR Doubles < 0 OR Triples < 0 OR HR < 0 OR TB_stored < 0 THEN 0 ELSE 1 END AS bit) AS NonNegative_ok,
    CAST(CASE WHEN H IS NULL OR Doubles IS NULL OR Triples IS NULL OR HR IS NULL THEN 0
              WHEN H < (Doubles + Triples + HR) THEN 0 ELSE 1 END AS bit)                                             AS Parts_leq_H_ok,
    CAST(CASE WHEN AB IS NULL OR H IS NULL THEN 0
              WHEN H > AB THEN 0 ELSE 1 END AS bit)                                                                    AS H_leq_AB_ok,

    -- Overall status
    CASE 
      WHEN
        (TB_calc = TB_stored OR (TB_calc IS NULL AND TB_stored IS NULL))
        AND (ABS(COALESCE(BA_stored,0) - COALESCE(BA_calc,0)) <= @epsilon)
        AND (ABS(COALESCE(SLG_stored,0) - COALESCE(SLG_calc,0)) <= @epsilon)
        AND (H_recalc_from_parts = H OR (H_recalc_from_parts IS NULL AND H IS NULL))
        AND (AB IS NOT NULL AND H IS NOT NULL AND H <= AB)
        AND NOT (AB < 0 OR H < 0 OR Doubles < 0 OR Triples < 0 OR HR < 0 OR TB_stored < 0)
        AND NOT (H IS NOT NULL AND Doubles IS NOT NULL AND Triples IS NOT NULL AND HR IS NOT NULL AND H < (Doubles + Triples + HR))
      THEN 'OK'
      ELSE 'MISMATCH'
    END                                            AS ReconStatus
FROM rounded
ORDER BY ReconStatus DESC, FullPlayerName;

/* ---------------------------
   Compact mismatch summary
----------------------------*/
SELECT
  ReconStatus,
  COUNT(*) AS PlayerCount
FROM (
  SELECT
    CASE 
      WHEN
        (H + Doubles + (2 * Triples) + (3 * HR)) = TB
        AND (ABS(COALESCE(BattingAverage,0) - ROUND(CASE WHEN AB = 0 THEN 0.0 ELSE CAST(H AS decimal(18,10))/NULLIF(CAST(AB AS decimal(18,10)),0) END, @ba_scale)) <= @epsilon)
        AND (ABS(COALESCE(SluggingPct,0) - ROUND(CASE WHEN AB = 0 THEN 0.0 ELSE CAST( (H + Doubles + (2 * Triples) + (3 * HR)) AS decimal(18,10))/NULLIF(CAST(AB AS decimal(18,10)),0) END, @slg_scale)) <= @epsilon)
        AND H IS NOT NULL AND Doubles IS NOT NULL AND Triples IS NOT NULL AND HR IS NOT NULL
        AND H >= (Doubles + Triples + HR)
        AND AB IS NOT NULL AND H IS NOT NULL AND H <= AB
        AND NOT (AB < 0 OR H < 0 OR Doubles < 0 OR Triples < 0 OR HR < 0 OR TB < 0)
      THEN 'OK'
      ELSE 'MISMATCH'
    END AS ReconStatus
  FROM dbo.MLBBaseballBattersHistorical
) x
GROUP BY ReconStatus;
GO
