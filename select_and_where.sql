SELECT * FROM teams
SELECT * FROM venues
SELECT * FROM umpires
SELECT * FROM wickets
SELECT * FROM roles
SELECT * FROM players
SELECT * FROM match
SELECT * FROM matchruns

--Number of runs scored in both innings of England vs Pakistan Series 
SELECT match_id, team_id, innings, SUM(runs)
FROM matchruns
WHERE match_id = 1001
GROUP BY match_id, team_id, innings
ORDER BY match_id
--Matches that took place at Old Trafford
SELECT * FROM match
JOIN venues 
ON match.venue_id = venues.id
WHERE name = 'Old Trafford'
--Which players were out via Bowled
SELECT * FROM matchruns
JOIN wickets
ON matchruns.wicket_id = wickets.id
WHERE dismissal = 'Bowled'
--Number of stumps/catches made by Mohammad Rizwan
SELECT * FROM matchruns
WHERE notes LIKE '%Rizwan%'
