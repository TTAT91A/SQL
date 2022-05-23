--Q58. Cho biết tên giáo viên nào mà tham gia đề tài đủ tất cả các chủ đề.
select distinct gv.HOTEN
from THAMGIADT tgia
join GIAOVIEN gv
on gv.MAGV = tgia.MAGV
where not exists((select cd.MaCD from CHUDE cd)
				except
				(select dt2.MACD from THAMGIADT tgia2 join DETAI dt2 on dt2.MADT = tgia2.MADT
				where tgia2.magv = tgia.magv))


--Q59. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn HTTT tham gia.
select distinct tgia.MADT, dt.TENDT
from THAMGIADT tgia
join GIAOVIEN gv
on tgia.MAGV = gv.MAGV
join DETAI dt on dt.MADT = tgia.MADT
where gv.MABM = 'HTTT' and
		not exists ((select MAGV from GIAOVIEN gv where gv.MABM = 'HTTT')
					except
					(select tgia1.MAGV from THAMGIADT tgia1
					where tgia1.MADT = tgia.MADT))

--Q60. Cho biết tên đề tài có tất cả giảng viên bộ môn “Hệ thống thông tin” tham gia
select distinct tgia.MADT, dt.TENDT
from THAMGIADT tgia
join GIAOVIEN gv
on tgia.MAGV = gv.MAGV
join DETAI dt on dt.MADT = tgia.MADT
where gv.MABM = 'HTTT' and
		not exists ((select MAGV from GIAOVIEN gv where gv.MABM = 'HTTT')
					except
					(select tgia1.MAGV from THAMGIADT tgia1
					where tgia1.MADT = tgia.MADT))

--Q61. Cho biết giáo viên nào đã tham gia tất cả các đề tài có mã chủ đề là QLGD.
select tgia.MAGV
from THAMGIADT tgia
where not exists ((select * from DETAI dt
					where dt.MACD='QLGD' and not exists (
						select*
						from THAMGIADT tgia1
						where tgia1.MADT = dt.MADT and tgia1.MAGV = tgia.MAGV and dt.MACD = 'QLGD')))
--Q62. Cho biết tên giáo viên nào tham gia tất cả các đề tài mà giáo viên Trần Trà Hương đã tham gia.
select distinct gv.HOTEN
from THAMGIADT tgia
join GIAOVIEN gv on gv.MAGV=tgia.MAGV
where not exists(
				(select MAGV from GIAOVIEN where HOTEN = N'Trần Trà Hương')
				except
				(select tgia2.MAGV from THAMGIADT tgia2
				 where tgia2.MADT = tgia.MADT and HOTEN != N'Trần Trà Hương')
				)

select distinct gv.HOTEN
from THAMGIADT tgia
join GIAOVIEN gv on gv.MAGV = tgia.MAGV
where not exists((select tgia2.MADT from THAMGIADT tgia2 join GIAOVIEN gv2 on gv2.MAGV = tgia2.MAGV where gv2.HOTEN = N'Trần Trà Hương')
				except 
				(select MADT from THAMGIADT tgia3 where tgia3.MAGV = tgia.MAGV)) and gv.HOTEN != N'Trần Trà Hương'
--Q63. Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn Hóa Hữu Cơ tham gia.
select distinct dt.TENDT
from THAMGIADT tgia
join DETAI dt on dt.MADT = tgia.MADT
where not exists (
					(select MAGV from GIAOVIEN gv1 join BOMON bm on bm.MABM = gv1.MABM where bm.TENBM = N'Hóa hữu cơ') 
					 except
					(select tgia2.MAGV from THAMGIADT tgia2
					 where tgia2.MADT = tgia.MADT)
					) and exists (select gv2.MAGV from GIAOVIEN gv2 join BOMON bm2 on bm2.MABM = gv2.MABM where bm2.TENBM = N'Hóa hữu cơ')
--Q64. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài 006.
select distinct gv.MAGV
from THAMGIADT tgia
join GIAOVIEN gv on gv.MAGV = tgia.MAGV
where not exists(
				(select cv.MADT, cv.SOTT from CONGVIEC cv where cv.MADT = '006')
				 except
				(select tgia2.MADT, tgia2.STT from THAMGIADT tgia2 where tgia2.MAGV = tgia.MAGV))

