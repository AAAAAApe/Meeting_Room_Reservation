package com.edu.controller;

import com.edu.entity.account.User;
import com.edu.service.SequenceService;
import com.edu.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class UserController {
    private final UserService userService;
    private final SequenceService sequenceService;

    public UserController(UserService userService, SequenceService sequenceService) { this.userService = userService;
        this.sequenceService = sequenceService;
    }

    @GetMapping("/user/{userId}")
    public User getUser(@PathVariable String userId) {
        return userService.findUserById(userId);
    }

    @GetMapping("/users")
    public List<User> getAllUsers() {
        return userService.findAllUsers();
    }

    @PostMapping("/user")
    public String createUser(@RequestBody User user, Integer year) {
        String id = sequenceService.generateUserId(year, user.getRole());
        user.setUserId(id);
        userService.insertUser(user);
        return id;
    }

    @PutMapping("user/{userId}")
    public void updateUser(@RequestBody User user) {
        userService.insertUser(user);
    }


    @PostMapping("/login")
    public String login(String userId, String password) {
        if (userService.validateUser(userId, password)) {
            return "success";
        } else {
            return "fail";
        }
    }
}
