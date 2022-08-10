use `student-management`;

create table Class(
	id int auto_increment primary key,
    name varchar(50)
);

create table Teacher(
	id int auto_increment primary key,
    name varchar(50),
    age int,
    country varchar(20)
);