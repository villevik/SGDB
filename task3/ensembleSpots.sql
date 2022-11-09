SELECT ensemble.lesson_id, ensemble.target_genre, lesson.time_start,
CASE
    WHEN CAST(ensemble.max_students AS int) - COUNT(lesson_student.student_id) = 0 THEN 'Fully booked'
    WHEN CAST(ensemble.max_students AS int) - COUNT(lesson_student.student_id) = 1 THEN '1 seat left'
	WHEN CAST(ensemble.max_students AS int) - COUNT(lesson_student.student_id) = 2 THEN '2 seat left'
    ELSE 'More  than 2 seats left'
END AS spotsLeft
FROM
ensemble, lesson_student, lesson
WHERE lesson_student.lesson_id = ensemble.lesson_id
AND lesson.id = ensemble.lesson_id
AND time_start < current_date + CAST((14 - EXTRACT(isodow from current_Date))AS INT)
AND time_start > current_date + CAST((8 - EXTRACT(isodow from current_Date))AS INT)
GROUP BY ensemble.lesson_id, lesson.id
ORDER BY ensemble.target_genre, EXTRACT(isodow FROM lesson.time_start)