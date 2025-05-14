package com.BookRoom.controller;

import com.BookRoom.service.CancelRequestService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@RequestMapping("/cancelRequest")
public class CancelRequestController {

    private final CancelRequestService cancelRequestService;

    public CancelRequestController(CancelRequestService cancelRequestService) {
        this.cancelRequestService = cancelRequestService;
    }

    @PutMapping("/apply")
    public boolean applyCancel(
            HttpServletRequest request,
            @RequestBody Map<String, Object> payload
    ) {
        String customerId = (String) request.getAttribute("userId");
        Integer meetingRoomId = (Integer) payload.get("meetingRoomId");

        return cancelRequestService.applyCancel(meetingRoomId, customerId);
    }
}