package com.csdl.group_one.controller;

import com.csdl.group_one.dto.ResponseDecicsionTree;
import com.csdl.group_one.services.DecisionTreeModel;
import com.csdl.group_one.services.DecisionTreeServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class WebController {
    @Autowired
    DecisionTreeServices decisionTreeServices;

    @RequestMapping("/nhom-1")
    public String home(Model model) {
        model.addAttribute("message", "Hello JSP in Spring Boot!");
        model.addAttribute("path", "khaiphadulieu/app-client.jsp");
        return "home"; //WEB-INF/views/home.jsp
    }

    @ResponseBody
    @GetMapping(value = "/do-model-decission-tree")
    public ResponseDecicsionTree doModelDecissionTree(@RequestParam(value = "percentage", defaultValue = "70") String percentage) throws Exception {
        ResponseDecicsionTree response = new ResponseDecicsionTree();
        int percentageNum = Integer.parseInt(percentage);
        response = decisionTreeServices.initModelDecisionTree(percentageNum);
        return response;
    }
}
