CREATE DATABASE QUANLYGIAOVU


CREATE TABLE KHOA 
(
	MAKHOA VARCHAR(4) PRIMARY KEY,
	TENKHOA VARCHAR(40),
	NGTLAP SMALLDATETIME,
	TRGKHOA CHAR(4)
);

CREATE TABLE MONHOC
(
	MAMH VARCHAR(10) PRIMARY KEY,
	TENMH VARCHAR(40),
	TCLT TINYINT,
	TCTH TINYINT,
	MAKHOA VARCHAR(4),
);

CREATE TABLE DIEUKIEN
(
	MAMH VARCHAR(10),
	MAMH_TRUOC VARCHAR(10),
	PRIMARY KEY (MAMH, MAMH_TRUOC)
);

CREATE TABLE GIAOVIEN
(
	MAGV CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40),
	HOCVI VARCHAR(10),
	HOCHAM VARCHAR(10),
	GIOITINH VARCHAR(3),
	NGSINH SMALLDATETIME,
	NGVL SMALLDATETIME,
	HESO NUMERIC(4,2),
	MUCLUONG MONEY,
	MAKHOA VARCHAR(4)
);

CREATE TABLE HOCVIEN
(
	MAHV CHAR(5) PRIMARY KEY,
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40),
	MALOP CHAR(3),
);

CREATE TABLE LOP
(
	MALOP CHAR(3) PRIMARY KEY,
	TENLOP VARCHAR(40),
	TRGLOP CHAR(5),
	SISO TINYINT,
	MAGVCN CHAR(4)
);

CREATE TABLE GIANGDAY
(
	MALOP CHAR(3),
	MAMH VARCHAR(10),
	MAGV CHAR(4),
	HOCKY TINYINT,
	NAM SMALLINT,
	TUNGAY SMALLDATETIME,
	DENNGAY SMALLDATETIME
	PRIMARY KEY (MALOP, MAMH),
);

CREATE TABLE KETQUATHI
(
	MAHV CHAR(5),
	MAMH VARCHAR(10),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2),
	KQUA VARCHAR(10)
	PRIMARY KEY (MAHV, MAMH, LANTHI)
);
--Thêm khóa ngoại
ALTER TABLE KHOA ADD CONSTRAINT FK_TRGKHOA FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV);

ALTER TABLE MONHOC ADD CONSTRAINT FK_MAKHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA);

ALTER TABLE DIEUKIEN ADD CONSTRAINT FK_MAMH_TRUOC FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH);
ALTER TABLE DIEUKIEN ADD CONSTRAINT FK_MAMH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH);

ALTER TABLE GIAOVIEN ADD CONSTRAINT FK_MAKHOA2 FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA);

ALTER TABLE LOP ADD CONSTRAINT FK_TRGLOP FOREIGN KEY(TRGLOP) REFERENCES HOCVIEN(MAHV);
ALTER TABLE LOP ADD CONSTRAINT FK_MAGVCN FOREIGN KEY(MAGVCN) REFERENCES GIAOVIEN(MAGV);

ALTER TABLE HOCVIEN ADD CONSTRAINT FK_LOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP);

ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MAMH2 FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH);
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MALOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP);
ALTER TABLE GIANGDAY ADD CONSTRAINT FK_MAGV FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV);

ALTER TABLE KETQUATHI ADD CONSTRAINT FK_MAHV FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV);
ALTER TABLE KETQUATHI ADD CONSTRAINT FK_MAMH3 FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH);
-- I.
-- 3. Thuộc tính của GIOITINH chỉ có giá trị là "Nam" hoặc "Nữ".
ALTER TABLE HOCVIEN ADD
CONSTRAINT CK_GT_HV CHECK (GIOITINH IN ('Nam', 'Nu'))

ALTER TABLE GIAOVIEN ADD
CONSTRAINT CK_GT_GV CHECK (GIOITINH IN ('Nam', 'Nu'))

-- 4. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).
ALTER TABLE KETQUATHI ADD 
CONSTRAINT CK_DIEM CHECK (
	DIEM BETWEEN 0 AND 10 AND
	LEN(SUBSTRING(CAST(DIEM AS VARCHAR), CHARINDEX('.', DIEM) + 1, 1000)) >= 2
)

-- 5. Kết quả thi là “Dat” nếu điểm từ 5 đến 10  và “Khong dat” nếu điểm nhỏ hơn 5.
ALTER TABLE KETQUATHI ADD 
CONSTRAINT CK_KQUA CHECK (KQUA = IIF(DIEM BETWEEN 5 AND 10, 'Dat', 'Khong dat'))

-- 6. Học viên thi một môn tối đa 3 lần.
ALTER TABLE KETQUATHI ADD
CONSTRAINT CK_SOLANTHI CHECK (LANTHI <= 3)

-- 7. Học kì chỉ có giá trị từ 1 đến 3.
ALTER TABLE GIANGDAY ADD
CONSTRAINT CK_HOCKY CHECK (HOCKY BETWEEN 1 AND 3)

