use quanlykhunghiduongfurama;

-- 2. Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là
-- một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 kí tự.

select * from employes
where (name_employe like "H%" or name_employe like "T%" or name_employe like "K%")
and (length(name_employe) <= 16) ;

-- 3. Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi 
-- và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.

select *, year(now()) - year(C.date) as AGE from customers C
where ((year(now()) - year(C.date)) between 18 and 50)
and (C.address like "%Đà Nẵng%" or C.address like "%Quảng Trị%");

-- 4. Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
-- Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng
-- Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

select C.*, COUNT(CT.id_contract)  as `Số lần đặt phòng` , TC.name_type from customers C
join contract CT on C.id_customer = CT.id_customer
join type_customer TC on TC.id_type = C.id_type 
where TC.name_type = "Diamond"
group by id_customer
order by `Số lần đặt phòng`;


-- 5. Hiển thị ma_khach_hang, ho_ten, ten_loai_khach, 
-- ma_hop_dong, ten_dich_vu, ngay_lam_hop_dong, ngay_ket_thuc, 
-- tong_tien (Với tổng tiền được tính theo công thức như sau: 
-- Chi Phí Thuê + Số Lượng * Giá, với Số Lượng và Giá là từ bảng dich_vu_di_kem,
-- hop_dong_chi_tiet) cho tất cả các khách hàng đã từng đặt phòng.
-- (những khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).

SELECT C.id_customer,C.name_customer,TC.name_type as type_customer,
CT.id_contract, S.name_service, CT.start_day, CT.end_day,
IFNULL(sum(DCT.quantity*SS.price),0) + S.rent_cost as Total
from customers C
left join contract CT on CT.id_customer = C.id_customer
left join type_customer TC on TC.id_type = C.id_type
left join Service S on  S.id_service = CT.id_service
left join details_contract DCT on CT.id_contract = DCT.id_contract
left join secondary_services SS on SS.id_secondary_service = DCT.id_secondary_service
group by id_customer
order by id_customer ASC, total DESC;

-- 6. Hiển thị ma_dich_vu, ten_dich_vu, dien_tich, chi_phi_thue, 
-- ten_loai_dich_vu của tất cả các loại dịch vụ chưa từng được
-- khách hàng thực hiện đặt từ quý 1 của năm 2021 (Quý 1 là tháng 1, 2, 3).

SELECT S.id_service, S.name_service, S.area, S.rent_cost, TS.name_type
from service S join type_service TS on S.id_type = TS.id_type
where id_service not in (select S.id_service from service S
join contract CT on CT.id_service = S.id_service
where (year(CT.start_day) = 2021 and month(CT.start_day) between 1 and 3));

-- 7. Hiển thị thông tin ma_dich_vu, ten_dich_vu, dien_tich, so_nguoi_toi_da,
-- chi_phi_thue, ten_loai_dich_vu của tất cả các loại dịch vụ đã từng được 
-- khách hàng đặt phòng trong năm 2020 nhưng chưa từng được khách hàng đặt phòng trong năm 2021.

SELECT distinct S.id_service, S.name_service, S.area, S.rent_cost, TS.name_type, S.number_limit_customer
from service S join type_service TS on S.id_type = TS.id_type
join contract CT on CT.id_service = S.id_service
where year(CT.start_day) = 2020 and
S.id_service not in (select S.id_service from service S
join contract CT on CT.id_service = S.id_service
where year(CT.start_day) = 2021);

-- 8. Hiển thị thông tin ho_ten khách hàng có trong hệ thống, với yêu cầu ho_ten không trùng nhau.

SELECT  distinct name_customer from customers;

SELECT name_customer from customers group by name_customer;
 
 SELECT name_customer from customers
 union
 SELECT name_customer from customers;
 
 -- 9. Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong 
 -- năm 2021 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.
 
 SELECT month(CT.start_day), Count(1) from contract CT 
 group by month(CT.start_day) order by month(CT.start_day)  ;
 
 -- 10. Hiển thị thông tin tương ứng với từng hợp đồng thì đã sử dụng 
 -- bao nhiêu dịch vụ đi kèm. Kết quả hiển thị bao gồm ma_hop_dong, ngay_lam_hop_dong,
 -- ngay_ket_thuc, tien_dat_coc, so_luong_dich_vu_di_kem (được tính dựa trên việc sum so_luong ở dich_vu_di_kem).
 
 select CT.id_contract, CT.start_day, CT.end_day, CT.deposit, sum(DCT.quantity)
 from contract CT left join details_contract DCT on DCT.id_contract = CT.id_contract
 left join secondary_services SS on SS.id_secondary_service = DCT.id_secondary_service
 group by id_contract;
 
