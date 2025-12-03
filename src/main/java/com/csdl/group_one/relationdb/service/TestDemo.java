package com.csdl.group_one.relationdb.service;

import java.util.UUID;

public class TestDemo {

    public static void main(String[] args){
        String uui = UUID.randomUUID().toString().replaceAll("-", "");
        System.out.println("UUID: " + System.currentTimeMillis());
    }
}
