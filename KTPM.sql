use master 
go 
-- Kiểm tra và xóa database nếu tồn tại 
if exists (select name from sys.databases where name = 'KTPM')
drop database KTPM
go 

-- Tạo lại database KTPM 
create database KTPM 
go

-- Chuyển ngữ cảnh sang database KTPM 
use KTPM
go

-- Tạo bảng vùng  
create table Vung
(Id int primary key
, Ten nvarchar(100) not null
)
insert into Vung(Id, Ten)
values
(1, N'Bắc Bộ'),
(2, N'Trung Bộ'),
(3, N'Nam Bộ'),
(4, N'Đồng bằng sông Hồng'),
(5, N'Đồng bằng sông Cửu Long'),
(6, N'Bắc Trung Bộ'),
(7, N'Tây Nguyên'),
(8, N'Đông Nam Bộ'),
(9, N'Miền núi phía Bắc'),
(10, N'Khu vực biển Đông');


-- Tạo bảng cập hành chính 
create table CapHanhCHinh
( Id int primary key
, Ten nvarchar(50) not null
, Cap int not null
)
insert into CapHanhChinh(Id, Ten, Cap)
values
(1, N'Thành Phố', 1)
,(2, N'Tỉnh', 1)
,(3, N'Quận', 2)
,(4, N'Huyện', 2)
,(5, N'Phường', 2)
,(6, N'Xã', 3)

-- Tạo bảng đơn vị hành chính 
create table DonViHanhChinh
(Id int primary key
,Ten nvarchar(50) not null
,CapHanhChinhId int foreign key references CapHanhChinh(Id)
,TrucThuocId int
)
insert into DonViHanhChinh(Id, Ten, CapHanhChinhId, TrucThuocId)
values
(1, N'Thành Phố Hà Nội', 1, null),        -- Thành phố trực thuộc trung ương
(2, N'Thành Phố Hồ Chí Minh', 1, null),  -- Thành phố trực thuộc trung ương
(3, N'Quận Ba Đình', 3, 1),              -- Quận thuộc Hà Nội
(4, N'Quận 1', 3, 2),                    -- Quận thuộc TP.HCM
(5, N'Huyện Gia Lâm', 4, 1),             -- Huyện thuộc Hà Nội
(6, N'Huyện Củ Chi', 4, 2),              -- Huyện thuộc TP.HCM
(7, N'Phường Trúc Bạch', 5, 3),          -- Phường thuộc Quận Ba Đình
(8, N'Phường Bến Nghé', 5, 4),           -- Phường thuộc Quận 1
(9, N'Xã Yên Viên', 6, 5),               -- Xã thuộc Huyện Gia Lâm
(10, N'Xã Trung An', 6, 6);              -- Xã thuộc Huyện Củ Chi

-- Tạo bảng Vai Trò 
create table VaiTro
(Ma int primary key
,Ten nvarchar(100) not null
)
insert into VaiTro(VaiTro.Ma, VaiTro.Ten)
values 
(0, 'ADMIN')
,(1, 'USER');

-- Tạo bảng người dùng 
create table NguoiDung
(Id int primary key
, TaiKhoan nvarchar(100) not null
, Email nvarchar(100) not null 
, MatKhau nvarchar(100) not null
);
insert into NguoiDung (Id, TaiKhoan, Email, MatKhau)
values
(1, N'admin', N'admin@example.com', N'Admin@123'),       -- Admin account
(2, N'user1', N'user1@example.com', N'User1@123'),       -- User account 1
(3, N'user2', N'user2@example.com', N'User2@123'),       -- User account 2
(4, N'user3', N'user3@example.com', N'User3@123'),       -- User account 3
(5, N'user4', N'user4@example.com', N'User4@123'),       -- User account 4
(6, N'user5', N'user5@example.com', N'User5@123'),       -- User account 5
(7, N'user6', N'user6@example.com', N'User6@123'),       -- User account 6
(8, N'user7', N'user7@example.com', N'User7@123'),       -- User account 7
(9, N'user8', N'user8@example.com', N'User8@123'),       -- User account 8
(10, N'user9', N'user9@example.com', N'User9@123');      -- User account 9

