package com.edu.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String hello(String name) {
        return "hello "+name;
    }

    @PostMapping("/post1")
    public String postTest1() {
        System.out.println("post1!!");
        return "post1!!";
    }

    @PostMapping("/post2")
    public String postTest2(String username, String password) {
        System.out.println("username: "+username+", password: "+password);
        return "ok";
    }
}
