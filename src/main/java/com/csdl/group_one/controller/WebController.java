package com.csdl.group_one.controller;

import com.csdl.group_one.dto.PatientInfoDTO;
import com.csdl.group_one.dto.PredictionResultDTO;
import com.csdl.group_one.dto.ResponseDecicsionTree;
import com.csdl.group_one.services.DecisionTreeModel;
import com.csdl.group_one.services.DecisionTreeServices;
import com.csdl.group_one.utils.EJson;
import com.csdl.group_one.utils.ResponseBodyJson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

@Controller
public class WebController {
    @Autowired
    DecisionTreeServices decisionTreeServices;
    @Autowired
    public ResponseBodyJson responseBodyJson;

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

    @ResponseBody
    @PostMapping("/predict-result")
    public String predictResult(@RequestBody PatientInfoDTO patientInfoDTO) throws Exception {
        final EJson responseJson = responseBodyJson.newEJson();
        PredictionResultDTO predictionResultDTO = decisionTreeServices.predictNewInstance(patientInfoDTO);
        responseJson.put("predictedclass", predictionResultDTO);
        responseJson.put("errorCode", 200);
        responseJson.put("errorMessage", "Success!");
        return responseJson.success();
    }
}
