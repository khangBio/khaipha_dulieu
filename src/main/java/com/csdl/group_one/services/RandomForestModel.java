package com.csdl.group_one.services;

import com.csdl.group_one.dto.ResponseDecicsionTree;
import weka.classifiers.Evaluation;
import weka.classifiers.trees.RandomForest;
import weka.core.Instances;
import weka.core.SerializationHelper;
import weka.core.converters.CSVLoader;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Remove;
import weka.filters.unsupervised.instance.RemovePercentage;

import java.io.File;
import java.io.IOException;

public class RandomForestModel {

    public void initRandomForestModel(int percentage) throws Exception {
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
        rf.setNumFeatures(0);     // 0 = mặc định sqrt/log2 tuỳ Weka
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
    }
}
