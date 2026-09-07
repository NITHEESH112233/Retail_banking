package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/register")
    public ResponseEntity<?> registerUser(@RequestBody User user) {
        if (userRepository.findByUsername(user.getUsername()).isPresent()) {
            return ResponseEntity.badRequest().body(Map.of("message", "Username already exists"));
        }
        user.setRole("USER");
        if (user.getBalance() == null) {
            user.setBalance(new java.math.BigDecimal("100000.00"));
        }
        userRepository.save(user);
        return ResponseEntity.ok(Map.of("message", "User registered successfully"));
    }

    @GetMapping("/current_user")
    public ResponseEntity<?> getCurrentUser(java.security.Principal principal) {
        if (principal == null) {
            return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));
        }
        User user = userRepository.findByUsername(principal.getName()).orElse(null);
        if (user == null) {
            return ResponseEntity.status(401).body(Map.of("message", "Unauthorized"));
        }
        if (user.getBalance() == null) {
            user.setBalance(new java.math.BigDecimal("10000.00"));
        }

        java.util.Map<String, Object> response = new java.util.HashMap<>();
        response.put("username", user.getUsername());
        response.put("balance", user.getBalance());
        response.put("name", user.getName() != null ? user.getName() : user.getUsername());

        return ResponseEntity.ok(response);
    }
}
