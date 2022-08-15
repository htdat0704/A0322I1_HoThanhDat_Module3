use quanlybanhang;

insert into Customer (cID, cName, CAge)
values (1,"Minh Quan",10), (2,"Ngoc Oanh",20), (3,"Hong Ha",50);

insert into `order` (oID, cID, oDate, oTotalPrice)
values (1,1,"2006/3/21",null),(2,2,"2006/3/23",null), (3,1,"2006/3/16",null);

insert into product (pID,pName,pPrice)
values (1,"May Giat",3),(2, "Tu Lanh", 5),(3, "Dieu Hoa",7),(4, "Quat",1),(5,"Bep Dien",2);

insert into OrderDetail (oID,pID ,odQTY )
values (1,1,3),(1, 3, 7),(1, 4,2),(2, 1,1),(3,1,8),(2, 5,4),(2,3,3);
 
 -- 1 Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
Select oID ,oDate ,oTotalPrice from `order`;

-- 2 Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
select C.cName,P.pName from
 Customer C join `Order` O on C.cID = O.cID 
 join `OrderDetail` OD on OD.oID = O.oID 
 join Product P where P.pID = OD.pID;

-- 3 Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào (use explain to test performence)
select cName from Customer where cID 
not in (select C.cID from Customer C join `order` O on C.cID = O.cID);

-- 4 Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT cName FROM customer c
LEFT JOIN `order` o on o.cid= c.cid
WHERE o.oid is NULL;

select O.oID, O.oDate as `Date`, sum(OD.odQTY*P.pPrice) as total from
`order` O left join orderdetail OD on O.oID = OD.oID join Product P on OD.pID = P.pID
GROUP BY O.oID;

