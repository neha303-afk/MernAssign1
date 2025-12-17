show databases;
create database mernp;
use mernp;

create table users(
   email VARCHAR(30) NOT NULL PRIMARY KEY,
   password VARCHAR(15) NOT NULL,
   roles enum('student','Admin') NOT NULL
);

create table Courses(
  course_id int NOT NULL PRIMARY KEY auto_increment,
  course_name VARCHAR(30) NOT NULL,
  descrip VARCHAR(60),
  fees INT NOT NULL,
  start_date date not null,
  end_date date not null,
  video_expire_days int not null

);

create table Students(
 reg_no INT primary KEY NOT NULL,
 s_name varchar(40) not null,
 email VARCHAR(30) NOT NULL,
 course_id int NOT NULL,
 mobile_no INT NOT NULL,
 profile_pic blob,
  constraint fk_mail foreign key (email)
  references Users(email) ,
  constraint fk_cid foreign key (course_id) 
  references Courses(course_id)
);

create table videos(
video_id int PRIMARY KEY,
course_id int NOT NULL,
title VARCHAR(20),
descrip VARCHAR(60),
youtube_url VARCHAR(50),
added_at date,

constraint fk_cid2
     foreign key (course_id)
     references Courses(course_id)
);

insert into users value
('admin@sunbeam.com', 'admin123', 'student'),
('student1@gmail.com', 'stud123', 'student'),
('student2@gmail.com', 'stud123', 'student');

desc courses;

INSERT INTO Courses
(course_id, course_name, descrip, fees, start_date, end_date, video_expire_days)
VALUES
(1, 'MERN Stack', 'Full stack web development', 15000, '2025-01-01', '2025-06-01', 180),
(2, 'Java', 'Core and Advanced Java', 12000, '2025-02-01', '2025-07-01', 180),
(3, 'C++', 'OOP and STL concepts', 20000, '2025-03-01', '2025-08-03', 180);

desc Students;

alter table  Students modify mobile_no bigint not null;

INSERT INTO Students
(reg_no, s_name, email, course_id, mobile_no, profile_pic)
VALUES
(101, 'Riya', 'student1@gmail.com', 1,' 9876543210', NULL),
(102, 'Anita', 'student2@gmail.com', 2, '9123456789', NULL);

INSERT INTO videos
(video_id, course_id, title, descrip, youtube_url, added_at)
VALUES
(1, 1, 'MERN Intro', 'Overview of MERN stack', 'https://youtu.be/mern1', '2025-01-05'),
(2, 1, 'Node Basics', 'Introduction to Node.js', 'https://youtu.be/node1', '2025-01-10'),
(3, 2, 'Java Intro', 'Java course overview', 'https://youtu.be/java1', '2025-02-05'),
(4, 3, 'C++ Intro', 'Basics of C++ programming', 'https://youtu.be/cpp1', '2025-03-06');

select * from courses where start_date>current_date();
-- fetch all the registered students along with course name

select  s.reg_no , s.s_name , s.email, s.mobile_no , c.course_id , c.course_name
from Students s JOIN Courses c on c.course_id=s.course_id;

-- fetch the complete details of a student(based on their email) along with the details of the course they are enrolled in.

select s.reg_no , s.s_name , s.email, s.mobile_no , c.course_id , c.course_name , c.descrip , c.fees , c.start_date , c.end_date
from Students s JOIN Courses c on  c.course_id=s.course_id
where s.email='ash04@mail.com';

-- 4th query

select c.course_id , c.course_name , c.start_date , c.end_date , c.video_expire_days , v.video_id , v.title , v.added_at
from Courses c JOIN videos v on c.course_id=v.course_id JOIN Students s on s.course_id=c.course_id
where s.email='ash04@mail.com' and datediff(v.added_at,current_date)<=c.video_expire_days;

