
create database QLDatPhong
use QLDatPhong
create table PHONG
(
	MaPhong varchar(5),
	TinhTrang nvarchar(5),
	LoaiPhong nvarchar(5),
	DonGia money
	constraint PK_Phong primary key (MaPhong)
)
create table KHACH
(
	MaKH varchar(5),
	HoTen nvarchar(50),
	DiaChi nvarchar(50),
	DienThoai int
	constraint PK_Khach primary key (MaKH)
)
create table DATPHONG
(
	MaDP int,
	MaKH varchar(5),
	MaPhong varchar(5),
	NgayDP datetime,
	NgayTra datetime,
	ThanhTien money
	constraint PK_DATPHONG primary key (MaDP)
)
alter table DATPHONG
add constraint FK_DATPHONG_KHACH foreign key (MaKH) references KHACH(MaKH)
alter table DATPHONG
add constraint FK_DATPHONG_PHONG foreign key (MaPhong) references PHONG(MaPhong)

