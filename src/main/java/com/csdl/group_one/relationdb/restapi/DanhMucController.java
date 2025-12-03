package com.csdl.group_one.relationdb.restapi;

import com.csdl.group_one.relationdb.service.DanhMucDAO;
import com.csdl.group_one.relationdb.dto.SanPhamDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DanhMucController {
    @Autowired
    DanhMucDAO danhMucDAO;

    @RequestMapping("/danh-muc")
    public String home(Model model) {
        model.addAttribute("message", "Hello JSP in Spring Boot!");
        model.addAttribute("path", "danhmuc/danhmucsanpham.jsp");
        return "home"; //WEB-INF/views/home.jsp
    }

    @ResponseBody
    @PostMapping("/do-san-pham")
    public Map doSanPham(@RequestBody SanPhamDTO sanPhamDTO){
        Map mapResult = new HashMap();
        int result = 0;
        String message = "";
        int idSanPham = sanPhamDTO.getIdSanPham();
        if (idSanPham > 0){
            result = danhMucDAO.updSanPham(sanPhamDTO);
            message = result > 0 ? "Cập nhật thành công!" : "Cập nhật thất bại!";
        }else {
            result = danhMucDAO.addSanPham(sanPhamDTO);
            message = result > 0 ? "Thêm thành công!" : "Thêm nhật thất bại!";
        }
        mapResult.put("errorCode", result);
        mapResult.put("message", message);
        return mapResult;
    }

    @ResponseBody
    @GetMapping("/get-danh-muc-san-pham")
    public List<SanPhamDTO> doSanPham(@RequestParam (value = "rownum", required = false, defaultValue = "100") int rownum){
        return danhMucDAO.querySanPham(rownum);
    }
}
