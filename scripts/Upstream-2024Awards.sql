delete from dbo.AwardsPlayers where yearID = '2024';

INSERT INTO dbo.AwardsPlayers 
(playerID, awardID, [yearid], lgID, tie, notes)  
VALUES 
('stantmi03', 'ALCS MVP', 2024, 'AL', NULL, NULL), -- Giancarlo Stanton 
('duranja01', 'All-Star Game MVP', 2024, 'AL', NULL, NULL), -- Jarren Duran
('bettsmo01', 'Babe Ruth Award', 2024, 'NL', NULL, NULL), -- Mookie Betts
('salech01', 'Comeback Player of the Year', 2024, 'NL', NULL, NULL), -- Chris Sale
('crochga01', 'Comeback Player of the Year', 2024, 'AL', NULL, NULL), -- Garrett Crochet
('salech01', 'Cy Young Award', 2024, 'NL', NULL, NULL), -- Chris Sale
('skubata01', 'Cy Young Award', 2024, 'AL', NULL, NULL), -- Tarik Skubal
('salech01', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Chris Sale  
('heimjo01', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Jonah Heim  
('lowena01', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Nathaniel Lowe  
('gimenan01', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Andrés Giménez  
('chapmma01', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Matt Chapman  
('wittbo02', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Bobby Witt Jr.  
('kwanst01', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Steven Kwan  
('kiermke01', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Kevin Kiermaier  
('garciad02', 'Gold Glove', 2024, 'AL', NULL, NULL), -- Adolis García  
('walketa01', 'Gold Glove', 2024, 'NL', NULL, NULL), -- Taijuan Walker  
('realmjt01', 'Gold Glove', 2024, 'NL', NULL, NULL), -- J.T. Realmuto  
('olsonma02', 'Gold Glove', 2024, 'NL', NULL, NULL), -- Matt Olson  
('hoernni01', 'Gold Glove', 2024, 'NL', NULL, NULL), -- Nico Hoerner  
('hayeske01', 'Gold Glove', 2024, 'NL', NULL, NULL), -- Ke'Bryan Hayes  
('swansda01', 'Gold Glove', 2024, 'NL', NULL, NULL), -- Dansby Swanson  
('happia01', 'Gold Glove', 2024, 'NL', NULL, NULL), -- Ian Happ  
('doylebr02', 'Gold Glove', 2024, 'NL', NULL, NULL), -- Brenton Doyle  
('bettsmo01', 'Gold Glove', 2024, 'NL', NULL, NULL), -- Mookie Betts  
('judgeaa01', 'Hank Aaron Award', 2024, 'AL', NULL, NULL), -- Aaron Judge 
('ohtansh01', 'Hank Aaron Award', 2024, 'NL', NULL, NULL), -- Shohei Ohtani 
('goldspa01', 'Lou Gehrig Memorial Award', 2024, 'NL', NULL, NULL), -- Paul GoldSchmidt
('judgeaa01', 'Most Valuable Player', 2024, 'AL', NULL, NULL), -- Aaron Judge 
('ohtansh01', 'Most Valuable Player', 2024, 'NL', NULL, NULL), -- Shohei Ohtani 
('edmanto01', 'NLCS MVP', 2024, 'AL', NULL, NULL), -- Tommy Edman 
('ohtansh01', 'Outstanding DH Award', 2024, 'NL', NULL, NULL), -- Shohei Ohtani 
-- Reliever of the Year
('raleica01', 'Platinum Glove', 2024, 'AL', NULL, NULL), -- Cal Raleigh 
('turanbr02', 'Platinum Glove', 2024, 'NL', NULL, NULL), -- Brice Turang 
('perezsa02', 'Roberto Clemente Award', 2024, 'AL', NULL, NULL), -- Salvador Perez 
-- Rookie of the Year
('rutscad01', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Adley Rutschman  
('guerrvl02', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Vladimir Guerrero Jr.  
('altuvjo01', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Jose Altuve  
('deverra01', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Rafael Devers  
('seageco01', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Corey Seager  
('judgeaa01', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Aaron Judge  
('tuckeky01', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Kyle Tucker  
('arozara01', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Randy Arozarena  
('rookebr01', 'Silver Slugger', 2024, 'AL', NULL, NULL), -- Brent Rooker  
('smithwi05', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Will Smith  
('freemfr01', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Freddie Freeman  
('albieoz01', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Ozzie Albies  
('machama01', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Manny Machado  
('lindofr01', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Francisco Lindor  
('bettsmo01', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Mookie Betts  
('sotoju01', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Juan Soto  
('harpebr03', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Bryce Harper  
('ohtansh01', 'Silver Slugger', 2024, 'NL', NULL, NULL), -- Shohei Ohtani  
('raleica01', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Cal Raleigh  
('lowena01', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Nathaniel Lowe  
('gimenan01', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Andrés Giménez  
('chapmma01', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Matt Chapman  
('wittbo02', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Bobby Witt Jr.  
('kwanst01', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Steven Kwan  
('kiermke01', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Kevin Kiermaier  
('garciad02', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Adolis García  
('salech01', 'TSN All-Star', 2024, 'AL', NULL, NULL), -- Chris Sale  
('realmjt01', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- J.T. Realmuto  
('olsonma02', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- Matt Olson  
('hoernni01', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- Nico Hoerner  
('hayeske01', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- Ke'Bryan Hayes  
('swansda01', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- Dansby Swanson  
('happia01', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- Ian Happ  
('doylebr02', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- Brenton Doyle  
('bettsmo01', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- Mookie Betts  
('walketa01', 'TSN All-Star', 2024, 'NL', NULL, NULL), -- Taijuan Walker  
('ohtansh01', 'TSN Major League Player of the Year', 2024, 'NL', NULL, NULL), -- Shohei Ohtani 
-- TSN Pitcher of the Year
-- TSN Reliever of the Year 
('freemfr01', 'World Series MVP', 2024, 'AL', NULL, NULL) -- Freddie Freeman

----
delete from dbo.AllstarFull where yearID = '2024'

INSERT INTO dbo.AllstarFull   
(playerID, yearID, gameNum, gameID, teamID, lgID, GP, startingPos)    
VALUES   
('rutscad01', 2024, 0, 'ALS20240716', 'BAL', 'AL', 1, NULL), -- Adley Rutschman  
('guerrvl02', 2024, 0, 'ALS20240716', 'TOR', 'AL', 1, NULL), -- Vladimir Guerrero Jr.  
('semiema01', 2024, 0, 'ALS20240716', 'TEX', 'AL', 1, NULL), -- Marcus Semien  
('deverra01', 2024, 0, 'ALS20240716', 'BOS', 'AL', 1, NULL), -- Rafael Devers  
('seageco01', 2024, 0, 'ALS20240716', 'TEX', 'AL', 1, NULL), -- Corey Seager  
('judgeaa01', 2024, 0, 'ALS20240716', 'NYY', 'AL', 1, NULL), -- Aaron Judge  
('tuckeky01', 2024, 0, 'ALS20240716', 'HOU', 'AL', 1, NULL), -- Kyle Tucker  
('arozara01', 2024, 0, 'ALS20240716', 'TB', 'AL', 1, NULL), -- Randy Arozarena  
('ohtansh01', 2024, 0, 'ALS20240716', 'LAA', 'AL', 1, NULL), -- Shohei Ohtani  
('smithwi05', 2024, 0, 'ALS20240716', 'LAD', 'NL', 1, NULL), -- Will Smith  
('freemfr01', 2024, 0, 'ALS20240716', 'ATL', 'NL', 1, NULL), -- Freddie Freeman  
('albieoz01', 2024, 0, 'ALS20240716', 'ATL', 'NL', 1, NULL), -- Ozzie Albies  
('machama01', 2024, 0, 'ALS20240716', 'SD', 'NL', 1, NULL), -- Manny Machado  
('lindofr01', 2024, 0, 'ALS20240716', 'NYM', 'NL', 1, NULL), -- Francisco Lindor  
('bettsmo01', 2024, 0, 'ALS20240716', 'LAD', 'NL', 1, NULL), -- Mookie Betts  
('sotoju01', 2024, 0, 'ALS20240716', 'SD', 'NL', 1, NULL), -- Juan Soto  
('acunaro01', 2024, 0, 'ALS20240716', 'ATL', 'NL', 1, NULL), -- Ronald Acuña Jr.  
('harpebr03', 2024, 0, 'ALS20240716', 'PHI', 'NL', 1, NULL); -- Bryce Harper  