-- 11. Hiển thị thông tin các dịch vụ đi kèm đã được sử dụng bởi những khách hàng
-- có ten_loai_khach là “Diamond” và có dia_chi ở “Vinh” hoặc “Quảng Ngãi”.
 
 select SS.* from secondary_services SS join  details_contract DCT
 on DCT.id_secondary_service = SS.id_secondary_service
 join contract CT on CT.id_contract  = DCT.id_contract 
 join customers C on C.id_customer = CT.id_customer
 join type_customer TC on TC.id_type = TC.id_type
 where TC.name_type = "Diamond" and 
 (C.address Like "%Vinh%" or C.address like "%Quảng Ngãi%");
 
 -- 12. Hiển thị thông tin ma_hop_dong, ho_ten (nhân viên), ho_ten (khách hàng), 
 -- so_dien_thoai (khách hàng), ten_dich_vu, so_luong_dich_vu_di_kem 
 -- (được tính dựa trên việc sum so_luong ở dich_vu_di_kem), 
 -- tien_dat_coc của tất cả các dịch vụ đã từng được khách hàng đặt vào 
 -- 3 tháng cuối năm 2020 nhưng chưa từng được khách hàng đặt vào 6 tháng đầu năm 2021.
 
select CT.id_contract, C.name_customer, E.name_employe, C.number, S.name_service, sum(DCT.quantity), CT.deposit
from contract CT left join customers C on CT.id_customer = C.id_customer
left join service S on S.id_service = CT.id_service
left join details_contract DCT on DCT.id_contract = CT.id_contract
left join secondary_services SS on SS.id_secondary_service = DCT.id_secondary_service
left join employes E on E.id_employe = CT.id_employe
where (month(CT.start_day) =10 or month(CT.start_day)=11 or month(CT.start_day)=12)
and CT.id_contract not in ( select id_contract from contract where (month(start_day) between 1 and 6) 
and year(start_day) = 2021 group by id_contract) group by CT.id_contract ;

-- 13. Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã 
-- đặt phòng. (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).

Select SS.*, sum(DCT.quantity) as sum from secondary_services SS 
join details_contract DCT on SS.id_secondary_service = DCT.id_secondary_service
group by id_secondary_service
having sum(DCT.quantity) = (select sum(quantity) as sumQ from details_contract group by id_secondary_service
order by sumQ desc limit 1);

-- 14.	Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một
-- lần duy nhất. Thông tin hiển thị bao gồm ma_hop_dong, ten_loai_dich_vu, ten_dich_vu_di_kem,
-- so_lan_su_dung (được tính dựa trên việc count các ma_dich_vu_di_kem).
 
 select CT.id_contract,TS.name_type, SS.name_secondary_service, S.name_service, count(CT.id_contract)
 from contract CT join details_contract DCT on DCT.id_contract = CT.id_contract
 left join secondary_services SS on SS.id_secondary_service = DCT.id_secondary_service
 join service S on S.id_service = CT.id_service
 join type_service TS on TS.id_type = S.id_type
 group by SS.id_secondary_service  having count(CT.id_contract) = 1
 order by CT.id_contract asc;
 
 -- 15. Hiển thi thông tin của tất cả nhân viên bao gồm ma_nhan_vien, 
 -- ho_ten, ten_trinh_do, ten_bo_phan, so_dien_thoai, dia_chi mới chỉ lập 
 -- được tối đa 3 hợp đồng từ năm 2020 đến 2021.
 
 select E.id_employe, E.name_employe, D.name_department, L.name_level, E.number, E.address
 from employes E join departments D on E.id_department = D.id_department
 join levels L on E.id_level = L.id_level
 left join contract CT on CT.id_employe = E.id_employe
 where year(CT.start_day) between 2020 and 2021
 group by E.id_employe having count(CT.id_contract) <3
 order by E.id_employe;
 
 -- 16. Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2019 đến năm 2021 (tạo biến tạm).
 delete from employes E where E.id_employe in (
 
 select tmp.id_employe from (
  select E.id_employe from employes E left join contract CT
 on E.id_employe = CT.id_employe where id_contract is null
 ) tmp
 
);

-- 17. Cập nhật thông tin những khách hàng có ten_loai_khach từ 
-- Platinum lên Diamond, chỉ cập nhật những khách hàng đã từng đặt 
-- phòng với Tổng Tiền thanh toán trong năm 2021 là lớn hơn 10.000.000 VNĐ.

