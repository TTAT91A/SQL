
--create proc sp_DatPhong @makhachhang varchar(5), @maphong varchar(5), @ngaydat datetime
--as
--begin
--	declare @ktra int
--	set @ktra = 1
--	if (@makhachhang not in(select kh.MaKH from KHACH kh))
--		set @ktra = 0
--	if (@maphong not in(select ph.MaPhong from PHONG ph))
--		set @ktra = 0
--	if (@ktra = 1 and @maphong in (select ph.MaPhong from PHONG ph where ph.TinhTrang = N'Rảnh'))
--		begin
--			insert into DATPHONG (NgayDP,NgayTra,ThanhTien) values (@ngaydat,NULL,NULL)
--			update PHONG set TinhTrang = N'Bận' where MaPhong = @maphong
--		end
--		print N'Đặt phòng thành công'
--	print N'Đặt phòng ko thành công'
--end

create function fDatPhong (@makhachhang varchar(5), @maphong varchar(5), @ngaydat datetime)
returns nvarchar
as
begin
	declare @ktra int
	set @ktra = 1
	if (@makhachhang not in(select kh.MaKH from KHACH kh))
		set @ktra = 0
	if (@maphong not in(select ph.MaPhong from PHONG ph))
		set @ktra = 0
	if (@ktra = 1 and @maphong in (select ph.MaPhong from PHONG ph where ph.TinhTrang = N'Rảnh'))
		begin
			insert into DATPHONG (NgayDP,NgayTra,ThanhTien) values (@ngaydat,NULL,NULL)
			update PHONG set TinhTrang = N'Bận' where MaPhong = @maphong
		end
		return N'DatPhongThanhCong!'
	return N'DatPhongKhongThanhCong!'
end
