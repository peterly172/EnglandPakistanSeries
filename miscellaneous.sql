--StrikeRates for each player 
SELECT match_id, team_id, player_id, runs, balls, (runs/NULLIF(balls, 0.0)*100) AS SR
FROM matchruns

--Number of Player of the Match Awards
SELECT p.name playerofthematch, COUNT(*)
FROM match
JOIN players AS p
ON match.potm = p.id
GROUP BY p.name
