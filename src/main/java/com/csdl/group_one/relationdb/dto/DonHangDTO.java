package com.csdl.group_one.relationdb.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class DonHangDTO {
    @JsonProperty("idDonHang")
    int idDonHang;
    @JsonProperty("maDonHang")
    String maDonHang;
    @JsonProperty("ngayHoaDon")
    String ngayHoaDon;
    @JsonProperty("tongTien")
    float tongTien;
    @JsonProperty("trangThai")
    String trangThai = "0";
    @JsonProperty("idKhachHang")
    int idKhachHang;
    @JsonProperty("chiTietDonHangs")
    List<ChiTietDonHangDTO> chiTietDonHangs;

    public int getIdDonHang() {
        return idDonHang;
    }

    public void setIdDonHang(int idDonHang) {
        this.idDonHang = idDonHang;
    }

    public String getMaDonHang() {
        return maDonHang;
    }

    public void setMaDonHang(String maDonHang) {
        this.maDonHang = maDonHang;
    }

    public String getNgayHoaDon() {
        return ngayHoaDon;
    }

    public void setNgayHoaDon(String ngayHoaDon) {
        this.ngayHoaDon = ngayHoaDon;
    }

    public float getTongTien() {
        return tongTien;
    }

    public void setTongTien(float tongTien) {
        this.tongTien = tongTien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public int getIdKhachHang() {
        return idKhachHang;
    }

    public void setIdKhachHang(int idKhachHang) {
        this.idKhachHang = idKhachHang;
    }

    public List<ChiTietDonHangDTO> getChiTietDonHangs() {
        return chiTietDonHangs;
    }

    public void setChiTietDonHangs(List<ChiTietDonHangDTO> chiTietDonHangs) {
        this.chiTietDonHangs = chiTietDonHangs;
    }
}
