use QLChuyenBay
--Q1
select nv.MaNV, nv.Ten, nv.DiaChi,nv.DienThoai
from NHANVIEN nv
join KHANANG kn
on nv.MaNV = kn.MaNV
where kn.MaLoai = 'B747'
--Q2
select cb.MaCB, lb.NgayDi
from CHUYENBAY cb
join LICHBAY lb
on cb.MaCB = lb.MaCB
where cb.SbDi = 'DCA' and (cb.GioDi >= '14:00' and cb.GioDi <= '18:00')
--Q3
select distinct nv.Ten
from NHANVIEN nv
join PHANCONG pc
on nv.MaNV = pc.MaNV
join CHUYENBAY cb
on pc.MaCB = cb.MaCB
where cb.SbDi = 'SLC'
--Q4
select lb.MaLoai, lb.SoHieu
from LICHBAY lb
join CHUYENBAY cb
on lb.MaCB = cb.MaCB
where cb.SbDi = 'MIA'
--Q5
select distinct dc.MaCB, dc.NgayDi, kh.MaKH, kh.Ten, kh.DiaChi, kh.DienThoai
from KHACHHANG kh
join DATCHO dc
on dc.MaKH = kh.MaKH
join LICHBAY lb
on lb.MaCB = dc.MaCB
order by MaCB asc, NgayDi desc
--Q6
select distinct lb.MaCB, lb.NgayDi, nv.Ten, nv.DiaChi, nv.DienThoai
from NHANVIEN nv
join PHANCONG pc
on nv.MaNV = pc.MaNV
join LICHBAY lb
on lb.MaCB = pc.MaCB
order by MaCB asc, NgayDi desc
--Q7
select distinct cb.MaCB, pc.NgayDi, pc.MaNV, nv.Ten
from NHANVIEN nv
join PHANCONG pc
on pc.MaNV = nv.MaNV
join CHUYENBAY cb
on cb.MaCB = pc.MaCB
where nv.LoaiNV = '1' and cb.SbDen = 'ORD'
--Q8 
select distinct cb.MaCB, pc.NgayDi, nv.Ten
from CHUYENBAY cb
join PHANCONG pc
on pc.MaCB = cb.MaCB
join NHANVIEN nv
on nv.MaNV = pc.MaNV
where nv.MaNV ='1001'
--Q9
select distinct cb.MaCB, cb.SbDi, cb.GioDi, cb.GioDen, lb.NgayDi
from CHUYENBAY cb
join LICHBAY lb
on lb.MaCB = cb.MaCB
order by NgayDi desc, cb.SbDi asc
--Q10
select nv.MaNV, nv.Ten, lmb.HangSX, lmb.MaLoai
from NHANVIEN nv
join KHANANG kn
on kn.MaNV = nv.MaNV
join LOAIMB lmb
on lmb.MaLoai = kn.MaLoai
where nv.LoaiNV ='1'
--Q11
select nv.MaNV, nv.Ten
from NHANVIEN nv
join PHANCONG pc
on pc.MaNV = nv.MaNV 
where pc.MaCB = '100' and pc.NgayDi='2000-11-01' and nv.LoaiNV ='1'
--Q12
select distinct cb.MaCB, nv.MaNV, nv.Ten
from NHANVIEN nv
join PHANCONG pc
on pc.MaNV = nv.MaNV 
join CHUYENBAY cb
on cb.MaCB = pc.MaCB
where pc.NgayDi = '2000-10-31' and cb.SbDi = 'MIA' and cb.GioDi = '20:30'
--Q13
select distinct pc.MaCB, mb.SoHieu, mb.MaLoai, lmb.HangSX
from NHANVIEN nv
join PHANCONG pc
on pc.MaNV = nv.MaNV
join KHANANG kn
on kn.MaNV = nv.MaNV
join MAYBAY mb
on mb.MaLoai = kn.MaLoai
join LOAIMB lmb
on lmb.MaLoai = mb.MaLoai
where nv.Ten='Quang'
 --Q14 chưa được
select nv.Ten
from NHANVIEN nv
left join PHANCONG pc 
on nv.MaNV = pc.MaNV
where pc.MaNV IS NULL

--Q15
select distinct kh.Ten
from KHACHHANG kh
join DATCHO dc
on kh.MaKH = dc.MaKH
join LICHBAY lb
on lb.MaCB = dc.MaCB
join LOAIMB lmb
on lmb.MaLoai = lb.MaLoai
where lmb.HangSX = 'Boeing'
--Q16
select lb.MaCB
from LICHBAY lb
where lb.SoHieu='10' and lb.MaLoai='B747'
