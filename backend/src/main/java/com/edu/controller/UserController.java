package com.edu.controller;

import com.edu.dto.LoginRequest;
import com.edu.entity.account.User;
import com.edu.service.SequenceService;
import com.edu.service.UserService;
import com.edu.utils.JwtUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Objects;

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
    public ResponseEntity<Map<String, Object>> login(@RequestBody LoginRequest request) {
        try {
            if (userService.validateUser(request.userId(), request.password())) {
                String token = JwtUtils.generateToken(request.userId());
                return ResponseEntity.ok()
                        .header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
                        .body(Map.of(
                                "code", 200,
                                "token", token,
                                "user", userService.findUserById(request.userId())
                        ));
            }
            return ResponseEntity.status((HttpStatus.UNAUTHORIZED))
                    .body(Map.of(
                            "code", 401,
                            "message", "Invalid credentials"
                    ));
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body(Map.of(
                            "code", 500,
                            "message", "Authentication failed"
                    ));
        }
    }

    @GetMapping("/validate-token")
    public ResponseEntity<Void> validateToken(@RequestHeader(HttpHeaders.AUTHORIZATION) String authHeader) {
        try {
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                String token = authHeader.substring(7);
                if (JwtUtils.validateToken(token)) {
                    return ResponseEntity.ok().build();
                }
            }
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
}
