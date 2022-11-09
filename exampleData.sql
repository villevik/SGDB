INSERT INTO person VALUES ('1','0105291337','Ville','Vik','20','Grindhagsvagen','19453','stockholm');
INSERT INTO email VALUES ('1','villevik@gmail.com');
INSERT INTO phone VALUES ('1','0701234567');
INSERT INTO student VALUES ('1','1','vvik','1');
INSERT INTO rent VALUES ('1','100','2022-01-01 12:00:00');
INSERT INTO instrument_for_rent VALUES ('1','1','Electric guitar','Tenson','1');
INSERT INTO monthly_fee VALUES ('1','900','2022-01-31 09:00:00');
INSERT INTO student_sibling VALUES ('1','2');
INSERT INTO discount VALUES ('1','20');



INSERT INTO person VALUES ('2','0205291337','Emil','Vik','23','Ronnvagen','19454','stockholm');
INSERT INTO email VALUES ('2','emilvik@gmail.com');
INSERT INTO phone VALUES ('2','0701234568');
INSERT INTO student VALUES ('2','2','evik','0');

INSERT INTO person VALUES ('3','6505291337','Soren','Vik','53','Grindhagsvagen','19453','stockholm');
INSERT INTO email VALUES ('3','sorenvik@gmail.com');
INSERT INTO phone VALUES('3','0701234569');


INSERT INTO person VALUES ('4','7505291337','Karl','Svensson','43','Strandvagen','10053','stockholm');
INSERT INTO email VALUES ('4','karl@gmail.com');
INSERT INTO email VALUES ('4','karl@kth.com');
INSERT INTO phone VALUES ('4','0701234560');
INSERT INTO instructor VALUES ('1','ksve','yes','4');
INSERT INTO instrument_knowledge VALUES ('1','Electric guitar');
INSERT INTO monthly_salary VALUES ('1','1800','2021-12-23 04:00:00');

INSERT INTO schedule VALUES ('1');

INSERT INTO lesson VALUES ('1','303','Beginner','1');
INSERT INTO lesson_student VALUES ('1','1');
INSERT INTO individual_lesson VALUES ('1','2022-01-02 13:00:00','Electric guitar');

INSERT INTO lesson VALUES ('2','405','Beginner','2022-01-03 12:00:00','1');
INSERT INTO ensemble VALUES ('2','Rock','2','5','1','2022-01-03 14:00:00');
INSERT INTO lesson_student VALUES ('2','1');

INSERT INTO lesson VALUES ('4','405','Beginner','2022-01-04 12:00:00','1');
INSERT INTO ensemble VALUES ('4','Metal','2','4','1','2022-01-04 14:00:00');
INSERT INTO lesson_student VALUES ('4','1');

INSERT INTO lesson VALUES ('5','405','Beginner','2022-01-05 12:00:00','1');
INSERT INTO ensemble VALUES ('5','Metal','2','4','1','2022-01-05 14:00:00');
INSERT INTO lesson_student VALUES ('5','1');



INSERT INTO lesson VALUES ('3','305','Intermediate','1');
INSERT INTO group_lesson VALUES ('3','3','7','Electric guitar','1','2022-02-05 12:00:00','2022-02-05 14:00:00');



/*INSERT INTO time_slot VALUES ('2022-01-03 12:00:00','2022-01-03 14:00:00','1');
INSERT INTO time_slot VALUES ('2022-01-04 13:00:00','2022-01-04 15:00:00','1');
INSERT INTO time_slot VALUES ('2022-01-05 14:00:00','2022-01-05 16:00:00','1');
INSERT INTO time_slot VALUES ('2022-01-06 12:00:00','2022-01-06 14:00:00','1');
INSERT INTO time_slot VALUES ('2022-01-07 12:00:00','2022-01-07 14:00:00','1');
INSERT INTO time_slot VALUES ('2022-01-08 15:00:00','2022-01-08 17:00:00','1');
INSERT INTO time_slot VALUES ('2022-02-05 12:00:00','2022-02-05 14:00:00','3');
INSERT INTO time_slot VALUES ('2022-01-03 12:00:00','2022-01-03 14:00:00','2');
*/