update customers set id_type = 1 where id_customer in 
( select tmp.id_customer from (Select C.id_customer from customers C 
join contract CT on CT.id_customer = C.id_customer
join details_contract DCT on DCT.id_contract = CT.id_contract
join type_customer TC on TC.id_type = C.id_type
left join service S on S.id_service = CT.id_service
left join secondary_services SS on SS.id_secondary_service = DCT.id_secondary_service
where IFNULL((DCT.quantity*SS.price),0)+ S.rent_cost > 10000000 and TC.name_type = "Platinium"
group by C.id_customer) tmp);

-- 18. Xóa những khách hàng có hợp đồng trước năm 2021 (chú ý ràng buộc giữa các bảng).
delete from customers where id_customer in (
select temp.id_customer from (select C.id_customer, CT.start_day 
from customers C join contract CT on C.id_customer = CT.id_customer
where year(start_day) <2021)temp);

-- 19. Cập nhật giá cho các dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2020 lên gấp đôi.

update secondary_services SS set price = SS.price*2 where id_secondary_service in ( 
select temp.id_secondary_service from (
select SS.id_secondary_service from secondary_services SS 
join details_contract DCT on SS.id_secondary_service = DCT.id_secondary_service
join contract CT on CT.id_contract = DCT.id_contract 
where year(CT.start_day) = 2020 group by SS.id_secondary_service
having sum(DCT.quantity) > 10) temp );

-- 20. Hiển thị thông tin của tất cả các nhân viên và khách hàng có trong hệ thống, thông tin
--  hiển thị bao gồm id (ma_nhan_vien, ma_khach_hang), ho_ten, email, so_dien_thoai, ngay_sinh, dia_chi.

select id_customer as id, name_customer, email, number, date, address from customers
union
select id_employe as id, name_employe, email, number, date, address from employes;

-- 21. Tạo khung nhìn có tên là v_nhan_vien để lấy được thông tin 
-- của tất cả các nhân viên có địa chỉ là “Hải Châu” và đã từng lập hợp đồng 
-- cho một hoặc nhiều khách hàng bất kì với ngày lập hợp đồng là “12/12/2019”.

create or replace  view v_employe as
select * from employes E join contract CT
on E.id_employe = CT.id_employe
where address like "%Đà Nẵng%";

-- 22. Thông qua khung nhìn v_nhan_vien thực hiện cập nhật địa chỉ thành 
-- “Liên Chiểu” đối với tất cả các nhân viên được nhìn thấy bởi khung nhìn này.

update employes set address = replace(address,"Đà Nẵng","Liên Chiểu")
 where EXISTS( select tmp.* from (select * from v_employe)tmp );
 
 -- 23.	Tạo Stored Procedure sp_xoa_khach_hang dùng để xóa thông tin của một khách hàng
 -- nào đó với ma_khach_hang được truyền vào như là 1 tham số của sp_xoa_khach_hang.
 
delimiter //
create procedure sp_xoa_khach_hang(ma_khach_hang int)
begin
	delete from customers where id_customer = ma_khach_hang;
end //
delimiter ;

-- 24. Tạo Stored Procedure sp_them_moi_hop_dong dùng để 
-- thêm mới vào bảng hop_dong với yêu cầu sp_them_moi_hop_dong phải
-- thực hiện kiểm tra tính hợp lệ của dữ liệu bổ sung, với nguyên tắc
-- không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu đến các bảng liên quan.

delimiter //
create procedure sp_them_moi_hop_dong(ma_hop_dong int, uid_customer int,uid_service int, uid_employe int
,ustart_day datetime, end_day datetime, deposit double)
begin
	if ma_hop_dong in (select id_contract from contract) then
		SIGNAL sqlstate '45123' set message_text = "PK is duplicate in contract";
	end if;
    if uid_customer not in ( select id_customer from customers) then
		SIGNAL sqlstate '45124' set message_text = "FK customer not exists in table customers";
	end if;
    if uid_service not in ( select id_service from service) then
		SIGNAL sqlstate '45125' set message_text = "FK service not exists in table service";
	end if;
    if uid_employe not in ( select id_employe from employes) then
		SIGNAL sqlstate '45126' set message_text = "FK employe not exists in table employes";
	end if;
    insert into contract values (ma_hop_dong,ustart_day,end_day,deposit,uid_customer, uid_employe,uid_service );
end //
delimiter ;

-- 25. Tạo Trigger có tên tr_xoa_hop_dong khi xóa bản ghi 
-- trong bảng hop_dong thì hiển thị tổng số lượng bản ghi còn lại 
-- có trong bảng hop_dong ra giao diện console của database.

delimiter //
create trigger tr_xoa_hop_dong
after delete on contract
for each row
Begin
	declare count_contract int default 0;
    select count(id_contract) into count_contract from contract;
	signal sqlstate '01000' set message_text= count_contract;
    -- select 'Total remain record:' + count_contract As Message;
