package com.csdl.group_one.relationdb.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class ChiTietDonHangDTO {
    @JsonProperty("idChiTiet")
    int idChiTiet;
    @JsonProperty("soLuong")
    int soLuong;
    @JsonProperty("donGia")
    double donGia;
    @JsonProperty("idDonHang")
    int idDonHang;
    @JsonProperty("idSanPham")
    int idSanPham;
    @JsonProperty("trangThai")
    int trangThai = 0;
    @JsonProperty("createDate")
    String createDate;

    @JsonProperty("sanPhamDTO")
    SanPhamDTO sanPhamDTO =new SanPhamDTO();

    public int getIdChiTiet() {
        return idChiTiet;
    }

    public void setIdChiTiet(int idChiTiet) {
        this.idChiTiet = idChiTiet;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public double getDonGia() {
        return donGia;
    }

    public void setDonGia(double donGia) {
        this.donGia = donGia;
    }

    public int getIdDonHang() {
        return idDonHang;
    }

    public void setIdDonHang(int idDonHang) {
        this.idDonHang = idDonHang;
    }

    public int getIdSanPham() {
        return idSanPham;
    }

    public void setIdSanPham(int idSanPham) {
        this.idSanPham = idSanPham;
    }

    public int getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(int trangThai) {
        this.trangThai = trangThai;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public SanPhamDTO getSanPhamDTO() {
        return sanPhamDTO;
    }

    public void setSanPhamDTO(SanPhamDTO sanPhamDTO) {
        this.sanPhamDTO = sanPhamDTO;
    }
}
