package com.csdl.group_one.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import lombok.Data;

import java.util.List;

@Data
@Document(collection = "donhang_mongo")
public class DonHangMongo {
    @Id
    private String id;
    private String maDonHang;
    private String ngayDat;
    private Double tongTien;
    private String trangThai;
    private String khachHang;
    private List<ChiTiet> chiTietDonHang;

    @Data
    public static class ChiTiet {
        private String tenSanPham;
        private Integer soLuong;
        private Double donGia;
    }
}
