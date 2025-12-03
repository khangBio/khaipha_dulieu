package com.csdl.group_one.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "KhachHang")
@Data
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idKhachHang;

    private String maKhachHang;
    private String hoTen;
    private String email;
    private String soDienThoai;
    private String diaChi;
    private String hinhAnhKhachHang;
}
