SELECT CAST(COUNT(*) AS float) / CAST(12 AS float)
FROM lesson
WHERE 
EXTRACT(YEAR FROM time_start) = 2022