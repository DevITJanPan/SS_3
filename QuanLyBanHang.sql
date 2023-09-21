-- Tạo CSDL QUANLYBANHANG
create database QuanLyBanHang;
use QuanLyBanHang;
-- 1.Tạo bảng KHACHHANG
create table KHACHHANG(
    MaKH     nvarchar(4) primary key,
    TenKH    nvarchar(30) not null,
    DiaChi   nvarchar(50),
    NgaySinh datetime,
    SoDT     nvarchar(15) unique
);

-- 2.Tạo bảng NHANVIEN
create table NHANVIEN(
    MaNV        nvarchar(4) primary key,
    HoTen       nvarchar(30) not null,
    GioiTinh    bit          not null,
    DiaChi      nvarchar(50) not null,
    NgaySinh    datetime     not null,
    DienThoai   nvarchar(15),
    Email        text,
    NoiSinh     nvarchar(20) not null,
    NgayVaoLam datetime,
    MaNQL       nvarchar(4)
);

-- 3.Tạo bảng NHACUNGCAP
create table NHACUNGCAP(
    MaNCC     nvarchar(5) primary key,
    TenNCC    nvarchar(50) not null,
    DiaChi    nvarchar(50) not null,
    DienThoai nvarchar(15) not null,
    Email      nvarchar(30) not null,
    Website    nvarchar(30)
);
-- 4.Tạo bảng LOAISP
create table LOAISP(
    MaLoaiSP  nvarchar(4) primary key,
    TenLoaiSP nvarchar(30)  not null,
    GhiChu     nvarchar(100) not null
);

-- 5.Tạo bảng SANPHAM
create table SANPHAM(
    MaSP       nvarchar(4) primary key,
    MaLoaiSP  nvarchar(4)  not null,
    TenSP      nvarchar(50) not null,
    DonViTinh nvarchar(10) not null,
    GhiChu     nvarchar(100),
    foreign key (MaLoaiSP) references LOAISP (MaLoaiSP)
);
-- 6.Tạo bảng PHIEUNHAP
create table PHIEUNHAP(
    SoPN     nvarchar(5) primary key,
    MaNV     nvarchar(4) not null,
    MaNCC    nvarchar(5) not null,
    NgayNhap datetime default (current_date()),
    GhiChu   nvarchar(100),
    foreign key (MaNV) references NHANVIEN (MaNV),
    foreign key (MaNCC) references NHACUNGCAP (MaNCC)
);

-- 7.Tạo bảng CTPHIEUNHAP
create table CTPHIEUNHAP(
    MaSP    nvarchar(4),
    SoPN    nvarchar(5),
    SoLuong smallint default (0),
    GiaNhap real check (GiaNhap >= 0),
    foreign key (MaSP) references SanPham (MaSP),
    foreign key (SoPN) references PhieuNhap (SoPN),
    primary key (MaSP, SoPN)
);
-- 8.Tạo bảng PHIEUXUAT
create table PHIEUXUAT(
    SoPX    nvarchar(5),
    MaNV    nvarchar(4),
    MaKH    nvarchar(4),
    NgayBan date default (current_date()),
    GhiChu  text,
    foreign key (MaNV) references NhanVien (MaNV),
    foreign key (MaKH) references KHACHHANG (MaKH),
    primary key (SoPX)
);
-- 9.Tạo bảng CTPHIEUXUAT
create table CTPHIEUXUAT(
    SoPX    nvarchar(5),
    MaSP    nvarchar(4),
    SoLuong smallint not null check (SoLuong > 0),
    GiaBan  real     not null check (GiaBan > 0),
    foreign key (SoPX) references PHIEUXUAT (SoPX),
    foreign key (MaSP) references SanPham (MaSP),
    primary key (SoPX, MaSP)
);

