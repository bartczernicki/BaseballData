set nocount on;

-- 1) HALLOFFAME INSERTS

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

-- 2) AWARDSPLAYERS
delete from dbo.AwardsPlayers where 
(yearID > 2017)

insert into dbo.AwardsPlayers
(playerID, awardID, yearID, lgID, tie, notes)
-- ALCS MVP
select 'bradlja02', 'ALCS MVP', 2018, 'AL', NULL, NULL
UNION ALL
select 'altuvjo01', 'ALCS MVP', 2019, 'AL', NULL, NULL
UNION ALL
select 'arozara01', 'ALCS MVP', 2020, 'AL', NULL, NULL
UNION ALL
-- Comeback Player of the Year - AL
select 'priceda01', 'Comeback Player of the Year', 2018, 'AL', NULL, NULL
UNION ALL
select 'carraca01', 'Comeback Player of the Year', 2019, 'AL', NULL, NULL
UNION ALL
select 'arozara01', 'Comeback Player of the Year', 2020, 'AL', NULL, NULL
UNION ALL
-- Comeback Player of the Year - NL
select 'ventejo01', 'Comeback Player of the Year', 2018, 'NL', NULL, NULL
UNION ALL
select 'donaljo02', 'Comeback Player of the Year', 2019, 'NL', NULL, NULL
UNION ALL
select 'perezsa02', 'Comeback Player of the Year', 2020, 'NL', NULL, NULL
UNION ALL
-- Gold Glove - AL & NL - 2018
select 'keuchda01', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'greinza01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
select 'perezsa02', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'molinya01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
select 'olsonma02', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'freemfr01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
select 'kinslia01', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'lemahdj01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
select 'simmoan01', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'ahmedni01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
select 'chapmma01', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'arenano01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
select 'gordoal01', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'dickeco01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
select 'bradlja02', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'inciaen01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
select 'bettsmo01', 'Gold Glove', 2018, 'AL', NULL, NULL
UNION ALL
select 'markani01', 'Gold Glove', 2018, 'NL', NULL, NULL
UNION ALL
-- Gold Glove - AL & NL - 2019
select 'keuchda01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'greinza01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'perezsa02', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'molinya01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'olsonma02', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'freemfr01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'kinslia01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'lemahdj01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'simmoan01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'ahmedni01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'chapmma01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'arenano01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'gordoal01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'dickeco01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'bradlja02', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'inciaen01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'bettsmo01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'markani01', 'Gold Glove', 2019, 'NL', NULL, NULL

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