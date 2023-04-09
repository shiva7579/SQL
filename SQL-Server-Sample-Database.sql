--Creating tables 
--users table
DROP TABLE IF EXISTS USERS;
create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

insert into users values
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com'),
(6,'Shiva','shiva@gmail.com');
insert into users values (7, 'Robin', 'robin@gmail.com');
SELECT * FROM USERS;

--employee_table
DROP TABLE IF EXISTS employee;
CREATE TABLE employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

--doctors_table
DROP TABLE IF EXISTS doctors;
CREATE TABLE doctors
(
id int primary key,
name varchar(50) not null,
speciality varchar(100),
hospital varchar(50),
city varchar(50),
consultation_fee int
);

INSERT INTO doctors VALUES
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

--login_details_table
DROP TABLE IF EXISTS login_details;
CREATE TABLE login_details(
login_id int primary key,
user_name varchar(50) not null,
login_date date);

INSERT INTO login_details VALUES
(101, 'Michael', current_date),
(102, 'James', current_date),
(103, 'Stewart', current_date+1),
(104, 'Stewart', current_date+1),
(105, 'Stewart', current_date+1),
(106, 'Michael', current_date+2),
(107, 'Michael', current_date+2),
(108, 'Stewart', current_date+3),
(109, 'Stewart', current_date+3),
(110, 'James', current_date+4),
(111, 'James', current_date+4),
(112, 'James', current_date+5),
(113, 'James', current_date+6);


--students_table
DROP TABLE IF EXISTS students;
CREATE TABLE students
(
id int primary key,
student_name varchar(50) not null
);
INSERT INTO students VALUES
(1, 'James'),
(2, 'Michael'),
(3, 'George'),
(4, 'Stewart'),
(5, 'Robin');

--weather 
DROP TABLE IF EXISTS weather;
CREATE TABLE weather
(
id int,
city varchar(50),
temperature int,
day date
);
INSERT INTO weather VALUES
(1, 'London', -1, to_date('2021-01-01','yyyy-mm-dd')),
(2, 'London', -2, to_date('2021-01-02','yyyy-mm-dd')),
(3, 'London', 4, to_date('2021-01-03','yyyy-mm-dd')),
(4, 'London', 1, to_date('2021-01-04','yyyy-mm-dd')),
(5, 'London', -2, to_date('2021-01-05','yyyy-mm-dd')),
(6, 'London', -5, to_date('2021-01-06','yyyy-mm-dd')),
(7, 'London', -7, to_date('2021-01-07','yyyy-mm-dd')),
(8, 'London', 5, to_date('2021-01-08','yyyy-mm-dd'));

--event_category,physician_specilaity,patient_treatment
DROP TABLE IF EXISTS event_category;
CREATE TABLE event_category
(
  event_name varchar(50),
  category varchar(100)
);

DROP TABLE IF EXISTS  physician_speciality;
CREATE TABLE physician_speciality
(
  physician_id int,
  speciality varchar(50)
);

DROP TABLE IF EXISTS  patient_treatment;
CREATE TABLE patient_treatment
(
  patient_id int,
  event_name varchar(50),
  physician_id int
);


insert into event_category values ('Chemotherapy','Procedure');
insert into event_category values ('Radiation','Procedure');
insert into event_category values ('Immunosuppressants','Prescription');
insert into event_category values ('BTKI','Prescription');
insert into event_category values ('Biopsy','Test');


insert into physician_speciality values (1000,'Radiologist');
insert into physician_speciality values (2000,'Oncologist');
insert into physician_speciality values (3000,'Hermatologist');
insert into physician_speciality values (4000,'Oncologist');
insert into physician_speciality values (5000,'Pathologist');
insert into physician_speciality values (6000,'Oncologist');


insert into patient_treatment values (1,'Radiation', 1000);
insert into patient_treatment values (2,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 1000);
insert into patient_treatment values (3,'Immunosuppressants', 2000);
insert into patient_treatment values (4,'BTKI', 3000);
insert into patient_treatment values (5,'Radiation', 4000);
insert into patient_treatment values (4,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 5000);
insert into patient_treatment values (6,'Chemotherapy', 6000);



--1)Write a SQL Query to fetch all the duplicate records in a table.

SELECT * FROM users;
WITH t1 AS(
SELECT *,ROW_NUMBER() OVER (PARTITION BY user_name)
FROM users)
SELECT 
DISTINCT(user_name),
email
FROM t1 WHERE ROW_NUMBER<>1;

SELECT *
FROM users
WHERE users.ctid not in
(SELECT min(ctid) as ctid FROM USERS
GROUP BY user_name
ORDER BY ctid);

--2)Write a SQL query to fetch the second last record from employee table.
select * from employee;
SELECT * FROM employee 
WHERE emp_id =
(select (max(emp_id)-1) as emp_id 
from employee);

WITH t1 AS
(SELECT *,RANK() OVER(ORDER BY emp_id DESC) FROM employee)
SELECT emp_name,dept_name,salary
FROM t1 
WHERE t1.rank=2;

