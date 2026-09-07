package com.example.demo.controller;

import com.example.demo.entity.Beneficiary;
import com.example.demo.entity.Transaction;
import com.example.demo.entity.User;
import com.example.demo.repository.BeneficiaryRepository;
import com.example.demo.repository.TransactionRepository;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.security.Principal;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

@RestController
@RequestMapping("/api/transfer")
public class TransactionController {

    @Autowired
    private TransactionRepository transactionRepository;
    
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BeneficiaryRepository beneficiaryRepository;

    @PostMapping("/initiate")
    public ResponseEntity<?> initiateTransfer(@RequestBody Map<String, String> request, Principal principal) {
        User user = userRepository.findByUsername(principal.getName()).orElse(null);
        if (user == null) return ResponseEntity.status(401).build();

        Long beneId = Long.parseLong(request.get("beneficiaryId"));
        BigDecimal amount = new BigDecimal(request.get("amount"));

        Beneficiary beneficiary = beneficiaryRepository.findById(beneId).orElse(null);
        if (beneficiary == null || !beneficiary.getUser().getId().equals(user.getId())) {
            return ResponseEntity.badRequest().body(Map.of("message", "Invalid beneficiary"));
        }

        Transaction transaction = Transaction.builder()
                .user(user)
                .beneficiary(beneficiary)
                .amount(amount)
                .timestamp(LocalDateTime.now())
                .build();

        if (user.getBalance() == null) {
            user.setBalance(new java.math.BigDecimal("10000.00"));
            userRepository.save(user); // Persist the default balance if missing
        }

        if (user.getBalance().compareTo(amount) >= 0) {
            user.setBalance(user.getBalance().subtract(amount));
            userRepository.save(user);
            transaction.setStatus("SUCCESS");
        } else {
            transaction.setStatus("FAILED (Insufficient Balance)");
        }

        transactionRepository.save(transaction);
        return ResponseEntity.ok(Map.of("message", "Transfer processed", "status", transaction.getStatus()));
    }

    @GetMapping("/status")
    public ResponseEntity<?> getTransferStatus(Principal principal) {
        User user = userRepository.findByUsername(principal.getName()).orElse(null);
        if (user == null) return ResponseEntity.status(401).build();
        
        return ResponseEntity.ok(transactionRepository.findByUserOrderByTimestampDesc(user));
    }
}
