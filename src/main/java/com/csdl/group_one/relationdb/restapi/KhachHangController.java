package com.csdl.group_one.relationdb.restapi;

import com.csdl.group_one.relationdb.dto.ChiTietDonHangDTO;
import com.csdl.group_one.relationdb.dto.DonHangDTO;
import com.csdl.group_one.relationdb.dto.KhachHangDTO;
import com.csdl.group_one.relationdb.dto.SanPhamDTO;
import com.csdl.group_one.relationdb.service.DanhMucDAO;
import com.csdl.group_one.relationdb.service.KhachHangService;
import com.csdl.group_one.utils.EJson;
import com.csdl.group_one.utils.ResponseBodyJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class KhachHangController {
    @Autowired
    KhachHangService khachHangService;

    @Autowired
    public ResponseBodyJson responseBodyJson;
    @Autowired
    private DanhMucDAO danhMucDAO;

    @ResponseBody
    @PostMapping("/do-khach-hang")
    public String doKhachHang(@RequestBody KhachHangDTO khachHangDTO){
        final EJson responseJson = responseBodyJson.newEJson();
        int result = 0;
        String message = "";
        int idKhachHang = khachHangDTO.getIdKhachHang();
        if (idKhachHang > 0){
            result = khachHangService.updKhachHang(khachHangDTO);
            message = result > 0 ? "Cập nhật thành công!" : "Cập nhật thất bại!";
        }else {
            KhachHangDTO khachHang = khachHangService.findOneKhachHang(khachHangDTO);
            if (khachHang.getIdKhachHang() > 0){
                responseJson.put("errorCode", -1);
                responseJson.put("errorMessage", "Thông tin khách hàng này đã tồn tại với tên: " + khachHang.getHoTen());
                return responseJson.success();
            }
            result = khachHangService.addKhachHang(khachHangDTO);
            message = result > 0 ? "Thêm thành công!" : "Thêm thất bại!";
        }
        responseJson.put("errorCode", result);
        responseJson.put("errorMessage", message);
        return responseJson.success();
    }

    @ResponseBody
    @PostMapping("/find-info-khach-hang")
    public String findThongTinKhachHang(@RequestBody KhachHangDTO khachHangDTO){
        final EJson responseJson = responseBodyJson.newEJson();
        int result = 0;
        String message = "";
        KhachHangDTO khachHang = khachHangService.findOneKhachHang(khachHangDTO);
        responseJson.put("khachHang", khachHang);
        responseJson.put("errorCode", khachHang.getIdKhachHang());
        return responseJson.success();
    }

    @ResponseBody
    @PostMapping("/do-don-hang")
    public String doKhachHang(@RequestBody DonHangDTO donHangDTO){
        final EJson responseJson = responseBodyJson.newEJson();
        long result = 0;
        String message = "";
        String maDonHang = donHangDTO.getMaDonHang();
        if (!maDonHang.equals("")){
            result = khachHangService.updDonHang(donHangDTO);
            message = result > 0 ? "Cập nhật thành công!" : "Cập nhật thất bại!";
        }else {
            result = khachHangService.createDonHang(donHangDTO);
            message = result > 0 ? "Thêm thành công!" : "Thêm thất bại!";
        }
        responseJson.put("maDonHang", result);
        responseJson.put("errorCode", result);
        responseJson.put("errorMessage", message);
        return responseJson.success();
    }

    @ResponseBody
    @GetMapping("/get-list-don-hang")
    public KhachHangDTO getListDonHangByKhachHang(@RequestParam (value = "idKhachHang", required = false, defaultValue = "-1") int idKhachHang,
                                                  @RequestParam (value = "soHoaDon", required = false, defaultValue = "-1") String soHoaDon){

        KhachHangDTO khachHangDTO = new KhachHangDTO();
        if (idKhachHang > 0){
            khachHangDTO.setIdKhachHang(idKhachHang);
            khachHangDTO = khachHangService.findOneKhachHang(khachHangDTO);
            List<DonHangDTO> donHangDTOList = khachHangService.findDonHangByIdKhachHang(khachHangDTO, soHoaDon);
            khachHangDTO.setDanhSachDonHang(donHangDTOList);
            return  khachHangDTO;
        }

        List<DonHangDTO> donHangDTOList = khachHangService.findDonHangByIdKhachHang(khachHangDTO, soHoaDon);
        if (donHangDTOList.size() > 0){
            DonHangDTO donHangDTO = donHangDTOList.get(0);
            khachHangDTO.setIdKhachHang(donHangDTO.getIdKhachHang());
            khachHangDTO = khachHangService.findOneKhachHang(khachHangDTO);
            khachHangDTO.setDanhSachDonHang(donHangDTOList);
        }
        return khachHangDTO;
    }

    @ResponseBody
    @PostMapping("/do-chi-tiet-don-hang")
    public String doChiTietDonHang(@RequestBody ChiTietDonHangDTO chiTietDonHangDTO){
        final EJson responseJson = responseBodyJson.newEJson();
        long result = 0;
        String message = "";

        if (chiTietDonHangDTO.getIdChiTiet() > 0){
            result = khachHangService.deleteChiTietDonHang(chiTietDonHangDTO.getIdChiTiet());
            message = result > 0 ? "Xóa thành công!" : "Xóa thất bại!";
        }else {
            result = khachHangService.addChiTietDonHang(chiTietDonHangDTO);
            message = result > 0 ? "Thêm thành công!" : "Thêm thất bại!";
        }
        responseJson.put("errorCode", result);
        responseJson.put("errorMessage", message);
        return responseJson.success();
    }

    @ResponseBody
    @GetMapping("/get-chi-tiet-don-hang")
    public DonHangDTO getChiTietDonHang(@RequestParam (value = "idDonHang", defaultValue = "-1") int idDonHang){

        DonHangDTO donHangDTO =  new DonHangDTO();
        donHangDTO =  khachHangService.findOneDonHang(idDonHang);
        List<ChiTietDonHangDTO> chiTietDonHangDTOS = new ArrayList<>();
        if (donHangDTO.getMaDonHang()!=null && !donHangDTO.getMaDonHang().equals("")){
            List<ChiTietDonHangDTO> chiTietDonHangDTOList = khachHangService.chiTietDonHang(donHangDTO.getIdDonHang());
            for (ChiTietDonHangDTO chiTietDon : chiTietDonHangDTOList){
                SanPhamDTO sanPhamDTO = danhMucDAO.getFindOneSanPham(chiTietDon.getIdSanPham());
                chiTietDon.setSanPhamDTO(sanPhamDTO);
                chiTietDonHangDTOS.add(chiTietDon);
            }
            donHangDTO.setChiTietDonHangs(chiTietDonHangDTOS);
        }
        return donHangDTO;
    }
}
