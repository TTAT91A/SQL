--35. 
SELECT NV.TEN
FROM NHANVIEN NV, PHANCONG PC
WHERE NV.MANV = PC.MANV AND NV.LOAINV = 0
GROUP BY NV.TEN
HAVING COUNT(NV.MANV) >= ALL (SELECT COUNT(*) 
       FROM PHANCONG PC, NHANVIEN NV
       WHERE NV.MANV = PC.MANV AND NV.LOAINV = 0
       GROUP BY PC.MANV)


--36. 
SELECT NV.TEN, NV.DCHI, NV.DTHOAI
FROM NHANVIEN NV, PHANCONG PC
WHERE PC.MANV = NV.MANV AND NV.LOAINV = 1
GROUP BY NV.TEN, NV.DCHI, NV.DTHOAI
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
        FROM PHANCONG PC, NHANVIEN NV
        WHERE PC.MANV = NV.MANV AND NV.LOAINV = 1
        GROUP BY PC.MANV)

--37. 
SELECT CB.SBDEN, COUNT(*) SOCHUYENBAYDEN
FROM CHUYENBAY CB
GROUP BY CB.SBDEN
HAVING COUNT(*)<=ALL(SELECT COUNT(*) 
					FROM CHUYENBAY CB
					GROUP BY CB.SBDEN)

--38. 
SELECT CB.SBDI, COUNT(*) SOCHUYENBAYDI
FROM CHUYENBAY CB
GROUP BY CB.SBDI
HAVING COUNT(*)>=ALL(SELECT COUNT(*) 
					FROM CHUYENBAY CB
					GROUP BY CB.SBDI)


--39. 
SELECT KH.TEN,KH.DCHI,KH.DTHOAI
FROM KHACHHANG KH, DATCHO DC
WHERE KH.MAKH=DC.MAKH
GROUP BY KH.TEN,KH.DCHI,KH.DTHOAI
HAVING COUNT(KH.MAKH) >=ALL(SELECT COUNT(*) FROM DATCHO DC GROUP BY DC.MAKH)



--40. 
SELECT NV.MANV,NV.TEN,NV.LUONG
FROM NHANVIEN NV, KHANANG KN
WHERE NV.MANV=KN.MANV AND NV.LOAINV=1
GROUP BY NV.MANV,NV.TEN,NV.LUONG
HAVING COUNT(*) >=ALL(SELECT COUNT(*) FROM KHANANG KN GROUP BY KN.MANV)