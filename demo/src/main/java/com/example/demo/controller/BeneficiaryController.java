package com.example.demo.controller;

import com.example.demo.entity.Beneficiary;
import com.example.demo.entity.User;
import com.example.demo.repository.BeneficiaryRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/bene")
public class BeneficiaryController {

    @Autowired
    private BeneficiaryRepository beneficiaryRepository;
    
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/list")
    public ResponseEntity<?> getBeneficiaries(Principal principal) {
        User user = userRepository.findByUsername(principal.getName()).orElse(null);
        if (user == null) return ResponseEntity.status(401).build();
        
        List<Beneficiary> list = beneficiaryRepository.findByUser(user);
        return ResponseEntity.ok(list);
    }

    @PostMapping("/create")
    public ResponseEntity<?> createBeneficiary(@RequestBody Beneficiary request, Principal principal) {
        User user = userRepository.findByUsername(principal.getName()).orElse(null);
        if (user == null) return ResponseEntity.status(401).build();
        
        request.setUser(user);
        beneficiaryRepository.save(request);
        
        return ResponseEntity.ok(Map.of("message", "Beneficiary added successfully"));
    }
}
