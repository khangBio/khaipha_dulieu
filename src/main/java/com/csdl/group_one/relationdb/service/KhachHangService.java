package com.csdl.group_one.relationdb.service;

import com.csdl.group_one.relationdb.dto.ChiTietDonHangDTO;
import com.csdl.group_one.relationdb.dto.DonHangDTO;
import com.csdl.group_one.relationdb.dto.KhachHangDTO;

import java.util.List;

public interface KhachHangService {
    public int addKhachHang(KhachHangDTO khachHangDTO);

    public int updKhachHang(KhachHangDTO khachHangDTO);

    public KhachHangDTO findOneKhachHang(KhachHangDTO khachHangDTO);

    public long createDonHang(DonHangDTO donHangDTO);

    public int updDonHang(DonHangDTO donHangDTO);

    public List<DonHangDTO> findDonHangByIdKhachHang(KhachHangDTO khachHangDTO, String soHoaDon);

    public DonHangDTO findOneDonHang(int idDonHang);

    public int addChiTietDonHang(ChiTietDonHangDTO donHangDTO);

    public int deleteChiTietDonHang(int idChiTietDonHang);

    public List<ChiTietDonHangDTO> chiTietDonHang(int idDonHang);
}
