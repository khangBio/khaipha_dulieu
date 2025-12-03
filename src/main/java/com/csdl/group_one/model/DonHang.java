package com.csdl.group_one.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "DonHang")
@Data
public class DonHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idDonHang;

    private String maDonHang;
    private String ngayDat;
    private Double tongTien;
    private String trangThai;

    @ManyToOne
    @JoinColumn(name = "idKhachHang")
    private KhachHang khachHang;
}
