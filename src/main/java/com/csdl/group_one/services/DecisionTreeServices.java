package com.csdl.group_one.services;

import com.csdl.group_one.dto.PatientInfoDTO;
import com.csdl.group_one.dto.PredictionResultDTO;
import com.csdl.group_one.dto.ResponseDecicsionTree;

import java.util.Map;

public interface DecisionTreeServices {
    public ResponseDecicsionTree initModelDecisionTree(int percentage) throws Exception;

    public PredictionResultDTO predictNewInstance(PatientInfoDTO patientInfoDTO) throws Exception;
}
