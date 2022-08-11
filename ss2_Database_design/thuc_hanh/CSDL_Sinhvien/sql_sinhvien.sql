create database QuanLySinhVien;
use QuanLySinhVien;
create table Class (
	ClassID int NOt null primary key auto_increment,
    ClassName varchar(60) not null,
    StartDate datetime not null,
    Status bit
);

create table Student (
	StudentID int NOt null primary key auto_increment,
    ClassName varchar(30) not null,
    Address varchar(50),
    Phone varchar(20),
    Status bit,
    ClassID int,
    foreign key (ClassID) references Class(ClassID)
);

create table Subject (
	SubID int primary key auto_increment,
    SubName varchar(30) NOT NULL,
    Credit tinyint not null default(1) check(Credit>= 1),
    Status bit default(1)
);

create table Mark (
	MarkID int not null primary key auto_increment,
    SubID int not null,
    StudentID int not null,
    Mark float check(Mark between 0 and 100) default(0),
    ExamTimes tinyint default(1),
    unique(SubID,StudentID),
    foreign key (SubID) references Subject(SubID),
    foreign key (StudentID) references Student(StudentID)
)
