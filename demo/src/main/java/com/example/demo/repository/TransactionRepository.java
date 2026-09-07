package com.example.demo.repository;

import com.example.demo.entity.Transaction;
import com.example.demo.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {
    List<Transaction> findByUserOrderByTimestampDesc(User user);
}
