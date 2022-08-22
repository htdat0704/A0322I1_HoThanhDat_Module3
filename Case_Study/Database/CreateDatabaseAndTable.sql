Create database QuanLyKhuNghiDuongFurama;

use QuanLyKhuNghiDuongFurama;

create table employes (
	id_employe int primary key,
    name_employe varchar(45),
    `date` date,
    cmnd varchar(50),
    salary double,
    `number` varchar(50),
    email varchar(50),
    address varchar(50),
    id_position int,
    id_level int,
    id_department int,
    foreign key (id_position) references positions(id_position),
    foreign key (id_level) references levels(id_level),
    foreign key (id_department) references departments(id_department)
);

create table positions (
	id_position int primary key,
    name_position varchar(45)
);

create table levels (
	id_level int primary key,
    name_level varchar(45)
);

create table departments (
	id_department int primary key,
    name_department varchar(45)
);

create table type_customer (
	id_type int primary key,
    name_type varchar(45)
);

create table customers (
	id_customer int primary key,
    id_type int,
    name_customer varchar(45),
    `date` date,
    gender bit,
    cmnd varchar(45),
    `number` varchar(45),
    email varchar(45),
    address varchar(45),
    foreign key (id_type) references type_customer(id_type)
);

create table type_rent (
	id_rent int primary key,
    name_rent varchar(45)
);

create table type_service(
	id_type int primary key,
	name_type varchar(45)
);

create table service(
	id_service int primary key,
    name_service varchar(45),
    area int,
    rent_cost double,
    number_limit_customer int,
    area_pool double,
    floor int,
    other_comforts varchar(45),
    standard_room varchar(45),
    id_type int,
    id_rent int,
    foreign key (id_type) references type_service(id_type),
    foreign key (id_rent) references type_rent(id_rent)
);

create table secondary_services (
	id_secondary_service int primary key,
    name_secondary_service varchar(45),
    price double,
    unit varchar(10),
    `status` varchar(45)
);

create table contract (
	id_contract int primary key,
    start_day datetime,
    end_day datetime,
    deposit double,
    id_customer int,
    id_employe int,
    id_service int,
    foreign key (id_customer) references customers(id_customer),
    foreign key (id_employe) references employes(id_employe),
    foreign key (id_service) references service(id_service)
);

create table details_contract (
	id_details_contract int primary key,
    id_contract int,
    id_secondary_service int,
    quantity int,
    foreign key (id_contract) references contract(id_contract),
    foreign key (id_secondary_service) references secondary_services(id_secondary_service)
);






