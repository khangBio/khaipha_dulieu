package com.csdl.group_one.relationdb.service;

import com.csdl.group_one.relationdb.dto.ChiTietDonHangDTO;
import com.csdl.group_one.relationdb.dto.DonHangDTO;
import com.csdl.group_one.relationdb.dto.KhachHangDTO;
import com.csdl.group_one.relationdb.dto.SanPhamDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class KhachHangServiceImpl implements KhachHangService{
    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Override
    public int addKhachHang(KhachHangDTO khachHangDTO){
        String sql = " INSERT INTO dbo.KhachHang(maKhachHang, hoTen, cccd, ngaySinh, email, soDienThoai, diaChi, hinhAnhKhachHang)\n" +
                "VALUES(:maKhachHang, :hoTen, :cccd, :ngaySinh, :email, :soDienThoai, :diaChi, :hinhAnhKhachHang)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("maKhachHang", khachHangDTO.getSoDienThoai());
        parameterSource.addValue("hoTen", khachHangDTO.getHoTen());
        parameterSource.addValue("cccd", khachHangDTO.getCccd());
        parameterSource.addValue("ngaySinh", khachHangDTO.getNgaySinh());
        parameterSource.addValue("email", khachHangDTO.getEmail());
        parameterSource.addValue("soDienThoai", khachHangDTO.getSoDienThoai());
        parameterSource.addValue("diaChi", khachHangDTO.getDiaChi());
        parameterSource.addValue("hinhAnhKhachHang", khachHangDTO.getHinhAnhKhachHang());
        try {
            int result = namedParameterJdbcTemplate.update(sql, parameterSource);
            if (result > 0){
               KhachHangDTO khachHang = findOneKhachHang(khachHangDTO);
               return khachHang.getIdKhachHang();
            }
            return -1;
        }catch (Exception e){
            return -1;
        }
    }

    @Override
    public int updKhachHang(KhachHangDTO khachHangDTO){
        String sql = " UPDATE dbo.KhachHang                 \n" +
                "         SET hoTen = :hoTen,               \n" +
                "             cccd = :cccd,                 \n" +
                "             ngaySinh = :ngaySinh,         \n" +
                "             email = :email,               \n" +
                "             soDienThoai = :soDienThoai,   \n" +
                "             diaChi = :diaChi              \n" +
                "       WHERE idKhachHang = :idKhachHang";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("hoTen", khachHangDTO.getHoTen());
        parameterSource.addValue("cccd", khachHangDTO.getCccd());
        parameterSource.addValue("ngaySinh", khachHangDTO.getNgaySinh());
        parameterSource.addValue("email", khachHangDTO.getEmail());
        parameterSource.addValue("soDienThoai", khachHangDTO.getSoDienThoai());
        parameterSource.addValue("diaChi", khachHangDTO.getDiaChi());
        parameterSource.addValue("idKhachHang", khachHangDTO.getIdKhachHang());
        try {
            return namedParameterJdbcTemplate.update(sql, parameterSource);
        }catch (Exception e){
            return -1;
        }
    }

    @Override
    public KhachHangDTO findOneKhachHang(KhachHangDTO khachHangDTO) {
        String sql = " SELECT TOP(1) idKhachHang        \n" +
                "      ,maKhachHang                     \n" +
                "      ,hoTen                           \n" +
                "      ,cccd                            \n" +
                "      ,ngaySinh                        \n" +
                "      ,email                           \n" +
                "      ,soDienThoai                     \n" +
                "      ,diaChi                          \n" +
                "      ,hinhAnhKhachHang                \n" +
                "  FROM dbo.KhachHang                   \n" +
                "  where 1 = 1                          \n";
        String sqlWhere = "";
        if (khachHangDTO.getIdKhachHang() != null && khachHangDTO.getIdKhachHang() > 0){
            sqlWhere = sqlWhere + " and idKhachHang = :idKhachHang";
        }

        if (khachHangDTO.getSoDienThoai() != null && !khachHangDTO.getSoDienThoai().equals("")){
            sqlWhere = sqlWhere + " and soDienThoai = :soDienThoai";
        }
        if (khachHangDTO.getCccd() != null && !khachHangDTO.getCccd().equals("")){
            sqlWhere = sqlWhere + " and cccd = :cccd";
        }

        if (khachHangDTO.getNgaySinh() != null && !khachHangDTO.getNgaySinh().equals("")){
            sqlWhere = sqlWhere + " and ngaySinh = :ngaySinh";
        }
        sql = sql + sqlWhere;
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("idKhachHang", khachHangDTO.getIdKhachHang());
        parameterSource.addValue("cccd", khachHangDTO.getCccd());
        parameterSource.addValue("ngaySinh", khachHangDTO.getNgaySinh());
        parameterSource.addValue("soDienThoai", khachHangDTO.getSoDienThoai());

        try {
            Map mapResult =  namedParameterJdbcTemplate.queryForMap(sql, parameterSource);
            KhachHangDTO khachHang = new KhachHangDTO();
            if (!mapResult.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                khachHang = mapper.readValue(mapper.writeValueAsString(mapResult), KhachHangDTO.class);
            }
            return khachHang;
        }catch (Exception e){
            return new KhachHangDTO();
        }
    }

    @Override
    public long createDonHang(DonHangDTO donHangDTO) {
        Long maDonHang = System.currentTimeMillis();
        String sql = "INSERT INTO dbo.DonHang(maDonHang, ngayHoaDon, tongTien, trangThai, idKhachHang)\n" +
                "VALUES (:maDonHang, :ngayHoaDon, :tongTien, :trangThai, :idKhachHang)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("maDonHang", maDonHang.longValue());
        parameterSource.addValue("ngayHoaDon", donHangDTO.getNgayHoaDon());
        parameterSource.addValue("tongTien", donHangDTO.getTongTien());
        parameterSource.addValue("trangThai", donHangDTO.getTrangThai());
        parameterSource.addValue("idKhachHang", donHangDTO.getIdKhachHang());
        try {
            int result = namedParameterJdbcTemplate.update(sql, parameterSource);
            return result > 0 ? maDonHang.longValue() : -1;
        }catch (Exception e){
            return -1;
        }
    }

    @Override
    public int updDonHang(DonHangDTO donHangDTO) {
        String sql = "UPDATE dbo.DonHang                \n" +
                "        SET ngayHoaDon = :ngayHoaDon,  \n" +
                "            tongTien = :tongTien,      \n" +
                "            trangThai = :trangThai     \n" +
                "      WHERE maDonHang = :maDonHang";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("ngayHoaDon", donHangDTO.getNgayHoaDon());
        parameterSource.addValue("tongTien", donHangDTO.getTongTien());
        parameterSource.addValue("trangThai", donHangDTO.getTrangThai());
        parameterSource.addValue("maDonHang", donHangDTO.getMaDonHang());
        try {
            return namedParameterJdbcTemplate.update(sql, parameterSource);
        }catch (Exception e){
            return -1;
        }
    }

    @Override
    public List<DonHangDTO> findDonHangByIdKhachHang(KhachHangDTO khachHangDTO, String soHoaDon) {
        String sql = "SELECT TOP (100) idDonHang    \n" +
                "      ,maDonHang       \n" +
                "      ,ngayHoaDon      \n" +
                "      ,tongTien        \n" +
                "      ,trangThai       \n" +
                "      ,idKhachHang     \n" +
                "  FROM dbo.DonHang hd  \n" +
                "  WHERE 1 = 1 ";

        String sqlWhere = "";
        if (khachHangDTO.getIdKhachHang() != null || khachHangDTO.getIdKhachHang() > 0){
            sqlWhere = sqlWhere + " and idKhachHang = :idKhachHang";
        }
        if (!soHoaDon.equals("") && !soHoaDon.equals("-1")){
            sqlWhere = sqlWhere + " and maDonHang = :maDonHang";
        }
        sql = sql + sqlWhere;
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("idKhachHang", khachHangDTO.getIdKhachHang());
        parameterSource.addValue("maDonHang", soHoaDon);
        try {
            List donHangList =  namedParameterJdbcTemplate.queryForList(sql, parameterSource);
            ObjectMapper objectMapper = new ObjectMapper();
            return (List<DonHangDTO>) donHangList.stream().map(item -> {
                try {
                    return objectMapper.readValue(objectMapper.writeValueAsString(item), DonHangDTO.class);
                } catch (Exception e) {
                    return new ArrayList<DonHangDTO>();
                }
            }).collect(Collectors.toList());
        }catch (Exception e){
            return new ArrayList<DonHangDTO>();
        }
    }

    @Override
    public DonHangDTO findOneDonHang(int idDonHang) {
        String sql = "SELECT TOP (1) idDonHang      \n" +
                "      ,maDonHang       \n" +
                "      ,ngayHoaDon      \n" +
                "      ,tongTien        \n" +
                "      ,trangThai       \n" +
                "      ,idKhachHang     \n" +
                "  FROM dbo.DonHang     \n" +
                "  WHERE idDonHang =:idDonHang";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("idDonHang", idDonHang);
        try {
            Map mapResult =  namedParameterJdbcTemplate.queryForMap(sql, parameterSource);
            DonHangDTO  donHangDTO = new DonHangDTO();
            if (!mapResult.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                donHangDTO = mapper.readValue(mapper.writeValueAsString(mapResult), DonHangDTO.class);
            }
            return donHangDTO;
        }catch (Exception e){
            return new DonHangDTO();
        }
    }

    @Override
    public int addChiTietDonHang(ChiTietDonHangDTO chiTietDon) {
        String sql = "INSERT INTO dbo.ChiTietDonHang (idDonHang, idSanPham, soLuong, donGia, trangThai)\n" +
                "VALUES (:idDonHang, :idSanPham, :soLuong, :donGia, :trangThai)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("idDonHang", chiTietDon.getIdDonHang());
        parameterSource.addValue("idSanPham", chiTietDon.getIdSanPham());
        parameterSource.addValue("soLuong", chiTietDon.getSoLuong());
        parameterSource.addValue("donGia", chiTietDon.getDonGia());
        parameterSource.addValue("trangThai", chiTietDon.getTrangThai());
        try {
            return namedParameterJdbcTemplate.update(sql, parameterSource);
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public int deleteChiTietDonHang(int idChiTietDonHang) {
        String sql = "DELETE FROM dbo.ChiTietDonHang\n" +
                "WHERE idChiTiet = :idChiTiet";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("idChiTiet", idChiTietDonHang);
        try {
            return namedParameterJdbcTemplate.update(sql, parameterSource);
        } catch (Exception e) {
            return -1;
        }
    }

    @Override
    public List<ChiTietDonHangDTO> chiTietDonHang(int idDonHang) {
        String sql = "SELECT TOP (100) idChiTiet\n" +
                "      ,soLuong\n" +
                "      ,donGia\n" +
                "      ,idDonHang\n" +
                "      ,idSanPham\n" +
                "      ,trangThai\n" +
                "      ,createDate\n" +
                "  FROM dbo.ChiTietDonHang" +
                " WHERE idDonHang = :idDonHang";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("idDonHang", idDonHang);
        try {
            List donHangList =  namedParameterJdbcTemplate.queryForList(sql, parameterSource);
            ObjectMapper objectMapper = new ObjectMapper();
            return (List<ChiTietDonHangDTO>) donHangList.stream().map(item -> {
                try {
                    return objectMapper.readValue(objectMapper.writeValueAsString(item), ChiTietDonHangDTO.class);
                } catch (Exception e) {
                    return new ArrayList<ChiTietDonHangDTO>();
                }
            }).collect(Collectors.toList());
        }catch (Exception e){
            return new ArrayList<ChiTietDonHangDTO>();
        }
    }
}
