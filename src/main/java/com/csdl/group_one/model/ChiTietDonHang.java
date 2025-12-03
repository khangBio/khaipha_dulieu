package com.csdl.group_one.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "ChiTietDonHang")
@Data
public class ChiTietDonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idChiTiet;

    private Integer soLuong;
    private Double donGia;

    @ManyToOne
    @JoinColumn(name = "idDonHang")
    private DonHang donHang;

    @ManyToOne
    @JoinColumn(name = "idSanPham")
    private DanhMucSanPham sanPham;
}
