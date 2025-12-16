package com.csdl.group_one.services;

import com.csdl.group_one.dto.PatientInfoDTO;
import com.csdl.group_one.dto.PredictionResultDTO;
import com.csdl.group_one.dto.ResponseDecicsionTree;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import weka.classifiers.Evaluation;
import weka.classifiers.trees.J48;
import weka.core.DenseInstance;
import weka.core.Instances;
import weka.core.converters.CSVLoader;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Remove;
import weka.filters.unsupervised.instance.RemovePercentage;
import weka.core.SerializationHelper;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class DecisionTreeModel implements DecisionTreeServices{

    @Override
    public ResponseDecicsionTree initModelDecisionTree(int percentage) throws Exception {
        int percentageTest = 100 - percentage;
        // 1. Load dữ liệu
        CSVLoader loader = new CSVLoader();
        loader.setSource(new File("data-ori.csv"));
        Instances data = loader.getDataSet();
        data.setClassIndex(data.numAttributes() - 1);

        Remove remove = new Remove();
        /*Chỉ định các cột cần bỏ (đánh số từ 1)*/
        remove.setAttributeIndices("10");  //Exclude colum SEX
        remove.setInvertSelection(false);
        remove.setInputFormat(data);
        Instances dataColumFilter = Filter.useFilter(data, remove);
        dataColumFilter.setClassIndex(dataColumFilter.numAttributes() - 1);

        // 2. Xáo trộn dữ liệu (rất quan trọng)
        dataColumFilter.randomize(new Random(1));

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

        // 5. Huấn luyện Decision Tree
        J48 tree = new J48();
        tree.setConfidenceFactor(0.25f); // pruning
        tree.setMinNumObj(2);            // min samples per leaf
        tree.setUnpruned(false);         // bật cắt tỉa

        tree.buildClassifier(trainData);
        SerializationHelper.write("decision_tree_data_ori.model", tree); /*Save model*/

        // 6. Đánh giá mô hình trên TEST set
        Evaluation eval = new Evaluation(trainData);
//        eval.crossValidateModel(tree, testData, 10, new Random(1));
        eval.evaluateModel(tree, testData);

        // 7. In kết quả
        System.out.println("=== Decision Tree (Train/Test Split) ===");
        System.out.println(tree);

        System.out.println("=== Evaluation on Test Set ===");
        System.out.println(eval.toSummaryString());
        System.out.println(eval.toClassDetailsString());
        System.out.println(eval.toMatrixString());
        ResponseDecicsionTree response = new ResponseDecicsionTree();
        response.setAccuracy(eval.pctCorrect());
        response.setKappa(eval.kappa());
        response.setMeanAbsoluteError(eval.meanAbsoluteError());
        response.setMeanSquaredError(eval.rootMeanSquaredError());

        // Class metrics
        response.classMetrics = new HashMap<>();
        for (int i = 0; i < data.numClasses(); i++) {
            ResponseDecicsionTree.ClassMetric classMetric = new ResponseDecicsionTree.ClassMetric();
            classMetric.setPrecision( eval.precision(i));
            classMetric.setRecall(eval.recall(i));
            classMetric.setF1(eval.fMeasure(i));
            classMetric.setRoc(eval.areaUnderROC(i));

            response.classMetrics.put(data.classAttribute().value(i), classMetric);
        }

        // Confusion matrix
        response.setConfusionMatrix(eval.confusionMatrix());
        response.setClassLabels(new String[]{"OUT", "IN"});

        return response;
    }

    @Override
    public PredictionResultDTO predictNewInstance(PatientInfoDTO patientInfo) throws Exception {
        J48 modeTree = (J48) SerializationHelper.read("decision_tree_data_ori.model");

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
        double clsIndex = modeTree.classifyInstance(instance);
        double[] dist = modeTree.distributionForInstance(instance);

        PredictionResultDTO result = new PredictionResultDTO();
        result.setPredictedClass(modelStructure.classAttribute().value((int) clsIndex));;
        result.setProbability(dist[(int) clsIndex]);
        return result;
    }
}
