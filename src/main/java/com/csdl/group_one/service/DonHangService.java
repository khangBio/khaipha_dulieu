package com.csdl.group_one.service;

import com.csdl.group_one.model.DonHang;

import java.util.Map;

public interface DonHangService {
    DonHang taoDonHang(DonHang donHang);
    void luuDonHangJson(Map<String, Object> donHangData);
}