-- Tạo bảng trung gian Vai Trò và Người dùng 
create table VaiTroNguoiDung
(
    NguoiDungId int not null foreign key references NguoiDung(Id), 
    VaiTroId int not null foreign key references VaiTro(Ma),      
    primary key (NguoiDungId, VaiTroId)                           
)
insert into VaiTroNguoiDung (NguoiDungId, VaiTroId)
values
(1, 0),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(5, 0),
(7, 1),
(8, 1),
(9, 1),
(10, 1);

--select NguoiDung.TaiKhoan, VaiTro.Ten from VaiTroNguoiDung 
--inner join VaiTro on VaiTroNguoiDung.VaiTroId = VaiTro.Ma
--inner join NguoiDung on VaiTroNguoiDung.NguoiDungId = NguoiDung.ID

-- Tạo bảng loại sản phẩm 
create table LoaiSanPham
(Id int primary key
, Ten nvarchar(100) not null
)
insert into  LoaiSanPham(Id, Ten)
values 
(1, N'Giống cây trồng chính')
,(2, N'Giống cây được lưu hành tại Việt Nam')
,(3, N'Giống Cây đầu dòng')
,(4, N'Thuốc bảo vệ thực vật')
,(5, N'Phân bón');

-- Tạo bảng sản phẩm 
create table SanPham
(Id int primary key
, Ten nvarchar(100) not null
, LoaiSanPhamId int foreign key references LoaiSanPham(Id)
)
insert into SanPham (Id, Ten, LoaiSanPhamId)
values 
(1, N'Lúa', 1),
(2, N'Cà phê', 1),
(3, N'Cam', 1),
(4, N'Táo', 2),
(5, N'Nhãn', 2),
(6, N'Bưởi', 2),
(7, N'Sầu riêng', 3),
(8, N'Vải', 3),
(9, N'Chuối', 3),
(10, N'Thuốc trừ sâu', 4),
(11, N'Thuốc trừ chuột', 4),
(12, N'Thuốc diệt cỏ', 4),
(13, N'Phân bón Bình Điền', 5),
(14, N'Phân bón Lâm Thao', 5),
(15, N'Phân bón Văn Điển', 5);

-- Tạo bảng loại cơ sở 
create table LoaiCoSo
(Id int primary key 
, Ten nvarchar(100) not null
)
insert into LoaiCoSo(Id, Ten)
values 
(1, N'Cơ sở sản xuất thuộc bảo vệ thực vật')
,(2, N'Cơ sở buôn bán thuộc bảo vệ thực vật')
,(3, N'Cơ sở sản xuất phân bón')
,(4, N'Cơ sở buôn bán phân bón')
,(5, N'Cơ sở sản xuất trồng trọ đủ điều kiện an toàn thực phẩm VietGap');

-- Tạo bảng cơ sở 
create table CoSo
(Id int primary key
, Ten nvarchar(100) not null
, Diachi nvarchar(100) not null
, DonViHanhChinhId int foreign key references  DonViHanhChinh(Id)
, LoaiCoSoId int foreign key references LoaiCoSo(Id)
, VungId int foreign key references Vung(Id)
)
insert into CoSo (Id, Ten, DiaChi, DonViHanhChinhId, LoaiCoSoId, VungId)
values 
(1, N'Cơ sở sản xuất Hà Nội', N'123 Đường Láng, Hà Nội', 1, 3, 2),
(2, N'Cơ sở buôn bán TP. HCM', N'45 Đường Lê Lợi, TP.HCM', 2, 4, 4),
(3, N'Cơ sở phân phối Ba Đình', N'12 Phố Trúc Bạch, Quận Ba Đình', 3, 1, 5),
(4, N'Cơ sở sản xuất Quận 1', N'78 Đường Đồng Khởi, Quận 1', 4, 4, 3),
(5, N'Cơ sở trồng trọt Gia Lâm', N'Xã Yên Viên, Huyện Gia Lâm', 5, 5, 4),
(6, N'Cơ sở sản xuất Củ Chi', N'Xã Trung An, Huyện Củ Chi', 6, 5, 1),
(7, N'Cơ sở cung ứng Hà Nội', N'98 Đường Nguyễn Trãi, Hà Nội', 1, 3, 2),
(8, N'Cơ sở phân phối TP.HCM', N'200 Đường Phạm Ngũ Lão, TP.HCM', 2, 1, 8),
(9, N'Cơ sở sản xuất Phường Trúc Bạch', N'Phố Trúc Bạch, Quận Ba Đình', 7, 2, 9),
(10, N'Cơ sở sản xuất Phường Bến Nghé', N'Đường Bến Nghé, Quận 1', 8, 2, 8);

