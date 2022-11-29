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

alter proc lab5_2b @manv int
as
begin
		select count(MANV) as 'so luong', MADA, TENPHG from NHANVIEN
		inner join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
		inner join DEAN on DEAN.PHONG = PHONGBAN.MAPHG
		where MADA = @manv
		group by TENPHG,MADA
end
exec lab5_2b 11 
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