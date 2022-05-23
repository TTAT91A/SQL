--Q1
select HoTen,Luong
from GIAOVIEN

--Q2
select HoTen,Luong,Luong*1.1 as 'Luong Sau Khi Tang10%'
from GIAOVIEN

--Q3
select gv.MAGV, gv.HOTEN, bm.MABM,bm.MAKHOA
from GIAOVIEN gv
join BOMON bm
on gv.MAGV = bm.TRUONGBM
where (gv.HOTEN like N'Nguyễn%' and gv.LUONG > 1200) or (gv.MAGV = bm.TRUONGBM and year(bm.NGAYNHAMCHUC) > 1995)
--Q4
select gv.MAGV, gv.HOTEN
from GIAOVIEN gv 
join BOMON bm 
on gv.MABM = bm.MABM
where MAKHOA = 'CNTT'

--Q5 
select* 
from BOMON bm
join GIAOVIEN gv
on bm.TRUONGBM = gv.MAGV
where bm.TruongBM = gv.MaGV

--Q6
select gv.MaGV, bm.MABM, bm.TENBM, bm.TRUONGBM
from BOMON bm
join GIAOVIEN gv
on bm.MaBM = gv.MABM

--Q7
select TenDT, GVCNDT
from DETAI
--Q8
select *
from KHOA kh, GIAOVIEN gv
where kh.TruongKhoa = gv.MaGV

select *
from GIAOVIEN gv
join BOMON bm
on gv.MABM = bm.MABM
join KHOA kh
on kh.MAKHOA = bm.MAKHOA 

select kh.MAKHOA,gv.*
from KHOA kh
join GIAOVIEN gv
on kh.TRUONGKHOA = gv.MAGV

--Q9
select*
from GIAOVIEN gv
join THAMGIADT tgia
on tgia.MAGV = gv.MAGV and tgia.MADT ='006' and gv.MABM = 'VS'

--Q10
--không có dữ liệu cấp Thành phố

--Q11
select gv.MAGV, gv.HOTEN, gv1.MAGV as 'MaGVQLCM', gv1.HOTEN as 'HOTEN GVQLCM'
from GIAOVIEN gv
join GIAOVIEN gv1
on gv.GVQLCM = gv1.MAGV
--Q12
select gv.MAGV, gv.HOTEN, gv1.MAGV as 'MaGVQLCM', gv1.HOTEN as 'HOTEN GVQLCM'
from GIAOVIEN gv
join GIAOVIEN gv1
on gv.GVQLCM = gv1.MAGV 
where gv1.HOTEN = N'Nguyễn Thanh Tùng'
--Q13
select gv.MAGV, gv.HOTEN
from GIAOVIEN gv
join BOMON bm
on gv.MAGV = bm.TRUONGBM
where bm.TENBM = N'Hệ thống thông tin'
--Q14
select distinct gv.MAGV, gv.HOTEN
from GIAOVIEN gv
left join DETAI dt
on gv.MAGV = dt.GVCNDT
join CHUDE cd
on dt.MACD = cd.MACD
where cd.TENCD = N'Quản lí giáo dục'

--Q15  Cho	biết	tên	các	công	việc	của	đề tài	HTTT	quản	lý	các	trường	ĐH	có	thời	gian	bắt	đầu	 trong	tháng	3/2008.
select cv.TENCV
from  CONGVIEC cv
join DETAI dt
on cv.MADT = dt.MADT
where dt.TENDT = N'HTTT quản lý các trường ĐH'

--Q16  Cho	biết	tên	giáo	viên	và	tên	người	quản	lý	chuyên	môn	của	giáo	viên	đó.
select gv.MAGV, gv.HOTEN, gv1.MAGV as 'MaGVQLCM', gv1.HOTEN as 'HOTEN GVQLCM'
from GIAOVIEN gv
join GIAOVIEN gv1
on gv.GVQLCM = gv1.MAGV
--Q17
select cv.TENCV
from CONGVIEC cv
where cv.NGAYBD >= '2007-01-01' and cv.NGAYBD <= '2007-08-01'
--Q18 Cho	biết	họ tên	các	giáo	viên	cùng	bộ môn	với	giáo	viên	“Trần	Trà	Hương”.
select gv.MAGV, gv.HOTEN
from GIAOVIEN gv
join GIAOVIEN gv1
on gv.MABM = gv1.MABM
where gv1.HOTEN = N'Trần Trà Hương' and gv.HOTEN not like N'Trần Trà Hương'

--Q19  Tìm	những	giáo	viên	vừa	là	trưởng	bộ môn	vừa	chủ nhiệm	đề tài.
select gv.*, bm.TRUONGBM, dt.GVCNDT, dt.MADT
from GIAOVIEN gv
join BOMON bm
on gv.MAGV = bm.TRUONGBM
join DETAI dt
on dt.GVCNDT = gv.MAGV

--Q20
select gv.MAGV, gv.HOTEN
from GIAOVIEN gv
join KHOA kh
on kh.TRUONGKHOA = gv.MAGV
join BOMON bm
on bm.TRUONGBM = gv.MAGV
--Q21
select distinct gv.MAGV, gv.HOTEN
from GIAOVIEN gv
join BOMON bm
on bm.TRUONGBM = gv.MAGV
join DETAI dt
on dt.GVCNDT = gv.MAGV
--Q22
select distinct kh.TRUONGKHOA
from KHOA kh
join DETAI dt
on kh.TRUONGKHOA = dt.GVCNDT
--Q23
select distinct gv.MAGV
from GIAOVIEN gv
join THAMGIADT tgia
on gv.MAGV = tgia.MAGV
where gv.MABM = 'HTTT' and tgia.MADT = '001'
--Q24
select gv.MAGV
from GIAOVIEN gv
join GIAOVIEN gv1
on gv.MABM = gv1.MABM
where gv1.MAGV = '002'
--Q25
select gv.*
from GIAOVIEN gv
join BOMON bm
on bm.TRUONGBM = gv.MAGV
--Q26
select gv.HOTEN, gv.LUONG
from GIAOVIEN gv
