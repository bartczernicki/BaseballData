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
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,PrimaryPositionPlayer,YearsPlayed,AB,R,H,Doubles,Triples,HR,
RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed,ID
into dbo.MLBBaseballBattersHistorical
from dbo.vwMLBBaseballBattersHistorical
go

if object_id('MLBBaseballBattersHistoricalPositionPlayers') is NOT NULL
drop table MLBBaseballBattersHistoricalPositionPlayers
go
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,PrimaryPositionPlayer,YearsPlayed,AB,R,H,Doubles,Triples,HR,
RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed,ID
into dbo.MLBBaseballBattersHistoricalPositionPlayers
from dbo.vwMLBBaseballBattersHistorical
where (PrimaryPositionPlayer = 1)
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
where (a.PrimaryPositionPlayer = 1)
go
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
	(LastYearPlayed <= 2016)
go
-- select count(*) from MLBBaseballBattersFullTraining

if object_id('MLBBaseballBattersSplitTraining') is NOT NULL
drop table MLBBaseballBattersSplitTraining
go
set nocount on;
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed, a.ID
into dbo.MLBBaseballBattersSplitTraining
from (
select top 100 PERCENT
		b.*,
		row_number() over (order by OnHallOfFameBallot, newid()) as seqnum,
		count(*) over () as cnt,
		count(*) over (partition by OnHallOfFameBallot) as cc_cnt
      from dbo.MLBBaseballBattersFullTraining b
	  order by LastYearPlayed
	  ) a
where seqnum % (4) != 0
-- select count(*) from MLBBaseballBattersSplitTraining

if object_id('MLBBaseballBattersSplitTest') is NOT NULL
drop table MLBBaseballBattersSplitTest
go
set nocount on;
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,RBI,SB,BattingAverage,SluggingPct,AllStarAppearances,TB,TotalPlayerAwards,LastYearPlayed, a.ID
into dbo.MLBBaseballBattersSplitTest
from (
select top 100 PERCENT
		b.*,
		row_number() over (order by OnHallOfFameBallot, newid()) as seqnum,
		count(*) over () as cnt,
		count(*) over (partition by OnHallOfFameBallot) as cc_cnt
      from dbo.MLBBaseballBattersFullTraining b
	  order by LastYearPlayed
	  ) a
where seqnum % (4) = 0
go
-- select count(*) from MLBBaseballBattersSplitTest
