package com.csdl.group_one.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import weka.classifiers.trees.J48;

import java.util.HashMap;
import java.util.Map;

@Controller
public class WebController {

    @RequestMapping("/nhom-1")
    public String home(Model model) {
        model.addAttribute("message", "Hello JSP in Spring Boot!");
        model.addAttribute("path", "khaiphadulieu/app-client.jsp");
        return "home"; //WEB-INF/views/home.jsp
    }

    @RequestMapping(value = "/do-model-decission-tree", method = RequestMethod.POST)
    @ResponseBody
    public Map doModelDecissionTree() {
        return new HashMap<>();
    }
}
