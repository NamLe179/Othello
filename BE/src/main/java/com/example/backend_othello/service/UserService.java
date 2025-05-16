package com.example.backend_othello.service;

import com.example.backend_othello.entity.User;
import com.example.backend_othello.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    //Xác thực người dùng4
    public User login(User loginRequest) {
        User user = userRepository.findByUserName(loginRequest.getUserName());

        if (user != null && user.getPassWord().equals(loginRequest.getPassWord()) && user.getIsActive() == 1) {
            return user;
        }
        return null;
    }

    //Đăng ký người dùng mới
    public User register(User registerRequest) {
        if (userRepository.findByUserName(registerRequest.getUserName()) != null) {
            return null; // Trả về null nếu đã tồn tại
        }
        User user = new User();
        user.setId(UUID.randomUUID().toString().substring(0, 10)); 
        user.setUserName(registerRequest.getUserName());
        user.setPassWord(registerRequest.getPassWord());
        user.setEmail(registerRequest.getEmail());
        user.setRole("PLAYER"); //Mặc định là người chơi, dùng để chia role cho bên quản lý
        user.setIsActive(1); //Mặc định là hoạt động, dùng để vô hiệu hóa tài khoản bên quản lý
        return userRepository.save(user);
    }
}