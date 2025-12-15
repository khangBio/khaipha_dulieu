package com.csdl.group_one.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class PatientInfoDTO {
    @JsonProperty("haematocrit")
    private double haematocrit = 0;
    @JsonProperty("haemoglobins")
    private double haemoglobins = 0;
    @JsonProperty ("erythrocyte")
    private double erythrocyte = 0;
    @JsonProperty("leucocyte")
    private double leucocyte = 0;
    @JsonProperty("thrombocyte")
    private double thrombocyte = 0;
    @JsonProperty("mch")
    private double mch = 0;
    @JsonProperty("mchc")
    private double mchc = 0;
    @JsonProperty("mcv")
    private double mcv = 0;
    @JsonProperty("age")
    private int age = 0;
    @JsonProperty("sex")
    private String sex;
    @JsonProperty("source")
    private String source;

    public double getHaematocrit() {
        return haematocrit;
    }

    public void setHaematocrit(double haematocrit) {
        this.haematocrit = haematocrit;
    }

    public double getHaemoglobins() {
        return haemoglobins;
    }

    public void setHaemoglobins(double haemoglobins) {
        this.haemoglobins = haemoglobins;
    }

    public double getErythrocyte() {
        return erythrocyte;
    }

    public void setErythrocyte(double erythrocyte) {
        this.erythrocyte = erythrocyte;
    }

    public double getLeucocyte() {
        return leucocyte;
    }

    public void setLeucocyte(double leucocyte) {
        this.leucocyte = leucocyte;
    }

    public double getThrombocyte() {
        return thrombocyte;
    }

    public void setThrombocyte(double thrombocyte) {
        this.thrombocyte = thrombocyte;
    }

    public double getMch() {
        return mch;
    }

    public void setMch(double mch) {
        this.mch = mch;
    }

    public double getMchc() {
        return mchc;
    }

    public void setMchc(double mchc) {
        this.mchc = mchc;
    }

    public double getMcv() {
        return mcv;
    }

    public void setMcv(double mcv) {
        this.mcv = mcv;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
}
