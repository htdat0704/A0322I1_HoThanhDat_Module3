use quanlysinhvien;

-- 1. Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from student where StudentName like "h%";

-- 2. Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select * from class where MONTH(StartDate) = 12; 

-- 3. Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from subject where credit >= 3 and credit <= 5;

SET SQL_SAFE_UPDATES = 0;

-- 4. Thay đổi mã lớp(ClassID) của sinh viên có tên ‘Hung’ là 2.
update student 
set ClassID = 2
where StudentName = 'Hung';

-- 5. Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select S.StudentName,Sub.SubName,M.mark 
from Student S join Mark M 
on S.StudentID = M.StudentID join subject Sub on Sub.SubID = M.SubID
order by (M.mark) DESC , S.StudentName asc;