--Rankings of Players scored the most runs in the Championship
SELECT p.name AS player, SUM(runs),
RANK() OVER(ORDER BY SUM(runs)DESC) AS total_runs
FROM matchruns AS m
LEFT JOIN players AS p
ON m.player_id = p.id
WHERE runs IS NOT NULL
GROUP BY p.name
ORDER BY total_runs

--Number of balls bowled by each venue
SELECT v.name, SUM(balls) AS total_balls,
RANK() OVER(ORDER BY SUM(balls)DESC)
FROM matchruns AS m
LEFT JOIN match
ON m.match_id = match.id
LEFT JOIN venues AS v
ON match.venue_id = v.id
GROUP BY v.name

--Number of balls bowled by each venue and format
SELECT v.name, f.format, SUM(balls) AS total_balls,
RANK() OVER(ORDER BY SUM(balls)DESC)
FROM matchruns AS m
LEFT JOIN match
ON m.match_id = match.id
LEFT JOIN venues AS v
ON match.venue_id = v.id
LEFT JOIN formats AS f
ON match.format_id = f.id
GROUP BY v.name, f.format
