package com.csdl.group_one.service;

import com.csdl.group_one.model.*;
import com.csdl.group_one.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DonHangServiceImpl implements DonHangService {

    private final DonHangRepository donHangRepository;
    private final ChiTietDonHangRepository chiTietRepository;
    private final DonHangMongoRepository donHangMongoRepository;
    private final DonHangJsonRepository donHangJsonRepository;

    @Override
    public DonHang taoDonHang(DonHang donHang) {
        return donHangRepository.save(donHang);
    }

    @Override
    public void luuDonHangJson(Map<String, Object> donHangData) {
        donHangJsonRepository.saveDonHangDocument(donHangData);
    }
}