-- select dữ liệu các bảng
select *
from KHACHHANG;
select *
from NHANVIEN;
select *
from NHACUNGCAP;
select *
from LOAISP;
select *
from PHIEUNHAP;
select *
from CTPHIEUNHAP;
select *
from PHIEUXUAT;
select *
from CTPHIEUXUAT;
/*
Bài 3: Dùng lệnh INSERT thêm dữ liệu vào các bảng:
1. Thêm 2 Phiếu nhập trong tháng hiện hành. Mỗi phiếu nhập có 2 sản phẩm. 
(Tùy chọn các thông tin liên quan còn lại)
2. Thêm 2 Phiếu xuất trong ngày hiện hành. Mỗi phiếu xuất có 3 sản phẩm. 
(Tùy chọn các thông tin liên quan còn lại)
3. Thêm 1 nhân viên mới (Tùy chọn các thông tin liên quan còn lại)
*/
-- Thêm Phiếu nhập 1
INSERT INTO PHIEUNHAP (SoPN, MaNV, MaNCC)
VALUES ('PN001', 'NV001', 'NCC001');

-- Thêm chi tiết Phiếu nhập 1
INSERT INTO CTPHIEUNHAP (MaSP, SoPN, SoLuong, GiaNhap)
VALUES ('SP001', 'PN001', 5, 10),
       ('SP002', 'PN001', 3, 8);

-- Thêm Phiếu nhập 2
INSERT INTO PHIEUNHAP (SoPN, MaNV, MaNCC)
VALUES ('PN002', 'NV002', 'NCC002');

-- Thêm chi tiết Phiếu nhập 2
INSERT INTO CTPHIEUNHAP (MaSP, SoPN, SoLuong, GiaNhap)
VALUES ('SP003', 'PN002', 4, 12),
       ('SP004', 'PN002', 6, 15);
-- Thêm 2 Phiếu xuất trong ngày hiện hành. Mỗi phiếu xuất có 3 sản phẩm. 
-- Thêm Phiếu xuất 1
INSERT INTO PHIEUXUAT (SoPX, MaNV, MaKH)
VALUES ('PX001', 'NV003', 'KH001');

-- Thêm chi tiết Phiếu xuất 1
INSERT INTO CTPHIEUXUAT (SoPX, MaSP, SoLuong, GiaBan)
VALUES ('PX001', 'SP001', 2, 15),
       ('PX001', 'SP002', 3, 20),
       ('PX001', 'SP003', 1, 18);

-- Thêm Phiếu xuất 2
INSERT INTO PHIEUXUAT (SoPX, MaNV, MaKH)
VALUES ('PX002', 'NV004', 'KH002');

-- Thêm chi tiết Phiếu xuất 2
INSERT INTO CTPHIEUXUAT (SoPX, MaSP, SoLuong, GiaBan)
VALUES ('PX002', 'SP002', 4, 22),
       ('PX002', 'SP003', 2, 19),
       ('PX002', 'SP004', 1, 24);
--     Thêm 1 nhân viên mới
-- Thêm nhân viên mới
INSERT INTO NHANVIEN (MaNV, HoTen, GioiTinh, DiaChi, NgaySinh, DienThoai, Email, NoiSinh, NgayVaoLam, MaNQL)
VALUES ('NV005', 'Nguyen Van E', 1, '123 ABC Street', '1990-03-15', '0123456789', 'e@example.com', 'City E', '2023-09-21', 'NV001');

/*
Bài 4: Dùng lệnh UPDATE cập nhật dữ liệu các bảng
1. Cập nhật lại số điện thoại mới cho khách hàng mã KH10. (Tùy chọn các 
thông tin liên quan)
2. Cập nhật lại địa chỉ mới của nhân viên mã NV05 (Tùy chọn các thông tin 
liên quan)
*/
-- 1. Cập nhật lại số điện thoại mới cho khách hàng mã KH10.
-- Cập nhật số điện thoại mới cho khách hàng KH10
UPDATE KHACHHANG
SET SoDT = '0987654321'
WHERE MaKH = 'KH10';
-- 2. Cập nhật lại địa chỉ mới của nhân viên mã NV05
-- Cập nhật địa chỉ mới cho nhân viên NV05
UPDATE NHANVIEN
SET DiaChi = '456 XYZ Street'
WHERE MaNV = 'NV05';
/*
Bài 5: Dùng lệnh DELETE xóa dữ liệu các bảng
1. Xóa nhân viên mới vừa thêm tại yêu cầu C.3
2. Xóa sản phẩm mã SP15
*/
-- Bài 5: Dùng lệnh DELETE xóa dữ liệu các bảng
-- 5.1. Xóa nhân viên mới vừa thêm tại yêu cầu C.3
-- Xóa nhân viên mới (NV005)
DELETE FROM NHANVIEN
WHERE MaNV = 'NV005';
-- 5.2 Xóa sản phẩm mã SP15
-- Xóa sản phẩm có mã SP15
DELETE FROM SANPHAM
WHERE MaSP = 'SP15';

