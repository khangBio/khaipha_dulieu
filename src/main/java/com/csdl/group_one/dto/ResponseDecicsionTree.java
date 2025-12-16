package com.csdl.group_one.dto;

import java.util.Map;

public class ResponseDecicsionTree {
    private double accuracy;
    private double kappa;
    private double MeanAbsoluteError;
    private double MeanSquaredError;
    public Map<String, ClassMetric> classMetrics;
    private double[][] confusionMatrix;
    private String[] classLabels;

    public static class ClassMetric {
        private double precision;
        private double recall;
        private double f1;
        private double roc;

        public double getPrecision() {
            return precision;
        }

        public void setPrecision(double precision) {
            this.precision = precision;
        }

        public double getRecall() {
            return recall;
        }

        public void setRecall(double recall) {
            this.recall = recall;
        }

        public double getF1() {
            return f1;
        }

        public void setF1(double f1) {
            this.f1 = f1;
        }

        public double getRoc() {
            return roc;
        }

        public void setRoc(double roc) {
            this.roc = roc;
        }
    }

    public double getAccuracy() {
        return accuracy;
    }

    public void setAccuracy(double accuracy) {
        this.accuracy = accuracy;
    }

    public double getKappa() {
        return kappa;
    }

    public void setKappa(double kappa) {
        this.kappa = kappa;
    }

    public double getMeanAbsoluteError() {
        return MeanAbsoluteError;
    }

    public void setMeanAbsoluteError(double meanAbsoluteError) {
        MeanAbsoluteError = meanAbsoluteError;
    }

    public double getMeanSquaredError() {
        return MeanSquaredError;
    }

    public void setMeanSquaredError(double meanSquaredError) {
        MeanSquaredError = meanSquaredError;
    }

    public Map<String, ClassMetric> getClassMetrics() {
        return classMetrics;
    }

    public void setClassMetrics(Map<String, ClassMetric> classMetrics) {
        this.classMetrics = classMetrics;
    }

    public double[][] getConfusionMatrix() {
        return confusionMatrix;
    }

    public void setConfusionMatrix(double[][] confusionMatrix) {
        this.confusionMatrix = confusionMatrix;
    }

    public String[] getClassLabels() {
        return classLabels;
    }

    public void setClassLabels(String[] classLabels) {
        this.classLabels = classLabels;
    }
}
