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
IFNULL((DCT.quantity*SS.price),0) + S.rent_cost as Total
from customers C
left join contract CT on CT.id_customer = C.id_customer
left join type_customer TC on TC.id_type = C.id_type
left join Service S on  S.id_service = CT.id_service
left join details_contract DCT on CT.id_contract = DCT.id_contract
left join secondary_services SS on SS.id_secondary_service = DCT.id_secondary_service
group by id_contract
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
 
 