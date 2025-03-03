package com.edu.controller;

import com.edu.service.UserService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {
    private final UserService userService;
    public UserController(UserService userService) { this.userService = userService; }

    @PostMapping("/login")
    public String login(String userId, String password) {
        if (userService.validateUser(userId, password)) {
            return "success";
        } else {
            return "fail";
        }
    }
}
