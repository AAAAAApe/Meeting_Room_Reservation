package com.BookRoom;

import com.github.jeffreyning.mybatisplus.conf.EnableMPP;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication // 标识这是一个Spring Boot应用程序
@MapperScan("com.BookRoom.mapper") // 扫描指定包下的Mapper接口
@EnableMPP
public class BackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(BackendApplication.class, args); // 运行Spring Boot应用程序
    }

}
