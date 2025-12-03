package com.csdl.group_one.relationdb.service;

import com.csdl.group_one.relationdb.dto.SanPhamDTO;

import java.util.List;

public interface DanhMucDAO {
    public int addSanPham(SanPhamDTO sanPhamDTO);

    public int updSanPham(SanPhamDTO sanPhamDTO);

    public SanPhamDTO getFindOneSanPham(int idSanPham);

    public List<SanPhamDTO> querySanPham(int rownum);

}
