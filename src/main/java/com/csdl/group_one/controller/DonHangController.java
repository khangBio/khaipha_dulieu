package com.csdl.group_one.controller;

import com.csdl.group_one.model.DonHang;
import com.csdl.group_one.relationdb.dto.DonHangDTO;
import com.csdl.group_one.relationdb.service.KhachHangService;
import com.csdl.group_one.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/donhang")
@RequiredArgsConstructor
public class DonHangController {

    private final DonHangService donHangService;
    private final KhachHangService khachHangService;

    @PostMapping("/them-don-hang")
    public String taoDonHang(@RequestBody DonHang donHang) {
        donHangService.taoDonHang(donHang);
        return "Thêm đơn hàng thành công!";
    }

//    @PostMapping("/them-don-hang-json")
//    public String taoDonHang(@RequestBody Map<String, Object> donHangData) {
//        donHangService.luuDonHangJson(donHangData);
//        return "Thêm đơn hàng thành công!";
//    }

    @PostMapping("/them-don-hang-json")
    public String taoDonHang(@RequestBody Map<String, Object> donHangData) {

        try {
            //Tạo DTO cho SQL Server Update
            // Lấy dữ liệu từ Map (do hàm thanhtoan() JavaScript gửi lên)
            String maDonHang = donHangData.get("maDonHang").toString();
            String ngayHoaDon = donHangData.get("ngayHoaDon").toString();
            String trangThai = donHangData.get("trangThai").toString();

            Float tongTien = 0.0f;
            Object tongTienObj = donHangData.get("tongTien");
            if (tongTienObj instanceof Number) {
                tongTien = ((Number) tongTienObj).floatValue();
            }

            // Tạo đối tượng DTO cho hàm updDonHang
            DonHangDTO donHangSqlDTO = new DonHangDTO();
            donHangSqlDTO.setMaDonHang(maDonHang);
            donHangSqlDTO.setNgayHoaDon(ngayHoaDon);
            donHangSqlDTO.setTongTien(tongTien);
            donHangSqlDTO.setTrangThai(trangThai);

            // Gọi hàm updDonHang (SQL Server)
            int sqlUpdateResult = khachHangService.updDonHang(donHangSqlDTO);

            if (sqlUpdateResult <= 0) {
                return "Lỗi: Cập nhật SQL Server thất bại.";
            }
            // Lưu đơn hàng vào MongoDB
            donHangService.luuDonHangJson(donHangData);
            return "Thêm đơn hàng thành công!";
        } catch (Exception e) {
            return "Đã xảy ra lỗi: " + e.getMessage();
        }
    }
}
