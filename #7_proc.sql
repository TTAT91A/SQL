--j) Xuất ra toàn bộ danh sách giáo viên.
create proc sp_XuatDSGV
as
	select* from GIAOVIEN
exec sp_XuatDSGV

--k) Tính số lượng đề tài mà một giáo viên đang thực hiện.
create procedure sp_SoLuongDeTai @MaGV varchar(5)
as
begin
	select count(distinct tgia.MADT)
	from THAMGIADT tgia, GIAOVIEN gv
	where tgia.MAGV = gv.MAGV and tgia.MAGV = @MaGV
end
exec sp_SoLuongDeTai'006'
--l) In thông tin chi tiết của một giáo viên(sử dụng lệnh print): Thông tin cá
--	nhân, Số lượng đề tài tham gia, Số lượng thân nhân của giáo viên đó.
create proc sp_InGV @magv varchar(5)
as 
begin
	select magv, hoten, (select count(*) from NGUOITHAN where magv = @magv) as 'SoTN',
			(select count(distinct MADT) from THAMGIADT where MAGV = @magv) as 'SoDT'
	from GIAOVIEN
	where MAGV = @magv
end
go
exec sp_InGV '003'
--m) Kiểm tra xem một giáo viên có tồn tại hay không (dựa vào MAGV).
create proc sp_KtraGV @magv varchar(5)
as
begin
	if(exists(select * from GIAOVIEN where MAGV = @magv))
		print N'Giáo viên tồn tại'
	else
		print N'Giáo viên ' +@magv +N' không tồn tại!'
end
go
exec sp_KtraGV '002'

--n) Kiểm tra quy định của một giáo viên: Chỉ được thực hiện các đề tài mà bộ
--môn của giáo viên đó làm chủ nhiệm.
create proc sp_KtraGVDT @magv varchar(5)
as
begin	
	if(select from )
end

--o) Thực hiện thêm một phân công cho giáo viên thực hiện một công việc của đề tài:
--	o Kiểm tra thông tin đầu vào hợp lệ: giáo viên phải tồn tại, 
--		công việc phải tồn tại, thời gian tham gia phải >0
--	o Kiểm tra quy định ở câu n.
create proc sp_ThemGVThucHienCV @magv varchar(5), @congviec nvarchar(50), @thoigiantgia time
as
begin
		
end
--p) Thực hiện xoá một giáo viên theo mã. Nếu giáo viên có thông tin liên quan
--	(Có thân nhân, có làm đề tài, ...) thì báo lỗi.
create proc sp_XoaGV @magv varchar(5)
as
begin
	declare @hop_le int
	set @hop_le = 1
	--co tham gia dt
	if @magv in (select MAGV from THAMGIADT)
		set @hop_le = 0
	--co nguoi than
	if @magv in (select MAGV from NGUOITHAN)
		set @hop_le = 0
	--gvqlcm
	if @magv in (select GVQLCM from GIAOVIEN)
		set @hop_le = 0
	--co la truong bm
	if(@magv in (select TRUONGBM from bomon))
		set @hop_le = 0
	-- lam truong khoa
	if(@magv in (select truongkhoa from khoa))
		set @hop_le = 0
	-- lam chu nhiem de tai
	if(@magv in (select gvcndt from detai))
		set @hop_le = 0

	if (@hop_le = 1)
		begin
			delete from GIAOVIEN
			where MAGV = @magv
			print N'Đã xóa!!!'
		end
	else
		print N'Không thể xóa!!!'
end

--q) In ra danh sách giáo viên của một phòng ban nào đó cùng với số lượng đề
--	tài mà giáo viên tham gia, số thân nhân, số giáo viên mà giáo viên đó quản
--	lý nếu có, ...
create proc sp_InDSGV @makhoa varchar(5)
as
begin
	select gv.*,(select count(distinct MADT) from THAMGIADT where gv.MAGV = MAGV) as 'SoDT',
			(select count(*) from NGUOITHAN where gv.MAGV = MAGV) as 'SoNT',
			(select count(*) from GIAOVIEN where gv.GVQLCM = MAGV) as 'SoGVQL'
	from GIAOVIEN gv
	join BOMON bm on bm.MABM = gv.MABM
	where bm.MAKHOA = @makhoa
end
exec sp_InDSGV 'CNTT'
--r) Kiểm tra quy định của 2 giáo viên a, b: Nếu a là trưởng bộ môn c của b thì
--	lương của a phải cao hơn lương của b. (a, b: mã giáo viên)
create proc sp_KtraGVa_b @magv1 varchar(5), @magv2 varchar(5)
as
begin
	declare @ktra int
	set @ktra = 1
	if (@magv1 in ( select bm.TRUONGBM
					from GIAOVIEN gv
					join BOMON bm on bm.MABM = gv.MABM
					where gv.MAGV = @magv2))
		begin
			declare @luong1 money, @luong2 money
			select @luong1 = luong
			from GIAOVIEN
			where MAGV = @magv1
			select @luong2 = luong
			from GIAOVIEN
			where MAGV = @magv2
			if (@luong1 <= @luong2)
				set @ktra = 0
		end
	if(@ktra = 1)
		print N'Đúng quy định'
	else
		print N'Sai quy dinh'
end
exec sp_KtraGVa_b '002', '003'
-- s. Thêm một giáo viên: Kiểm tra các quy định: Không trùng tên, tuổi > 18, lương > 0
create proc sp_ThemGV @magv varchar(5), @hoten nvarchar(50), @luong money, @phai nvarchar(3),
					  @ngsinh date, @diachi nvarchar(50), @gvqlcm varchar(10), @mabm varchar(10)
as
begin
	declare @ktra int
	set @ktra = 1
	if (@hoten in (select HOTEN from GIAOVIEN))
		set @ktra = 0
	if (DATEDIFF(y, @ngsinh, getdate()) <=18)
		set @ktra = 0
	if (@luong < 0)
		set @ktra = 0
	if (@ktra = 1)
		begin
			insert into GIAOVIEN values(@magv, @hoten, @luong, @phai, @ngsinh, @diachi, @gvqlcm,@mabm)
			print N'Them Giao Vien thanh cong'
		end
	else
		print N'Khong thoa man quy dinh'
end
--t) Mã giáo viên được xác định tự động theo quy tắc: Nếu đã có giáo viên 001,
--		002, 003 thì MAGV của giáo viên mới sẽ là 004. Nếu đã có giáo viên 001,
--		002, 005 thì MAGV của giáo viên mới là 003.
create proc sp_TuDongThemMaGV @magv varchar(5)
as
begin
	declare @i int
	set @i = 0
	while exists(select gv.MAGV from GIAOVIEN gv where gv.MAGV = '00'+ @i)
		set @i = @i +1
	set @magv = '00' + @i
end