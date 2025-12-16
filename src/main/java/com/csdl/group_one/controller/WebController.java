package com.csdl.group_one.controller;

import com.csdl.group_one.dto.ResponseDecicsionTree;
import com.csdl.group_one.services.DecisionTreeModel;
import com.csdl.group_one.services.DecisionTreeServices;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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

    @RequestMapping(value = "/do-model-decission-tree", method = RequestMethod.GET)
    @ResponseBody
    public ResponseDecicsionTree doModelDecissionTree() throws Exception {
        ResponseDecicsionTree response = new ResponseDecicsionTree();
        response = decisionTreeServices.initModelDecisionTree();
        return response;
    }
}
