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
select 'olsonma02', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'rizzoan01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'sanchca01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'wongko01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'lindofr01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'ahmedni01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'chapmma01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'arenano01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'gordoal01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'peralda01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'kiermke01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'cainlo01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'bettsmo01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'bellico01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'perezro02', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'realmjt01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
select 'leakemi01', 'Gold Glove', 2019, 'AL', NULL, NULL
UNION ALL
select 'greinza01', 'Gold Glove', 2019, 'NL', NULL, NULL
UNION ALL
-- Gold Glove - AL & NL - 2020
select 'whiteev01', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'rizzoan01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
select 'hernace02', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'wongko01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
select 'crawfjp01', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'baezja01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
select 'kineris01', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'arenano01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
select 'gordoal01', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'oneilty01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
select 'roberlu01', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'grishtr01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
select 'gallojo01', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'bellico01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
select 'perezro02', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'barnhtu01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
select 'cannigr01', 'Gold Glove', 2020, 'AL', NULL, NULL
UNION ALL
select 'friedma01', 'Gold Glove', 2020, 'NL', NULL, NULL
UNION ALL
-- Hank Aaron Award - AL & NL
select 'martijd02', 'Hank Aaron Award', 2018, 'AL', NULL, NULL
UNION ALL
select 'yelicch01', 'Hank Aaron Award', 2018, 'NL', NULL, NULL
UNION ALL
select 'troutmi01', 'Hank Aaron Award', 2019, 'AL', NULL, NULL
UNION ALL
select 'yelicch01', 'Hank Aaron Award', 2019, 'NL', NULL, NULL
UNION ALL
select 'abreujo01', 'Hank Aaron Award', 2020, 'AL', NULL, NULL
UNION ALL
select 'freemfr01', 'Hank Aaron Award', 2020, 'NL', NULL, NULL
UNION ALL
-- Most Valuable Player - AL & NL
select 'bettsmo01', 'Most Valuable Player', 2018, 'AL', NULL, NULL
UNION ALL
select 'yelicch01', 'Most Valuable Player', 2018, 'NL', NULL, NULL
UNION ALL
select 'troutmi01', 'Most Valuable Player', 2019, 'AL', NULL, NULL
UNION ALL
select 'bellico01', 'Most Valuable Player', 2019, 'NL', NULL, NULL
UNION ALL
select 'abreujo01', 'Most Valuable Player', 2020, 'AL', NULL, NULL
UNION ALL
select 'freemfr01', 'Most Valuable Player', 2020, 'NL', NULL, NULL
UNION ALL
-- NLCS MVP
select 'bellico01', 'NLCS MVP', 2018, 'NL', NULL, NULL
UNION ALL
select 'kendrho01', 'NLCS MVP', 2019, 'NL', NULL, NULL
UNION ALL
select 'seageco01', 'NLCS MVP', 2020, 'NL', NULL, NULL
UNION ALL
-- Roberto Clemente Award
select 'molinya01', 'Roberto Clemente Award', 2018, 'NL', NULL, NULL
UNION ALL
select 'carraca01', 'Roberto Clemente Award', 2019, 'NL', NULL, NULL
UNION ALL
select 'wainwad01', 'Roberto Clemente Award', 2020, 'NL', NULL, NULL
UNION ALL
-- Rookie of the Year - AL & NL
select 'ohtansh01', 'Rookie of the Year', 2018, 'AL', NULL, NULL
UNION ALL
select 'acunaro01', 'Rookie of the Year', 2018, 'NL', NULL, NULL
UNION ALL
select 'alvaryo01', 'Rookie of the Year', 2019, 'AL', NULL, NULL
UNION ALL
select 'alonspe01', 'Rookie of the Year', 2019, 'NL', NULL, NULL
UNION ALL
select 'lewisky01', 'Rookie of the Year', 2020, 'AL', NULL, NULL
UNION ALL
select 'willide03', 'Rookie of the Year', 2020, 'NL', NULL, NULL
UNION ALL
-- Silver Slugger - AL & NL - 2018
select 'abreujo02', 'Silver Slugger', 2018, 'AL', NULL, '1B'
UNION ALL
select 'goldspa01', 'Silver Slugger', 2018, 'NL', NULL, '1B'
UNION ALL
select 'altuvjo01', 'Silver Slugger', 2018, 'AL', NULL, '2B'
UNION ALL
select 'baezja01', 'Silver Slugger', 2018, 'NL', NULL, '2B'
UNION ALL
select 'ramirjo01', 'Silver Slugger', 2018, 'AL', NULL, '3B'
UNION ALL
select 'arenano01', 'Silver Slugger', 2018, 'NL', NULL, '3B'
UNION ALL
select 'lindofr01', 'Silver Slugger', 2018, 'AL', NULL, 'SS'
UNION ALL
select 'storytr01', 'Silver Slugger', 2018, 'NL', NULL, 'SS'
UNION ALL
select 'bettsmo01', 'Silver Slugger', 2018, 'AL', NULL, 'OF'
UNION ALL
select 'markani01', 'Silver Slugger', 2018, 'NL', NULL, 'OF'
UNION ALL
select 'troutmi01', 'Silver Slugger', 2018, 'AL', NULL, 'OF'
UNION ALL
select 'peralda01', 'Silver Slugger', 2018, 'NL', NULL, 'OF'
UNION ALL
select 'martijd02', 'Silver Slugger', 2018, 'AL', NULL, 'OF'
UNION ALL
select 'yelicch01', 'Silver Slugger', 2018, 'NL', NULL, 'OF'
UNION ALL
select 'perezsa02', 'Silver Slugger', 2018, 'AL', NULL, 'C'
UNION ALL
select 'realmjt01', 'Silver Slugger', 2018, 'NL', NULL, 'C'
UNION ALL
select 'martijd02', 'Silver Slugger', 2018, 'AL', NULL, 'DH'
UNION ALL
select 'marquge01', 'Silver Slugger', 2018, 'NL', NULL, 'DH'
UNION ALL
-- Silver Slugger - AL & NL - 2019
select 'santaca01', 'Silver Slugger', 2019, 'AL', NULL, '1B'
UNION ALL
select 'freemfr01', 'Silver Slugger', 2019, 'NL', NULL, '1B'
UNION ALL
select 'lemahdj01', 'Silver Slugger', 2019, 'AL', NULL, '2B'
UNION ALL
select 'albieoz01', 'Silver Slugger', 2019, 'NL', NULL, '2B'
UNION ALL
select 'bregmal01', 'Silver Slugger', 2019, 'AL', NULL, '3B'
UNION ALL
select 'rendoan01', 'Silver Slugger', 2019, 'NL', NULL, '3B'
UNION ALL
select 'bogaexa01', 'Silver Slugger', 2019, 'AL', NULL, 'SS'
UNION ALL
select 'storytr01', 'Silver Slugger', 2019, 'NL', NULL, 'SS'
UNION ALL
select 'bettsmo01', 'Silver Slugger', 2019, 'AL', NULL, 'OF'
UNION ALL
select 'acunaro01', 'Silver Slugger', 2019, 'NL', NULL, 'OF'
UNION ALL
select 'troutmi01', 'Silver Slugger', 2019, 'AL', NULL, 'OF'
UNION ALL
select 'bellico01', 'Silver Slugger', 2019, 'NL', NULL, 'OF'
UNION ALL
select 'springe01', 'Silver Slugger', 2019, 'AL', NULL, 'OF'
UNION ALL
select 'yelicch01', 'Silver Slugger', 2019, 'NL', NULL, 'OF'
UNION ALL
select 'garvemi01', 'Silver Slugger', 2019, 'AL', NULL, 'C'
UNION ALL
select 'realmjt01', 'Silver Slugger', 2019, 'NL', NULL, 'C'
UNION ALL
select 'bettsmo01', 'Silver Slugger', 2019, 'AL', NULL, 'DH'
UNION ALL
select 'greinza01', 'Silver Slugger', 2019, 'NL', NULL, 'DH'
UNION ALL
-- Silver Slugger - AL & NL - 2020
select 'abreujo02', 'Silver Slugger', 2020, 'AL', NULL, '1B'
UNION ALL
select 'freemfr01', 'Silver Slugger', 2020, 'NL', NULL, '1B'
UNION ALL
select 'lemahdj01', 'Silver Slugger', 2020, 'AL', NULL, '2B'
UNION ALL
select 'solando01', 'Silver Slugger', 2020, 'NL', NULL, '2B'
UNION ALL
select 'ramirjo01', 'Silver Slugger', 2020, 'AL', NULL, '3B'
UNION ALL
select 'machama01', 'Silver Slugger', 2020, 'NL', NULL, '3B'
UNION ALL
select 'anderti01', 'Silver Slugger', 2020, 'AL', NULL, 'SS'
UNION ALL
select 'tatisfe02', 'Silver Slugger', 2020, 'NL', NULL, 'SS'
UNION ALL
select 'jimenel02', 'Silver Slugger', 2020, 'AL', NULL, 'OF'
UNION ALL
select 'sotoju01', 'Silver Slugger', 2020, 'NL', NULL, 'OF'
UNION ALL
select 'troutmi01', 'Silver Slugger', 2020, 'AL', NULL, 'OF'
UNION ALL
select 'acunaro01', 'Silver Slugger', 2020, 'NL', NULL, 'OF'
UNION ALL
select 'hernate01', 'Silver Slugger', 2020, 'AL', NULL, 'OF'
UNION ALL
select 'bettsmo01', 'Silver Slugger', 2020, 'NL', NULL, 'OF'
UNION ALL
select 'perezsa02', 'Silver Slugger', 2020, 'AL', NULL, 'C'
UNION ALL
select 'darnatr01', 'Silver Slugger', 2020, 'NL', NULL, 'C'
UNION ALL
select 'bettsmo01', 'Silver Slugger', 2020, 'AL', NULL, 'DH'
UNION ALL
select 'ozunama01', 'Silver Slugger', 2020, 'NL', NULL, 'DH'
UNION ALL
-- TSN All-Star - NL - 2018
select 'contrwi01', 'TSN All-Star', 2018, 'NL', NULL, 'C'
UNION ALL
select 'molinya01', 'TSN All-Star', 2018, 'NL', NULL, 'C'
UNION ALL
select 'poseybu01', 'TSN All-Star', 2018, 'NL', NULL, 'C'
UNION ALL
select 'realmjt01', 'TSN All-Star', 2018, 'NL', NULL, 'C'
UNION ALL
select 'freemfr01', 'TSN All-Star', 2018, 'NL', NULL, '1B'
UNION ALL
select 'aguilje01', 'TSN All-Star', 2018, 'NL', NULL, '1B'
UNION ALL
select 'goldspa01', 'TSN All-Star', 2018, 'NL', NULL, '1B'
UNION ALL
select 'vottojo01', 'TSN All-Star', 2018, 'NL', NULL, '1B'
UNION ALL
select 'baezja01', 'TSN All-Star', 2018, 'NL', NULL, '2B'
UNION ALL
select 'albieoz01', 'TSN All-Star', 2018, 'NL', NULL, '2B'
UNION ALL
select 'gennesc01', 'TSN All-Star', 2018, 'NL', NULL, '2B'
UNION ALL
select 'arenano01', 'TSN All-Star', 2018, 'NL', NULL, '3B'
UNION ALL
select 'suareeu01', 'TSN All-Star', 2018, 'NL', NULL, '3B'
UNION ALL
select 'crawfbr01', 'TSN All-Star', 2018, 'NL', NULL, 'SS'
UNION ALL
select 'storytr01', 'TSN All-Star', 2018, 'NL', NULL, 'SS'
UNION ALL
select 'markani01', 'TSN All-Star', 2018, 'NL', NULL, 'OF'
UNION ALL
select 'kempma01', 'TSN All-Star', 2018, 'NL', NULL, 'OF'
UNION ALL
select 'harpebr03', 'TSN All-Star', 2018, 'NL', NULL, 'OF'
UNION ALL
select 'blackch02', 'TSN All-Star', 2018, 'NL', NULL, 'OF'
UNION ALL
select 'cainlo01', 'TSN All-Star', 2018, 'NL', NULL, 'OF'
UNION ALL
select 'yelicch01', 'TSN All-Star', 2018, 'NL', NULL, 'OF'
UNION ALL
-- TSN All-Star - AL - 2018
select 'ramoswi01', 'TSN All-Star', 2018, 'AL', NULL, 'C'
UNION ALL
select 'perezsa02', 'TSN All-Star', 2018, 'AL', NULL, 'C'
UNION ALL
select 'gomesya01', 'TSN All-Star', 2018, 'AL', NULL, 'C'
UNION ALL
select 'cruzne02', 'TSN All-Star', 2018, 'AL', NULL, 'DH'
UNION ALL
select 'abreujo02', 'TSN All-Star', 2018, 'AL', NULL, '1B'
UNION ALL
select 'morelmi01', 'TSN All-Star', 2018, 'AL', NULL, '1B'
UNION ALL
select 'altuvjo01', 'TSN All-Star', 2018, 'AL', NULL, '2B'
UNION ALL
select 'lowrije01', 'TSN All-Star', 2018, 'AL', NULL, '2B'
UNION ALL
select 'torregl01', 'TSN All-Star', 2018, 'AL', NULL, '2B'
UNION ALL
select 'ramirjo01', 'TSN All-Star', 2018, 'AL', NULL, '3B'
UNION ALL
select 'bregmal01', 'TSN All-Star', 2018, 'AL', NULL, '3B'
UNION ALL
select 'machama01', 'TSN All-Star', 2018, 'AL', NULL, 'SS'
UNION ALL
select 'lindofr01', 'TSN All-Star', 2018, 'AL', NULL, 'SS'
UNION ALL
select 'segurje01', 'TSN All-Star', 2018, 'AL', NULL, 'SS'
UNION ALL
select 'troutmi01', 'TSN All-Star', 2018, 'AL', NULL, 'OF'
UNION ALL
select 'judgeaa01', 'TSN All-Star', 2018, 'AL', NULL, 'OF'
UNION ALL
select 'martijd02', 'TSN All-Star', 2018, 'AL', NULL, 'OF'
UNION ALL
select 'choosh01', 'TSN All-Star', 2018, 'AL', NULL, 'OF'
UNION ALL
select 'hanigmi01', 'TSN All-Star', 2018, 'AL', NULL, 'OF'
UNION ALL
select 'springe01', 'TSN All-Star', 2018, 'AL', NULL, 'OF'
UNION ALL
-- TSN All-Star - NL - 2019
select 'contrwi01', 'TSN All-Star', 2019, 'NL', NULL, 'C'
UNION ALL
select 'grandya01', 'TSN All-Star', 2019, 'NL', NULL, 'C'
UNION ALL
select 'realmjt01', 'TSN All-Star', 2019, 'NL', NULL, 'C'
UNION ALL
select 'freemfr01', 'TSN All-Star', 2019, 'NL', NULL, '1B'
UNION ALL
select 'alonspe01', 'TSN All-Star', 2019, 'NL', NULL, '1B'
UNION ALL
select 'belljo02', 'TSN All-Star', 2019, 'NL', NULL, '1B'
UNION ALL
select 'muncyma01', 'TSN All-Star', 2019, 'NL', NULL, '1B'
UNION ALL
select 'marteke01', 'TSN All-Star', 2019, 'NL', NULL, '2B'
UNION ALL
select 'moustmi01', 'TSN All-Star', 2019, 'NL', NULL, '2B'
UNION ALL
select 'arenano01', 'TSN All-Star', 2019, 'NL', NULL, '3B'
UNION ALL
select 'bryankr01', 'TSN All-Star', 2019, 'NL', NULL, '3B'
UNION ALL
select 'rendoan01', 'TSN All-Star', 2019, 'NL', NULL, '3B'
UNION ALL
select 'baezja01', 'TSN All-Star', 2019, 'NL', NULL, 'SS'
UNION ALL
select 'dejonpa01', 'TSN All-Star', 2019, 'NL', NULL, 'SS'
UNION ALL
select 'storytr01', 'TSN All-Star', 2019, 'NL', NULL, 'SS'
UNION ALL
select 'acunaro01', 'TSN All-Star', 2019, 'NL', NULL, 'OF'
UNION ALL
select 'bellico01', 'TSN All-Star', 2019, 'NL', NULL, 'OF'
UNION ALL
select 'yelicch01', 'TSN All-Star', 2019, 'NL', NULL, 'OF'
UNION ALL
select 'blackch02', 'TSN All-Star', 2019, 'NL', NULL, 'OF'
UNION ALL
select 'dahlda01', 'TSN All-Star', 2019, 'NL', NULL, 'OF'
UNION ALL
select 'mcneije01', 'TSN All-Star', 2019, 'NL', NULL, 'OF'
UNION ALL
-- TSN All-Star - AL - 2019
select 'sanchga02', 'TSN All-Star', 2019, 'AL', NULL, 'C'
UNION ALL
select 'mccanja02', 'TSN All-Star', 2019, 'AL', NULL, 'C'
UNION ALL
select 'martijd02', 'TSN All-Star', 2019, 'AL', NULL, 'DH'
UNION ALL
select 'pencehu01', 'TSN All-Star', 2019, 'AL', NULL, 'DH'
UNION ALL
select 'santaca01', 'TSN All-Star', 2019, 'AL', NULL, '1B'
UNION ALL
select 'abreujo02', 'TSN All-Star', 2019, 'AL', NULL, '1B'
UNION ALL
select 'vogelda01', 'TSN All-Star', 2019, 'AL', NULL, '1B'
UNION ALL
select 'lemahdj01', 'TSN All-Star', 2019, 'AL', NULL, '2B'
UNION ALL
select 'lasteto01', 'TSN All-Star', 2019, 'AL', NULL, '2B'
UNION ALL
select 'lowebr01', 'TSN All-Star', 2019, 'AL', NULL, '2B'
UNION ALL
select 'bregmal01', 'TSN All-Star', 2019, 'AL', NULL, '3B'
UNION ALL
select 'chapmma01', 'TSN All-Star', 2019, 'AL', NULL, '3B'
UNION ALL
select 'polanjo01', 'TSN All-Star', 2019, 'AL', NULL, 'SS'
UNION ALL
select 'bogaexa01', 'TSN All-Star', 2019, 'AL', NULL, 'SS'
UNION ALL
select 'lindofr01', 'TSN All-Star', 2019, 'AL', NULL, 'SS'
UNION ALL
select 'troutmi01', 'TSN All-Star', 2019, 'AL', NULL, 'OF'
UNION ALL
select 'brantmi02', 'TSN All-Star', 2019, 'AL', NULL, 'OF'
UNION ALL
select 'bettsmo01', 'TSN All-Star', 2019, 'AL', NULL, 'OF'
UNION ALL
select 'gallojo01', 'TSN All-Star', 2019, 'AL', NULL, 'OF'
UNION ALL
select 'meadoau01', 'TSN All-Star', 2019, 'AL', NULL, 'OF'
UNION ALL
select 'merriwh01', 'TSN All-Star', 2019, 'AL', NULL, 'OF'
UNION ALL
-- TSN All-Star - NL - 2020
select 'realmjt01', 'TSN All-Star', 2020, 'NL', NULL, 'C'
UNION ALL
select 'freemfr01', 'TSN All-Star', 2020, 'NL', NULL, '1B'
UNION ALL
select 'solando01', 'TSN All-Star', 2020, 'NL', NULL, '2B'
UNION ALL
select 'machama01', 'TSN All-Star', 2020, 'NL', NULL, '3B'
UNION ALL
select 'tatisfe02', 'TSN All-Star', 2020, 'NL', NULL, 'SS'
UNION ALL
select 'yastrmi01', 'TSN All-Star', 2020, 'NL', NULL, 'OF'
UNION ALL
select 'bettsmo01', 'TSN All-Star', 2020, 'NL', NULL, 'OF'
UNION ALL
select 'harpebr03', 'TSN All-Star', 2020, 'NL', NULL, 'OF'
UNION ALL
select 'winkeje01', 'TSN All-Star', 2020, 'NL', NULL, 'DH'
UNION ALL
-- TSN All-Star - AL - 2020
select 'severpe01', 'TSN All-Star', 2020, 'AL', NULL, 'C'
UNION ALL
select 'voitlu01', 'TSN All-Star', 2020, 'AL', NULL, '1B'
UNION ALL
select 'lowebr01', 'TSN All-Star', 2020, 'AL', NULL, '2B'
UNION ALL
select 'rendoan01', 'TSN All-Star', 2020, 'AL', NULL, '3B'
UNION ALL
select 'anderti01', 'TSN All-Star', 2020, 'AL', NULL, 'SS'
UNION ALL
select 'lewisky01', 'TSN All-Star', 2020, 'AL', NULL, 'OF'
UNION ALL
select 'troutmi01', 'TSN All-Star', 2020, 'AL', NULL, 'OF'
UNION ALL
select 'judgeaa01', 'TSN All-Star', 2020, 'AL', NULL, 'OF'
UNION ALL
select 'cruzne02', 'TSN All-Star', 2020, 'AL', NULL, 'DH'
UNION ALL
-- World Series MVP
select 'pearcst01', 'World Series MVP', 2018, 'AL', NULL, NULL
UNION ALL
select 'strasst01', 'World Series MVP', 2019, 'NL', NULL, NULL
UNION ALL
select 'seageco01', 'World Series MVP', 2020, 'NL', NULL, NULL

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