/*
Bài 6: Dùng lệnh SELECT lấy dữ liệu từ các bảng
*/
/*1. Liệt kê thông tin về nhân viên trong cửa hàng, gồm: mã nhân viên, họ tên 
nhân viên, giới tính, ngày sinh, địa chỉ, số điện thoại, tuổi. Kết quả sắp xếp 
theo tuổi
*/
SELECT MaNV, HoTen, CASE WHEN GioiTinh = 1 THEN 'Nam' ELSE 'Nữ' END AS GioiTinh, NgaySinh, DiaChi, DienThoai, 
DATEDIFF(YEAR, NgaySinh, GETDATE()) AS Tuoi
FROM NHANVIEN
ORDER BY Tuoi;
/*
2. Liệt kê các hóa đơn nhập hàng trong tháng 6/2018, gồm thông tin số phiếu 
nhập, mã nhân viên nhập hàng, họ tên nhân viên, họ tên nhà cung cấp, ngày
nhập hàng, ghi chú.
*/
SELECT PN.SoPN, PN.MaNV, NV.HoTen AS HoTenNV, NCC.TenNCC, PN.NgayNhap, PN.GhiChu
FROM PHIEUNHAP PN
INNER JOIN NHANVIEN NV ON PN.MaNV = NV.MaNV
INNER JOIN NHACUNGCAP NCC ON PN.MaNCC = NCC.MaNCC
WHERE YEAR(PN.NgayNhap) = 2018 AND MONTH(PN.NgayNhap) = 6;
/*
3. Liệt kê tất cả sản phẩm có đơn vị tính là chai, gồm tất cả thông tin về sản 
phẩm
*/
SELECT *
FROM SANPHAM
WHERE DonViTinh = 'chai';
/*
4. Liệt kê chi tiết nhập hàng trong tháng hiện hành gồm thông tin: số phiếu 
nhập, mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính, số lượng, giá 
nhập, thành tiền
*/
SELECT PN.SoPN, CTPN.MaSP, SP.TenSP, LOAISP.TenLoaiSP, SP.DonViTinh, CTPN.SoLuong, CTPN.GiaNhap, CTPN.SoLuong * CTPN.GiaNhap AS ThanhTien
FROM PHIEUNHAP PN
INNER JOIN CTPHIEUNHAP CTPN ON PN.SoPN = CTPN.SoPN
INNER JOIN SANPHAM SP ON CTPN.MaSP = SP.MaSP
INNER JOIN LOAISP ON SP.MaLoaiSP = LOAISP.MaLoaiSP
WHERE YEAR(PN.NgayNhap) = YEAR(GETDATE()) AND MONTH(PN.NgayNhap) = MONTH(GETDATE());
/*
5. Liệt kê các nhà cung cấp có giao dịch mua bán trong tháng hiện hành, gồm 
thông tin: mã nhà cung cấp, họ tên nhà cung cấp, địa chỉ, số điện thoại, 
email, số phiếu nhập, ngày nhập. Sắp xếp thứ tự theo ngày nhập hàng.
*/
SELECT DISTINCT NCC.MaNCC, NCC.TenNCC, NCC.DiaChi, NCC.DienThoai, NCC.Email, PN.SoPN, PN.NgayNhap
FROM NHACUNGCAP NCC
INNER JOIN PHIEUNHAP PN ON NCC.MaNCC = PN.MaNCC
WHERE YEAR(PN.NgayNhap) = YEAR(GETDATE()) AND MONTH(PN.NgayNhap) = MONTH(GETDATE())
ORDER BY PN.NgayNhap;
/*
6. Liệt kê chi tiết hóa đơn bán hàng trong 6 tháng đầu năm 2018 gồm thông tin: 
số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên sản phẩm, 
đơn vị tính, số lượng, giá bán, doanh thu
*/
SELECT PX.SoPX, NV.HoTen AS NhanVienBanHang, PX.NgayBan, CT.MaSP, SP.TenSP, SP.DonViTinh, CT.SoLuong, CT.GiaBan, CT.SoLuong * CT.GiaBan AS DoanhThu
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN NHANVIEN NV ON PX.MaNV = NV.MaNV
INNER JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
WHERE YEAR(PX.NgayBan) = 2018 AND MONTH(PX.NgayBan) BETWEEN 1 AND 6;
/*
7. Hãy in danh sách khách hàng có ngày sinh nhật trong tháng hiện hành (gồm 
tất cả thông tin của khách hàng)
*/
SELECT *
FROM KHACHHANG
WHERE MONTH(NgaySinh) = MONTH(GETDATE());
/*
8. Liệt kê các hóa đơn bán hàng từ ngày 15/04/2018 đến 15/05/2018 gồm các 
thông tin: số phiếu xuất, nhân viên bán hàng, ngày bán, mã sản phẩm, tên 
sản phẩm, đơn vị tính, số lượng, giá bán, doanh thu
*/
SELECT PX.SoPX, NV.HoTen AS NhanVienBanHang, PX.NgayBan, CT.MaSP, SP.TenSP, SP.DonViTinh, CT.SoLuong, CT.GiaBan, CT.SoLuong * CT.GiaBan AS DoanhThu
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN NHANVIEN NV ON PX.MaNV = NV.MaNV
INNER JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
WHERE PX.NgayBan BETWEEN '2018-04-15' AND '2018-05-15';
/*
9. Liệt kê các hóa đơn mua hàng theo từng khách hàng, gồm các thông tin: số 
phiếu xuất, ngày bán, mã khách hàng, tên khách hàng, trị giá
*/
SELECT PX.SoPX, PX.NgayBan, PX.MaKH, KH.TenKH, SUM(CT.SoLuong * CT.GiaBan) AS TriGia
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN KHACHHANG KH ON PX.MaKH = KH.MaKH
GROUP BY PX.SoPX, PX.NgayBan, PX.MaKH, KH.TenKH;
/*
10. Cho biết tổng số chai nước xả vải Comfort đã bán trong 6 tháng đầu năm 
2018. Thông tin hiển thị: tổng số lượng.
*/
SELECT SUM(CT.SoLuong) AS TongSoLuong
FROM CTPHIEUXUAT CT
INNER JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
WHERE YEAR(CT.NgayBan) = 2018 AND MONTH(CT.NgayBan) BETWEEN 1 AND 6 AND SP.TenSP = 'Comfort';
/*
11.Tổng kết doanh thu theo từng khách hàng theo tháng, gồm các thông tin: 
tháng, mã khách hàng, tên khách hàng, địa chỉ, tổng tiền
*/
SELECT YEAR(PX.NgayBan) AS Nam, MONTH(PX.NgayBan) AS Thang, PX.MaKH, KH.TenKH, KH.DiaChi, SUM(CT.SoLuong * CT.GiaBan) AS TongTien
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN KHACHHANG KH ON PX.MaKH = KH.MaKH
GROUP BY YEAR(PX.NgayBan), MONTH(PX.NgayBan), PX.MaKH, KH.TenKH, KH.DiaChi
ORDER BY Nam, Thang, PX.MaKH;
/*
12.Thống kê tổng số lượng sản phẩm đã bán theo từng tháng trong năm, gồm 
thông tin: năm, tháng, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số 
lượng.
*/
SELECT YEAR(CT.NgayBan) AS Nam, MONTH(CT.NgayBan) AS Thang, CT.MaSP, SP.TenSP, SP.DonViTinh, SUM(CT.SoLuong) AS TongSoLuong
FROM CTPHIEUXUAT CT
INNER JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
GROUP BY YEAR(CT.NgayBan), MONTH(CT.NgayBan), CT.MaSP, SP.TenSP, SP.DonViTinh
ORDER BY Nam, Thang, CT.MaSP;
/*
13.Thống kê doanh thu bán hàng trong trong 6 tháng đầu năm 2018, thông tin 
hiển thị gồm: tháng, doanh thu
*/
SELECT YEAR(PX.NgayBan) AS Nam, MONTH(PX.NgayBan) AS Thang, SUM(CT.SoLuong * CT.GiaBan) AS DoanhThu
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
WHERE YEAR(PX.NgayBan) = 2018 AND MONTH(PX.NgayBan) BETWEEN 1 AND 6
GROUP BY YEAR(PX.NgayBan), MONTH(PX.NgayBan)
ORDER BY Nam, Thang;
/*
14.Liệt kê các hóa đơn bán hàng của tháng 5 và tháng 6 năm 2018, gồm các 
thông tin: số phiếu, ngày bán, họ tên nhân viên bán hàng, họ tên khách hàng, 
tổng trị giá.
*/
SELECT PX.SoPX, PX.NgayBan, NV.HoTen AS NhanVienBanHang, KH.TenKH, SUM(CT.SoLuong * CT.GiaBan) AS TongTrigia
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN NHANVIEN NV ON PX.MaNV = NV.MaNV
INNER JOIN KHACHHANG KH ON PX.MaKH = KH.MaKH
WHERE (YEAR(PX.NgayBan) = 2018 AND MONTH(PX.NgayBan) = 5) OR (YEAR(PX.NgayBan) = 2018 AND MONTH(PX.NgayBan) = 6)
GROUP BY PX.SoPX, PX.NgayBan, NV.HoTen, KH.TenKH;
/*
15.Cuối ngày, nhân viên tổng kết các hóa đơn bán hàng trong ngày, thông tin 
gồm: số phiếu xuất, mã khách hàng, tên khách hàng, họ tên nhân viên bán 
hàng, ngày bán, trị giá
*/
SELECT PX.SoPX, PX.MaKH, KH.TenKH, NV.HoTen AS NhanVienBanHang, PX.NgayBan, SUM(CT.SoLuong * CT.GiaBan) AS TriGia
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN NHANVIEN NV ON PX.MaNV = NV.MaNV
INNER JOIN KHACHHANG KH ON PX.MaKH = KH.MaKH
WHERE PX.NgayBan = CURRENT_DATE
GROUP BY PX.SoPX, PX.MaKH, KH.T
/*
16.Thống kê doanh số bán hàng theo từng nhân viên, gồm thông tin: mã nhân 
viên, họ tên nhân viên, mã sản phẩm, tên sản phẩm, đơn vị tính, tổng số 
lượng.
*/
SELECT NV.MaNV, NV.HoTen AS TenNhanVien, CT.MaSP, SP.TenSP, SP.DonViTinh, SUM(CT.SoLuong) AS TongSoLuong
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN NHANVIEN NV ON PX.MaNV = NV.MaNV
INNER JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
GROUP BY NV.MaNV, NV.HoTen, CT.MaSP, SP.TenSP, SP.DonViTinh;

