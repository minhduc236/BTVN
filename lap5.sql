create proc lab5_1a @name nvarchar(20)
as
	begin
		print 'welcome : ' + @name
	end
exec lab5_1a 'Minh Duc'
go

create proc lab5_1b @so1 int, @so2 int
as
	begin
		declare @tong int = 0;
		set @tong = @so1 + @so2 
		print 'tong: ' + cast(@tong as varchar(10))
	end

exec lab5_1b 6,9
go

create proc lab5_1c @l int
as
	begin
		declare @tong int = 0, @i int = 0;
		while @i < @l
			begin
				set @tong = @tong + @i
				set @i = @i + 2
			end
		print 'tổng: ' + cast(@tong as varchar(10))
	end
exec lab5_1c 9
go

create proc lab5_1d @a int, @b int
as
	begin
		while (@a != @b)
			begin
				if(@a > @b)
					set @a = @a -@b
				else
					set @b = @b - @a
			end
			return @a
	end
declare @l int
exec @l = lab5_1d 5,6 
print @l
go

create proc lab5_2a @MaNV varchar(20)
as
	begin
		select * from NHANVIEN where MANV = @MaNV
	end
exec lab5_2a '003'
go

select count(MANV), MADA, TENPHG from NHANVIEN
inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
where MADA = 2
group by TENPHG,MADA
go

create proc cau2b @MaDa int
as
begin
    select count(MANV), MADA, TENPHG from PHONGBAN
    inner join NHANVIEN on NHANVIEN.PHG = PHONGBAN.MAPHG
    inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
    where MADA = @MaDa
    group by TENPHG,MADA
    having MADA = @MaDa
end
go
exec cau2b 20
go

select * from NHANVIEN
select * from PHONGBAN
select * from THANNHAN
select * from nhanvien
inner join PHONGBAN on phongban.MAPHG=NHANVIEN.PHG
left outer join THANNHAN on THANNHAN.MA_NVIEN=NHANVIEN.MANV
where THANNHAN.MA_NVIEN is null and TRPHG='008'

if exists(select * from NHANVIEN where manv=MANV and phg=@MAPHG)
	print 'co'
else
	print 'khong'


create proc sp_themphongbanmoi
	@TENPHG nvarchar(15),
	@MAPHG int,
	@TRPHG nvarchar(9),
	@NG_NHANCHUC date
as
begin 
	if exists(select*from PHONGBAN where MAPHG = @MAPHG)
	begin
		print N' Mã phòng đã tồn tại';
		return;
	end
	insert into PHONGBAN(TENPHG,MAPHG,TRPHG,NG_NHANCHUC) values(@TENPHG,@MAPHG,@TRPHG,@NG_NHANCHUC);
end;

exec sp_themphongbanmoi 'CNTT',15, '005', '10-12-2020';



create proc sp_capnhatphongban
	@TENPHGCU nvarchar(15),
	@TENPHG nvarchar(15),
	@MAPHG int,
	@TRPHG nvarchar(9),
	@NG_NHANCHUC date
as
begin
	update PHONGBAN
	set TENPHG = @TENPHG,
		MAPHG = @MAPHG,
		TRPHG = @TRPHG,
		NG_NHANCHUC = @NG_NHANCHUC
	where TENPHG = @TENPHGCU;
end;

exec sp_capnhatphongban 'CNTT', 'IT', 10, '005', '1-1-2020';


--Bài 3

create proc sp_themNV
	@HONV nvarchar(15),
	@TENLOT nvarchar(15),
	@TENNV nvarchar(15),
	@MANV nvarchar(9),
	@NGSINH datetime,
	@DCHI nvarchar(30),
	@PHAI nvarchar(3),
	@LUONG float,
	@PHG int
as
begin
	if not exists(select*from PHONGBAN where TENPHG = 'IT')
	begin
		print N'Nhân viên phải trực thuộc phòng IT';
		return;
	end;
	declare @MA_NQL nvarchar(9);
	if @LUONG > 25000
		set @MA_NQL = '005';
	else
		set @MA_NQL = '009';
	declare @age int;
	select @age = DATEDIFF(year,@NGSINH,getdate()) + 1;
	if @PHAI = 'Nam' and (@age < 18 or @age >60)
	begin
		print N'Nam phải có độ tuổi từ 18-65';
		return;
	end;
	else if @PHAI = 'Nữ' and (@age < 18 or @age >60)
	begin
		print N'Nữ phải có độ tuổi từ 18-60';
		return;
	end;
	INSERT INTO NHANVIEN(HONV,TENLOT,TENNV,MANV,NGSINH,DCHI,PHAI,LUONG,MA_NQL,PHG)
		VALUES(@HONV,@TENLOT,@TENNV,@MANV,@NGSINH,@DCHI,@PHAI,@LUONG,@MA_NQL,@PHG)
end;

exec sp_themNV N'Nguyễn',N'Hoàng',N'Tuấn','022','12-5-1977',N'Hà Nội','Nam',30000,6;
