----câu 1a
create trigger Themnv on NHANVIEN
for insert
as
if (select LUONG from inserted) < 15000
begin
print ' luong phai > 15000 '
rollback transaction 
end
insert into NHANVIEN values ('Trần', 'Thiện', 'Nam', '09',CAST('1978-10-23' as date), '243 Cộng Hòa, TP HCM', 'Nam', 16000, '004', 5)
select * from NHANVIEN

-----câu 1b
create trigger Themnv2 on NHANVIEN
for insert
as
declare @tuoi int
set @tuoi=year(getdate())-(select year(ngsinh) from inserted)
if(@tuoi<18 or @tuoi>65)
begin
print 'tuoi khong dung voi yeu cau'
rollback transaction
end
insert into NHANVIEN values ('Trần', 'Thiện', 'Nam', '09',CAST('1978-10-23' as date), '243 Cộng Hòa, TP HCM', 'Nam', 16000, '004', 5)
select * from NHANVIEN

----câu 1c
create trigger update_nv on NHANVIEN
for Update
as
if(select dchi from inserted) like '%TP HCM%'
begin
print 'dia chi khong hop le'
rollback transaction
end
update NHANVIEN set TENNV='an' where MANV='001'


-----câu 2a
	
   on NHANVIEN
   AFTER INSERT
AS
   Declare @male int, @female int;
   select @female = count(Manv) from NHANVIEN where PHAI = N'Nữ';
   select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
   print N'Tổng số nhân viên là nữ: ' + cast(@female as varchar);
   print N'Tổng số nhân viên là nam: ' + cast(@male as varchar);
INSERT INTO NHANVIEN VALUES ('Ha','Ha','Ha','345','7-12-1999','HCM','Nam',600000,'005',1)
GO
 --câu 2b
 create trigger trg_TongNVSauUpdate
   on NHANVIEN
   AFTER update
AS
   if (select top 1 PHAI FROM deleted) != (select top 1 PHAI FROM inserted)
   begin
      Declare @male int, @female int;
      select @female = count(Manv) from NHANVIEN where PHAI = N'Nữ';
      select @male = count(Manv) from NHANVIEN where PHAI = N'Nam';
      print N'so nhan vien la nu: ' + cast(@female as varchar);
      print N'so nhan vien la nam: ' + cast(@male as varchar);
   end
UPDATE NHANVIEN
   SET HONV = 'Tín',PHAI = N'Nữ'
 WHERE  MaNV = '010'
GO
---câu 2c
CREATE TRIGGER trg_TongNVSauXoa on DEAN
AFTER DELETE
AS
begin
   SELECT MA_NVIEN, COUNT(MADA) as 'so de an da tham gia' from PHANCONG
      GROUP BY MA_NVIEN
	  end
insert into dean values ('SQL', 50, 'HH', 4)
delete from dean where MADA=50

----bài 3a

create trigger delete_thannhan on NHANVIEN
instead of delete
as
begin
delete from THANNHAN where MA_NVIEN in(select manv from deleted)
delete from NHANVIEN where manv in(select manv from deleted)
end
insert into THANNHAN values ('012', 'Khang', 'Nam', '03-10-2017', 'con')
delete from NHANVIEN where manv='012'

-----bài 3b

create trigger nhanvien3 on NHANVIEN
after insert 
as
begin
insert into PHANCONG values ((select manv from inserted), 1,19,10)
end
insert into NHANVIEN values ('Trần', 'Thiện', 'Nam', '09',CAST('1978-10-23' as date), '243 Cộng Hòa, TP HCM', 'Nam', 16000, '004', 5)