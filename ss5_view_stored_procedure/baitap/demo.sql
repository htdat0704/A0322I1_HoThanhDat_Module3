create database demo;

use demo;
-- b1
create table Products(
	id int primary key,
    productCode varchar(25),
    productName varchar(25),
    productPrice float,
    productAmount int,
    productDescription varchar(25),
    productStatus bit default 0
);
-- b2
insert into Products values 
(1,"1234","Laptop1", 12345, 10, "đẹp", 1),
(2,"1235","Laptop2", 19999, 10, "đẹp", 0),
(3,"1236","Laptop3", 29999, 10, "đẹp", 1),
(4,"1237","Laptop4", 3999, 10, "đẹp", 1),
(5,"1238","Laptop5", 49999, 10, "đẹp", 0),
(6,"1239","Mouse1", 59999, 10, "đẹp", 0),
(7,"1240","Mouse2", 69999, 10, "đẹp", 1),
(8,"1241","Mouse3", 999, 10, "đẹp", 0),
(9,"1242","Mouse4", 9999, 10, "đẹp", 1),
(10,"1243","Screen1", 119999, 10, "đẹp", 1),
(11,"1244","Screen2", 109999, 10, "đẹp", 1),
(12,"1245","Screen3", 179999, 10, "đẹp", 0);

-- b3
create unique index index_product on Products(productCode);

create index composite_index on Products(productName,productPrice);

EXPLAIN select * from products where productCode ="1241";
EXPLAIN select * from products where productName ="Laptop1";

-- b4

create view view_Products as
select productCode, productName, productPrice, productStatus from products;

select * from view_products;

create or replace view view_Products as
select productName, productPrice, productStatus from products;

drop view view_products;

-- b5

DELIMITER //

create procedure get_all_information()
Begin
	select * from products;
end //

DELIMITER ;

call get_all_information();

DELIMITER //
create procedure add_product(id int, productCode varchar(25), productName varchar(25),
productPrice float, productAmount int, productDescription varchar(25), productStatus bit)
begin
	insert into products values
    (id,productCode,productName,productPrice,productAmount,productDescription,productStatus);
end //
DELIMITER ;

DELIMITER //
create procedure edit_product(uid int, uproductCode varchar(25), uproductName varchar(25),
uproductPrice float, uproductAmount int, uproductDescription varchar(25), uproductStatus bit)
begin
	update products set
    productCode = uproductCode, productName = uproductName,
    productPrice = uproductPrice, productAmount = uproductAmount,
    productDescription = uproductDescription, productStatus = uproductStatus
    where id = uid;
end //
DELIMITER ;
drop procedure edit_product;
call edit_product(15,"124567","Screen4", 999, 10, "đẹp", 1);

DELIMITER //
create procedure delete_product(idd int)
begin
	delete from products where id = idd;
end //
DELIMITER ;

call delete_product(15);