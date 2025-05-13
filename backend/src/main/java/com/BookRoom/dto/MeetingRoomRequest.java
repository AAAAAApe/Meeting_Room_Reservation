package com.BookRoom.dto;

import com.BookRoom.entity.meetingRoom.MeetingRoom;

import java.util.List;

/**
 * 会议室请求数据传输对象
 * 用于接收创建或更新会议室的请求参数
 */
public record MeetingRoomRequest(MeetingRoom meetingRoom, List<String> employeeIds) {}