--3.Write a SQL query to display only the details of employees who either earn the highest salary or the lowest salary in each department from the employee table.

select * from employee;
WITH t1 AS(
SELECT *,dense_rank() over(partition by dept_name ORDER BY salary) AS rnk
FROM employee),
t2 AS (
SELECT dept_name,max(rnk) as max ,min(rnk) as min
FROM t1
GROUP BY dept_name)
SELECT t1.emp_id,t1.emp_name,t1.dept_name,t1.salary
FROM t1,t2
WHERE t1.dept_name=t2.dept_name AND (t1.rnk=t2.min OR t1.rnk=t2.max);

WITH t1 AS (
SELECT DISTINCT(dept_name),
MAX(salary) OVER(PARTITION BY dept_name) AS MAX_SALARY,
MIN(salary) OVER(PARTITION BY dept_name) AS MIN_SALARY
FROM employee
GROUP BY dept_name,salary)
SELECT E.*FROM employee E
JOIN t1 ON t1.dept_name=E.dept_name AND (t1.max_salary=E.salary OR t1.min_salary = E.salary)
ORDER BY E.dept_name;

--4. From the doctors table, fetch the details of doctors who work in the same hospital but in different specialty.
SELECT * FROM doctors;
WITH t1 AS (
SELECT *,count(1) OVER (PARTITION BY hospital) as rno
FROM doctors),
t2 AS (
SELECT *,count(1) OVER (PARTITION BY speciality) as spo
FROM t1
WHERE t1.rno >1
)
SELECT d.* FROM doctors d 
JOIN t2 ON d.id=t2.id 
WHERE t2.spo =1;

SELECT d1.*
FROM doctors d1
JOIN doctors d2 ON d1.hospital=d2.hospital AND d1.speciality <> d2.speciality;

--5.From the login_details table, fetch the users who logged in consecutively 3 or more times.

SELECT * FROM login_details;
WITH t1 AS(
SELECT *,
CASE WHEN user_name=LEAD(user_name,2) OVER(ORDER BY login_id) THEN user_name ELSE NULL END AS NAMES
FROM login_details)
SELECT DISTINCT(t1.user_name) FROM t1 
WHERE t1.names IS NOT NULL;

SELECT * FROM login_details;
WITH t1 AS(
SELECT *,
CASE WHEN user_name=LAG(user_name,2) OVER(ORDER BY login_id) THEN user_name ELSE NULL END AS NAMES
FROM login_details)
SELECT DISTINCT(t1.user_name) FROM t1 
WHERE t1.names IS NOT NULL;

--6.From the students table, write a SQL query to interchange the adjacent student names.
SELECT * FROM students;
SELECT *,
CASE 
     WHEN mod(id,2)<>0 THEN LEAD(student_name,1,student_name) OVER(ORDER BY id)
     WHEN mod(id,2)=0 THEN LAG(student_name) OVER(ORDER BY id)
END AS adj_student_name
FROM students
GROUP BY id;

--7.From the weather table, fetch all the records when London had extremely cold temperature for 3 consecutive days or more.
SELECT * FROM weather;

WITH t1 AS 
(
	SELECT * 
	FROM weather
	WHERE temperature < 0),
t2 AS 
(SELECT *,
 CASE 
 WHEN lead(day) over(order by day)=day+1 AND lead(day,2) over(order by day)=day+2 THEN '1'
 WHEN lag(day) over(order by day)=day-1 AND lead(day) over(order by day)=day+1 THEN '1'
 WHEN lag(day) over(order by day)=day-1 AND lag(day,2) over(order by day)=day-2 THEN '1'
      ELSE null
 END AS cold_day
 FROM t1
)
SELECT t1.* FROM t1
JOIN t2 on t1.id=t2.id
WHERE t2.cold_day='1';

/*
8.From the following 3 tables (event_category, physician_speciality, patient_treatment), 
Write a SQL query to get the histogram of specialties of the unique physicians who have done the procedures but never did prescribe anything.	
*/


SELECT * FROM patient_treatment;
SELECT * FROM event_category;
SELECT * FROM physician_speciality;

WITH t1 AS(
SELECT pt.*,ps.speciality,ec.category FROM (patient_treatment pt
JOIN physician_speciality ps ON pt.physician_id = ps.physician_id 
JOIN event_category ec ON pt.event_name = ec.event_name )
	),
t2 AS(
SELECT DISTINCT(physician_id),speciality
FROM t1 
WHERE category='Procedure'),
t3 AS(
SELECT DISTINCT(physician_id),speciality
FROM t1 
WHERE category='Prescription')
SELECT DISTINCT(t2.physician_id),t2.speciality FROM t2 RIGHT JOIN t3
ON t2.physician_id <> t3.physician_id
WHERE t2.physician_id not in (t3.physician_id);

WITH t1 AS(
SELECT pt.*,ps.speciality,ec.category FROM (patient_treatment pt
JOIN physician_speciality ps ON pt.physician_id = ps.physician_id 
JOIN event_category ec ON pt.event_name = ec.event_name )
	)
SELECT DISTINCT(physician_id),category
FROM t1 
WHERE category='Prescription';























