package com.csdl.group_one.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "DanhMucSanPham")
@Data
public class DanhMucSanPham {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idSanPham;

    private String maSanPham;
    private String tenSanPham;
    private String maLoaiSanPham;
    private String tenLoaiSanPham;
    private Double donGia;
    private String xuatXu;
    private String ngaySanXuat;
    private String hinhAnhSanPham;
}
