SELECT        dbo.DEAN.TENDEAN, CAST(SUM(dbo.PHANCONG.THOIGIAN) AS decimal(5, 2)) AS [Tổng số giờ làm việc]
FROM            dbo.DEAN INNER JOIN
                         dbo.PHANCONG ON dbo.DEAN.MADA = dbo.PHANCONG.MADA
GROUP BY dbo.DEAN.TENDEAN


SELECT        dbo.DEAN.TENDEAN, CAST(SUM(dbo.PHANCONG.THOIGIAN) AS varchar) AS [Tổng số giờ làm việc]
FROM            dbo.DEAN INNER JOIN
                         dbo.PHANCONG ON dbo.DEAN.MADA = dbo.PHANCONG.MADA
GROUP BY dbo.DEAN.TENDEAN


SELECT        dbo.PHONGBAN.MAPHG, dbo.PHONGBAN.TENPHG, CAST(AVG(dbo.NHANVIEN.LUONG) AS decimal(15, 2)) AS 'Lương trung bình'
FROM            dbo.NHANVIEN INNER JOIN
                         dbo.PHONGBAN ON dbo.NHANVIEN.PHG = dbo.PHONGBAN.MAPHG
GROUP BY dbo.PHONGBAN.MAPHG, dbo.PHONGBAN.TENPHG

SELECT        dbo.PHONGBAN.MAPHG, dbo.PHONGBAN.TENPHG, LEFT(CAST(AVG(dbo.NHANVIEN.LUONG) AS varchar), 3) + [,] + REPLACE(CAST(AVG(dbo.NHANVIEN.LUONG) AS varchar), LEFT(CAST(AVG(dbo.NHANVIEN.LUONG) AS varchar), 
                         3), [,]) AS 'Lương trung bình'
FROM            dbo.NHANVIEN INNER JOIN
                         dbo.PHONGBAN ON dbo.NHANVIEN.PHG = dbo.PHONGBAN.MAPHG
GROUP BY dbo.PHONGBAN.MAPHG, dbo.PHONGBAN.TENPHG


SELECT        dbo.DEAN.TENDEAN, CEILING(SUM(dbo.PHANCONG.THOIGIAN)) AS [Tổng số giờ làm việc]
FROM            dbo.DEAN INNER JOIN
                         dbo.PHANCONG ON dbo.DEAN.MADA = dbo.PHANCONG.MADA
GROUP BY dbo.DEAN.TENDEAN


SELECT        dbo.DEAN.TENDEAN, FLOOR(SUM(dbo.PHANCONG.THOIGIAN)) AS [Tổng số giờ làm việc]
FROM            dbo.DEAN INNER JOIN
                         dbo.PHANCONG ON dbo.DEAN.MADA = dbo.PHANCONG.MADA
GROUP BY dbo.DEAN.TENDEAN


SELECT        dbo.DEAN.TENDEAN, ROUND(SUM(dbo.PHANCONG.THOIGIAN), 2) AS [Tổng số giờ làm việc]
FROM            dbo.DEAN INNER JOIN
                         dbo.PHANCONG ON dbo.DEAN.MADA = dbo.PHANCONG.MADA
GROUP BY dbo.DEAN.TENDEAN


SELECT        HONV + ' ' + TENLOT + ' ' + TENNV AS 'Họ tên nhân viên có lương trung bình trên mức lương trung bình của phòng "Nghiên cứu"', LUONG
FROM            dbo.NHANVIEN
WHERE        (LUONG >
                             (SELECT        ROUND(AVG(NHANVIEN_1.LUONG), 2) AS 'Lương trung bình của nhân viên là :'
                               FROM            dbo.NHANVIEN AS NHANVIEN_1 INNER JOIN
                                                         dbo.PHONGBAN ON NHANVIEN_1.PHG = dbo.PHONGBAN.MAPHG
                               WHERE        (dbo.PHONGBAN.TENPHG = N'Nghiên cứu')))


SELECT        UPPER(dbo.NHANVIEN.HONV) AS HONV, LOWER(dbo.NHANVIEN.TENLOT) AS TENLOT, LOWER(SUBSTRING(dbo.NHANVIEN.TENNV, 1, 1)) + UPPER(SUBSTRING(dbo.NHANVIEN.TENNV, 2, 1)) 
                         + SUBSTRING(dbo.NHANVIEN.TENNV, 3, 10) AS TENNV , dbo.NHANVIEN.DIACHI
FROM            dbo.NHANVIEN INNER JOIN
                         dbo.THANNHAN ON dbo.NHANVIEN.MANV = dbo.THANNHAN.MA_NVIEN
GROUP BY dbo.NHANVIEN.HONV, dbo.NHANVIEN.TENLOT, dbo.NHANVIEN.TENNV
HAVING        (COUNT(dbo.THANNHAN.MA_NVIEN) > 2)

SELECT TENNV
FROM NHANVIEN
WHERE YEAR(NGSINH) between 1960 and 1965
SELECT YEAR(GETDATE())-YEAR(NGSINH) as 'Tuoi' FROM NHANVIEN