:: =========================================
:: BCP Export Script for MLB Baseball Tables
:: =========================================

setlocal EnableExtensions EnableDelayedExpansion

:: Set connection info
SET SERVERNAME=tcp:[SERVER].database.windows.net,1433
SET DATABASE=
SET USERNAME=
SET PASSWORD=

:: Output directory (change as needed)
SET OUTDIR=C:\Users\BartAIServer\Downloads\

:: Ensure tools exist in PATH (optional, comment out if not needed)
where sqlcmd >nul 2>nul || (echo ERROR: sqlcmd not found in PATH.& goto :eof)
where bcp    >nul 2>nul || (echo ERROR: bcp not found in PATH.& goto :eof)

:: Make sure output dir exists
if not exist "%OUTDIR%" mkdir "%OUTDIR%"

:: ====== TABLE LIST ======
for %%T in (
  MLBBaseballBatters
  MLBBaseballBattersFullTraining
  MLBBaseballBattersHistorical
  MLBBaseballBattersHistoricalPositionPlayers
  MLBBaseballBattersPositionPlayers
  MLBBaseballBattersSplitTest
  MLBBaseballBattersSplitTraining
) do (
  echo Exporting %%T...

  set "CSV=%OUTDIR%\%%T.csv"
  set "TMP=%OUTDIR%\%%T.tmp"

  :: --- 1) Write header row (ordered by column_id) ---
  :: Using FOR XML to preserve order (works on all supported SQL Server versions)
  sqlcmd -S "%SERVERNAME%" -d "%DATABASE%" %AUTH% -h -1 -W -Q ^
    "SET NOCOUNT ON;
     SELECT STUFF((
       SELECT ',' + QUOTENAME(c.name, '\"')
       FROM sys.columns c
       WHERE c.object_id = OBJECT_ID('dbo.%%T')
       ORDER BY c.column_id
       FOR XML PATH(''), TYPE).value('.','nvarchar(max)'),1,1,'');" ^
    > "%CSV%"

  if errorlevel 1 (
    echo ERROR: Failed to write header for table %%T
    del /q "%CSV%" >nul 2>nul
    goto :continueLoop
  )

  :: --- 2) Export data rows to temp file ---
  del /q "%TMP%" >nul 2>nul
  bcp "SELECT * FROM dbo.%%T" queryout "%TMP%" -c -t"," -S "%SERVERNAME%" -d "%DATABASE%" %AUTH%
  if errorlevel 1 (
    echo ERROR: BCP failed for table %%T
    del /q "%TMP%" >nul 2>nul
    goto :continueLoop
  )

  :: If tmp has size > 0, append to CSV
  for %%Z in ("%TMP%") do if %%~zZ gtr 0 (
    type "%TMP%" >> "%CSV%"
  ) else (
    echo (Note) Table %%T has no data rows.
  )

  del /q "%TMP%" >nul 2>nul
  :continueLoop
)

echo Done!
endlocal