/*
17.Liệt kê các hóa đơn bán hàng cho khách vãng lai (KH01) trong quý 2/2018, 
thông tin gồm số phiếu xuất, ngày bán, mã sản phẩm, tên sản phẩm, đơn vị 
tính, số lượng, đơn giá, thành tiền.
*/
SELECT PX.SoPX, PX.NgayBan, CT.MaSP, SP.TenSP, SP.DonViTinh, CT.SoLuong, CT.GiaBan, (CT.SoLuong * CT.GiaBan) AS ThanhTien
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN KHACHHANG KH ON PX.MaKH = KH.MaKH
INNER JOIN SANPHAM SP ON CT.MaSP = SP.MaSP
WHERE KH.MaKH = 'KH01' AND YEAR(PX.NgayBan) = 2018 AND MONTH(PX.NgayBan) BETWEEN 4 AND 6;

/*
18.Liệt kê các sản phẩm chưa bán được trong 6 tháng đầu năm 2018, thông tin 
gồm: mã sản phẩm, tên sản phẩm, loại sản phẩm, đơn vị tính.
*/
SELECT SP.MaSP, SP.TenSP, LOAI.TenLoaiSP, SP.DonViTinh
FROM SANPHAM SP
INNER JOIN LOAISP LOAI ON SP.MaLoaiSP = LOAI.MaLoaiSP
LEFT JOIN CTPHIEUXUAT CT ON SP.MaSP = CT.MaSP
WHERE CT.MaSP IS NULL AND YEAR(CT.NgayBan) = 2018 AND MONTH(CT.NgayBan) BETWEEN 1 AND 6;