-- Tạo bảng trung gian sản phẩm và cơ sở 
create table SanPhamCoSo(
SanPhamId int not null foreign key references SanPham(Id), 
CoSoId int not null foreign key references CoSo(Id),      
primary key (SanPhamId, CoSoId)
)
insert into SanPhamCoSo (SanPhamId, CoSoId)
values
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(1, 5),
(2, 6),
(3, 7),
(4, 8),
(5, 9),
(6, 10),
(7, 1),
(8, 2),
(9, 3),
(10, 4);

-- Câu lệnh thể hiện mối quan hệ nhiều nhiều giữa sản phẩm và cơ sỏ 
--select SanPham.Ten as TenSanPham, CoSo.Ten as TenCoSo
--from SanPhamCoSo
--INNER JOIN SanPham on SanPhamCoSo.SanPhamId = SanPham.Id
--INNER JOIN CoSo on SanPhamCoSo.CoSoId = CoSo.Id;
--select SanPham.Ten as TenSanPham 
--from SanPhamCoSo 
--inner join SanPham on SanPhamCoSo.SanPhamId = SanPham.Id
--inner join CoSo on CoSo.Id = 5


--select CoSo.Ten, LoaiCoSo.Ten, Vung.Ten
--from CoSo 
--inner join LoaiCoSo on LoaiCoSoId = LoaiCoSo.Id
--inner join Vung on VungId = Vung.Id


-- Tạo bảng sinh vật gây hại 
create table SVGayhai
(Id int primary key
, Ten nvarchar(100) not null
, CapDoPhoBien INT CHECK (CapDoPhoBien BETWEEN 1 AND 5)
, TinhHinh nvarchar(200) not null
)
insert into SVGayhai (Id, Ten, CapDoPhoBien, TinhHinh)
values 
(1, N'Chuột đồng', 5, N'Phá hoại mùa màng, làm giảm năng suất nông nghiệp'),
(2, N'Rầy nâu', 4, N'Tấn công cây lúa, gây bệnh vàng lùn và lùn xoắn lá'),
(3, N'Sâu đục thân', 3, N'Làm tổn hại cây trồng như ngô, lúa và mía'),
(4, N'Bọ xít xanh', 2, N'Gây hại cho cây ăn quả, làm rụng quả non'),
(5, N'Nhện đỏ', 3, N'Hút nhựa cây, làm giảm năng suất cây trồng'),
(6, N'Ve sầu non', 2, N'Tấn công cây cà phê và cây công nghiệp'),
(7, N'Sâu xanh da láng', 4, N'Phá hoại lá cây, làm giảm khả năng quang hợp'),
(8, N'Bọ trĩ', 5, N'Làm hỏng hoa và quả non của cây trái'),
(9, N'Sâu keo mùa thu', 3, N'Gây thiệt hại lớn cho ngô và các cây lương thực khác'),
(10, N'Ốc bươu vàng', 5, N'Phá hại cây lúa, gây thiệt hại mùa màng nghiêm trọng');
