package com.BookRoom.service;

import com.BookRoom.dto.MeetingRoomOrderSearchParams;
import com.BookRoom.mapper.MeetingRoomSelectionMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.meetingRoom.MeetingRoom;
import com.BookRoom.entity.meetingRoom.MeetingRoomSelection;
import com.BookRoom.entity.view.MeetingRoomSelectView;
import com.BookRoom.entity.view.MeetingRoomView;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 会议室服务接口
 * 定义了会议室管理相关的业务逻辑方法，包括会议室的增删改查、选会议室、退会议室和成绩管理等功能
 */
public interface MeetingRoomService {
    /**
     * 根据会议室ID获取会议室信息
     *
     * @param meetingRoomId 会议室ID
     * @return 会议室信息
     */
    MeetingRoomView getMeetingRoomById(String meetingRoomId);

    /**
     * 根据顾客ID获取会议室列表（分页）
     *
     * @param customerId 顾客ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 分页会议室列表
     */
    Page<MeetingRoomSelectView> getMeetingRoomsByCustomerPage(String customerId, long current, long size);

    /**
     * 获取所有会议室（分页）
     *
     * @param current 当前页码
     * @param size    每页大小
     * @return 分页会议室列表
     */
    Page<MeetingRoomView> getAllMeetingRoomsByPage(
            long current,
            long size,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Integer minCapacity
    );
    /**
     * 创建新会议室
     *
     * @param meetingRoom 会议室信息
     * @return 会议室ID
     */
    Integer createOrUpdateMeetingRoom(MeetingRoom meetingRoom);

    /**
     * 删除会议室
     *
     * @param meetingRoomId 会议室ID
     * @return 是否删除成功
     */
    boolean deleteMeetingRoom(Integer meetingRoomId);

    /**
     * 顾客选会议室
     *
     * @param meetingRoomId
     * @param customerId
     * @return
     */
    boolean selectMeetingRoom(Integer meetingRoomId, String customerId, LocalDateTime startTime, LocalDateTime endTime);

    /**
     * 顾客退选会议室
     *
     * @param meetingRoomSelection 选会议室信息（包含会议室ID、顾客ID和员工ID）
     * @return 是否退选成功
     */
    boolean dropMeetingRoom(MeetingRoomSelection meetingRoomSelection);

    /**
     * 获取顾客已选会议室列表
     *
     * @param customerId 顾客ID
     * @return 已选会议室列表
     */
    List<MeetingRoomSelectView> getCustomerMeetingRooms(String customerId);

    /**
     * 获取顾客已选会议室列表（分页）
     *
     * @param customerId 顾客ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 分页已选会议室列表
     */
    Page<MeetingRoomSelectView> getCustomerMeetingRoomsPage(String customerId, long current, long size);

    Page<MeetingRoomSelectView> getCustomerMeetingRoomSelections(String customerId, long current, long size);

    Page<MeetingRoomSelectView> getMeetingRoomCustomers(Integer meetingRoomId, long current, long size);

    Page<MeetingRoomView> getMeetingRoomDetails(Integer meetingRoomId, long current, long size);

    boolean confirmPayment(Integer meetingRoomId, String customerId,LocalDateTime startTime, LocalDateTime endTime);

    BigDecimal calculateRefundAmount(LocalDateTime startTime, BigDecimal totalPrice);
    Page<MeetingRoom> getAvailableRooms(Page<MeetingRoom> page,
                                            LocalDateTime startTime,
                                            LocalDateTime endTime,
                                            Boolean hasProjector,
                                            Boolean hasAudio,
                                            Boolean hasNetwork);


    List<MeetingRoomSelection> searchMeetingRoomOrders();

    boolean reserve(Long roomId, String userId, LocalDateTime startTime, LocalDateTime endTime);

}
