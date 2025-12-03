--add linked  NODE_KHIEM
EXEC sp_addlinkedserver
    @server = 'NODE_VINH',
    @srvproduct = '',
    @provider = 'SQLNCLI',
    @datasrc = 'DESKTOP-OUQRBEM';

EXEC sp_addlinkedsrvlogin
    @rmtsrvname = 'NODE_VINH',
    @useself = 'false',
    @locallogin = NULL,
    @rmtuser = 'sa',
    @rmtpassword = 'csdl@123';

--add linked  NODE_KHIEM
EXEC sp_addlinkedserver
    @server = 'NODE_KHIEM',
    @srvproduct = '',
    @provider = 'SQLNCLI',
    @datasrc = 'DESKTOP-SHMM7JF';

EXEC sp_addlinkedsrvlogin
    @rmtsrvname = 'NODE_KHIEM',
    @useself = 'false',
    @locallogin = NULL,
    @rmtuser = 'sa',
    @rmtpassword = 'csdl@123';

---Test performance query node cục bộ
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT TOP (100) [idKhachHang]
     ,[maKhachHang]
     ,[hoTen]
     ,[cccd]
     ,[ngaySinh]
     ,[email]
     ,[soDienThoai]
     ,[diaChi]
     ,[hinhAnhKhachHang]
     ,[rowguid]
FROM CSDL_OLAP.dbo.KhachHang;
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

---Test performance query node subscription
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT TOP (100) [idKhachHang]
     ,[maKhachHang]
     ,[hoTen]
     ,[cccd]
     ,[ngaySinh]
     ,[email]
     ,[soDienThoai]
     ,[diaChi]
     ,[hinhAnhKhachHang]
     ,[rowguid]
FROM NODE_VINH.CSDL_OLAP.dbo.KhachHang;
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

---Test performance query node subscription
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
SELECT TOP (100) [idKhachHang]
     ,[maKhachHang]
     ,[hoTen]
     ,[cccd]
     ,[ngaySinh]
     ,[email]
     ,[soDienThoai]
     ,[diaChi]
     ,[hinhAnhKhachHang]
     ,[rowguid]
FROM NODE_KHIEM.CSDL_OLAP.dbo.KhachHang;
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;

