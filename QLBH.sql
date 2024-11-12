﻿CREATE DATABASE QLBH
USE QLBH

CREATE TABLE KHACHHANG(
	MAKH char(4) PRIMARY KEY,
	HOTEN varchar(40),
	DIACHI varchar(50),
	SDT varchar(20),
	NGSINH smalldatetime,
	DOANHSO money,
	NGDK smalldatetime,
);

CREATE TABLE NHANVIEN(
	MANV char(4) PRIMARY KEY,
	HOTEN varchar(40),
	NGVL smalldatetime,
	SDT varchar(20),
);

CREATE TABLE SANPHAM(
	MASP char(4) PRIMARY KEY,
	TENSP varchar(40),
	DVT varchar(20),
	NUOCSX varchar(20),
	GIA money,
);

CREATE TABLE HOADON(
	SOHD int PRIMARY KEY,
	NGHD smalldatetime,
	MAKH char(4) REFERENCES KHACHHANG(MAKH),
	MANV char(4) REFERENCES NHANVIEN(MANV),
	TRIGIA money,
);

CREATE TABLE CTHD(
	SOHD int REFERENCES HOADON(SOHD),
	MASP char(4) REFERENCES SANPHAM(MASP),
	SL int,
	PRIMARY KEY (SOHD, MASP),
);





ALTER TABLE SANPHAM
ADD GHICHU varchar(20)

ALTER TABLE KHACHHANG
ADD LOAIKH tinyint 

ALTER TABLE SANPHAM
ALTER COLUMN GHICHU varchar(100)

ALTER TABLE SANPHAM
DROP COLUMN GHICHU

ALTER TABLE KHACHHANG ALTER COLUMN LOAIKH varchar(12)
ALTER TABLE KHACHHANG ADD CONSTRAINT CHECKLOAIKH CHECK( LOAIKH IN ('Vang lai', 'Thuong xuyen', 'Vip'))

ALTER TABLE SANPHAM ADD CONSTRAINT CHECKSP CHECK(DVT IN('cay', 'hop', 'cai', 'quyen', 'chuc'))

ALTER TABLE SANPHAM ADD CONSTRAINT CHECKGIA CHECK(GIA>=500)

ALTER TABLE HOADON ADD CONSTRAINT CHECKSOSPMUA CHECK(TRIGIA>0)

ALTER TABLE KHACHHANG ADD CONSTRAINT CHECKNGAYDK CHECK(NGDK>=NGSINH)

