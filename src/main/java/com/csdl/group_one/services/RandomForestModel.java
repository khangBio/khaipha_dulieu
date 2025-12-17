package com.csdl.group_one.services;

import com.csdl.group_one.dto.PatientInfoDTO;
import com.csdl.group_one.dto.PredictionResultDTO;
import com.csdl.group_one.dto.ResponseDecicsionTree;
import com.csdl.group_one.dto.ResponseRandomForest;
import org.springframework.stereotype.Service;
import weka.classifiers.Evaluation;
import weka.classifiers.trees.J48;
import weka.classifiers.trees.RandomForest;
import weka.core.DenseInstance;
import weka.core.Instances;
import weka.core.SerializationHelper;
import weka.core.converters.CSVLoader;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Remove;
import weka.filters.unsupervised.instance.RemovePercentage;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;

@Service
public class RandomForestModel implements RandomForestServices {

    @Override
    public ResponseRandomForest initRandomForestModel(int percentage) throws Exception {
        int percentageTest = 100 - percentage;
        // 1. Load dữ liệu
        CSVLoader loader = new CSVLoader();
        loader.setSource(new File("data-ori.csv"));
        Instances data = loader.getDataSet();
        data.setClassIndex(data.numAttributes() - 1);

        /*Chỉ định các cột cần bỏ (đánh số từ 1)*/
        Remove remove = new Remove();
        remove.setAttributeIndices("10");  //Exclude colum SEX
        remove.setInvertSelection(false);
        remove.setInputFormat(data);
        Instances dataColumFilter = Filter.useFilter(data, remove);
        dataColumFilter.setClassIndex(dataColumFilter.numAttributes() - 1);

        // 3. Tạo tập TRAIN (70%)
        RemovePercentage trainFilter = new RemovePercentage();
        trainFilter.setPercentage(percentageTest); // remove 30% → giữ lại 70%
        trainFilter.setInputFormat(dataColumFilter);
        Instances trainData = Filter.useFilter(dataColumFilter, trainFilter);

        // 4. Tạo tập TEST (30%)
        RemovePercentage testFilter = new RemovePercentage();
        testFilter.setPercentage(percentageTest);
        testFilter.setInvertSelection(true); // lấy 30% bị loại
        testFilter.setInputFormat(dataColumFilter);
        Instances testData = Filter.useFilter(dataColumFilter, testFilter);

        //5. --- Train RandomForest ---
        RandomForest rf = new RandomForest();
        rf.setSeed(1);
        rf.setNumIterations(300);      // tương ứng option -I (num trees)
//        rf.setNumFeatures(0);     // 0 = mặc định sqrt/log2 tuỳ Weka
        rf.setMaxDepth(0);        // 0 = unlimited (tương ứng option -depth 0)
        rf.buildClassifier(trainData);
        SerializationHelper.write("random_forest_data_ori.model", rf); /*Save model*/

        // 6. Đánh giá mô hình trên TEST set
        Evaluation eval = new Evaluation(trainData);
        // eval.crossValidateModel(rf, data, 10, new Random(1));
        eval.evaluateModel(rf, testData);

        // 7. Output evaluation results
        System.out.println("=== Random Forest Evaluation ===");
        System.out.println(eval.toSummaryString());
        System.out.println(eval.toClassDetailsString());
        System.out.println(eval.toMatrixString());

        ResponseRandomForest rsf = new ResponseRandomForest();
        rsf.setAccuracy(eval.pctCorrect());
        rsf.setKappa(eval.kappa());
        rsf.setMeanAbsoluteError(eval.meanAbsoluteError());
        rsf.setMeanSquaredError(eval.rootMeanSquaredError());

        // Class metrics
        rsf.classMetrics = new HashMap<>();
        for (int i = 0; i < data.numClasses(); i++) {
            ResponseDecicsionTree.ClassMetric classMetric = new ResponseDecicsionTree.ClassMetric();
            classMetric.setPrecision( eval.precision(i));
            classMetric.setRecall(eval.recall(i));
            classMetric.setF1(eval.fMeasure(i));
            classMetric.setRoc(eval.areaUnderROC(i));

            rsf.classMetrics.put(data.classAttribute().value(i), classMetric);
        }

        // Confusion matrix
        rsf.setConfusionMatrix(eval.confusionMatrix());
        rsf.setClassLabels(new String[]{"OUT", "IN"});
        return rsf;
    }

    @Override
    public PredictionResultDTO predictNewInstanceRF(PatientInfoDTO patientInfo) throws Exception {
        RandomForest rf = (RandomForest) SerializationHelper.read("random_forest_data_ori.model");

        // Load structure (ARFF header dùng khi train)
        Instances modelStructure = new Instances(new BufferedReader(new FileReader("header.arff")));
        modelStructure.setClassIndex(modelStructure.numAttributes() - 1);

        // Create new instance
        DenseInstance instance = new DenseInstance(modelStructure.numAttributes());
        instance.setDataset(modelStructure);
        instance.setValue(0, patientInfo.getHaematocrit());
        instance.setValue(1, patientInfo.getHaemoglobins());
        instance.setValue(2, patientInfo.getErythrocyte());
        instance.setValue(3, patientInfo.getLeucocyte());
        instance.setValue(4, patientInfo.getThrombocyte());
        instance.setValue(5, patientInfo.getMch());
        instance.setValue(6, patientInfo.getMchc());
        instance.setValue(7, patientInfo.getMcv());
        instance.setValue(8, patientInfo.getAge());

        // Predict
        double clsIndex = rf.classifyInstance(instance);
        double[] dist = rf.distributionForInstance(instance);

        PredictionResultDTO result = new PredictionResultDTO();
        result.setPredictedClass(modelStructure.classAttribute().value((int) clsIndex));;
        result.setProbability(dist[(int) clsIndex]);
        System.out.println("========= Prediction Result =========");
        System.out.println(result.toString());
        return result;
    }
}
