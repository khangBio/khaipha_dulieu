package com.csdl.group_one.repository;

import com.csdl.group_one.model.DonHangMongo;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DonHangMongoRepository extends MongoRepository<DonHangMongo, String> {
}
