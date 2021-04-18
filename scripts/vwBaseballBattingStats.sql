/*
SQL Server, Azure SQL Compatible View that creates historical batting statistics for MLB players
Note: Baseline is the Sean Lahman database.
*/

if object_id('vwBaseballBattingStats') is NOT NULL
drop view vwBaseballBattingStats
go

create view vwBaseballBattingStats as
select distinct
m.playerID,
(m.nameFirst + ' ' + m.nameLast) as FullPlayerName,
case when (primaryPitcherBatters.playerID is NULL) then 1 else 0 end as PrimaryPositionPlayer,
case when ((h.inducted = 'Y' and h.votedBy IN ('BBWAA', 'Special Election', 'Run Off', 'CUSTOM'))) then 1 else 0 end as InductedToHallOfFame,
case when ((hofvote.playerID is NOT NULL)) then 1 else 0 end as OnHallOfFameBallot,
hofvote.MaxBallotVotePercentage,
dense_rank() OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'YearsPlayed',
sum(b.AB) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'AB',
sum(b.R) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'R',
sum(b.H) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'H',
sum(b.[2B]) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'Doubles',
sum(b.[3B]) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'Triples',
sum(b.HR) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'HR',
sum(b.RBI) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'RBI',
sum(b.SB) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'SB',
sum(b.BB) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'BB',
sum((b.H-b.[2b]-b.[3b]-b.[HR]) + 2*(b.[2B]) + 3*(b.[3B]) + 4*(b.HR)) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) as 'TB',
case when (sum(b.AB) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) > 0) then
(
	sum(b.H) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID)
	/
	(convert(decimal, sum(b.AB) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID)))
)
else 0.0 end as 'BattingAverage',
case when (sum(b.AB) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) > 0) then
(
	(
	sum(b.H) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) -
	sum(b.HR) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) -
	sum(b.[3B]) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) -
	sum(b.[2B]) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) +
	2*sum(b.[2B]) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) +
	3*sum(b.[3B]) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID) +
	4*sum(b.HR) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID)
	)
	/
	(convert(decimal, sum(b.AB) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID)))
)
else 0.0 end as 'SluggingPct',
coalesce(sum(totalPlayerAwards.TotalPlayerAwardsCount) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID), 0) as 'TotalPlayerAwards',
coalesce(sum(mvp.MvpCount) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID), 0) as 'MVPs',
coalesce(sum(allStar.AllStarCount) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID), 0) as 'AllStarAppearances',
coalesce(sum(tripleCrown.TripleCrownCount) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID), 0) as 'TripleCrowns',
coalesce(sum(goldGlove.GoldGloveCount) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID), 0) as 'GoldGloves',
coalesce(sum(silverSlugger.SilverSluggerCount) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID), 0) as 'SilverSluggerAwards',
coalesce(sum(majorLeaguePlayerOfTheYear.MajorLeaguePlayerOfTheYearCount) OVER (PARTITION BY m.playerID ORDER BY m.playerID, b.yearID), 0) as 'MajorLeaguePlayerOfTheYearAwards',
max(b.yearID) OVER (PARTITION BY m.playerID ORDER BY m.playerID) as LastYearPlayed,
max(b.AB) OVER (PARTITION BY m.playerID ORDER BY m.playerID) as MaxAB
from
dbo.People2020 m inner join dbo.Batting2020 b on (m.playerID = b.playerId)
left outer join (SELECT distinct playerID, max(votes/convert(decimal, needed)) as MaxBallotVotePercentage
FROM dbo.HallOfFame where category = 'Player' and votedBy IN ('BBWAA', 'Special Election', 'Run Off', 'CUSTOM')
group by playerID) hofvote on (m.playerID = hofvote.playerID)
-- Hall Of Fame
left outer join (
select *
from dbo.HallOfFame where inducted = 'Y' and category = 'Player') h on (m.playerID = h.playerID)
-- Total TotalPlayerAwards
left outer join (
select playerID, yearID, count(awardID) as TotalPlayerAwardsCount
from dbo.AwardsPlayers
group by playerID, yearID) totalPlayerAwards on (m.playerId = totalPlayerAwards.playerId AND b.yearID = totalPlayerAwards.yearID)
-- MVPs
left outer join (
select playerID, yearID, count(awardID) as MvpCount
from dbo.AwardsPlayers where AwardID = 'Most Valuable Player'
group by playerID, yearID) mvp on (m.playerId = mvp.playerId AND b.yearID = mvp.yearID)
-- Triple Crown
left outer join (
select playerID, yearID, count(awardID) as TripleCrownCount
from dbo.AwardsPlayers where AwardID = 'Triple Crown'
group by playerID, yearID) tripleCrown on (m.playerId = tripleCrown.playerId AND b.yearID = tripleCrown.yearID)
-- AllStar Count
left outer join (
select playerID, yearID, count(distinct yearID) as AllStarCount
from dbo.AllStarFull
group by playerID, yearID) allstar on (m.playerId = allstar.playerId AND b.yearID = allstar.yearID)
-- Gold Glove
left outer join (
select playerID, yearID, count(awardID) as GoldGloveCount
from dbo.AwardsPlayers where AwardID = 'Gold Glove'
group by playerID, yearID) goldGlove on (m.playerId = goldGlove.playerId AND b.yearID = goldGlove.yearID)
-- Silver Slugger
left outer join (
select playerID, yearID, count(awardID) as SilverSluggerCount
from dbo.AwardsPlayers where AwardID = 'Silver Slugger'
group by playerID, yearID) silverSlugger on (m.playerId = silverSlugger.playerId AND b.yearID = silverSlugger.yearID)
---- Major League Player of the Year
left outer join (
select playerID, yearID, count(awardID) as MajorLeaguePlayerOfTheYearCount
from dbo.AwardsPlayers where AwardID = 'TSN Major League Player of the Year'
group by playerID, yearID) majorLeaguePlayerOfTheYear on (m.playerId = majorLeaguePlayerOfTheYear.playerId AND b.yearID = majorLeaguePlayerOfTheYear.yearID)
left outer join (
	select playerID from
	(
	select f2.*, f2.PitchingGames/convert(decimal, (coalesce(f1.NonPitchingGames, 0) + f2.PitchingGames)) as PitchingRatio
	from
	(select playerID, sum(G) as NonPitchingGames from dbo.Fielding where POS != 'P' group by playerID) as f1 right outer join
	(select playerID, sum(G) as PitchingGames from dbo.Fielding where POS = 'P' group by playerID) as f2
	on f1.playerID = f2.playerID
	where
	f2.PitchingGames/convert(decimal, (coalesce(f1.NonPitchingGames, 0) + f2.PitchingGames)) > 0.65
	) as PrimaryPitchers
) primaryPitcherBatters on (m.playerID = primaryPitcherBatters.playerID)
go

