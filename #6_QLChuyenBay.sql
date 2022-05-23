use QLChuyenBay
--51
select distinct lb.MACB
from LICHBAY lb
where not exists (
		(select lmb.MALOAI from LOAIMB lmb where lmb.HANGSX='Boeing')
		except
		(select lb1.MALOAI from LICHBAY lb1 where lb1.MACB=lb.MACB )
)
--52
select distinct nv.MANV
from NHANVIEN nv 
where not exists (
			(select lmb.MALOAI from LOAIMB lmb where lmb.HANGSX='Airbus')
			except 
			(select lb.MALOAI from LICHBAY lb join PHANCONG pc on pc.NGAYDI=lb.NGAYDI and pc.MACB=lb.MACB
			where nv.MANV=pc.MANV) 

)and nv.LOAINV='1'
--53
select distinct nv.MANV
from NHANVIEN nv
where not exists (
			(select lb.NGAYDI,lb.MACB from LICHBAY lb where lb.MACB='100')
			except 
			(select pc.NGAYDI,pc.MACB from PHANCONG pc where pc.MANV=nv.MANV)
) and nv.LOAINV='0'
--54
select distinct lb.NGAYDI
from LICHBAY lb
where not exists (
			(select lmb.MALOAI from LOAIMB lmb where lmb.HANGSX='Boeing')
			except
			(select lb1.MALOAI from LICHBAY lb1 where lb1.NGAYDI=lb.NGAYDI)
)
--55
select lmb.MALOAI
from LOAIMB lmb
where  not exists(
			(select lb.NGAYDI from LICHBAY lb)
			except 
			(select lb.NGAYDI from LICHBAY lb where lb.MALOAI=lmb.MALOAI)
)and lmb.HANGSX='Boing'
--56
select distinct kh.TEN,kh.MAKH
from KHACHHANG kh
where not exists
(			(select lb.NGAYDI from LICHBAY lb where lb.NGAYDI between '2000/1/1'and '2000/11/30')
			except
			(select dc.NGAYDI from DATCHO dc where dc.MAKH=kh.MAKH)
)
--57
select distinct nv.MANV
from NHANVIEN nv
where  exists (
			(select lmb.maloai from LOAIMB lmb where lmb.HANGSX='Airbus')
			except
			(select lb.MALOAI from PHANCONG pc join LICHBAY lb on lb.MACB=pc.MACB and lb.NGAYDI=pc.NGAYDI
			where pc.MANV=nv.MANV)
) and nv.LOAINV='1'
--58
select distinct cb.SBDI
from CHUYENBAY cb
where  not exists (
			(select lmb.MALOAI from LOAIMB lmb where lmb.HANGSX='Boing')
			except
			(select lb.MALOAI from CHUYENBAY cb1 join LICHBAY lb on lb.MACB=cb1.MACB where cb1.SBDI=cb.SBDI )
)