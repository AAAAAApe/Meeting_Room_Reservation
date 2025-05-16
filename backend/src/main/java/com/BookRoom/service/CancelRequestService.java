package com.BookRoom.service;

import com.BookRoom.dto.CancelRequest;

import java.util.List;

public interface CancelRequestService {
    boolean applyCancel(Integer meetingRoomId, String customerId);
    List<CancelRequest> getPendingRequests();
    void updateStatus(Long id, String status);
}
