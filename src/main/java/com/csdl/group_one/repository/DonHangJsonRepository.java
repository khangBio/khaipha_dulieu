package com.csdl.group_one.repository;

import lombok.RequiredArgsConstructor;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
@RequiredArgsConstructor
public class DonHangJsonRepository {
    private final MongoTemplate mongoTemplate;

    public void saveDonHangDocument(Map<String, Object> donHangData) {
        mongoTemplate.save(donHangData, "donhang"); // lưu vào collection "donhang"
    }
}
