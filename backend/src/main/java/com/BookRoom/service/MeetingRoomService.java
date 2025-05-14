package com.BookRoom.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.meetingRoom.MeetingRoom;
import com.BookRoom.entity.meetingRoom.MeetingRoomSelection;
import com.BookRoom.entity.view.MeetingRoomSelectView;
import com.BookRoom.entity.view.MeetingRoomView;

import java.util.List;

/**
 * 会议室服务接口
 * 定义了会议室管理相关的业务逻辑方法，包括会议室的增删改查、选课、退课和成绩管理等功能
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
     * 根据部门ID获取会议室列表（分页）
     *
     * @param departmentId 部门ID
     * @param current      当前页码
     * @param size         每页大小
     * @return 分页会议室列表
     */
    Page<MeetingRoomView> getMeetingRoomsByDepartmentPage(String departmentId, long current, long size);

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
     * 获取所有会议室（分页），支持按院系ID列表筛选
     *
     * @param current 当前页码
     * @param size    每页大小
     * @param departmentIds 院系ID列表，为null时获取所有会议室
     * @return 分页会议室列表
     */
    Page<MeetingRoomView> getAllMeetingRoomsByPage(long current, long size, List<String> departmentIds);

    /**
     * 创建新会议室
     *
     * @param meetingRoom 会议室信息
     * @return 会议室ID
     */
    Integer createOrUpdateMeetingRoom(MeetingRoom meetingRoom, String creatorId);

    /**
     * 删除会议室
     *
     * @param meetingRoomId 会议室ID
     * @return 是否删除成功
     */
    boolean deleteMeetingRoom(Integer meetingRoomId);

    /**
     * 顾客选课
     *
     * @param meetingRoomId
     * @param customerId
     * @return
     */
    boolean selectMeetingRoom(Integer meetingRoomId, String customerId);

    /**
     * 顾客退选会议室
     *
     * @param meetingRoomSelection 选课信息（包含会议室ID、顾客ID和员工ID）
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

    /**
     * 更新顾客成绩
     *
     * @param meetingRoomSelection 选课信息（包含会议室ID、顾客ID、员工ID和成绩）
     * @return 是否更新成功
     */
    boolean updateScore(MeetingRoomSelection meetingRoomSelection);

    Page<MeetingRoomSelectView> getCustomerMeetingRoomSelections(String customerId, long current, long size);

    Page<MeetingRoomSelectView> getMeetingRoomCustomers(Integer meetingRoomId, long current, long size);

    boolean setMeetingRoomScore(Integer meetingRoomId, String customerId, Double score);

    Page<MeetingRoomView> getMeetingRoomDetails(Integer meetingRoomId, long current, long size);
}
