SELECT instructor_id 
FROM
(SELECT instructor.instructor_id, COUNT(lesson.id) AS Les
FROM instructor, lesson
WHERE instructor.id = lesson.instructor_id
AND EXTRACT(MONTH FROM time_start) = EXTRACT(MONTH FROM current_date)
GROUP BY instructor.id) AS insLes
WHERE les > 1