-- Re-Create MLBBaseballBattersHistorical table by dropping and re-inserting to the table
set nocount on;

if object_id('MLBBaseballBattersHistorical') is NOT NULL
drop table MLBBaseballBattersHistorical
go
select
case when (InductedToHallOfFame = 1) then 'TRUE' else 'FALSE' end as InductedToHallOfFame,
case when (OnHallOfFameBallot = 1) then 'TRUE' else 'FALSE' end as OnHallOfFameBallot,
FullPlayerName, YearsPlayed, AB, R, H, Doubles, Triples, HR,
ISNULL(RBI, 0 ) as RBI, ISNULL(SB, 0 ) as SB,
CAST(BattingAverage AS DECIMAL(10,3)) as BattingAverage, CAST(SluggingPct AS DECIMAL(10,3)) as SluggingPct,
AllStarAppearances, MVPs, TripleCrowns, GoldGloves, MajorLeaguePlayerOfTheYearAwards,
TB, TotalPlayerAwards, LastYearPlayed,
playerID as ID
--, playerID
into dbo.MLBBaseballBattersHistorical
from dbo.vwBaseballBattingStats
go

/*
if object_id('BaseballHOFValidationInBBWAVoting') is NOT NULL
drop table BaseballHOFValidationInBBWAVoting
go
select * into BaseballHOFValidationInBBWAVoting
from dbo.BaseballDataInBBWAVoting
where
InductedToHallOfFame = 'TRUE' and ID % 3 = 0
order by LastYearPlayed asc;
go
insert into BaseballHOFValidationInBBWAVoting
select * from dbo.BaseballDataInBBWAVoting
where
InductedToHallOfFame = 'FALSE' and ID % 3 = 0
order by LastYearPlayed asc;

if object_id('BaseballHOFTrainingInBBWAVoting') is NOT NULL
drop table BaseballHOFTrainingInBBWAVoting
go
select * into BaseballHOFTrainingInBBWAVoting
from dbo.BaseballDataInBBWAVoting
where
InductedToHallOfFame = 'TRUE' and ID % 3 != 0
order by LastYearPlayed asc;
go
insert into BaseballHOFTrainingInBBWAVoting
select * from dbo.BaseballDataInBBWAVoting
where
InductedToHallOfFame = 'FALSE' and ID % 3 != 0
order by LastYearPlayed asc;
*/
-- select count(*) as 'MLBBaseballBattersHistorical - Count' from MLBBaseballBattersHistorical

