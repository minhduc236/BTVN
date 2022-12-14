create database QLHANG
go
use QLHANG
go
CREATE TABLE VATTU (
	MaVT NVARCHAR(10) not null,
	TenVT NVARCHAR(20) not null,
	DVTinh NVARCHAR(10) not null,
	SLCon INT not null,
	CONSTRAINT pk_vattu PRIMARY KEY (MaVT)
)
GO

CREATE TABLE HDBAN (
	MaHD NVARCHAR(10) not null,
	NgayXuat SMALLDATETIME not null,
	HoTenKhach NVARCHAR(20) not null
	CONSTRAINT pk_hbban PRIMARY KEY (MaHD)
)
GO

CREATE TABLE HANGXUAT(
	MaHD NVARCHAR(10) not null,
	MaVT NVARCHAR(10) not null,
	DonGia MONEY not null,
	SLBan INT not null,
)
GO
ALTER TABLE HANGXUAT
WITH CHECK ADD
CONSTRAINT FK_vattu_hangxuat foreign key (MaVT) references VATTU(MaVT)
GO
ALTER TABLE HANGXUAT
WITH CHECK ADD
CONSTRAINT FK_hdban_hangxuat foreign key (MaHD) references HDBAN(MaHD)
go
INSERT INTO VATTU VALUES ('VT01','Kem đánh răng PS','cây',200)
INSERT INTO VATTU VALUES ('VT02','Bánh tráng trộn','bịch',100)
INSERT INTO HDBAN VALUES ('HD01',CAST('2022-10-12' as date),N'Trần Văn Nhớ')
INSERT INTO HDBAN VALUES ('HD02',CAST('2022-10-12' as date),N'Lê Thị Ơn')
INSERT INTO HANGXUAT VALUES ('HD01','VT01',17000,2)
INSERT INTO HANGXUAT VALUES ('HD02','VT01',20000,10)
INSERT INTO HANGXUAT VALUES ('HD01','VT02',17000,3)
INSERT INTO HANGXUAT VALUES ('HD02','VT02',20000,5)

------------Câu 2
select top 1 MaHD, sum(DonGia*SLBan) as TongTien from HANGXUAT group by MaHD,
DONGIA order by DONGIA desc
-------Câu 3
CREATE FUNCTION inra_thu (@MAHD nvarchar(10))
RETURNS TABLE
AS
RETURN
    SELECT 
        HX.MaHD,
        HD.NgayXuat,
        VT.MaVT,
        HX.DonGia,
        HX.SLBan,  
        CASE 
            WHEN DATENAME(WEEKDAY,HD.NgayXuat) = 0 THEN N'Thứ hai'            
            WHEN DATENAME(WEEKDAY,HD.NgayXuat) = 1 THEN N'Thứ ba'
            WHEN DATENAME(WEEKDAY,HD.NgayXuat) = 2 THEN N'Thứ tư'
            WHEN DATENAME(WEEKDAY,HD.NgayXuat) = 3 THEN N'Thứ năm'
            WHEN DATENAME(WEEKDAY,HD.NgayXuat) = 4 THEN N'Thứ sáu'
            WHEN DATENAME(WEEKDAY,HD.NgayXuat) = 5 THEN N'Thứ bảy'
            ELSE N'Chủ nhật'
        END AS NGAYTHU
    FROM HANGXUAT HX
    INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
	INNER JOIN VATTU VT ON VT.MaVT = HX.MaVT
    WHERE HX.MaHD = @MAHD;
---------Câu 4
CREATE PROCEDURE tongtien @thang int, @nam int 
AS
SELECT 
SUM(SLBAN * DONGIA)
FROM HANGXUAT HX
INNER JOIN HDBAN HD ON HX.MAHD = HD.MAHD
where MONTH(HD.NgayXuat) = @THANG AND YEAR(HD.NgayXuat) = @NAM;
select top 1 MAHD, sum(DonGia) as TongTien from HANGXUAT group by MAHD,
DONGIA order by DONGIA desc