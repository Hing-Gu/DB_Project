CREATE TABLE COURSE(
   c_id varchar(5) CONSTRAINT course_pk PRIMARY KEY NOT NULL,
   c_id_no int NOT NULL,
   c_name varchar(41),
   c_unit int,
   c_time date,
   c_max int,
   c_enroll int,
   c_addr varchar(10)
);
