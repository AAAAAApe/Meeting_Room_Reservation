package com.BookRoom.utils;

import com.BookRoom.entity.meetingRoom.MeetingRoomSelection;
import com.BookRoom.mapper.MeetingRoomSelectionMapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Slf4j
@Component
public class MeetingRoomOrderCleaner {

    private final MeetingRoomSelectionMapper selectionMapper;

    public MeetingRoomOrderCleaner(MeetingRoomSelectionMapper selectionMapper) {
        this.selectionMapper = selectionMapper;
    }

    // 每5分钟执行一次
    @Scheduled(cron = "0 */5 * * * ?")
    public void cleanExpiredOrders() {
        log.info("执行自动释放过期订单任务");

        LambdaUpdateWrapper<MeetingRoomSelection> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(MeetingRoomSelection::getStatus, "pending_payment")
                .lt(MeetingRoomSelection::getSelectionTime, LocalDateTime.now().minusMinutes(30))
                .set(MeetingRoomSelection::getStatus, "cancelled")
                .set(MeetingRoomSelection::getCancellationTime, LocalDateTime.now());

        int affected = selectionMapper.update(null, wrapper);
        if (affected > 0) {
            log.info("释放了 {} 个过期订单", affected);
        }
    }
}
