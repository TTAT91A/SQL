--Q35
select MAX(luong) as 'Luong cao nhat'
from GIAOVIEN 
--Q36
select *
from GIAOVIEN
where (luong = (select MAX(luong)
		from GIAOVIEN ))
--Q37  Cho biết lương cao nhất trong bộ môn “HTTT”.
select MAX(luong) as 'max luong'
from GIAOVIEN gv
where gv.MABM = 'HTTT'
--Q38
select gv.HOTEN
from GIAOVIEN gv
where year(NGSINH) <= ALL(select year(NGSINH)
								from GIAOVIEN where MABM='HTTT') and gv.MABM = 'HTTT'
--q39 
select gv.HOTEN
from GIAOVIEN gv
join BOMON bm
on bm.MABM = gv.MABM
where year(NGSINH) >= ALL(select year(NGSINH)
								from GIAOVIEN gv1
								join BOMON bm
								on bm.MABM = gv1.MABM
								where bm.MAKHOA='CNTT') and bm.MAKHOA='CNTT'

--Q40 Cho biết tên giáo viên và tên khoa của giáo viên có lương cao nhất.
select gv.HOTEN, kh.TENKHOA
from GIAOVIEN gv
join BOMON bm
on gv.MABM = bm.MABM
join KHOA kh
on kh.MAKHOA = bm.MAKHOA
where  gv.LUONG = (select MAX(luong)
		from GIAOVIEN )
									
--Q41 Cho biết những giáo viên có lương lớn nhất trong bộ môn của họ.
select gv.MAGV, gv.HOTEN, gv.MABM
from GIAOVIEN gv
join (select max(luong) as 'luong max', gv.MABM
from GIAOVIEN gv
group by gv.MABM) as T
on T.MABM = gv.MABM
where gv.LUONG = T.[luong max]


--Q42
select distinct dt.TENDT
from THAMGIADT tgia
join DETAI dt
on dt.MADT = tgia.MADT
where tgia.MADT NOT IN (
select tgia.MADT
from THAMGIADT tgia
join GIAOVIEN gv
on gv.MAGV = tgia.MAGV
where gv.HOTEN = N'Nguyễn Hoài An')

--Q43
select distinct dt.TENDT, gv.HOTEN
from THAMGIADT tgia
join DETAI dt
on dt.MADT = tgia.MADT
join GIAOVIEN gv
on gv.MAGV = dt.GVCNDT
where tgia.MADT NOT IN (
select tgia.MADT
from THAMGIADT tgia
join GIAOVIEN gv
on gv.MAGV = tgia.MAGV
where gv.HOTEN = N'Nguyễn Hoài An')

--Q44 Cho biết tên những giáo viên khoa Công nghệ thông tin mà chưa tham gia đề tài nào.
select gv.HOTEN
from GIAOVIEN gv
join BOMON bm
on bm.MABM = gv.MABM
join KHOA kh
on kh.MAKHOA = bm.MAKHOA
where kh.MAKHOA = 'CNTT' and gv.HOTEN NOT IN (
select distinct gv.HOTEN
from GIAOVIEN gv
join BOMON bm
on bm.MABM = gv.MABM
join KHOA kh
on kh.MAKHOA = bm.MAKHOA
join THAMGIADT tgia
on tgia.MAGV = gv.MAGV
where kh.MAKHOA = 'CNTT'
)

--Q45  Tìm những giáo viên không tham gia bất kỳ đề tài nào
select distinct gv.*
from GIAOVIEN gv
where gv.MAGV NOT IN (
select distinct tgia.MAGV
from THAMGIADT tgia
)
--Q46  Cho biết giáo viên có lương lớn hơn lương của giáo viên “Nguyễn Hoài An”
select gv.*
from GIAOVIEN gv
where gv.LUONG > (
select gv.LUONG
from GIAOVIEN gv
where gv.HOTEN =N'Nguyễn Hoài An')
--Q47 Tìm những trưởng bộ môn tham gia tối thiểu 1 đề tài
select distinct gv.*
from GIAOVIEN gv
join BOMON bm
on bm.TRUONGBM = gv.MAGV
join THAMGIADT tgia
on tgia.MAGV = gv.MAGV
where gv.MAGV in (
select tgia.MAGV
from THAMGIADT tgia)
--Q48 Tìm giáo viên trùng tên và cùng giới tính với giáo viên khác trong cùng bộ môn
select *
from GIAOVIEN GV1, GIAOVIEN GV2
where GV1.HOTEN = GV2.HOTEN AND GV2.PHAI = GV1.PHAI  AND GV1.MAGV != GV2.MAGV AND GV1.MABM = GV2.MABM

