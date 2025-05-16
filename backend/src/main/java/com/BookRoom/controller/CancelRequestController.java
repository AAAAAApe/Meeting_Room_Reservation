package com.BookRoom.controller;

import com.BookRoom.dto.CancelRequest;
import com.BookRoom.dto.PaymentRequest;
import com.BookRoom.service.CancelRequestService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/cancelRequest")
public class CancelRequestController {

    private final CancelRequestService cancelRequestService;

    public CancelRequestController(CancelRequestService cancelRequestService) {
        this.cancelRequestService = cancelRequestService;
    }

    @PutMapping("/{meetingRoomId}/apply")
    public boolean applyCancel(
            @PathVariable Integer meetingRoomId,
            HttpServletRequest request,
            @RequestBody PaymentRequest payload
    ) {
        String customerId = (String) request.getAttribute("userId");

        return cancelRequestService.applyCancel(
                meetingRoomId,
                customerId,
                payload.getStartTime(),
                payload.getEndTime());
    }
    @GetMapping("/pending")
    public List<CancelRequest> getPendingRequests() {
        System.out.println("查询"+cancelRequestService.getPendingRequests());
        return cancelRequestService.getPendingRequests();
    }

    @PutMapping("/{id}/approve")
    public void approve(@PathVariable Long id) {
        cancelRequestService.updateStatus(id, "approved");
    }

    @PutMapping("/{id}/reject")
    public void reject(@PathVariable Long id) {
        cancelRequestService.updateStatus(id, "rejected");
    }
}