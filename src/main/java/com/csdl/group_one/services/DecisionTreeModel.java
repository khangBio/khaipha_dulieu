package com.csdl.group_one.services;

import com.csdl.group_one.dto.ResponseDecicsionTree;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import weka.classifiers.Evaluation;
import weka.classifiers.trees.J48;
import weka.core.Instances;
import weka.core.converters.CSVLoader;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Remove;
import weka.filters.unsupervised.instance.RemovePercentage;
import weka.core.SerializationHelper;
import java.io.File;
import java.util.HashMap;
import java.util.Random;

@Service
public class DecisionTreeModel implements DecisionTreeServices{

    public ResponseDecicsionTree initModelDecisionTree() throws Exception {
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
        trainFilter.setPercentage(30); // remove 30% → giữ lại 70%
        trainFilter.setInputFormat(dataColumFilter);
        Instances trainData = Filter.useFilter(dataColumFilter, trainFilter);

        // 4. Tạo tập TEST (30%)
        RemovePercentage testFilter = new RemovePercentage();
        testFilter.setPercentage(30);
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
        eval.crossValidateModel(tree, data, 10, new Random(1));
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
}
