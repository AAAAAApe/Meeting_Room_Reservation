package com.BookRoom.service;

import com.BookRoom.dto.CancelRequest;

import java.time.LocalDateTime;
import java.util.List;

public interface CancelRequestService {
    boolean applyCancel(Integer meetingRoomId, String customerId, LocalDateTime startTime, LocalDateTime endTime);
    List<CancelRequest> getPendingRequests();
    void updateStatus(Long id, String status);
    void approveAndDeleteOrder(Long cancelRequestId);
}
