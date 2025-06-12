package com.BookRoom.controller;

import com.BookRoom.entity.meetingRoom.MeetingRoomSelection;
import com.BookRoom.service.MeetingRoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class QueryOrderController {
    @Autowired
    private MeetingRoomService meetingRoomService;

    @GetMapping("/employee/query")
    public List<MeetingRoomSelection> queryOrders() {
        List<MeetingRoomSelection> list = meetingRoomService.searchMeetingRoomOrders();
        for (MeetingRoomSelection meetingRoomSelection : list) {
            System.out.println(meetingRoomSelection);
        }
        return meetingRoomService.searchMeetingRoomOrders();
    }
}