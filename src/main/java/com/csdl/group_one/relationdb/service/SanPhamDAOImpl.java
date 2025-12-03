package com.csdl.group_one.relationdb.service;

import com.csdl.group_one.relationdb.dto.DonHangDTO;
import com.csdl.group_one.relationdb.service.DanhMucDAO;
import com.csdl.group_one.relationdb.dto.SanPhamDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class SanPhamDAOImpl implements DanhMucDAO {
    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    @Override
    public int addSanPham(SanPhamDTO sanPhamDTO) {
        String sql = " INSERT INTO dbo.DanhMucSanPham(maSanPham, tenSanPham, maLoaiSanPham, tenLoaiSanPham, donGia, xuatXu, ngaySanXuat, hinhAnhSanPham)\n" +
                "  VALUES(:maSanPham, :tenSanPham, :maLoaiSanPham, :tenLoaiSanPham, :donGia, :xuatXu, :ngaySanXuat, :hinhAnhSanPham)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("maSanPham", sanPhamDTO.getMaSanPham());
        parameterSource.addValue("tenSanPham", sanPhamDTO.getTenSanPham());
        parameterSource.addValue("maLoaiSanPham", sanPhamDTO.getMaLoaiSanPham());
        parameterSource.addValue("tenLoaiSanPham", sanPhamDTO.getTenLoaiSanPham());
        parameterSource.addValue("donGia", sanPhamDTO.getDonGia());
        parameterSource.addValue("xuatXu", sanPhamDTO.getXuatXu());
        parameterSource.addValue("ngaySanXuat", sanPhamDTO.getNgaySanXuat());
        parameterSource.addValue("hinhAnhSanPham", sanPhamDTO.getHinhAnhSanPham());
        try {
            return jdbcTemplate.update(sql, parameterSource);
        }catch (Exception e){
            return -1;
        }

    }

    @Override
    public int updSanPham(SanPhamDTO sanPhamDTO) {
        String sql = " UPDATE dbo.DanhMucSanPham        \n" +
                "       SET tenSanPham = :tenSanPham,   \n" +
                "           donGia = :donGia, \n" +
                "           xuatXu = :xuatXu, \n" +
                "           ngaySanXuat = :ngaySanXuat, \n" +
                "           hinhAnhSanPham  = :hinhAnhSanPham\n" +
                "     WHERE idSanPham = :idSanPham";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("tenSanPham", sanPhamDTO.getTenSanPham());
        parameterSource.addValue("donGia", sanPhamDTO.getDonGia());
        parameterSource.addValue("xuatXu", sanPhamDTO.getXuatXu());
        parameterSource.addValue("ngaySanXuat", sanPhamDTO.getNgaySanXuat());
        parameterSource.addValue("hinhAnhSanPham", sanPhamDTO.getHinhAnhSanPham());
        try {
            return jdbcTemplate.update(sql, parameterSource);
        }catch (Exception e){
            return -1;
        }
    }

    @Override
    public SanPhamDTO getFindOneSanPham(int idSanPham) {
        String sql = "SELECT TOP (1) idSanPham\n" +
                "      ,maSanPham\n" +
                "      ,tenSanPham\n" +
                "      ,maLoaiSanPham\n" +
                "      ,tenLoaiSanPham\n" +
                "      ,donGia\n" +
                "      ,xuatXu\n" +
                "      ,ngaySanXuat\n" +
                "      ,hinhAnhSanPham\n" +
                "  FROM dbo.DanhMucSanPham\n" +
                "  WHERE idSanPham = :idSanPham";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("idSanPham", idSanPham);
        try {
            Map mapResult =  jdbcTemplate.queryForMap(sql, parameterSource);
            SanPhamDTO sanPhamDTO = new SanPhamDTO();
            if (!mapResult.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                sanPhamDTO = mapper.readValue(mapper.writeValueAsString(mapResult), SanPhamDTO.class);
            }
            return sanPhamDTO;
        }catch (Exception e){
            return new SanPhamDTO();
        }
    }

    @Override
    public List<SanPhamDTO> querySanPham(int rownum) {
        String sql ="SELECT TOP (:rownum) idSanPham\n" +
                "      ,maSanPham\n" +
                "      ,tenSanPham\n" +
                "      ,maLoaiSanPham\n" +
                "      ,tenLoaiSanPham\n" +
                "      ,donGia\n" +
                "      ,xuatXu\n" +
                "      ,ngaySanXuat\n" +
                "      ,hinhAnhSanPham\n" +
                "  FROM dbo.DanhMucSanPham";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("rownum", rownum);

        try {
            List list = jdbcTemplate.queryForList(sql, parameterSource);
            ObjectMapper objectMapper = new ObjectMapper();
            return (List<SanPhamDTO>) list.stream().map(item -> {
                try {
                    return objectMapper.readValue(objectMapper.writeValueAsString(item), SanPhamDTO.class);
                } catch (Exception e) {
                    return null;
                }
            }).collect(Collectors.toList());
        } catch (Exception e) {
            return null;
        }
    }
}

