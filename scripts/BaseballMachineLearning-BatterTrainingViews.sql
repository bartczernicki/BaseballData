if object_id('vwMLBBaseballBattersHistorical') is NOT NULL
drop view vwMLBBaseballBattersHistorical
go
create view vwMLBBaseballBattersHistorical
as

select 
	  InductedToHallOfFame, OnHallOfFameBallot, FullPlayerName, 
	  YearsPlayed, AB, R, H, Doubles, Triples, HR, RBI, SB, 
	  BattingAverage, SluggingPct, AllStarAppearances,
	  TB, TotalPlayerAwards,LastYearPlayed, ID
      from dbo.MLBBaseballBatters m

go
/*
select * from vwMLBBaseballBattersHistorical order by LastYearPlayed ASC, ID ASC, YearsPlayed ASC
*/

if object_id('vwMLBBaseballBattersFullTraining') is NOT NULL
drop view vwMLBBaseballBattersFullTraining
go
create view vwMLBBaseballBattersFullTraining
as

select 
		InductedToHallOfFame, OnHallOfFameBallot, FullPlayerName, 
		YearsPlayed, AB, R, H, Doubles, Triples, HR, RBI, SB, 
		BattingAverage, SluggingPct, AllStarAppearances,
		TB, TotalPlayerAwards,LastYearPlayed, ID
      from dbo.MLBBaseballBatters m
	  -- 185 is the minimum AB in the history of MLB that someone appeared on the MLB ballot
	  where m.AB > 185
	  -- MLB BWAA Rules state you need to have been retired at least 5 years from the game
	  -- Also include the shoe ins for the Hall Of Fame
	  AND (m.LastYearPlayed <= 2015 OR m.OnHallOfFameBallot = 'TRUE')

go
/*
select * from vwMLBBaseballBattersFullTraining
*/

if object_id('vwMLBBaseballBattersSplitTraining') is NOT NULL
drop view vwMLBBaseballBattersSplitTraining
go
create view vwMLBBaseballBattersSplitTraining
as

select
		InductedToHallOfFame, OnHallOfFameBallot, FullPlayerName, 
		YearsPlayed, AB, R, H, Doubles, Triples, HR, RBI, SB, 
		BattingAverage, SluggingPct, AllStarAppearances,
		TB, TotalPlayerAwards,LastYearPlayed, ID
from (
select top 100 PERCENT
		b.*,
		row_number() over (order by OnHallOfFameBallot, newid()) as seqnum,
		count(*) over () as cnt,
		count(*) over (partition by OnHallOfFameBallot) as cc_cnt
      from vwMLBBaseballBattersFullTraining b
	  order by LastYearPlayed
	  ) a
where seqnum % (4) != 0

go
/*
select * from vwMLBBaseballBattersSplitTraining
*/

if object_id('vwMLBBaseballBattersSplitTest') is NOT NULL
drop view vwMLBBaseballBattersSplitTest
go
create view vwMLBBaseballBattersSplitTest
as

select
		InductedToHallOfFame, OnHallOfFameBallot, FullPlayerName, 
		YearsPlayed, AB, R, H, Doubles, Triples, HR, RBI, SB, 
		BattingAverage, SluggingPct, AllStarAppearances,
		TB, TotalPlayerAwards,LastYearPlayed, ID
from (
select top 100 PERCENT
		b.*,
		row_number() over (order by OnHallOfFameBallot, newid()) as seqnum,
		count(*) over () as cnt,
		count(*) over (partition by OnHallOfFameBallot) as cc_cnt
      from vwMLBBaseballBattersFullTraining b
	  order by LastYearPlayed
	  ) a
where seqnum % (4) = 0

go
/*
select * from vwMLBBaseballBattersSplitTest
*/