-- 8. Học vị của giáo viên chỉ có thể là "CN", "KS", "ThS", "TS", "PTS".
ALTER TABLE GIAOVIEN ADD
CONSTRAINT CK_HOCVI CHECK (HOCVI IN ('CN', 'KS', 'ThS', 'TS', 'PTS'))
--LAB2
-- Nhập dữ liệu cho KHOA --
INSERT INTO KHOA VALUES ('KHMT','Khoa hoc may tinh','6/7/2005','GV01'),
('HTTT','He thong thong tin','6/7/2005','GV02'),
('CNPM','Cong nghe phan mem','6/7/2005','GV04'),
('MTT','Mang va truyen thong','10/20/2005','GV03'),
('KTMT','Ky thuat may tinh','12/20/2005','')
-- Nhập dữ liệu cho LOP --
INSERT INTO LOP VALUES('K11','Lop 1 khoa 1','K1108',11,'GV07'),
('K12','Lop 2 khoa 1','K1205',12,'GV09'),
('K13','Lop 3 khoa 1','K1305',12,'GV14')
-- Nhập dữ liệu cho MONHOC --
INSERT INTO MONHOC VALUES('THDC','Tin hoc dai cuong',4,1,'KHMT'),
('CTRR','Cau truc roi rac',5,2,'KHMT'),
('CSDL','Co so du lieu',3,1,'HTTT'),
('CTDLGT','Cau truc du lieu va giai thuat',3,1,'KHMT'),
('PTTKTT','Phan tich thiet ke thuat toan',3,0,'KHMT'),
('DHMT','Do hoa may tinh',3,1,'KHMT'),
('KTMT','Kien truc may tinh',3,0,'KTMT'),
('TKCSDL','Thiet ke co so du lieu',3,1,'HTTT'),
('PTTKHTTT','Phan tich thiet ke he thong thong tin',4,1,'HTTT'),
('HDH','He dieu hanh',4,1,'KTMT'),
('NMCNPM','Nhap mon cong nghe phan mem',3,0,'CNPM'),
('LTCFW','Lap trinh C for win',3,1,'CNPM'),
('LTHDT','Lap trinh huong doi tuong',3,1,'CNPM')
-- Nhập dữ liệu cho GIANGDAY --
INSERT INTO GIANGDAY VALUES('K11','THDC','GV07',1,2006,'1/2/2006','5/12/2006'),
('K12','THDC','GV06',1,2006,'1/2/2006','5/12/2006'),
('K13','THDC','GV15',1,2006,'1/2/2006','5/12/2006'),
('K11','CTRR','GV02',1,2006,'1/9/2006','5/17/2006'),
('K12','CTRR','GV02',1,2006,'1/9/2006','5/17/2006'),
('K13','CTRR','GV08',1,2006,'1/9/2006','5/17/2006'),
('K11','CSDL','GV05',2,2006,'6/1/2006','7/15/2006'),
('K12','CSDL','GV09',2,2006,'6/1/2006','7/15/2006'),
('K13','CTDLGT','GV15',2,2006,'6/1/2006','7/15/2006'),
('K13','CSDL','GV05',3,2006,'8/1/2006','12/15/2006'),
('K13','DHMT','GV07',3,2006,'8/1/2006','12/15/2006'),
('K11','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006'),
('K12','CTDLGT','GV15',3,2006,'8/1/2006','12/15/2006'),
('K11','HDH','GV04',1,2007,'1/2/2007','2/18/2007'),
('K12','HDH','GV04',1,2007,'1/2/2007','3/20/2007'),
('K11','DHMT','GV07',1,2007,'2/18/2007','3/20/2007')
-- Nhập dữ liệu cho GIAOVIEN --
INSERT INTO GIAOVIEN VALUES('GV01','Ho Thanh Son','PTS','GS','Nam','5/2/1950','1/11/2004',5.00,2250000,'KHMT'),
('GV02','Tran Tam Thanh','TS','PGS','Nam','12/17/1965','4/20/2004',4.50,2025000,'HTTT'),
('GV03','Do Nghiem Phung','TS','GS','Nu','8/1/1950','9/23/2004',4.00,1800000,'CNPM'),
('GV04','Tran Nam Son','TS','PGS','Nam','2/22/1961','1/12/2005',4.50,2025000,'KTMT'),
('GV05','Mai Thanh Danh','ThS','GV','Nam','3/12/1958','1/12/2005',3.00,1350000,'HTTT'),
('GV06','Tran Doan Hung','TS','GV','Nam','3/11/1953','1/12/2005',4.50,2025000,'KHMT'),
('GV07','Nguyen Minh Tien','ThS','GV','Nam','11/23/1971','3/1/2005',4.00,1800000,'KHMT'),
('GV08','Le Thi Tran','KS','','Nu','3/26/1974','3/1/2005',1.69,760500,'KHMT'),
('GV09','Nguyen To Lan','ThS','GV','Nu','12/31/1966','3/1/2005',4.00,1800000,'HTTT'),
('GV10','Le Tran Anh Loan','KS','','Nu','7/17/1972','3/1/2005',1.86,837000,'CNPM'),
('GV11','Ho Thanh Tung','CN','GV','Nam','1/12/1980','5/15/2005',2.67,1201500,'MTT'),
('GV12','Tran Van Anh','CN','','Nu','3/29/1981','5/15/2005',1.69,760500,'CNPM'),
('GV13','Nguyen Linh Dan','CN','','Nu','5/23/1980','5/15/2005',1.69,760500,'KTMT'),
('GV14','Truong Minh Chau','ThS','GV','Nu','11/30/1976','5/15/2005',3.00,1350000,'MTT'),
('GV15','Le Ha Thanh','ThS','GV','Nam','5/4/1978','5/15/2005',3.00,1350000,'KHMT')
-- NHẬP DỮ LIỆU CHO DIEUKIEN --
INSERT INTO DIEUKIEN VALUES('CSDL','CTRR'),
('CSDL','CTDLGT'),
('CTDLGT','THDC'),
('PTTKTT','THDC'),
('PTTKTT','CTDLGT'),
('DHMT','THDC'),
('LTHDT','THDC'),
('PTTKHTTT','CSDL')
-- Nhập dữ liệu cho KETQUATHI --
INSERT INTO KETQUATHI VALUES('K1101','CSDL',1,'7/20/2006',10.00,'Dat'),
('K1101','CTDLGT',1,'12/28/2006',9.00,'Dat'),
('K1101','THDC',1,'5/20/2006',9.00,'Dat'),
('K1101','CTRR',1,'5/13/2006',9.50,'Dat'),
('K1102','CSDL',1,'7/20/2006',4.00,'Khong Dat'),
('K1102','CSDL',2,'7/27/2006',4.25,'Khong Dat'),
('K1102','CSDL',3,'8/10/2006',4.50,'Khong Dat'),
('K1102','CTDLGT',1,'12/28/2006',4.50,'Khong Dat'),
('K1102','CTDLGT',2,'1/5/2007',4.00,'Khong Dat'),
('K1102','CTDLGT',3,'1/15/2007',6.00,'Dat'),
('K1102','THDC',1,'5/20/2006',5.00,'Dat'),
('K1102','CTRR',1,'5/13/2006',7.00,'Dat'),
('K1103','CSDL',1,'7/20/2006',3.50,'Khong Dat'),
('K1103','CSDL',2,'7/27/2006',8.25,'Dat'),
('K1103','CTDLGT',1,'12/28/2006',7.00,'Dat'),
('K1103','THDC',1,'5/20/2006',8.00,'Dat'),
('K1103','CTRR',1,'5/13/2006',6.50,'Dat'),
('K1104','CSDL',1,'7/20/2006',3.75,'Khong Dat'),
('K1104','CTDLGT',1,'12/28/2006',4.00,'Khong Dat'),
('K1104','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1104','CTRR',1,'5/13/2006',4.00,'Khong Dat'),
('K1104','CTRR',2,'5/20/2006',3.50,'Khong Dat'),
('K1104','CTRR',3,'6/30/2006',4.00,'Khong Dat'),
('K1201','CSDL',1,'7/20/2006',6.00,'Dat'),
('K1201','CTDLGT',1,'12/28/2006',5.00,'Dat'),
('K1201','THDC',1,'5/20/2006',8.50,'Dat'),
('K1201','CTRR',1,'5/13/2006',9.00,'Dat'),
('K1202','CSDL',1,'7/20/2006',8.00,'Dat'),
('K1202','CTDLGT',1,'12/28/2006',4.00,'Khong Dat'),
('K1202','CTDLGT',2,'1/5/2007',5.00,'Dat'),
('K1202','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1202','THDC',2,'5/27/2006',4.00,'Khong Dat'),
('K1202','CTRR',1,'5/13/2006',3.00,'Khong Dat'),
('K1202','CTRR',2,'5/20/2006',4.00,'Khong Dat'),
('K1202','CTRR',3,'6/30/2006',6.25,'Dat'),
('K1203','CSDL',1,'7/20/2006',9.25,'Dat'),
('K1203','CTDLGT',1,'12/28/2006',9.50,'Dat'),
('K1203','THDC',1,'5/20/2006',10.00,'Dat'),
('K1203','CTRR',1,'5/13/2006',10.00,'Dat'),
('K1204','CSDL',1,'7/20/2006',8.50,'Dat'),
('K1204','CTDLGT',1,'12/28/2006',6.75,'Dat'),
('K1204','THDC',1,'5/20/2006',4.00,'Khong Dat'),
('K1204','CTRR',1,'5/13/2006',6.00,'Dat'),
('K1301','CSDL',1,'12/20/2006',4.25,'Khong Dat'),
('K1301','CTDLGT',1,'7/25/2006',8.00,'Dat'),
('K1301','THDC',1,'5/20/2006',7.75,'Dat'),
('K1301','CTRR',1,'5/13/2006',8.00,'Dat'),
('K1302','CSDL',1,'12/20/2006',6.75,'Dat'),
('K1302','CTDLGT',1,'7/25/2006',5.00,'Dat'),
('K1302','THDC',1,'5/20/2006',8.00,'Dat'),
('K1302','CTRR',1,'5/13/2006',8.50,'Dat'),
('K1303','CSDL',1,'12/20/2006',4.00,'Khong Dat'),
('K1303','CTDLGT',1,'7/25/2006',4.50,'Khong Dat'),
('K1303','CTDLGT',2,'8/7/2006',4.00,'Khong Dat'),
('K1303','CTDLGT',3,'8/15/2006',4.25,'Khong Dat'),
('K1303','THDC',1,'5/20/2006',4.50,'Khong Dat'),
('K1303','CTRR',1,'5/13/2006',3.25,'Khong Dat'),
('K1303','CTRR',2,'5/20/2006',5.00,'Dat'),
('K1304','CSDL',1,'12/20/2006',7.75,'Dat'),
('K1304','CTDLGT',1,'7/25/2006',9.75,'Dat'),
('K1304','THDC',1,'5/20/2006',5.50,'Dat'),
('K1304','CTRR',1,'5/13/2006',5.00,'Dat'),
('K1305','CSDL',1,'12/20/2006',9.25,'Dat'),
('K1305','CTDLGT',1,'7/25/2006',10.00,'Dat'),
('K1305','THDC',1,'5/20/2006',8.00,'Dat'),
('K1305','CTRR',1,'5/13/2006',10.00,'Dat')
-- Nhập dữ liệu cho HOCVIEN --
INSERT INTO HOCVIEN VALUES('K1101','Nguyen Van','A','1/27/1986','Nam','TpHCM','K11'),
('K1102','Tran Ngoc','Han','3/1/1986','Nu','Kien Giang','K11'),
('K1103','Ha Duy','Lap','4/18/1986','Nam','Nghe An','K11'),
('K1104','Tran Ngoc','Linh','3/30/1986','Nu','Tay Ninh','K11'),
('K1105','Tran Minh','Long','2/27/1986','Nam','TpHCM','K11'),
('K1106','Le Nhat','Minh','1/24/1986','Nam','TpHCM','K11'),
('K1107','Nguyen Nhu','Nhut','1/27/1986','Nam','Ha Noi','K11'),
('K1108','Nguyen Manh','Tam','2/27/1986','Nam','Kien Giang','K11'),
('K1109','Phan Thi Thanh','Tam','1/27/1986','Nu','Vinh Long','K11'),
('K1110','Le Hoai','Thuong','2/5/1986','Nu','Can Tho','K11'),
('K1111','Le Ha','Vinh','12/25/1986','Nam','Vinh Long','K11'),
('K1201','Nguyen Van','B','2/11/1986','Nam','TpHCM','K12'),
('K1202','Nguyen Thi Kim','Duyen','1/18/1986','Nu','TpHCM','K12'),
('K1203','Tran Thi Kim','Duyen','9/17/1986','Nu','TpHCM','K12'),
('K1204','Truong My','Hanh','5/19/1986','Nu','Dong Nai','K12'),
('K1205','Nguyen Thanh','Nam','4/17/1986','Nam','TpHCM','K12'),
('K1206','Nguyen Thi Truc','Thanh','3/4/1986','Nu','Kien Giang','K12'),
('K1207','Tran Thi Bich','Thuy','2/8/1986','Nu','Nghe An','K12'),
('K1208','Huynh Thi Kim','Trieu','4/8/1986','Nu','Tay Ninh','K12'),
('K1209','Pham Thanh','Trieu','2/23/1986','Nam','TpHCM','K12'),
('K1210','Ngo Thanh','Tuan','2/14/1986','Nam','TpHCM','K12'),
('K1211','Do Thi','Xuan','3/9/1986','Nu','Ha Noi','K12'),
('K1212','Le Thi Phi','Yen','3/12/1986','Nu','TpHCM','K12'),
('K1301','Nguyen Thi Kim','Cuc','6/9/1986','Nu','Kien Giang','K13'),
('K1302','Truong Thi My','Hien','3/18/1986','Nu','Nghe An','K13'),
('K1303','Le Duc','Hien','3/12/1986','Nam','Tay Ninh','K13'),
('K1304','Le Quang','Hien','4/18/1986','Nam','TpHCM','K13'),
('K1305','Le Thi','Huong','3/27/1986','Nu','TpHCM','K13'),
('K1306','Nguyen Thai','Huu','3/30/1986','Nam','Ha Noi','K13'),
('K1307','Tran Minh','Man','5/28/1986','Nam','TpHCM','K13'),
('K1308','Nguyen Hieu','Nghia','4/8/1986','Nam','Kien Giang','K13'),
('K1309','Nguyen Trung','Nghia','1/18/1987','Nam','Nghe An','K13'),
('K1310','Tran Thi Hong','Tham','4/22/1986','Nu','Tay Ninh','K13'),
('K1311','Tran Minh','Thuc','4/4/1986','Nam','TpHCM','K13'),
('K1312','Nguyen Thi Kim','Yen','9/7/1986','Nu','TpHCM','K13')

