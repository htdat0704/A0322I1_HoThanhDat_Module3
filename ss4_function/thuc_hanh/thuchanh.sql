use quanlysinhvien;

select ClassID, count(ClassID) as numberStudent from student group by ClassID;

SELECT S.StudentId,S.StudentName, AVG(Mark)
FROM Student S join Mark M on S.StudentId = M.StudentId
GROUP BY S.StudentId, S.StudentName;

select S.StudentName, avg(M.mark) from Student S 
join Mark M on S.StudentId = M.StudentId group by S.StudentName
 Having avg(M.mark) > 15;
 
select S.StudentName, avg(M.mark) from student S
join Mark M on S.StudentId = M.StudentId group by S.StudentId
having avg(M.mark) >= All (Select avg(mark) from mark group by mark.StudentId);
