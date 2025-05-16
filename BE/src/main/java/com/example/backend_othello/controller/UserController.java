package com.example.backend_othello.controller;

import com.example.backend_othello.entity.User;
import com.example.backend_othello.service.UserService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService;

    //API xử lý đăng nhập
    @PostMapping("/login")
    public ResponseEntity<User> login(@RequestBody User request) {
        User user = userService.login(request);
        if (user != null) {
            return ResponseEntity.ok(user);
        }
        return ResponseEntity.status(401).build();
    }

    //API xử lý đăng ký
    @PostMapping("/register")
    public ResponseEntity<User> register(@RequestBody User request) {
        User user = userService.register(request);
        if (user != null) {
            return ResponseEntity.ok(user);
        }
        return ResponseEntity.status(400).build();
    }
}