--Cau 3
ALTER TABLE HOCVIEN ADD CONSTRAINT CHECKGTHV CHECK (GIOITINH IN ('Nam', 'Nu'));
ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECKGTGV CHECK (GIOITINH IN ('Nam', 'Nu'));

--Cau 4
ALTER TABLE KETQUATHI ADD CONSTRAINT CHECK_DIEM CHECK 
(
	DIEM BETWEEN 0 AND 10
	AND RIGHT(CAST(DIEM AS VARCHAR), 3) LIKE '.__'
);

--Cau 5
ALTER TABLE KETQUATHI ADD CONSTRAINT CHECK_KETQUA CHECK
(	
	( (DIEM BETWEEN 5 AND 10) AND KQUA = 'Dat')
	OR ( DIEM < 5 AND KQUA = 'Khong dat')
);

--Cau 6
ALTER TABLE KETQUATHI ADD CONSTRAINT CHECK_LANTHI CHECK (LANTHI <= 3);

--Cau 7
ALTER TABLE GIANGDAY ADD CONSTRAINT CHECKHOCKI CHECK( HOCKY BETWEEN 1 AND 3);

--Cau 8
ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECK_HOCVI CHECK (HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'));

--Câu 11 đến 14 phần I
--Câu 11
ALTER TABLE HOCVIEN ADD CONSTRAINT CHECK_TUOI CHECK(DATEDIFF(YEAR, NGSINH, GETDATE()) >= 18);
--Câu 12
ALTER TABLE GIANGDAY ADD CONSTRAINT CHECK_NGAYDAY CHECK(TUNGAY<DENNGAY);
--Câu 13
ALTER TABLE GIAOVIEN ADD CONSTRAINT CHECK_TUOIGIAOVIEN CHECK(DATEDIFF(YEAR, NGSINH, GETDATE()) >= 22);
--Câu 14
ALTER TABLE MONHOC ADD CONSTRAINT CHECK_SOCHECHLECHTIN CHECK(ABS(TCLT-TCTH)<=3);

--Câu 1 đến 5 phần III
--Câu 1 In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
SELECT 
    MAHV, 
    HO,
	TEN,
    NGSINH, 
    MALOP
FROM 
    HOCVIEN
WHERE 
    MAHV IN (SELECT TRGLOP FROM LOP);
--Câu 2 In ra bảng điểm khi thi (mã học viên, họ tên, lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên.
SELECT 
    HOCVIEN.MAHV, 
    HOCVIEN.HO, 
    HOCVIEN.TEN, 
    KETQUATHI.LANTHI, 
    KETQUATHI.DIEM
FROM 
    KETQUATHI, HOCVIEN
WHERE
	KETQUATHI.MAHV=HOCVIEN.MAHV
    AND KETQUATHI.MAMH = 'CTRR' 
    AND HOCVIEN.MALOP = 'K12'
ORDER BY 
    HOCVIEN.TEN ASC, 
    HOCVIEN.HO ASC;
--Câu 3 In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT 
	HOCVIEN.MAHV,
	HO,
	TEN,
	MAMH
FROM 
	HOCVIEN, KETQUATHI
WHERE 
	HOCVIEN.MAHV=KETQUATHI.MAHV 
	AND KQUA ='Dat' 
	AND LANTHI=1
--Câu 4 In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
SELECT 
	MAHV,
	HO,
	TEN
FROM
	HOCVIEN
WHERE 
	MALOP = 'K11' AND MAHV IN (SELECT MAHV FROM KETQUATHI WHERE MAMH='CTRR' AND LANTHI=1 AND KQUA='Khong dat')
--Câu 5 * Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
SELECT 
	MAHV,
	HO,
	TEN
FROM
	HOCVIEN
WHERE 
	MALOP LIKE 'K%' AND MAHV IN (SELECT MAHV FROM KETQUATHI WHERE KQUA='Khong dat' AND MAMH ='CTRR')

--LAB3
--2.Sinh viên hoàn thành Phần II bài tập QuanLyGiaoVu từ câu 1 đến câu 4
--Câu 1: Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa. 
UPDATE GIAOVIEN
SET MUCLUONG=MUCLUONG*1.2
WHERE MAGV IN (SELECT TRGKHOA FROM KHOA)

--Câu 2: Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên (tất cả các 
--môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau 
--cùng)
UPDATE HOCVIEN SET DIEMTB = DTB_HOCVIEN.DTB
FROM HOCVIEN HV LEFT JOIN (SELECT MAHV, AVG(DIEM) AS DTB 
	FROM KETQUATHI A
	WHERE NOT EXISTS (
		SELECT 1 
		FROM KETQUATHI B 
		WHERE A.MAHV = B.MAHV AND A.MAMH = B.MAMH AND A.LANTHI < B.LANTHI
	) 
	GROUP BY MAHV
) DTB_HOCVIEN
ON HV.MAHV = DTB_HOCVIEN.MAHV
--Câu 3: Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất 
--kỳ thi lần thứ 3 dưới 5 điểm.
UPDATE HOCVIEN 
SET GHICHU = 'Cam thi'
WHERE MAHV IN (
	SELECT MAHV 
	FROM KETQUATHI 
	WHERE LANTHI = 3 AND DIEM < 5
-- 4. Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau:
-- o Nếu DIEMTB >= 9 thì XEPLOAI =”XS”
-- o Nếu 8 <= DIEMTB < 9 thì XEPLOAI = “G”
-- o Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = “K”
-- o Nếu 5 <= DIEMTB < 6.5 thì XEPLOAI = “TB”
-- o Nếu DIEMTB < 5 thì XEPLOAI = ”Y”
UPDATE HOCVIEN 
SET XEPLOAI = 
CASE 
	WHEN DIEMTB >= 9 THEN 'XS'
	WHEN DIEMTB >= 8 THEN 'G'
	WHEN DIEMTB >= 6.5 THEN 'K'
	WHEN DIEMTB >= 5 THEN 'TB'
	ELSE 'Y'
	END
--3.Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 6 đến câu 10.
--6 Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
SELECT MH.TENMH
FROM GIANGDAY GD
JOIN MONHOC MH ON GD.MAMH = MH.MAMH
JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
WHERE GV.HOTEN = 'Tran Tam Thanh'
  AND GD.HOCKY = 1
  AND GD.NAM = 2006;

--7 Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006. 
SELECT MH.MAMH, MH.TENMH
FROM GIANGDAY GD
JOIN MONHOC MH ON GD.MAMH = MH.MAMH
JOIN LOP L ON GD.MALOP = L.MALOP
WHERE L.MALOP = 'K11'
  AND GD.HOCKY = 1
  AND GD.NAM = 2006
  AND GD.MAGV = L.MAGVCN;

--8 Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”. 
SELECT HO, TEN 
FROM HOCVIEN, LOP, GIAOVIEN, GIANGDAY, MONHOC
WHERE HOCVIEN.MAHV = LOP.TRGLOP AND GIANGDAY.MALOP = LOP.MALOP AND GIANGDAY.MAGV = GIAOVIEN.MAGV AND GIANGDAY.MAMH = MONHOC.MAMH
	AND HOTEN = N'Nguyen To Lan' AND TENMH = N'Co so du lieu'

--9 In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT MH2.MAMH, MH2.TENMH 
FROM DIEUKIEN JOIN MONHOC MH1 ON DIEUKIEN.MAMH = MH1.MAMH
			JOIN MONHOC MH2 ON DIEUKIEN.MAMH_TRUOC = MH2.MAMH
WHERE MH1.TENMH = N'Co so du lieu'

--10 Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT MH1.MAMH, MH1.TENMH 
FROM DIEUKIEN JOIN MONHOC MH1 ON DIEUKIEN.MAMH = MH1.MAMH
			JOIN MONHOC MH2 ON DIEUKIEN.MAMH_TRUOC = MH2.MAMH
WHERE MH2.TENMH = N'Cau truc roi rac'

--Câu 3: Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 11 đến câu 18.
--11 Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
SELECT HOTEN 
FROM GIAOVIEN, GIANGDAY
WHERE GIAOVIEN.MAGV = GIANGDAY.MAGV AND MALOP = N'K11' AND HOCKY = 1 AND NAM = 2006
UNION
SELECT HOTEN 
FROM GIAOVIEN, GIANGDAY
WHERE GIAOVIEN.MAGV = GIANGDAY.MAGV AND MALOP = N'K12' AND HOCKY = 1 AND NAM = 2006
--12 Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng 
--chưa thi lại môn này. 
SELECT HV.MAHV, HV.HO, HV.TEN
FROM HOCVIEN HV
WHERE HV.MAHV IN (
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    WHERE KQ.MAMH = 'CSDL' 
      AND KQ.LANTHI = 1 
      AND KQ.KQUA <> 'Dat'  
) 
AND HV.MAHV NOT IN (
    SELECT KQ.MAHV
    FROM KETQUATHI KQ
    WHERE KQ.MAMH = 'CSDL'
	AND KQ.LANTHI >=2
);

--13. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào. 
SELECT MAGV, HOTEN
FROM GIAOVIEN
WHERE MAGV NOT IN (
    SELECT MAGV
    FROM GIANGDAY 
);

--14 Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào 
--thuộc khoa giáo viên đó phụ trách. 
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
JOIN KHOA K ON GV.MAKHOA = K.MAKHOA
WHERE GV.MAGV NOT IN (
    SELECT GD.MAGV
    FROM GIANGDAY GD
    JOIN MONHOC MH ON GD.MAMH = MH.MAMH
    WHERE MH.MAKHOA = K.MAKHOA
);
--15 Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” 
--hoặc thi lần thứ 2 môn CTRR được 5 điểm.
SELECT HV.HO, HV.TEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
JOIN LOP L ON HV.MALOP = L.MALOP
WHERE L.MALOP = 'K11'
GROUP BY HV.MAHV, HV.HO, HV.TEN
HAVING 
    (COUNT(KQ.LANTHI) > 3 AND SUM(CASE WHEN KQ.KQUA = 'Khong dat' THEN 1 ELSE 0 END) = COUNT(KQ.LANTHI))
    OR 
    (SUM(CASE WHEN KQ.MAMH = 'CTRR' AND KQ.LANTHI = 2 THEN KQ.DIEM ELSE 0 END) = 5);
--16 Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học. 
SELECT HOTEN FROM GIAOVIEN 
WHERE MAGV IN (
	SELECT MAGV FROM GIANGDAY 
	WHERE MAMH = N'CTRR'
	GROUP BY MAGV, HOCKY, NAM 
	HAVING COUNT(MALOP) >= 2
)

--17 Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT HV.MAHV, HV.HO, HV.TEN, KQ.DIEM
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.MAMH = 'CSDL' 
AND KQ.LANTHI = (
    SELECT MAX(LANTHI) 
    FROM KETQUATHI 
    WHERE MAHV = HV.MAHV AND MAMH = 'CSDL'
);

--18 Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT HV.MAHV, HV.HO, HV.TEN, MAX(KQ.DIEM) AS DIEMTHI
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.MAMH = 'CSDL'
GROUP BY HV.MAHV, HV.HO, HV.TEN;

--LAB4:
--Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 19 đến câu 25.
--19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT MAKHOA, TENKHOA
FROM KHOA
WHERE NGTLAP = (SELECT MIN(NGTLAP)
				FROM KHOA)
--20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”. 
SELECT COUNT(MAGV) AS 'Số giao viên học hàm GS hoặc PGS'
FROM GIAOVIEN
WHERE HOCHAM='GS' OR HOCHAM='PGS'
--21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi 
--khoa
SELECT MAKHOA, COUNT(MAGV) SoGiaoVien
FROM GIAOVIEN
WHERE HOCVI='CN' OR HOCVI='KS' OR HOCVI='Ths' OR HOCVI='TS' OR HOCVI='PTS'
GROUP BY MAKHOA
--22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
WITH BANG1 AS (
    SELECT MAMH, COUNT(MAHV) AS SOHVDAT
    FROM KETQUATHI
    WHERE KQUA = 'Dat'
    GROUP BY MAMH
),
BANG2 AS (
    SELECT MAMH, COUNT(MAHV) AS SOHVKHONGDAT
    FROM KETQUATHI
    WHERE KQUA = 'Khong dat'
    GROUP BY MAMH
)
SELECT BANG1.MAMH, SOHVDAT, SOHVKHONGDAT
FROM BANG1
JOIN BANG2 ON BANG1.MAMH = BANG2.MAMH;
--23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho 
--lớp đó ít nhất một môn học.
SELECT MAGV,
	   HOTEN
FROM GIAOVIEN GV JOIN LOP ON GV.MAGV=LOP.MAGVCN
WHERE MALOP IN (SELECT MALOP
				FROM GIANGDAY
				WHERE GV.MAGV= GIANGDAY.MAGV)
--24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất. 
SELECT HO, TEN
FROM HOCVIEN
WHERE MAHV IN (SELECT TRGLOP
			   FROM LOP
			   WHERE SISO= (SELECT MAX(SISO)
							FROM LOP)
				)
--25. Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả 
--các lần thi).
SELECT HO, TEN
FROM
	HOCVIEN, LOP, KETQUATHI
WHERE
	HOCVIEN.MAHV = LOP.TRGLOP
	AND HOCVIEN.MAHV = KETQUATHI.MAHV
	AND KQUA = 'Khong Dat'
GROUP BY 
	TRGLOP, HO, TEN
HAVING 
	COUNT(*) > 3

--Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 26 đến câu 35.

--26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất. 
SELECT HOCVIEN.MAHV,
	   HO,
	   TEN
FROM 
	HOCVIEN, KETQUATHI
WHERE
	HOCVIEN.MAHV = KETQUATHI.MAHV
	AND DIEM >= 9
GROUP BY 
	HOCVIEN.MAHV, HO, TEN
ORDER BY 
	COUNT(*) DESC
--27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9, 10 nhiều nhất. 
WITH HocVienDiemCao AS (
    SELECT 
        HOCVIEN.MAHV,
        HOCVIEN.HO + ' ' + HOCVIEN.TEN AS HOTEN,
        HOCVIEN.MALOP,
        COUNT(*) AS SoMonDiemCao
    FROM 
        KETQUATHI
    JOIN 
        HOCVIEN ON KETQUATHI.MAHV = HOCVIEN.MAHV
    WHERE 
        KETQUATHI.DIEM IN (9, 10)
    GROUP BY 
        HOCVIEN.MAHV, HOCVIEN.HO, HOCVIEN.TEN, HOCVIEN.MALOP
),
MaxDiemCao AS (
    SELECT 
        MALOP,
        MAX(SoMonDiemCao) AS MaxDiemCao
    FROM 
        HocVienDiemCao
    GROUP BY 
        MALOP
)
SELECT 
    HocVienDiemCao.MAHV,
    HocVienDiemCao.HOTEN,
    HocVienDiemCao.MALOP,
    HocVienDiemCao.SoMonDiemCao
FROM 
    HocVienDiemCao
JOIN 
    MaxDiemCao ON HocVienDiemCao.MALOP = MaxDiemCao.MALOP 
               AND HocVienDiemCao.SoMonDiemCao = MaxDiemCao.MaxDiemCao
ORDER BY 
    HocVienDiemCao.MALOP, HocVienDiemCao.MAHV;
--28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao 
--nhiêu lớp.
SELECT MaGV, COUNT(DISTINCT MaMH) 'Số môn học', COUNT(DISTINCT MALOP) 'Số lớp', HOCKY, NAM
FROM GiangDay
GROUP BY MaGV, HOCKY, NAM
--29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất. 
WITH SoLanDay AS (
    SELECT 
        MAGV,
        HOCKY,
        NAM,
        COUNT(*) AS SoLanGiangDay
    FROM GIANGDAY
    GROUP BY MAGV, HOCKY, NAM
),

SoLanDayNhieu AS (
    SELECT 
        HOCKY,
        NAM,
        MAX(SoLanGiangDay) AS MAXLANDAY
    FROM SoLanDay
    GROUP BY HOCKY, NAM
)

SELECT 
    GV.MAGV,
    GV.HOTEN,
    SoLanDay.HOCKY,
    SoLanDay.NAM,
    SoLanDay.SoLanGiangDay AS MAXLANDAY
FROM SoLanDay
JOIN SoLanDayNhieu 
    ON SoLanDay.HOCKY = SoLanDayNhieu.HOCKY 
    AND SoLanDay.NAM = SoLanDayNhieu.NAM
    AND SoLanDay.SoLanGiangDay = SoLanDayNhieu.MAXLANDAY
JOIN GIAOVIEN GV 
    ON SoLanDay.MAGV = GV.MAGV;
--30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1)
--nhất.
SELECT TOP 1 WITH TIES KQ.MAMH, TENMH, COUNT(*) AS SOLANROT
FROM KETQUATHI KQ JOIN MONHOC ON KQ.MAMH=MONHOC.MAMH
WHERE KQ.LANTHI='1' 
	  AND KQ.KQUA='Khong dat'
GROUP BY KQ.MAMH, TENMH
ORDER BY SOLANROT DESC

--31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT DISTINCT KQ.MAHV, HO, TEN
FROM KETQUATHI KQ JOIN HOCVIEN ON KQ.MAHV=HOCVIEN.MAHV
WHERE KQ.LANTHI='1' 
	  AND KQ.MAHV NOT IN ( SELECT MAHV
					    FROM KETQUATHI 
					    WHERE KQUA='Khong dat' AND LANTHI='1')

--32. * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT DISTINCT KQ.MAHV ,HO, TEN
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV=KQ.MAHV
WHERE    KQ.MAHV NOT IN (SELECT MAHV
					 FROM KETQUATHI KQ2
					 WHERE KQ2.KQUA='Khong dat'
					 AND KQ2.LANTHI >= ALL(SELECT LANTHI
										   FROM KETQUATHI KQ2
										   WHERE KQ2.MAHV=KQ.MAHV
										   AND KQ2.MAMH=KQ.MAMH)
					)
		AND KQ.LANTHI>= ALL(SELECT LANTHI
							FROM KETQUATHI KQ3
							WHERE KQ3.MAHV=KQ.MAHV
							AND KQ3.MAMH=KQ.MAMH)
--33. Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn và đều đạt (chỉ xét lần thi thứ 1).
SELECT DISTINCT MAHV, HO, TEN
FROM HOCVIEN HV
WHERE NOT EXISTS (SELECT MAMH
				  FROM MONHOC
				  WHERE NOT EXISTS (SELECT MAMH
									FROM KETQUATHI KQ
									WHERE KQ.MAHV=HV.MAHV
										AND KQ.MAMH=MONHOC.MAMH
										AND LANTHI='1' AND KQUA='Dat')
				)
--34. Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn và đều đạt (chỉ xét lần thi sau cùng).
SELECT DISTINCT KQ.MAHV ,HO, TEN
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV=KQ.MAHV
WHERE    KQ.MAHV NOT IN (SELECT MAHV
					 FROM KETQUATHI KQ2
					 WHERE KQ2.KQUA='Khong dat'
					 AND KQ2.LANTHI >= ALL(SELECT LANTHI
										   FROM KETQUATHI KQ2
										   WHERE KQ2.MAHV=KQ.MAHV
										   AND KQ2.MAMH=KQ.MAMH)
					)
		AND KQ.LANTHI>= ALL(SELECT LANTHI
							FROM KETQUATHI KQ3
							WHERE KQ3.MAHV=KQ.MAHV
							AND KQ3.MAMH=KQ.MAMH)
GROUP BY KQ.MAHV, HO, TEN
HAVING COUNT(DISTINCT MAMH) = (SELECT COUNT( DISTINCT MAMH)
					 FROM MONHOC
					 )
--35. Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần
--thi sau cùng).
WITH BANGDIEM AS
(SELECT MAHV, MAMH, MAX(DIEM) AS DIEMTHI
FROM KETQUATHI KQ
WHERE LANTHI >= ALL(SELECT LANTHI
					FROM KETQUATHI KQ2
					WHERE KQ2.MAHV=KQ.MAHV
					AND KQ2.MAMH=KQ.MAMH)
GROUP BY MAHV, MAMH, LANTHI
)
SELECT HV.MAHV, HO, TEN, MAMH, DIEMTHI
FROM HOCVIEN HV, BANGDIEM BD
WHERE HV.MAHV=BD.MAHV
	AND DIEMTHI>=ALL(SELECT DIEMTHI	
					 FROM BANGDIEM BD2
					 WHERE BD2.MAMH=BD.MAMH)
ORDER BY MAMH
					



