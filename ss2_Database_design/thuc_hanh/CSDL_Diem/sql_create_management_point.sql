CREATE DATABASE QuanLyDiemThi;

use QuanLyDiemThi;

create table HocSinh(
	MaHS varchar(50) PRIMARY KEY,
    TenHS varchar(50),
    NgaySinh date,
    Lop varchar(10),
    GioiTinh bit
);

create table MonHoc(
	MaMH varchar(50) primary key,
    TenMH varchar(50),
    MaGV varchar(50),
    FOREIGN KEY (MaGV) REFERENCES GiaoVien(MaGV)
);

create table GiaoVien(
	MaGV varchar(50) primary key,
    TenGV varchar(50),
    SDT int
);

create table BangDiem(
	MaHS varchar(50),
    MaMH varchar(50),
    DiemThi float,
    NgayKT date,
    primary key(MaHS,MaMH),
    foreign key (MaHS) references HocSinh(MaHS),
    foreign key (MaMH) references MonHoc(MaMH)
)