--LAB2
--CÂU 1 LAB 2:
INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
('BC01', 'But chi', 'cay', 'Singapore', 3000),
('BC02', 'But chi', 'cay', 'Singapore', 5000),
('BC03', 'But chi', 'cay', 'Viet Nam', 3500),
('BC04', 'But chi', 'hop', 'Viet Nam', 30000),
('BB01', 'But bi', 'cay', 'Viet Nam', 5000),
('BB02', 'But bi', 'cay', 'Trung Quoc', 7000),
('BB03', 'But bi', 'hop', 'Thai Lan', 100000),
('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', 2500),
('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 4500),
('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000),
('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500),
('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000),
('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000),
('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000),
('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', 40000),
('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000),
('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000),
('ST04', 'So tay', 'quyen', 'Thai Lan', 55000),
('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000),
('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000),
('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000),
('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000),
('ST09', 'But long', 'cay', 'Viet Nam', 5000),
('ST10', 'But long', 'cay', 'Trung Quoc', 7000);

INSERT INTO NHANVIEN (MANV, HOTEN, SDT, NGVL) 
VALUES 
('NV01', 'Nguyen Nhu Nhut', '0927345678', '2006-04-13'),
('NV02', 'Le Thi Phi Yen', '0987567390', '2006-04-21'),
('NV03', 'Nguyen Van B', '0997047382', '2006-04-27'),
('NV04', 'Ngo Thanh Tuan', '0913758498', '2006-06-24'),
('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '2006-07-20');

INSERT INTO KHACHHANG (MAKH, HOTEN, DIACHI, SDT, NGSINH, DOANHSO, NGDK)
VALUES
('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '1960-10-22', 13060000, '2006-07-22'),
('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '1974-04-03', 280000, '2006-07-30'),
('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '1980-06-12', 3860000, '2006-08-05'),
('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '1965-03-09', 250000, '2006-10-02'),
('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '08246108', '1950-03-10', 21000, '2006-10-28'),
('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '08631738', '1981-12-31', 915000, '2006-11-24'),
('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '1971-04-06', 12500, '2006-12-01'),
('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '1971-01-10', 365000, '2006-12-13'),
('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '08654763', '1979-09-03', 70000, '2007-01-14'),
('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '08768904', '1983-05-02', 67500, '2007-01-16');

INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES
(1001, '2006-07-23', 'KH01', 'NV01', 320000),
(1002, '2006-08-12', 'KH01', 'NV02', 840000),
(1003, '2006-08-23', 'KH02', 'NV01', 100000),
(1004, '2006-09-01', 'KH02', 'NV01', 180000),
(1005, '2006-10-20', 'KH01', 'NV02', 3800000),
(1006, '2006-10-16', 'KH01', 'NV03', 2430000),
(1007, '2006-10-28', 'KH03', 'NV03', 510000),
(1008, '2006-10-28', 'KH01', 'NV03', 440000),
(1009, '2006-10-28', 'KH03', 'NV04', 200000),
(1010, '2006-11-01', 'KH01', 'NV01', 5200000),
(1011, '2006-11-04', 'KH04', 'NV03', 250000),
(1012, '2006-11-30', 'KH05', 'NV03', 21000),
(1013, '2006-12-12', 'KH06', 'NV01', 5000),
(1014, '2006-12-31', 'KH03', 'NV02', 3150000),
(1015, '2007-01-01', 'KH06', 'NV01', 910000),
(1016, '2007-01-01', 'KH07', 'NV02', 12500),
(1017, '2007-01-02', 'KH08', 'NV03', 35000),
(1018, '2007-01-13', 'KH08', 'NV03', 330000),
(1019, '2007-01-13', 'KH01', 'NV03', 30000),
(1020, '2007-01-14', 'KH09', 'NV04', 70000),
(1021, '2007-01-16', 'KH10', 'NV03', 67500),
(1022, '2007-01-16', NULL, 'NV03', 7000),
(1023, '2007-01-17', NULL, 'NV01', 330000);

INSERT INTO CTHD (SOHD, MASP, SL)
VALUES
(1001, 'TV02', 10),
(1001, 'ST01', 5),
(1001, 'BC01', 5),
(1001, 'BC02', 10),
(1001, 'ST08', 10),
(1002, 'BC04', 20),
(1002, 'BB01', 20),
(1002, 'BB02', 20),
(1003, 'BB03', 10),
(1004, 'TV01', 20),
(1004, 'TV02', 10),
(1004, 'TV03', 10),
(1004, 'TV04', 10),
(1005, 'TV05', 50),
(1005, 'TV06', 50),
(1006, 'TV07', 20),
(1006, 'ST01', 30),
(1006, 'ST02', 10),
(1007, 'ST03', 10),
(1008, 'ST04', 8),
(1009, 'ST05', 10),
(1010, 'TV07', 50),
(1010, 'ST07', 50),
(1010, 'ST08', 100),
(1010, 'ST04', 50),
(1010, 'TV03', 100),
(1011, 'ST06', 50),
(1012, 'ST07', 3),
(1013, 'ST08', 5),
(1014, 'BC02', 80),
(1014, 'BB02', 100),
(1014, 'BC04', 60),
(1014, 'BB01', 50),
(1015, 'BB02', 30),
(1015, 'BB03', 7),
(1016, 'TV01', 5),
(1017, 'TV02', 1),
(1017, 'TV03', 1),
(1017, 'TV04', 5),
(1018, 'ST04', 6),
(1019, 'ST05', 1),
(1019, 'ST06', 2),
(1020, 'ST07', 10),
(1021, 'ST08', 5),
(1021, 'TV01', 7),
(1021, 'TV02', 10),
(1022, 'ST07', 1),
(1023, 'ST04', 6);

--LAB3
--Bài tập 1: Sinh viên hoàn thành Phần III bài tập QuanLyBanHang câu 12 và câu 13.

--Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT
	SOHD
FROM
	CTHD
WHERE 
	MASP='BB01' OR MASP='BB02'	
	AND (SL BETWEEN 10 AND 20);
--Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT
	SOHD
FROM
	CTHD
WHERE 
	MASP='BB01'
	AND (SL BETWEEN 10 AND 20)

INTERSECT

SELECT
	SOHD
FROM
	CTHD
WHERE 
	MASP='BB02'
	AND (SL BETWEEN 10 AND 20);
--Bài tập 4: Sinh viên hoàn thành Phần III bài tập QuanLyBanHang từ câu 14 đến 18.
--In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT DISTINCT sp.MASP, sp.TENSP
FROM SANPHAM sp
LEFT JOIN CTHD ctd ON sp.MASP = ctd.MASP
LEFT JOIN HOADON hd ON ctd.SOHD = hd.SOHD
WHERE sp.NUOCSX = 'Trung Quoc'
   OR hd.NGHD = '2007-01-01';
--In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT 
	MASP,
	TENSP
FROM
	SANPHAM
EXCEPT
SELECT
	MaSP,
	TenSP
FROM
	SANPHAM
WHERE
	MASP IN (SELECT MASP FROM CTHD)
--In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT 
	MASP,
	TENSP
FROM
	SANPHAM
EXCEPT
SELECT
	MaSP,
	TenSP
FROM
	SANPHAM
WHERE
	MASP 
	IN (SELECT 
			MASP 
		FROM 
			CTHD 
		WHERE 
			SOHD IN (SELECT SOHD FROM HOADON WHERE  YEAR(NGHD)=2006 )
		)
--In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006
SELECT 
	MASP,
	TENSP
FROM
	SANPHAM
WHERE
	NUOCSX='Trung Quoc'
EXCEPT
SELECT
	MaSP,
	TenSP
FROM
	SANPHAM
WHERE
	MASP 
	IN (SELECT 
			MASP 
		FROM 
			CTHD 
		WHERE 
			SOHD IN (SELECT SOHD FROM HOADON WHERE  YEAR(NGHD)=2006 )
		)
	AND
		NUOCSX='Trung Quoc';
--Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
SELECT HOADON.SOHD
FROM CTHD JOIN HOADON ON CTHD.SOHD=HOADON.SOHD
WHERE YEAR(NGHD) = 2006
AND MASP IN (SELECT MASP FROM (SELECT MASP
							   FROM SANPHAM
							   WHERE NUOCSX = 'Singapore') AS SanPhamSG)
GROUP BY HOADON.SOHD
HAVING COUNT(DISTINCT MASP) = (SELECT COUNT(*) FROM (SELECT MASP
													 FROM SANPHAM
													 WHERE NUOCSX = 'Singapore') AS SanPhamSG)


--LAB4: 
--Sinh viên hoàn thành Phần III bài tập QuanLyBanHang từ câu 19 đến 30.
--19. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(SOHD) SOHOADON
FROM HOADON
WHERE MAKH IS NULL
--20. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006. 
SELECT COUNT(DISTINCT MASP) SOSANPHAMBANTRONGNAM2006
FROM CTHD
WHERE MASP IN (SELECT MASP 
			   FROM CTHD
			   WHERE SOHD IN (SELECT SOHD
							  FROM HOADON
							  WHERE YEAR(NGHD)=2006)
			   )
--21. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu? 
SELECT MAX(TRIGIA) AS 'Giá trị hóa đơn lớn nhất', MIN(TRIGIA) 'Giá trị hóa đơn nhỏ nhất'
FROM HOADON
--22. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AS 'Trung bình giá trị hóa đơn trong năm 2006'
FROM HOADON
WHERE YEAR(NGHD)=2006;
--23. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) DOANHTHU
FROM HOADON
WHERE YEAR(NGHD)=2006
--24. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT SOHD, TRIGIA
FROM HOADON
WHERE YEAR(NGHD)=2006
	AND TRIGIA >= ALL(SELECT TRIGIA
					FROM HOADON
					WHERE YEAR(NGHD)=2006)
--25. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HOTEN
FROM KHACHHANG KH 
	JOIN HOADON HD ON KH.MAKH=HD.MAKH
WHERE YEAR(HD.NGHD) = 2006
AND HD.TRIGIA = (
    SELECT MAX(TRIGIA)
    FROM HOADON
    WHERE YEAR(NGHD) = 2006
)
GROUP BY HOTEN;
--26. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC;
--27. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE GIA IN(SELECT TOP 3 GIA
			FROM SANPHAM
			ORDER BY GIA DESC)
--28. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức 
--giá cao nhất (của tất cả các sản phẩm). 
SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE GIA IN(SELECT TOP 3 GIA
			FROM SANPHAM
			ORDER BY GIA DESC)
	AND NUOCSX='Thai Lan'
--29. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức 
--giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất). 
SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE GIA IN(SELECT TOP 3 GIA
			FROM SANPHAM
			WHERE NUOCSX='Trung Quoc'
			ORDER BY GIA DESC)
	AND NUOCSX='Trung Quoc'
--30.  In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng). 
SELECT TOP 3 
    MAKH,
    HOTEN,
    DIACHI,
    SDT,
    NGSINH,
    NGDK,
    DOANHSO,
    RANK() OVER (ORDER BY DOANHSO DESC) AS XepHang
FROM 
    KHACHHANG
ORDER BY 
    XepHang;

--Sinh viên hoàn thành Phần III bài tập QuanLyBanHang từ câu 31 đến 45. 
--31. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(MASP) SOSANPHAM
FROM SANPHAM
WHERE NUOCSX='Trung Quoc'
--32. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, 
	   COUNT(MASP) SOSANPHAM
FROM SANPHAM
GROUP BY NUOCSX
--33. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX,
       MAX(GIA) AS [GIA MAX],
       MIN(GIA) AS [GIA MIN],
       AVG(GIA) AS [TRUNG BINH GIA]
FROM SANPHAM
GROUP BY NUOCSX;
--34. Tính doanh thu bán hàng mỗi ngày. 
SELECT NGHD AS Ngay,
       SUM(TRIGIA) AS DoanhThu
FROM HOADON
GROUP BY NGHD
ORDER BY NGHD;
-- 35. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT MASP, SUM(SL) SOLUONGBAN
FROM CTHD 
	JOIN HOADON ON CTHD.SOHD=HOADON.SOHD
WHERE YEAR(NGHD)=2006
	AND MONTH(NGHD)=10
GROUP BY MASP
--36. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) AS THANG,
       SUM(TRIGIA) AS DoanhThu
FROM HOADON
WHERE YEAR(NGHD)=2006
GROUP BY MONTH(NGHD)
--37. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT SOHD,
	   COUNT(DISTINCT MASP) SOSANPHAM
FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP)>=4
--38. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT SOHD,
	   COUNT(DISTINCT CTHD.MASP) SOSANPHAM
FROM CTHD JOIN SANPHAM ON CTHD.MASP=SANPHAM.MASP
WHERE NUOCSX='Viet Nam'
GROUP BY SOHD
HAVING COUNT(DISTINCT CTHD.MASP)>=3
--39. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.  
SELECT KHACHHANG.MAKH, HOTEN
FROM KHACHHANG, HOADON
WHERE KHACHHANG.MAKH = HOADON.MAKH
GROUP BY KHACHHANG.MAKH, HOTEN
HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM HOADON GROUP BY MAKH)
--40. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 WITH TIES
    MONTH(NGHD) AS Thang,
    SUM(TRIGIA) AS DoanhSo
FROM 
    HOADON
WHERE 
    YEAR(NGHD) = 2006
GROUP BY 
    MONTH(NGHD)
ORDER BY 
    DoanhSo DESC;
--41. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP IN (SELECT MASP 
			   FROM CTHD JOIN HOADON ON CTHD.SOHD=HOADON.SOHD
			   WHERE YEAR(NGHD)=2006
			   GROUP BY MASP
			   HAVING SUM(SL)<= ALL(SELECT SUM(SL) 
									FROM CTHD JOIN HOADON ON CTHD.SOHD=HOADON.SOHD
									WHERE YEAR(NGHD)=2006
									GROUP BY MASP
									)
				)
--42. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT MASP, TENSP, NUOCSX
FROM SANPHAM SP
WHERE GIA>=ALL(SELECT GIA
			  FROM SANPHAM
			  WHERE NUOCSX=SP.NUOCSX)

--43. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau. 
SELECT NUOCSX
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA)>=3
--44. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT TOP 1 WITH TIES KH.MAKH, KH.HOTEN
FROM KHACHHANG KH JOIN HOADON HD ON KH.MAKH=HD.MAKH
WHERE KH.MAKH IN (SELECT TOP 10 MAKH 
			   FROM KHACHHANG
			   ORDER BY DOANHSO DESC)
GROUP BY KH.MAKH, KH.HOTEN
ORDER BY COUNT(SOHD) DESC




