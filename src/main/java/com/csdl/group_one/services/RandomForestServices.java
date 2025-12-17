package com.csdl.group_one.services;

import com.csdl.group_one.dto.PatientInfoDTO;
import com.csdl.group_one.dto.PredictionResultDTO;
import com.csdl.group_one.dto.ResponseRandomForest;

public interface RandomForestServices {
    public ResponseRandomForest initRandomForestModel(int percentage) throws Exception;

    public PredictionResultDTO predictNewInstanceRF(PatientInfoDTO patientInfo) throws Exception;
}
