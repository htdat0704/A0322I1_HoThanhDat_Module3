use Quanlysinhvien;

insert into `class`(ClassName,StartDate)
values ('A1', '2008-12-20'),('A2','2008/12/22'),('B3',now());

SELECT * from `mark`;

insert into `student`(StudentName, Address, Phone, Status, ClassID) 
values ('Hung','Ha Noi','0912113113',1,1),
('Hoa','Hai Phong',null,1,1),
('Manh','HCM','0123123123',0,2);

insert into `subject`(SubName,Credit,Status)
values 
('CF',5,1),
('C',6,1),
('HDJ',5,1),
('RDBMS',10,1);

insert into `mark`(SubID,StudentID,Mark,ExamTimes)
values 
(1,1,8,1),
(1,2,10,2),
(2,1,12,1);
