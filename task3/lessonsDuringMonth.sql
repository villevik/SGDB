SELECT *
FROM
(
SELECT COUNT(*) 
FROM lesson
WHERE EXTRACT(MONTH FROM time_start) = 1
AND EXTRACT(YEAR FROM time_start) = 2022
) AS tot
,
(
SELECT COUNT(lesson_id)
FROM group_lesson
FULL OUTER JOIN lesson
ON lesson_id = id
WHERE EXTRACT(MONTH FROM time_start) = 1
AND EXTRACT(YEAR FROM time_start) = 2022
) AS gro
,
(
SELECT COUNT(lesson_id)
FROM individual_lesson
FULL OUTER JOIN lesson
ON lesson_id = id
WHERE EXTRACT(MONTH FROM time_start) = 1
AND EXTRACT(YEAR FROM time_start) = 2022
) AS ind
,
(
SELECT COUNT(lesson_id)
FROM ensemble
FULL OUTER JOIN lesson
ON lesson_id = id
WHERE EXTRACT(MONTH FROM time_start) = 1
AND EXTRACT(YEAR FROM time_start) = 2022
) AS ens