/*
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,RBI,SB,BattingAverage,SluggingPct,
AllStarAppearances,MVPs,TripleCrowns,GoldGloves,MajorLeaguePlayerOfTheYearAwards,TB,TotalPlayerAwards,LastYearPlayed,ID
from MLBBaseballBattersHistorical
order by InductedToHallOfFame DESC, LastYearPlayed ASC
*/

/*
select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,RBI,SB,BattingAverage,SluggingPct,
AllStarAppearances,MVPs,TripleCrowns,GoldGloves,MajorLeaguePlayerOfTheYearAwards,TB,TotalPlayerAwards,LastYearPlayed,ID
from BaseballHOFTrainingFull

select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,RBI,SB,BattingAverage,SluggingPct,
AllStarAppearances,MVPs,TripleCrowns,GoldGloves,MajorLeaguePlayerOfTheYearAwards,TB,TotalPlayerAwards,LastYearPlayed,ID
from BaseballHOFTraining

select
InductedToHallOfFame,OnHallOfFameBallot,FullPlayerName,YearsPlayed,AB,R,H,Doubles,Triples,HR,RBI,SB,BattingAverage,SluggingPct,
AllStarAppearances,MVPs,TripleCrowns,GoldGloves,MajorLeaguePlayerOfTheYearAwards,TB,TotalPlayerAwards,LastYearPlayed,ID
from BaseballHOFTest
*/



/* TESTS

-- verify no NULLs
select * from dbo.MLBBaseballBatters
order by LastYearPlayed

-- Spot Test custom votes and new inserts
select * from MLBBaseballBattersHistorical where FullPlayerName IN
('Derek Jeter', 'Larry Walker', 'Edgar Martinez', 'Barry Bonds', 'Miguel Cabrera',
'Mike Trout', 'Lou Gehrig', 'Roberto Clemente', 'Alan Trammell', 'Nellie Fox', 'Honus Wagner')

-- Spot Test new OnBallot Inserts
select * from MLBBaseballBatters where FullPlayerName IN
('Todd Helton', 'Jason Bay', 'Travis Hafner', 'Rick Ankiel', 'Juan Pierre',
'Bobby Abreu', 'Chone Figgins', 'Adam Dunn', 'Raul Ibanez', 'Carlos Pena')

select count(*) from dbo.MLBBaseballBatters
select count(*) from dbo.BaseballHOFTrainingFull
select count(*) from dbo.BaseballHOFTraining
select count(*) from dbo.BaseballHOFTest

select playerID, * from dbo.BaseballDataFull where playerID IN (
    select playerID from dbo.tempTestVeteransInductedPlayers
) order by AllStarAppearances desc
*/
