set nocount on;

-- DELETE the HallOFame Batters (Inserted Below)
delete from dbo.HallOfFame where 
(yearID = 2019 OR yearID = 2020 OR yearID = 2050)

-- REMOVE jonesja05 (error in Lahman)
delete from dbo.HallOfFame where
playerID = 'jonesja05'
-- Julio Franco is the person on ballot not the other one
update dbo.HallOfFame
set playerID = 'francju01'
where playerID = 'francju02'

-- INSERT HallOfFame
-- OnBallots that did not get in
insert into dbo.HallOfFame
(playerID, yearID, votedBy, ballots, needed, votes, inducted, category, needed_note)
select 'heltoto01', 2019, 'BBWAA', 425, 319, 70, 'N', 'player', NULL
UNION ALL
select 'youngmi02', 2019, 'BBWAA', 425, 319, 9, 'N', 'player', NULL
UNION ALL
select 'berkmla01', 2019, 'BBWAA', 425, 319, 5, 'N', 'player', NULL
UNION ALL
select 'tejadmi01', 2019, 'BBWAA', 425, 319, 5, 'N', 'player', NULL
UNION ALL
select 'polanpl01', 2019, 'BBWAA', 425, 319, 2, 'N', 'player', NULL
UNION ALL
select 'hafnetr01', 2019, 'BBWAA', 425, 319, 0, 'N', 'player', NULL
UNION ALL
select 'youklke01', 2019, 'BBWAA', 425, 319, 0, 'N', 'player', NULL
UNION ALL
select 'ankieri01', 2019, 'BBWAA', 425, 319, 0, 'N', 'player', NULL
UNION ALL
select 'wellsve01', 2019, 'BBWAA', 425, 319, 0, 'N', 'player', NULL
UNION ALL
select 'bayja01', 2019, 'BBWAA', 425, 319, 0, 'N', 'player', NULL
UNION ALL
select 'pierrju01', 2019, 'BBWAA', 425, 319, 0, 'N', 'player', NULL
UNION ALL
select 'abreubo01', 2020, 'BBWAA', 400, 300, 22, 'N', 'player', NULL
UNION ALL
select 'konerpa01', 2020, 'BBWAA', 400, 300, 10, 'N', 'player', NULL
UNION ALL
select 'giambja01', 2020, 'BBWAA', 400, 300, 6, 'N', 'player', NULL
UNION ALL
select 'soriaal01', 2020, 'BBWAA', 400, 300, 6, 'N', 'player', NULL
UNION ALL
select 'chaveer01', 2020, 'BBWAA', 400, 300, 2, 'N', 'player', NULL
UNION ALL
select 'ibanera01', 2020, 'BBWAA', 400, 300, 1, 'N', 'player', NULL
UNION ALL
select 'dunnad01', 2020, 'BBWAA', 400, 300, 1, 'N', 'player', NULL
UNION ALL
select 'penaca01', 2020, 'BBWAA', 400, 300, 0, 'N', 'player', NULL
UNION ALL
select 'furcara01', 2020, 'BBWAA', 400, 300, 0, 'N', 'player', NULL
UNION ALL
select 'roberbr01', 2020, 'BBWAA', 400, 300, 0, 'N', 'player', NULL
UNION ALL
select 'figgich01', 2020, 'BBWAA', 400, 300, 0, 'N', 'player', NULL

-- INSERT HallOfFame
-- Edgar Martinez, Derek Jeter, Larry Walker - 2019
insert into dbo.HallOfFame
(playerID, yearID, votedBy, ballots, needed, votes, inducted, category, needed_note)
select 'martied01', 2019, 'BBWAA', 422, 317, 363, 'Y', 'player', NULL
UNION ALL
select 'walkela01', 2020, 'BBWAA', 422, 317, 304, 'Y', 'player', NULL
UNION ALL
select 'jeterde01', 2020, 'BBWAA', 422, 317, 396, 'Y', 'player', NULL
go
-- INSERT HallOfFame
-- Pete Rose, Rafeal Pameiro, Barry Bonds, Alex Rodriguez, Miguel Cabrera
-- Mark McGwire, Sammy Sosa, Manny Ramirez, Albert Pujols, Ichiro Suzuki, David Ortiz
insert into dbo.HallOfFame
(playerID, yearID, votedBy, ballots, needed, votes, inducted, category, needed_note)
select 'rosepe01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'palmera01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'bondsba01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'rodrial01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'cabremi01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'mcgwima01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'sosasa01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'ramirma02', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'suzukic01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
UNION ALL
select 'ortizda01', 2050, 'CUSTOM', 422, 422, 422, 'Y', 'player', NULL
go

/* Verify
select * from dbo.HallOfFame where yearID >= 2019 order by yearID;

select * from people where nameLast = 'Martinez' and nameFirst = 'Edgar'
UNION ALL
select * from people where nameLast = 'Walker' and nameFirst = 'Larry'
UNION ALL
select * from people where nameLast = 'Jeter' and nameFirst = 'Derek'
UNION ALL
select * from people where nameLast = 'Cabrera' and nameFirst = 'Miguel'
UNION ALL
select * from people where nameLast = 'Trammell' and nameFirst = 'Alan'
UNION ALL
select * from people where nameLast = 'Trout' and nameFirst = 'Mike'
*/