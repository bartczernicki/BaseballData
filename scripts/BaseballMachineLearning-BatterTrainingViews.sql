-- Re-Create MLBBaseballBattersHistorical table by dropping and re-inserting to the table
set nocount on;

if object_id('vwMLBBaseballBattersHistorical') is NOT NULL
drop view vwMLBBaseballBattersHistorical
go
create view vwMLBBaseballBattersHistorical as
select
case when (InductedToHallOfFame = 1) then 'TRUE' else 'FALSE' end as InductedToHallOfFame,
case when (OnHallOfFameBallot = 1) then 'TRUE' else 'FALSE' end as OnHallOfFameBallot,
FullPlayerName, PrimaryPositionPlayer,
YearsPlayed, AB, R, H, Doubles, Triples, HR,
ISNULL(RBI, 0 ) as RBI, ISNULL(SB, 0 ) as SB,
CAST(BattingAverage AS DECIMAL(10,3)) as BattingAverage, CAST(SluggingPct AS DECIMAL(10,3)) as SluggingPct,
AllStarAppearances, MVPs, TripleCrowns, GoldGloves, MajorLeaguePlayerOfTheYearAwards,
TB, TotalPlayerAwards, LastYearPlayed,
playerID as ID
from dbo.vwBaseballBattingStats
go

if object_id('MLBBaseballBattersHistorical') is NOT NULL
drop table MLBBaseballBattersHistorical
go
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,
RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed,ID
into dbo.MLBBaseballBattersHistorical
from dbo.vwMLBBaseballBattersHistorical
go

if object_id('MLBBaseballBattersHistoricalPositionPlayers') is NOT NULL
drop table MLBBaseballBattersHistoricalPositionPlayers
go
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,
RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed,ID
into dbo.MLBBaseballBattersHistoricalPositionPlayers
from dbo.vwMLBBaseballBattersHistorical
where (PrimaryPositionPlayer = 1) and FullPlayerName is NOT NULL;
-- select count(*) from MLBBaseballBattersHistoricalPositionPlayers
go

if object_id('MLBBaseballBatters') is NOT NULL
drop table MLBBaseballBatters
go
set nocount on;
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,PrimaryPositionPlayer,YearsPlayed,AB,R,H,Doubles,Triples,HR,
RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed,a.ID
into dbo.MLBBaseballBatters
from dbo.vwMLBBaseballBattersHistorical a
inner join (select ID, max(YearsPlayed) as MaxYearsPlayed from dbo.MLBBaseballBattersHistorical group by ID) b
on a.ID = b.ID and a.YearsPlayed = b.MaxYearsPlayed
go
-- select count(*) from MLBBaseballBatters

if object_id('MLBBaseballBattersPositionPlayers') is NOT NULL
drop table MLBBaseballBattersPositionPlayers
go
set nocount on;
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,
RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed,a.ID
into dbo.MLBBaseballBattersPositionPlayers
from dbo.MLBBaseballBatters a
where (a.PrimaryPositionPlayer = 1) AND FullPlayerName is NOT NULL;
go
-- This is the table used by the current Baseball 
-- select count(*) from MLBBaseballBattersPositionPlayers

if object_id('MLBBaseballBattersFullTraining') is NOT NULL
drop table MLBBaseballBattersFullTraining
go
set nocount on;
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,
RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed,a.ID
into dbo.MLBBaseballBattersFullTraining
from dbo.MLBBaseballBatters a
where (a.PrimaryPositionPlayer = 1) AND
	(a.AB > 400 OR (a.OnHallOfFameBallot = 'TRUE')) AND
	(LastYearPlayed <= 2019) -- IMPORTANT to Update
go
-- select count(*) from MLBBaseballBattersFullTraining

-- Create a training set and a test set:
IF OBJECT_ID('dbo.MLBBaseballBattersSplitTraining','U') IS NOT NULL
    DROP TABLE dbo.MLBBaseballBattersSplitTraining;

IF OBJECT_ID('dbo.MLBBaseballBattersSplitTest','U') IS NOT NULL
    DROP TABLE dbo.MLBBaseballBattersSplitTest;

-- Clean up any leftover temp table
IF OBJECT_ID('tempdb..#split') IS NOT NULL
    DROP TABLE #split;

SET NOCOUNT ON;

-- One-time randomized, stratified assignment (by OnHallOfFameBallot)
SELECT
    b.InductedToHallOfFame, b.OnHallOfFameBallot, b.FullPlayerName, b.YearsPlayed,
    b.AB, b.R, b.H, b.Doubles, b.Triples, b.HR, b.RBI, b.SB,
    b.BattingAverage, b.SluggingPct, b.AllStarAppearances, b.TB,
    b.TotalPlayerAwards, b.LastYearPlayed, b.ID,
    ROW_NUMBER() OVER (PARTITION BY b.OnHallOfFameBallot ORDER BY NEWID()) AS rn,
    COUNT(*) OVER (PARTITION BY b.OnHallOfFameBallot) AS class_cnt
INTO #split
FROM dbo.MLBBaseballBattersFullTraining AS b;

-- Training: ~75%
SELECT
    InductedToHallOfFame, OnHallOfFameBallot, FullPlayerName, YearsPlayed,
    AB, R, H, Doubles, Triples, HR, RBI, SB, BattingAverage, SluggingPct,
    AllStarAppearances, TB, TotalPlayerAwards, LastYearPlayed, ID
INTO dbo.MLBBaseballBattersSplitTraining
FROM #split
WHERE rn <= CEILING(0.75 * class_cnt);

-- Test: ~25%
SELECT
    InductedToHallOfFame, OnHallOfFameBallot, FullPlayerName, YearsPlayed,
    AB, R, H, Doubles, Triples, HR, RBI, SB, BattingAverage, SluggingPct,
    AllStarAppearances, TB, TotalPlayerAwards, LastYearPlayed, ID
INTO dbo.MLBBaseballBattersSplitTest
FROM #split
WHERE rn > CEILING(0.75 * class_cnt);

/*
-- Optional sanity checks:
 SELECT 'train' AS which, COUNT(*) FROM dbo.MLBBaseballBattersSplitTraining
 UNION ALL
 SELECT 'test'  AS which, COUNT(*) FROM dbo.MLBBaseballBattersSplitTest;

 -- Check to make sure no player is left behind:
select * from MLBBaseballBattersFullTraining
where InductedToHallOfFame = 'TRUE'
AND ID NOT IN
(
select ID from MLBBaseballBattersSplitTraining
where InductedToHallOfFame = 'TRUE'
UNION ALL
select ID from MLBBaseballBattersSplitTest
where InductedToHallOfFame = 'TRUE'
)
order by FullPlayerName
 */
