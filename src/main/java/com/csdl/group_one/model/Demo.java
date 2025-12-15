package com.csdl.group_one.model;
import weka.core.Instances;
import weka.core.converters.CSVLoader;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;

public class Demo {
    public static void Convert(String sourcepath,String destpath) throws Exception
    {
        // load CSV
        CSVLoader loader = new CSVLoader();
        loader.setSource(new File(sourcepath));
        Instances dataSet = loader.getDataSet();

        // save ARFF
        BufferedWriter writer = new BufferedWriter(new FileWriter(destpath));
        writer.write(dataSet.toString());
        writer.flush();
        writer.close();
    }

    public static void main(String[] args) throws Exception {
        Convert("insurance.csv", "insurance.arff");
    }

}
