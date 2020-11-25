--Semi Scorecard for matches taken place at Old Trafford (Semi Join)
SELECT m.match_id, innings, player_id , runs, balls, bowler_id, wicket_id
FROM matchruns AS m
WHERE match_id IN (SELECT id FROM match
WHERE venue_id = 1)
ORDER BY m.match_id

--Semi Scorecard for matches taken place with Richard Illingworth as the Umpire (Semi Join)
SELECT m.match_id, innings, player_id , runs, balls, bowler_id, wicket_id
FROM matchruns AS m
WHERE match_id IN (SELECT id FROM match
WHERE umpire1_id = 1 OR umpire2_id = 1)
ORDER BY m.match_id

-- Number of wickets taken per venue (Stuart Broad)
SELECT v.name, subquery.wickets
FROM match
JOIN venues AS v
ON match.venue_id = v.id,
(SELECT match_id, p.name AS bowler, COUNT(*) AS wickets
FROM matchruns 
JOIN players AS p
ON matchruns.bowler_id = p.id
WHERE p.name = 'Stuart Broad'
GROUP BY match_id, p.name) AS subquery
WHERE match.id = subquery.match_id

--Number of runs made per venue (Babar Azam)
SELECT v.name, subquery.total_runs
FROM match
JOIN venues AS v
ON match.venue_id = v.id,
(SELECT match_id, p.name AS batsman, SUM(runs) AS total_runs
FROM matchruns 
JOIN players AS p
ON matchruns.player_id = p.id
WHERE p.name = 'Babar Azam'
GROUP BY match_id, p.name) AS subquery
WHERE match.id = subquery.match_id

--Players who score more than 100 runs in the series
SELECT p.name, runs, balls, fours, sixes FROM 
(SELECT * FROM matchruns WHERE runs > 100) a
LEFT JOIN players AS p
ON a.player_id = p.id


-- Show all scores where Pakistan won
SELECT * FROM matchruns
WHERE match_id
IN (SELECT id FROM match WHERE winner = 2)
--Show all LBW dismissals
SELECT * FROM matchruns
WHERE wicket_id
IN (SELECT id FROM wickets WHERE dismissal = 'LBW')

--Show all match taken place at Old Trafford
SELECT * FROM match
WHERE venue_id 
	IN (SELECT id FROM venues WHERE name = 'Old Trafford')

-- Total number of runs made by each team throughout
SELECT teams.name AS country,
(SELECT SUM(runs) FROM matchruns
 WHERE teams.id = matchruns.team_id) AS runs
 FROM teams
 ORDER by runs DESC

--Runs made by each player compared to overall
SELECT p.name, f.format, SUM(runs) AS total_runs_per_test,
(SELECT SUM(runs) FROM matchruns) AS overall_AVG
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
JOIN match
ON matchruns.match_id = match.id
JOIN formats AS F
ON match.format_id = f.id
WHERE runs IS NOT NULL
GROUP BY p.name, f.format
ORDER BY total_runs_per_test DESC

-- Run AVG from each stadium compared to overall
SELECT v.name AS venue, f.format AS format, ROUND(AVG(runs),2) AS Test_AVG, 
(SELECT ROUND(AVG(runs), 2) FROM matchruns) AS overall_AVG
FROM matchruns 
JOIN match AS m
ON matchruns.match_id = m.id
JOIN match
ON matchruns.match_id = match.id
JOIN formats AS F
ON match.format_id = f.id
JOIN venues AS v
ON m.venue_id = v.id
GROUP BY v.name, f.format

-- Number of runs scored by each team specifically via match and innings
SELECT teams.name AS country,
(SELECT SUM(runs) FROM matchruns AS m
 WHERE teams.id = m.team_id AND match_id= 1006 AND innings= 1) AS runs
 FROM teams
 ORDER by runs

--Number of runs made by each team vs overall
SELECT t.name AS country, SUM(runs) AS team_runs,
(SELECT SUM(runs) FROM matchruns) AS runs
 FROM matchruns AS m
 JOIN teams AS t
 ON m.team_id = t.id
 GROUP BY t.name
 ORDER by team_runs DESC

-- Number of runs made by each stadium
SELECT v.name, 
(SELECT SUM(runs) FROM matchruns 
WHERE m.id = matchruns.match_id) AS total_runs
FROM match AS m
JOIN venues AS v
ON m.venue_id = v.id
ORDER BY total_runs DESC
OR 
SELECT v.name AS venue, SUM(runs) AS runs
FROM matchruns m
LEFT JOIN match 
ON m.match_id = match.id
LEFT JOIN venues v
ON match.venue_id = v.id
GROUP BY v.name
ORDER BY runs DESC
