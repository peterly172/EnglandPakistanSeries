--  Players with the most wickets in the whole series
SELECT p.name, COUNT(*) AS wickets
FROM matchruns
JOIN players AS p
ON matchruns.bowler_id = p.id
GROUP BY p.name
ORDER BY wickets DESC

--  Players with the most wickets in test matches
SELECT p.name, COUNT(*) AS wickets
FROM matchruns
JOIN players AS p
ON matchruns.bowler_id = p.id
WHERE match_id BETWEEN 1001 AND 1003
GROUP BY p.name
ORDER BY wickets DESC

--  Players with the most wickets in T20 matches
SELECT p.name, COUNT(*) AS wickets
FROM matchruns
JOIN players AS p
ON matchruns.bowler_id = p.id
WHERE match_id BETWEEN 1004 AND 1006
GROUP BY p.name
ORDER BY wickets DESC

-- Matches that were umpired by Richard Kettleborough
SELECT * FROM match
JOIN umpires AS u1
ON match.umpire1_id = u1.id
JOIN umpires AS u2
ON match.umpire2_id = u2.id
WHERE u1.name = 'Richard Kettleborough'
OR u2.name = 'Richard Kettleborough'

--Number of innings played by each player during the series
SELECT p.name, COUNT(*) AS innings
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
GROUP BY p.name
ORDER BY innings DESC

--Number of ducks made in a  match 
SELECT match_id, p.name, innings, runs, COUNT(*) AS ducks
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs= 0
AND wicket_id != 6
GROUP BY match_id, innings, p.name, runs
ORDER BY match_id, COUNT(*) DESC


-- Players with the most runs during the series
SELECT p.name, SUM(runs) AS total_runs
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_runs DESC

-- Players with the most runs during test
SELECT p.name, SUM(runs) AS total_runs
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
AND match_id BETWEEN 1001 AND 1003
GROUP BY p.name
ORDER BY total_runs DESC

-- Players with the most runs during T20
SELECT p.name, SUM(runs) AS total_runs
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
AND match_id BETWEEN 1004 AND 1006
GROUP BY p.name
ORDER BY total_runs DESC

-- Players with the most runs in an inning
SELECT match_id, p.name, SUM(runs) AS total_runs
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY match_id, p.name
ORDER BY total_runs DESC

--Number of balls faced in descending order
SELECT p.name, SUM(balls) AS total_balls
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_balls DESC

--Most Boundaries by a player in Test
SELECT p.name, SUM(fours + sixes) AS total_boundaries
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
AND match_id BETWEEN 1001 AND 1003
GROUP BY p.name
ORDER BY total_boundaries DESC

--Most Boundaries by a player in T20
SELECT p.name, SUM(fours + sixes) AS total_boundaries
FROM matchruns
JOIN players AS p
ON matchruns.player_id = p.id
WHERE runs IS NOT NULL
AND match_id BETWEEN 1004 AND 1006
GROUP BY p.name
ORDER BY total_boundaries DESC

-- Most runs scored in an innings in the series
SELECT p.name, MAX(runs) AS maxruns
FROM matchruns AS m
JOIN players AS p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY maxruns DESC
