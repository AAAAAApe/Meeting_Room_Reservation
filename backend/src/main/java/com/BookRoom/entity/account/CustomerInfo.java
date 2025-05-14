package com.BookRoom.entity.account;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("customer_info")
public class CustomerInfo {
    @TableId
    private String userId;
    private String majorId;
    private Double pricePerHour;
}