/*
19.Liệt kê danh sách nhà cung cấp không giao dịch mua bán với cửa hàng trong 
quý 2/2018, gồm thông tin: mã nhà cung cấp, tên nhà cung cấp, địa chỉ, số 
điện thoại
*/
SELECT NCC.MaNCC, NCC.TenNCC, NCC.DiaChi, NCC.DienThoai
FROM NHACUNGCAP NCC
LEFT JOIN PHIEUNHAP PN ON NCC.MaNCC = PN.MaNCC
WHERE PN.MaNCC IS NULL AND YEAR(PN.NgayNhap) = 2018 AND MONTH(PN.NgayNhap) BETWEEN 4 AND 6;

/*
20.Cho biết khách hàng có tổng trị giá đơn hàng lớn nhất trong 6 tháng đầu năm 
2018.
*/
SELECT PX.MaKH, KH.TenKH, SUM(CT.SoLuong * CT.GiaBan) AS TongTriGiaDonHang
FROM PHIEUXUAT PX
INNER JOIN CTPHIEUXUAT CT ON PX.SoPX = CT.SoPX
INNER JOIN KHACHHANG KH ON PX.MaKH = KH.MaKH
WHERE YEAR(PX.NgayBan) = 2018 AND MONTH(PX.NgayBan) BETWEEN 1 AND 6
GROUP BY PX.MaKH, KH.TenKH
ORDER BY TongTriGiaDonHang DESC
LIMIT 1;

