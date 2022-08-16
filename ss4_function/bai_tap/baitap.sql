use quanlysinhvien;

-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select SubID, SubName, Status, max(credit) from `subject`;

select SubID, SubName, Credit from `subject` having Credit >= (select max(credit) from `subject`);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select C.ClassID, C.ClassName,C.StartDate, C.Status, Max(M.mark) from Class C 
join Student S on C.ClassID = S.ClassID
join Mark M on M.StudentID = S.StudentID group by C.ClassID
having max(M.mark) >= (select max(Mark) from mark);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select S.StudentID, S.Address, S.Phone, S.Status, S.StudentName,
 C.ClassName, AVG(M.Mark) as DTB from Student S 
 join Class C on S.ClassID = C.ClassID
 left join mark M on  M.StudentID = S.StudentID
 group by S.StudentID
 order By DTB DESC;
 

