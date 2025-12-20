package com.csdl.group_one.services;

import com.csdl.group_one.dto.PatientInfoDTO;
import com.csdl.group_one.dto.PredictionResultDTO;
import com.csdl.group_one.dto.ResponseSVM;
import org.springframework.stereotype.Service;
import weka.classifiers.Evaluation;
import weka.classifiers.functions.SMO;
import weka.classifiers.meta.FilteredClassifier;
import weka.core.DenseInstance;
import weka.core.Instances;
import weka.core.SerializationHelper;
import weka.core.converters.CSVLoader;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Normalize;
import weka.filters.unsupervised.attribute.Remove;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.Random;

@Service
public class SVMModel implements SVMServices{
    private static final String MODEL_FILE = "svm_data_ori.model";

    @Override
    public ResponseSVM initSVMModel(int percentage) throws Exception {
        int percentageTest = 100 - percentage;

        // 1. Load dữ liệu
        CSVLoader loader = new CSVLoader();
        loader.setSource(new File("data-ori.csv"));
        Instances data = loader.getDataSet();
        data.setClassIndex(data.numAttributes() - 1);

        // 2. Tiền xử lý: Loại bỏ cột SEX (index 10 - cột thứ 10 tính từ 1, index là 9 nếu tính từ 0, check lại file CSV)
        // Trong code cũ bạn remove index "10". Hãy đảm bảo cột SEX nằm ở vị trí đó.
        Remove remove = new Remove();
        remove.setAttributeIndices("10");
        remove.setInputFormat(data);
        Instances dataNoSex = Filter.useFilter(data, remove);

        // 3. Cấu hình FilteredClassifier (Normalize + SVM)
        // Đây là bước quan trọng nhất cho SVM: Tự động chuẩn hóa [0,1]
        FilteredClassifier fc = new FilteredClassifier();

        // Tạo bộ lọc Normalize
        Normalize normalize = new Normalize();
        fc.setFilter(normalize);

        // Tạo thuật toán SVM (SMO)
        SMO svm = new SMO();
        // Thay vì dùng svm.setBuildLogisticModels(true); ta dùng setOptions
        String[] options = {"-M"};
        svm.setOptions(options);
        // Có thể cấu hình thêm kernel nếu muốn (mặc định là PolyKernel)
        // svm.setKernel(new weka.classifiers.functions.supportVector.RBFKernel());
        fc.setClassifier(svm);

        // 4. Chia tập Train/Test
        int trainSize = (int) Math.round(dataNoSex.numInstances() * percentage / 100);
        int testSize = dataNoSex.numInstances() - trainSize;

        dataNoSex.randomize(new Random(1)); // Shuffle dữ liệu
        Instances train = new Instances(dataNoSex, 0, trainSize);
        Instances test = new Instances(dataNoSex, trainSize, testSize);

        // 5. Train Model
        long startTime = System.currentTimeMillis();
        fc.buildClassifier(train);
        long endTime = System.currentTimeMillis();
        double totalTime = (endTime - startTime) / 1000.0;

        // 6. Đánh giá Model
        Evaluation eval = new Evaluation(train);
        eval.evaluateModel(fc, test);

        // 7. Lưu Model và Header
        SerializationHelper.write(MODEL_FILE, fc);

        // Lưu header để dùng khi dự đoán (chứa cấu trúc dữ liệu)
        // Lưu ý: Lưu structure của data đã bỏ cột SEX
        File headerFile = new File("header_svm.arff");
        if(!headerFile.exists()) {
            // Chỉ lưu cấu trúc rỗng
            try (java.io.PrintWriter out = new java.io.PrintWriter("header_svm.arff")) {
                out.println(new Instances(dataNoSex, 0));
            }
        }

        // 8. Trả về kết quả (Mapping sang DTO)
        ResponseSVM response = new ResponseSVM();

        // --- CÁC CHỈ SỐ TỔNG QUAN ---
        response.setAccuracy(eval.pctCorrect()); // Độ chính xác (%)
        response.setKappa(eval.kappa());         // Hệ số Kappa
        response.setMeanAbsoluteError(eval.meanAbsoluteError()); // MAE
        response.setBuildTime(totalTime);

        // Tính MSE từ RMSE
        double rmse = eval.rootMeanSquaredError();
        response.setMeanSquaredError(rmse * rmse); // MSE = RMSE^2

        response.setConfusionMatrix(eval.confusionMatrix()); // Ma trận nhầm lẫn

        // --- CHI TIẾT TỪNG LỚP (PRECISION, RECALL, F1...) ---
        // Khởi tạo Map để chứa kết quả chi tiết
        java.util.Map<String, ResponseSVM.ClassMetric> classMetrics = new java.util.HashMap<>();

        // Lấy số lượng lớp ( "in", "out")
        int numClasses = train.numClasses();

        for (int i = 0; i < numClasses; i++) {
            // Lấy tên nhãn lớp (ví dụ: "in" hoặc "out")
            String classLabel = train.classAttribute().value(i);

            // Tạo đối tượng ClassMetric (dùng static class bên trong ResponseSVM)
            ResponseSVM.ClassMetric metric = new ResponseSVM.ClassMetric();

            // Lấy các chỉ số từ Evaluation theo index i
            metric.setPrecision(eval.precision(i));
            metric.setRecall(eval.recall(i));
            metric.setF1(eval.fMeasure(i));
            metric.setRoc(eval.areaUnderROC(i));

            // Put vào map
            classMetrics.put(classLabel, metric);
        }

        response.setClassMetrics(classMetrics);

        return response;
    }

    @Override
    public PredictionResultDTO predictNewInstanceSVM(PatientInfoDTO patientInfo) throws Exception {
        // 1. Load Model đã train (Bao gồm cả bộ lọc Normalize bên trong)
        FilteredClassifier fc = (FilteredClassifier) SerializationHelper.read(MODEL_FILE);

        // 2. Load cấu trúc dữ liệu (Header)
        Instances modelStructure = new Instances(new BufferedReader(new FileReader("header_svm.arff")));
        modelStructure.setClassIndex(modelStructure.numAttributes() - 1);

        // 3. Tạo Instance mới
        DenseInstance instance = new DenseInstance(modelStructure.numAttributes());
        instance.setDataset(modelStructure);

        // Gán giá trị (Lưu ý: Thứ tự phải khớp với file header_svm.arff đã bỏ cột SEX)
        // Giả sử sau khi bỏ cột SEX, thứ tự vẫn giữ nguyên các cột còn lại:
        instance.setValue(0, patientInfo.getHaematocrit());
        instance.setValue(1, patientInfo.getHaemoglobins());
        instance.setValue(2, patientInfo.getErythrocyte());
        instance.setValue(3, patientInfo.getLeucocyte());
        instance.setValue(4, patientInfo.getThrombocyte());
        instance.setValue(5, patientInfo.getMch());
        instance.setValue(6, patientInfo.getMchc());
        instance.setValue(7, patientInfo.getMcv());
        instance.setValue(8, patientInfo.getAge());
        // Không set SEX

        // 4. Dự đoán
        // FilteredClassifier sẽ tự động Normalize instance này trước khi đưa vào SVM
        double clsIndex = fc.classifyInstance(instance);
        double[] dist = fc.distributionForInstance(instance);

        PredictionResultDTO result = new PredictionResultDTO();
        result.setPredictedClass(modelStructure.classAttribute().value((int) clsIndex));
        result.setProbability(dist[(int) clsIndex]);

        return result;
    }
}
