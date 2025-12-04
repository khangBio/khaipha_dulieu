package com.csdl.group_one.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebController {

    @RequestMapping("/nhom-1")
    public String home(Model model) {
        model.addAttribute("message", "Hello JSP in Spring Boot!");
        model.addAttribute("path", "csdl/hoadonbanhang-html.jsp");
        return "home"; //WEB-INF/views/home.jsp
    }
}
