CREATE TABLE person (
 id INT NOT NULL,
 person_number VARCHAR(12) NOT NULL,
 first_name VARCHAR(500) NOT NULL,
 last_name VARCHAR(500) NOT NULL,
 age INT NOT NULL,
 street VARCHAR(500) NOT NULL,
 zip VARCHAR(500) NOT NULL,
 city VARCHAR(500) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE phone (
 person_id INT NOT NULL,
 phone_no VARCHAR(500) NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (person_id,phone_no);


CREATE TABLE schedule (
 id INT NOT NULL
);

ALTER TABLE schedule ADD CONSTRAINT PK_schedule PRIMARY KEY (id);


CREATE TABLE student (
 id INT NOT NULL,
 person_id INT NOT NULL,
 student_id VARCHAR(500) NOT NULL,
 rented_instrument_count VARCHAR(2),
 parent_phone VARCHAR(500),
 parent_email VARCHAR(500)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE student_sibling (
 student_id INT NOT NULL,
 sibling_student_id INT NOT NULL
);

ALTER TABLE student_sibling ADD CONSTRAINT PK_student_sibling PRIMARY KEY (student_id,sibling_student_id);


CREATE TABLE application (
 student_id INT NOT NULL,
 name_of_instrument VARCHAR(500) NOT NULL,
 skill_level VARCHAR(500) NOT NULL,
 message VARCHAR(5000) NOT NULL
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (student_id);


CREATE TABLE email (
 person_id INT NOT NULL,
 email VARCHAR(500) NOT NULL
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (person_id,email);


CREATE TABLE instructor (
 id INT NOT NULL,
 instructor_id VARCHAR(500) NOT NULL,
 can_teach_ensembles VARCHAR(3) NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instrument_knowledge (
 instructor_id INT NOT NULL,
 instrument_name VARCHAR(500) NOT NULL
);

ALTER TABLE instrument_knowledge ADD CONSTRAINT PK_instrument_knowledge PRIMARY KEY (instructor_id,instrument_name);


CREATE TABLE lesson (
 id INT NOT NULL,
 roomNumber VARCHAR(500),
 skill_level VARCHAR(500),
 instructor_id INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE lesson_student (
 lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE lesson_student ADD CONSTRAINT PK_lesson_student PRIMARY KEY (lesson_id,student_id);


CREATE TABLE monthly_fee (
 student_id INT NOT NULL,
 fee VARCHAR(500),
 time TIMESTAMP(10)
);

ALTER TABLE monthly_fee ADD CONSTRAINT PK_monthly_fee PRIMARY KEY (student_id);


CREATE TABLE monthly_salary (
 instructor_id INT NOT NULL,
 salary VARCHAR(500),
 time TIMESTAMP(10)
);

ALTER TABLE monthly_salary ADD CONSTRAINT PK_monthly_salary PRIMARY KEY (instructor_id);


CREATE TABLE parent (
 person_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE parent ADD CONSTRAINT PK_parent PRIMARY KEY (person_id,student_id);


CREATE TABLE rent (
 student_id INT NOT NULL,
 fee VARCHAR(500),
 time TIMESTAMP(10)
);

ALTER TABLE rent ADD CONSTRAINT PK_rent PRIMARY KEY (student_id);


CREATE TABLE discount (
 student_id INT NOT NULL,
 percentage VARCHAR(500)
);

ALTER TABLE discount ADD CONSTRAINT PK_discount PRIMARY KEY (student_id);


CREATE TABLE ensemble (
 lesson_id INT NOT NULL,
 target_genre VARCHAR(500),
 min_students VARCHAR(10),
 max_students VARCHAR(10),
 schedule_id INT NOT NULL,
 time_start TIMESTAMP(10),
 time_end TIMESTAMP(10)
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 min_students VARCHAR(10),
 max_students VARCHAR(10),
 name_instrument VARCHAR(500),
 schedule_id INT NOT NULL,
 time_start TIMESTAMP(10),
 time_end TIMESTAMP(10)
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 time TIMESTAMP(10),
 name_instrument VARCHAR(500)
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


CREATE TABLE instrument_for_rent (
 student_id INT NOT NULL,
 id INT NOT NULL,
 name_of_instrument VARCHAR(500) NOT NULL,
 brand VARCHAR(500) NOT NULL,
 quantity INT NOT NULL
);

ALTER TABLE instrument_for_rent ADD CONSTRAINT PK_instrument_for_rent PRIMARY KEY (student_id,id);


ALTER TABLE phone ADD CONSTRAINT FK_phone_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE student_sibling ADD CONSTRAINT FK_student_sibling_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE email ADD CONSTRAINT FK_email_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instrument_knowledge ADD CONSTRAINT FK_instrument_knowledge_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE lesson_student ADD CONSTRAINT FK_lesson_student_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE lesson_student ADD CONSTRAINT FK_lesson_student_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE monthly_fee ADD CONSTRAINT FK_monthly_fee_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE monthly_salary ADD CONSTRAINT FK_monthly_salary_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE parent ADD CONSTRAINT FK_parent_0 FOREIGN KEY (person_id) REFERENCES person (id);
ALTER TABLE parent ADD CONSTRAINT FK_parent_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE rent ADD CONSTRAINT FK_rent_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE discount ADD CONSTRAINT FK_discount_0 FOREIGN KEY (student_id) REFERENCES monthly_fee (student_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_1 FOREIGN KEY (schedule_id) REFERENCES schedule (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (schedule_id) REFERENCES schedule (id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE instrument_for_rent ADD CONSTRAINT FK_instrument_for_rent_0 FOREIGN KEY (student_id) REFERENCES rent (student_id);


ALTER TABLE instrument_for_rent 
ADD date Date;
CREATE TABLE rental_archive(
	instrument_id int NOT NULL,
	student_id int NOT NULL,
	name_of_instrument VARCHAR(500),
	cost real,
	date Date 
);

