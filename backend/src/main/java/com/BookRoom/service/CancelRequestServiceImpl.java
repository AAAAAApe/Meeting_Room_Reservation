package com.BookRoom.service;

import com.BookRoom.dto.CancelRequest;
import com.BookRoom.entity.meetingRoom.MeetingRoomSelection;
import com.BookRoom.mapper.CancelRequestMapper;
import com.BookRoom.mapper.MeetingRoomSelectViewMapper;
import com.BookRoom.mapper.MeetingRoomSelectionMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class CancelRequestServiceImpl implements CancelRequestService {

    private final CancelRequestMapper cancelRequestMapper;
    private final MeetingRoomSelectionMapper meetingRoomSelectionMapper;

    public CancelRequestServiceImpl(CancelRequestMapper cancelRequestMapper, MeetingRoomSelectionMapper meetingRoomSelectionMapper) {
        this.cancelRequestMapper = cancelRequestMapper;
        this.meetingRoomSelectionMapper = meetingRoomSelectionMapper;
    }

    @Override
    public boolean applyCancel(Integer meetingRoomId, String customerId, LocalDateTime startTime, LocalDateTime endTime) {
        // 查找订单是否存在，且时间区间匹配
        LambdaQueryWrapper<MeetingRoomSelection> selectionWrapper = new LambdaQueryWrapper<>();
        selectionWrapper.eq(MeetingRoomSelection::getMeetingRoomId, meetingRoomId)
                .eq(MeetingRoomSelection::getCustomerId, customerId)
//                .eq(MeetingRoomSelection::getStatus, "confirmed")
                .eq(MeetingRoomSelection::getStartTime, startTime)
                .eq(MeetingRoomSelection::getEndTime, endTime);
        System.out.println(meetingRoomId + ":" + customerId + ":" + startTime + ":" + endTime);
        MeetingRoomSelection selection = meetingRoomSelectionMapper.selectOne(selectionWrapper);

        if (selection == null) {
            System.out.println("No selection found");
            return false;
        }

        // 是否至少提前24小时
        if (selection.getStartTime().isBefore(LocalDateTime.now().plusHours(24))) {
            System.out.println("Start time is after end time");
            return false;
        }

        // 检查是否已有待处理申请
        LambdaQueryWrapper<CancelRequest> existWrapper = new LambdaQueryWrapper<>();
        existWrapper.eq(CancelRequest::getMeetingRoomId, meetingRoomId)
                .eq(CancelRequest::getCustomerId, customerId)
                .eq(CancelRequest::getStatus, "pending");

        Long count = cancelRequestMapper.selectCount(existWrapper);
        if (count > 0) {
            System.out.println("Cancel request already exists");
            return false;
        }

        // 插入新取消申请，带上时间范围
        CancelRequest request = new CancelRequest();
        request.setMeetingRoomId(meetingRoomId);
        request.setCustomerId(customerId);
//        request.setRequestTime(LocalDateTime.now());
        request.setStatus("pending");

        return cancelRequestMapper.insertOrUpdate(request);
    }


    @Override
    public List<CancelRequest> getPendingRequests() {
        return cancelRequestMapper.selectList(new LambdaQueryWrapper<CancelRequest>()
                .eq(CancelRequest::getStatus, "pending"));
    }

    @Override
    public void updateStatus(Long id, String status) {
        CancelRequest update = new CancelRequest();
        update.setId(id);
        update.setStatus(status);
        update.setReviewTime(LocalDateTime.now());
        cancelRequestMapper.updateById(update);
    }

    @Override
    public void approveAndDeleteOrder(Long cancelRequestId) {
        // 1. 先查找取消申请记录
        CancelRequest cancelRequest = cancelRequestMapper.selectById(cancelRequestId);
        if (cancelRequest == null) return;

        // 2. 根据取消申请里的信息删除订单表中的数据
        LambdaQueryWrapper<MeetingRoomSelection> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(MeetingRoomSelection::getMeetingRoomId, cancelRequest.getMeetingRoomId())
                .eq(MeetingRoomSelection::getCustomerId, cancelRequest.getCustomerId());
        // 如果 CancelRequest 有 startTime/endTime 字段，再加上这两个条件更精确
        // wrapper.eq(MeetingRoomSelection::getStartTime, cancelRequest.getStartTime())
        //        .eq(MeetingRoomSelection::getEndTime, cancelRequest.getEndTime());

        meetingRoomSelectionMapper.delete(wrapper);

        // 3. 更新取消申请状态为 approved
        cancelRequest.setStatus("approved");
        cancelRequest.setReviewTime(LocalDateTime.now());
        cancelRequestMapper.updateById(cancelRequest);
    }
}