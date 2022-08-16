create database QuanLyBanHang ;

use QuanLyBanHang ;

create table Customer(
	cID int,
    cName varchar(50),
    cAge int,
    primary key(cID)
);

create table `Order` (
	oID int,
    cID int,
    oDate date,
    oTotalPrice float,
    primary key(oID),
    foreign key (cID) references Customer(cID)
);

create table Product (
	pID int,
    pName varchar(50),
    pPrice float,
    primary key (pID)
);

create table OrderDetail (
	oID int,
    pID int,
    odQTY int,
    foreign key (oID) references `Order`(oID),
    foreign key (pID) references Product(pID)
);

alter table orderDetail add primary key(oID,pID);