--Q49 Tìm những giáo viên có lương lớn hơn lương của ít nhất một giáo viên bộ 
--môn “Công nghệ phần mềm”
select gv.*
from GIAOVIEN gv
where LUONG > any(
select LUONG
from GIAOVIEN gv
join BOMON bm
on bm.MABM = gv.MABM
where bm.TENBM = N'Công nghệ phần mềm')
--Q50 Tìm những giáo viên có lương lớn hơn lương của tất cả 
--giáo viên thuộc bộ môn “Hệ thống thông tin”
select gv.*
from GIAOVIEN gv
join BOMON bm
on bm.MABM = gv.MABM
where LUONG > all(
select LUONG
from GIAOVIEN gv
join BOMON bm
on bm.MABM = gv.MABM
where bm.TENBM = N'Hệ thống thông tin')

--Q51 Cho biết tên khoa có đông giáo viên nhất
select distinct kh.TENKHOA
from KHOA kh
join BOMON bm
on bm.MAKHOA = kh.MAKHOA
join (select count(*) as SLGV, kh.MAKHOA
		from GIAOVIEN gv
		join BOMON bm
		on bm.MABM = gv.MABM
		join KHOA kh
		on kh.MAKHOA = bm.MAKHOA
		group by kh.MAKHOA) as T1
on T1.MAKHOA = kh.MAKHOA
where T1.SLGV = (
select max(T.SLGV)
from (select count(*) as SLGV, kh.MAKHOA
		from GIAOVIEN gv
		join BOMON bm
		on bm.MABM = gv.MABM
		join KHOA kh
		on kh.MAKHOA = bm.MAKHOA
		group by kh.MAKHOA
) as T
)
--Q52  Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
select gv.HOTEN
from GIAOVIEN gv
join (select dt.GVCNDT, (count(dt.GVCNDT)) as 'SDT'
				from DETAI dt
				group by dt.GVCNDT) as dt1
on gv.MAGV = dt1.GVCNDT
join (select top 1 dt.GVCNDT, (count(dt.GVCNDT)) as 'SDT'
				from DETAI dt
				group by dt.GVCNDT
				order by 'SDT' desc) as dt2
on dt1.SDT = dt2.SDT

--Q53. Cho biết mã bộ môn có nhiều giáo viên nhất
select bm.MABM
from BOMON bm
join (
select count(gv.MABM) as 'SLGV', gv.MABM
from GIAOVIEN gv
group by MABM) as T
on bm.MABM = T.MABM
where T.SLGV >= all (
select count(gv.MABM) as 'SLGV'
from GIAOVIEN gv
group by MABM)

--Q54. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
SELECT HOTEN, TENBM
 FROM GIAOVIEN GV, BOMON BM
 WHERE GV.MABM = BM.MABM AND EXISTS      (SELECT GV2.MAGV
           FROM GIAOVIEN GV2, THAMGIADT TG
           WHERE GV2.MAGV = TG.MAGV  AND GV.MAGV = GV2.MAGV
           GROUP BY GV2.MAGV
           HAVING COUNT(*) >=ALL (SELECT (COUNT(*))
                 FROM GIAOVIEN GV3, THAMGIADT TG3
                 WHERE GV3.MAGV = TG3.MAGV
                 GROUP BY GV3.MAGV)
                )

--Q55. Cho biết tên giáo viên tham gia nhiều đề tài nhất của bộ môn HTTT.
select gv1.HOTEN
from GIAOVIEN gv1
where gv1.MAGV in (select tgia.MAGV
From GIAOVIEN gv,THAMGIADT tgia
where gv.MAGV=Tgia.MAGV and gv.MABM='HTTT'
group by tgia.MAGV
having count(*)>=all(select Count(*)
From GIAOVIEN gv,THAMGIADT tgia
where gv.MAGV=Tgia.MAGV and gv.MABM='HTTT'
group by tgia.MAGV))
--Q56. Cho biết tên giáo viên và tên bộ môn của giáo viên có nhiều người thân nhất.
SELECT HOTEN, TENBM
 FROM GIAOVIEN GV, BOMON BM
 WHERE GV.MABM = BM.MABM AND GV.MAGV IN (SELECT GV.MAGV
           FROM GIAOVIEN GV, NGUOITHAN NT
           WHERE GV.MAGV = NT.MAGV
           GROUP BY GV.MAGV
           HAVING COUNT(*) >=ALL (SELECT COUNT(*)
                 FROM GIAOVIEN GV, NGUOITHAN NT
                 WHERE GV.MAGV = NT.MAGV
                 GROUP BY GV.MAGV)
                 )
--Q57. Cho biết tên trưởng bộ môn mà chủ nhiệm nhiều đề tài nhất.
select gv.HOTEN
from GIAOVIEN gv
where gv.MAGV in (
select GVCNDT
from BOMON bm, DETAI dt
where bm.TRUONGBM = dt.GVCNDT 
group by GVCNDT
having count(*) >= all(
select count(*) as 'SLDT'
	from (
		select distinct GVCNDT, MADT
		from DETAI dt
		join BOMON bm
		on dt.GVCNDT = bm.TRUONGBM) as T1
	group by GVCNDT
))