--Q65. Cho biết giáo viên nào đã tham gia tất cả các đề tài của chủ đề Ứng dụng công nghệ.
select distinct gv.hoten 
from THAMGIADT tgia
join GIAOVIEN gv on gv.MAGV=tgia.MAGV
where not exists (
		(select dt.MADT from CHUDE cd join DETAI dt on cd.MACD=dt.MACD
		where cd.TENCD=N'Ứng dụng công nghệ')
		except 
		(select tgia1.madt   from THAMGIADT tgia1 where tgia1.MAGV=tgia1.MAGV)
)
--Q66. Cho biết tên giáo viên nào đã tham gia tất cả các đề tài của do Trần Trà Hương làm chủ nhiệm.
select distinct gv2.HOTEN
from THAMGIADT tgia
join GIAOVIEN gv2 on gv2.MAGV = tgia.MAGV
where not exists(
				(select dt.MADT from DETAI dt join GIAOVIEN gv on gv.MAGV = dt.GVCNDT where gv.HOTEN = N'Trần Trà Hương')
				except
				(select tgia2.MADT from THAMGIADT tgia2 where tgia2.MAGV = tgia.MAGV))
--Q67. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa CNTT tham gia.
select tgia.MADT, dt.TENDT
from THAMGIADT tgia
join DETAI dt on dt.MADT = tgia.MADT
where not exists (
				(select gv.MAGV from GIAOVIEN gv join BOMON bm on bm.MABM = gv.MABM where bm.MAKHOA = 'CNTT')
				except
				(select tgia2.MAGV from THAMGIADT tgia2 where tgia2.MADT = tgia.MADT))
--Q68. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài Nghiên cứu tế bào gốc.
select distinct gv.HOTEN
from THAMGIADT tgia
join GIAOVIEN gv on gv.MAGV = tgia.MAGV
where not exists(
				(select cv.MADT, cv.SOTT from CONGVIEC cv 
				join DETAI dt on dt.MADT = cv.MADT
				where dt.TENDT = N'Nghiên cứu tế bào gốc')
				except
				(select tgia2.MADT, tgia2.STT from THAMGIADT tgia2 where tgia2.MAGV = tgia.MAGV))
--Q69. Tìm tên các giáo viên được phân công làm tất cả các đề tài có kinh phí trên 100 triệu?
select distinct gv.HOTEN
from THAMGIADT tgia
join GIAOVIEN gv on gv.MAGV=tgia.MAGV
where not exists (
			(select dt.MADT from DETAI dt where dt.KINHPHI>100)
			except 
			(select tgia1.MADT from THAMGIADT tgia1 where tgia.magv=tgia1.MAGV)
)
--Q70. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa Sinh Học tham gia.
select distinct  dt.TENDT
from THAMGIADT tgia
join detai dt on dt.MADT=tgia.MADT
where not exists (
			(select gv.MAGV from GIAOVIEN gv join BOMON bm on bm.MABM=gv.MABM
				join khoa k on k.MAKHOA=bm.MAKHOA where k.TENKHOA=N'Sinh học')
				except 
				(select tgia1.MAGV from THAMGIADT tgia1 where tgia1.MADT=tgia.MADT)
)
--Q71. Cho biết mã số, họ tên, ngày sinh của giáo viên tham gia tất cả các công việc của đề tài “Ứng dụng hóa học xanh”.
select distinct gv.MAGV, gv.HOTEN,gv.ngsinh
from THAMGIADT tgia
join GIAOVIEN gv on gv.MAGV=tgia.MAGV
where not exists (
	(select cv.MADT,cv.SOTT from DETAI dt join CONGVIEC cv on cv.MADT=dt.MADT 
	where dt.TENDT=N'Ứng dụng hóa học xanh')
	except 
	(select tgia1.MADT,tgia1.STT from THAMGIADT tgia1 where tgia.MAGV=tgia1.MAGV)
) and exists (select cv.MADT,cv.SOTT from DETAI dt join CONGVIEC cv on cv.MADT=dt.MADT 
	where dt.TENDT=N'Ứng dụng hóa học xanh')
--Q72. Cho biết mã số, họ tên, tên bộ môn và tên người quản lý chuyên môn của giáo viên tham gia tất cả các đề tài thuộc chủ đề “Nghiên cứu phát triển”.
select distinct gv.MAGV, gv.HOTEN , gv1.HOTEN as GVquanli
from THAMGIADT tgia
join GIAOVIEN gv on gv.MAGV=tgia.MAGV
join GIAOVIEN gv1 on gv1.MAGV=gv.GVQLCM
where not exists (
		(select dt.MADT from detai dt join CHUDE cd on cd.MACD=dt.MACD 
		where cd.TENCD=N'Nghiên cứu phát triển')
		except 
		(select tgia.MADT from THAMGIADT tgia1 where tgia1.MAGV=tgia.MAGV)
)