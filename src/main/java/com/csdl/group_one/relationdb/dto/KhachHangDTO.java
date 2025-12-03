package com.csdl.group_one.relationdb.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class KhachHangDTO {
    @JsonProperty("idKhachHang")
    private int idKhachHang;
    @JsonProperty("maKhachHang")
    private String maKhachHang;
    @JsonProperty("hoTen")
    private String hoTen;
    @JsonProperty("cccd")
    private String cccd;
    @JsonProperty("ngaySinh")
    private String ngaySinh;
    @JsonProperty("email")
    private String email;
    @JsonProperty("soDienThoai")
    private String soDienThoai;
    @JsonProperty("diaChi")
    private String diaChi;
    @JsonProperty("hinhAnhKhachHang")
    private String hinhAnhKhachHang;
    @JsonProperty("donHangs")
    List<DonHangDTO> donHangs;

    @JsonProperty("danhSachDonHang")
    private List<DonHangDTO> danhSachDonHang;

    public Integer getIdKhachHang() {
        return idKhachHang;
    }

    public void setIdKhachHang(Integer idKhachHang) {
        this.idKhachHang = idKhachHang;
    }

    public String getMaKhachHang() {
        return maKhachHang;
    }

    public void setMaKhachHang(String maKhachHang) {
        this.maKhachHang = maKhachHang;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(String ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSoDienThoai() {
        return soDienThoai;
    }

    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getHinhAnhKhachHang() {
        return hinhAnhKhachHang;
    }

    public void setHinhAnhKhachHang(String hinhAnhKhachHang) {
        this.hinhAnhKhachHang = hinhAnhKhachHang;
    }

    public void setIdKhachHang(int idKhachHang) {
        this.idKhachHang = idKhachHang;
    }

    public List<DonHangDTO> getDanhSachDonHang() {
        return danhSachDonHang;
    }

    public void setDanhSachDonHang(List<DonHangDTO> danhSachDonHang) {
        this.danhSachDonHang = danhSachDonHang;
    }

    public List<DonHangDTO> getDonHang() {
        return donHangs;
    }

    public void setDonHang(List<DonHangDTO> donHangs) {
        this.donHangs = donHangs;
    }
}