/*
21.Cho biết mã khách hàng và số lượng đơn đặt hàng của mỗi khách hàng
*/
SELECT KH.MaKH, KH.TenKH, COUNT(PX.SoPX) AS SoLuongDonDatHang
FROM KHACHHANG KH
LEFT JOIN PHIEUXUAT PX ON KH.MaKH = PX.MaKH
GROUP BY KH.MaKH, KH.TenKH;

/*
22.Cho biết mã nhân viên, tên nhân viên, tên khách hàng kể cả những nhân viên 
không đại diện bán hàng
*/
SELECT DISTINCT NV.MaNV, NV.HoTen AS TenNhanVien, PX.MaKH, KH.TenKH
FROM NHANVIEN NV
LEFT JOIN PHIEUXUAT PX ON NV.MaNV = PX.MaNV
LEFT JOIN KHACHHANG KH ON PX.MaKH = KH.MaKH;

/*
23.Cho biết số lượng nhân viên nam, số lượng nhân viên nữ
*/
SELECT CASE WHEN NV.GioiTinh = 1 THEN 'Nam' ELSE 'Nữ' END AS GioiTinh, COUNT(*) AS SoLuongNhanVien
FROM NHANVIEN NV
GROUP BY NV.GioiTinh;

/*
24.Cho biết mã nhân viên, tên nhân viên, số năm làm việc của những nhân viên 
có thâm niên cao nhất
*/
SELECT NV.MaNV, NV.HoTen AS TenNhanVien, DATEDIFF(YEAR, NV.NgayVaoLam, GETDATE()) AS SoNamLamViec
FROM NHANVIEN NV
WHERE DATEDIFF(YEAR, NV.NgayVaoLam, GETDATE()) = (
    SELECT MAX(DATEDIFF(YEAR, NV2.NgayVaoLam, GETDATE()))
    FROM NHANVIEN NV2
);

