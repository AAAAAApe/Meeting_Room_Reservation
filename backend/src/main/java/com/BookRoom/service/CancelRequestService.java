package com.BookRoom.service;

public interface CancelRequestService {
    boolean applyCancel(Integer meetingRoomId, String customerId);
}
