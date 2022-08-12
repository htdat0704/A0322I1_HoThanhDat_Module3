use Quanlysinhvien;

Select * from student;

select * from student where `Status` = 1 ;

select * from subject where `Credit` < 10;

select S.StudentName, S.address, S.phone, Sub.SubName, M.mark
from Student S join Mark M
on S.StudentID = M.StudentID join Subject Sub on Sub.SubID = M.SubID
where SubName = 'CF';