/*
25.Hãy cho biết họ tên của những nhân viên đã đến tuổi về hưu (nam:60 tuổi, 
nữ: 55 tuổi)
*/
/*
26.Hãy cho biết họ tên của nhân viên và năm về hưu của họ. 
*/
/*
27.Cho biết tiền thưởng tết dương lịch của từng nhân viên. Biết rằng - thâm 
niên <1 năm thưởng 200.000 - 1 năm <= thâm niên < 3 năm thưởng 
400.000 - 3 năm <= thâm niên < 5 năm thưởng 600.000 - 5 năm <= thâm 
niên < 10 năm thưởng 800.000 - thâm niên >= 10 năm thưởng 1.000.000

*/
SELECT NV.MaNV, NV.HoTen AS TenNhanVien,
       CASE
           WHEN DATEDIFF(YEAR, NV.NgayVaoLam, GETDATE()) < 1 THEN 200000
           WHEN DATEDIFF(YEAR, NV.NgayVaoLam, GETDATE()) < 3 THEN 400000
           WHEN DATEDIFF(YEAR, NV.NgayVaoLam, GETDATE()) < 5 THEN 600000
           WHEN DATEDIFF(YEAR, NV.NgayVaoLam, GETDATE()) < 10 THEN 800000
           ELSE 1000000
       END AS TienThuongTetDuongLich
FROM NHANVIEN NV;

/*
28.Cho biết những sản phẩm thuộc ngành hàng Hóa mỹ phẩm
*/
SELECT SP.MaSP, SP.TenSP, LOAI.TenLoaiSP, SP.DonViTinh
FROM SANPHAM SP
INNER JOIN LOAISP LOAI ON SP.MaLoaiSP = LOAI.MaLoaiSP
WHERE LOAI.TenLoaiSP = 'Hóa mỹ phẩm';

/*
29.Cho biết những sản phẩm thuộc loại Quần áo.

*/
SELECT SP.MaSP, SP.TenSP, LOAI.TenLoaiSP, SP.DonViTinh
FROM SANPHAM SP
INNER JOIN LOAISP LOAI ON SP.MaLoaiSP = LOAI.MaLoaiSP
WHERE LOAI.TenLoaiSP = 'Quần áo';

/*
30.Cho biết số lượng sản phẩm loại Quần áo.

*/
SELECT LOAI.TenLoaiSP, COUNT(*) AS SoLuongSanPham
FROM SANPHAM SP
INNER JOIN LOAISP LOAI ON SP.MaLoaiSP = LOAI.MaLoaiSP
WHERE LOAI.TenLoaiSP = 'Quần áo'
GROUP BY LOAI.TenLoaiSP;

/*
31.Cho biết số lượng loại sản phẩm ngành hàng Hóa mỹ phẩm
*/
SELECT LOAI.TenLoaiSP, COUNT(*) AS SoLuongLoaiSanPham
FROM SANPHAM SP
INNER JOIN LOAISP LOAI ON SP.MaLoaiSP = LOAI.MaLoaiSP
WHERE LOAI.TenLoaiSP = 'Hóa mỹ phẩm'
GROUP BY LOAI.TenLoaiSP;

/*
32.Cho biết số lượng sản phẩm theo từng loại sản phẩm
*/
SELECT LOAI.TenLoaiSP, COUNT(*) AS SoLuongSanPham
FROM SANPHAM SP
INNER JOIN LOAISP LOAI ON SP.MaLoaiSP = LOAI.MaLoaiSP
GROUP BY LOAI.TenLoaiSP;









       