end //
delimiter ;

drop trigger tr_xoa_hop_dong;
select count(1) from contract;
call sp_them_moi_hop_dong(122,3,4,2,"2019-05-15", "2019-06-10",20000);
delete from contract where id_contract = 122;
-- 26.Tạo Trigger có tên tr_cap_nhat_hop_dong khi 
-- cập nhật ngày kết thúc hợp đồng, cần kiểm tra xem thời gian 
-- cập nhật có phù hợp hay không, với quy tắc sau: Ngày kết thúc hợp
-- đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày. Nếu dữ liệu 
-- hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ thì in ra thông báo 
-- “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database.

delimiter //
create trigger tr_cap_nhap_hop_dong
before update on contract
for each row
Begin
	if DATEDIFF(new.end_day, new.start_day) < 3
		then signal sqlstate '12346' set message_text = "So ngay nho hon 2";
	end if;
    if DATEDIFF(old.end_day, new.start_day) < 3
		then signal sqlstate '12346' set message_text = "So ngay nho hon 2";
	end if;
    if DATEDIFF(new.end_day, old.start_day) < 3
		then signal sqlstate '12346' set message_text = "So ngay nho hon 2";
	end if;
end //
delimiter ;

-- 27. Tạo Function thực hiện yêu cầu sau:
-- a. Tạo Function func_dem_dich_vu: Đếm các dịch vụ đã được sử dụng với tổng tiền là > 2.000.000 VNĐ.
SET GLOBAL log_bin_trust_function_creators = 1;
delimiter //
create function func_dem_dich_vu()
returns int
BEGIN
	DECLARE count_service int default 0;
    select count(1) into count_service  from service where id_service in 
    (select S.id_service from service S 
    join contract CT on S.id_service = CT.id_service 
    where S.rent_cost > 2000000 group by S.id_service) ;
	return count_service;
end //
delimiter ;
select func_dem_dich_vu();
 -- b.Tạo Function func_tinh_thoi_gian_hop_dong: Tính khoảng thời gian dài nhất tính
 -- từ lúc bắt đầu làm hợp đồng đến lúc kết thúc hợp đồng mà khách hàng đã thực hiện thuê dịch
 -- vụ (lưu ý chỉ xét các khoảng thời gian dựa vào từng lần làm hợp đồng thuê dịch vụ, không xét 
 -- trên toàn bộ các lần làm hợp đồng). Mã của khách hàng được truyền vào như là 1 tham số của function này.
 
 delimiter //
create function func_tinh_thoi_gian_hop_dong(ma_khach_hang int)
returns int
BEGIN
	DECLARE count_max_day int default 0;
    select ifnull(Max(DATEDIFF(CT.end_day, CT.start_day)),0) into count_max_day from contract CT left join
    customers C on C.id_customer = CT.id_customer where C.id_customer = ma_khach_hang
    group by C.id_customer;
	return count_max_day;
end //
delimiter ;

select(func_tinh_thoi_gian_hop_dong(3));

-- 28. Tạo Stored Procedure sp_xoa_dich_vu_va_hd_room để tìm các dịch vụ 
-- được thuê bởi khách hàng với loại dịch vụ là “Room” từ đầu năm 2015 đến hết năm 
-- 2019 để xóa thông tin của các dịch vụ đó (tức là xóa các bảng ghi trong bảng dich_vu) 
-- và xóa những hop_dong sử dụng dịch vụ liên quan (tức là phải xóa những bản gi trong bảng hop_dong)
 -- và những bản liên quan khác.
 
 delimiter //
create procedure sp_xoa_dich_vu_va_hd_room ()
begin
	delete from service where id_service in (
	select temp.id_service from (select S.id_service from  contract CT
    left join service S on S.id_service = CT.id_service
    join type_service TS on TS.id_type = S.id_type
    where TS.name_type = "room" and year(start_day) between 2015 and 2019 
    and year(end_day) between 2015 and 2019) temp);
end //
delimiter ;

call sp_xoa_dich_vu_va_hd_room();

insert into service values 
(7,"test 1 ",92929,12312,30,2923,12,"no","vip",3,2),
(8,"test 2 ",92929,12312,30,2923,12,"no","vip",3,1),
(9,"test 3 ",92929,12312,30,2923,12,"no","vip",3,3);

call sp_them_moi_hop_dong(101,3,7,3,"2016-05-15", "2017-06-10",20000);
call sp_them_moi_hop_dong(102,4,8,2,"2017-05-15", "2019-06-10",20000);
call sp_them_moi_hop_dong(103,2,9,1,"2015-05-15", "2019-06-10",20000);
