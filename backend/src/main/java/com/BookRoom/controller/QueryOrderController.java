package com.BookRoom.controller;

import com.BookRoom.dto.MeetingRoomOrderSearchParams;
import com.BookRoom.service.MeetingRoomService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
//@RequestMapping("/order")
public class QueryOrderController {

    private final MeetingRoomService meetingRoomService;

    public QueryOrderController(MeetingRoomService meetingRoomService) {
        this.meetingRoomService = meetingRoomService;
    }

    /**
     * 员工查询会议室订单，可按会议室、用户、时间、状态筛选
     *
     * @param params 查询参数（会议室ID、用户ID、时间范围、状态等
     */
    @GetMapping("/employee/query")
    public List<com.BookRoom.entity.meetingRoom.MeetingRoomSelection> queryOrders(MeetingRoomOrderSearchParams params) {
        // TODO: 可加上员工身份校验
        List<com.BookRoom.entity.meetingRoom.MeetingRoomSelection> result = meetingRoomService.searchMeetingRoomOrders();
        System.out.println("查询订单返回数据: " + result);
        System.out.println("123");
        return meetingRoomService.searchMeetingRoomOrders();
    }
}