package com.csdl.group_one.services;

import com.csdl.group_one.dto.PatientInfoDTO;
import com.csdl.group_one.dto.PredictionResultDTO;
import com.csdl.group_one.dto.ResponseSVM;

public interface SVMServices {
    public ResponseSVM initSVMModel(int percentage) throws Exception;
    public PredictionResultDTO predictNewInstanceSVM(PatientInfoDTO patientInfo) throws Exception;
}
