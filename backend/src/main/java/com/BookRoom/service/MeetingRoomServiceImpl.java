package com.BookRoom.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.meetingRoom.MeetingRoom;
import com.BookRoom.entity.meetingRoom.MeetingRoomSelection;
import com.BookRoom.entity.view.MeetingRoomSelectView;
import com.BookRoom.entity.view.MeetingRoomView;
import com.BookRoom.mapper.*;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 * 会议室服务实现类
 * 处理会议室的创建、查询、更新和删除等业务逻辑
 * 继承自ServiceImpl以利用MyBatis-Plus提供的通用CRUD功能
 */
@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
    private final MeetingRoomMapper meetingRoomMapper;
    private final MeetingRoomSelectionMapper meetingRoomSelectionMapper;
    private final MeetingRoomViewMapper meetingRoomViewMapper;
    private final MeetingRoomSelectViewMapper meetingRoomSelectViewMapper;

    /**
     * 构造函数，通过依赖注入初始化所有数据访问对象
     *
     * @param meetingRoomMapper           会议室数据访问对象
     * @param meetingRoomSelectionMapper  选会议室数据访问对象
     * @param meetingRoomViewMapper       会议室视图数据访问对象
     * @param meetingRoomSelectViewMapper 选会议室视图数据访问对象
     */
    public MeetingRoomServiceImpl(MeetingRoomMapper meetingRoomMapper,
                             MeetingRoomSelectionMapper meetingRoomSelectionMapper, MeetingRoomViewMapper meetingRoomViewMapper,
                             MeetingRoomSelectViewMapper meetingRoomSelectViewMapper) {
        this.meetingRoomMapper = meetingRoomMapper;
        this.meetingRoomSelectionMapper = meetingRoomSelectionMapper;
        this.meetingRoomViewMapper = meetingRoomViewMapper;
        this.meetingRoomSelectViewMapper = meetingRoomSelectViewMapper;
    }

    /**
     * 根据会议室ID获取会议室信息
     *
     * @param meetingRoomId 会议室ID
     * @return 会议室信息视图对象
     */
    @Override
    public MeetingRoomView getMeetingRoomById(String meetingRoomId) {
        return meetingRoomViewMapper.selectById(meetingRoomId);
    }

    /**
     * 根据部门ID获取会议室列表（分页）
     *
     * @param departmentId 部门ID
     * @param current      当前页码
     * @param size         每页大小
     * @return 包含分页会议室信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<MeetingRoomView> getMeetingRoomsByDepartmentPage(String departmentId, long current, long size) {
        Page<MeetingRoomView> page = new Page<>(current, size);
        return meetingRoomViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomView>().eq(MeetingRoomView::getDepartmentId, departmentId));
    }

    /**
     * 根据顾客ID获取会议室列表（分页）
     *
     * @param customerId 顾客ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 包含分页选会议室信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<MeetingRoomSelectView> getMeetingRoomsByCustomerPage(String customerId, long current, long size) {
        Page<MeetingRoomSelectView> page = new Page<>(current, size);
        return meetingRoomSelectViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomSelectView>().eq(MeetingRoomSelectView::getCustomerId, customerId));
    }

    /**
     * 获取所有会议室（分页）
     *
     * @param current 当前页码
     * @param size    每页大小
     * @return 包含分页会议室信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<MeetingRoomView> getAllMeetingRoomsByPage(
            long current,
            long size,
            List<String> departmentIds,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Integer minCapacity
    ) {
        Page<MeetingRoomView> page = new Page<>(current, size);
        LambdaQueryWrapper<MeetingRoomView> queryWrapper = new LambdaQueryWrapper<>();

        if (departmentIds != null && !departmentIds.isEmpty()) {
            queryWrapper.in(MeetingRoomView::getDepartmentId, departmentIds);
        }
        if (minPrice != null) {
            queryWrapper.ge(MeetingRoomView::getPricePerHour, minPrice);
        }
        if (maxPrice != null) {
            queryWrapper.le(MeetingRoomView::getPricePerHour, maxPrice);
        }
        if (minCapacity != null) {
            queryWrapper.ge(MeetingRoomView::getCapacity, minCapacity);
        }

        return meetingRoomViewMapper.selectPage(page, queryWrapper);
    }


    /**
     * 创建或更新会议室信息，同时更新会议室与员工的关联关系
     *
     * @param meetingRoom     会议室信息
     * @return 会议室ID
     */
    @Override
    public Integer createOrUpdateMeetingRoom(MeetingRoom meetingRoom, String creatorId) {
        meetingRoom.setCreatorId(creatorId);
        if (meetingRoomMapper.insertOrUpdate(meetingRoom)) {
            // 完全移除员工关联处理逻辑
            return meetingRoom.getMeetingRoomId();
        }
        return null;
    }


    /**
     * 删除会议室
     *
     * @param meetingRoomId 会议室ID
     * @return 是否删除成功
     */
    @Override
    public boolean deleteMeetingRoom(Integer meetingRoomId) {
        return meetingRoomMapper.deleteById(meetingRoomId) > 0;
    }

    @Override
    public boolean selectMeetingRoom(Integer meetingRoomId, String customerId, LocalDateTime startTime, LocalDateTime endTime) {
        // 1. 校验是否存在冲突的订单
        List<MeetingRoomSelection> conflictList = meetingRoomSelectionMapper.selectList(
                new LambdaQueryWrapper<MeetingRoomSelection>()
                        .eq(MeetingRoomSelection::getMeetingRoomId, meetingRoomId)
                        .in(MeetingRoomSelection::getStatus, List.of("pending_payment", "confirmed"))
                        .and(wrapper -> wrapper
                                .lt(MeetingRoomSelection::getEndTime, endTime)
                                .gt(MeetingRoomSelection::getStartTime, startTime))
        );
        if (!conflictList.isEmpty()) {
            return false; // 冲突，不能预订
        }

        // 2. 查询会议室价格
        MeetingRoom room = meetingRoomMapper.selectById(meetingRoomId);
        if (room == null) return false;

        BigDecimal hourlyRate = room.getPricePerHour();
        long hours = ChronoUnit.HOURS.between(startTime, endTime);
        if (hours <= 0) return false;

        BigDecimal totalPrice = hourlyRate.multiply(BigDecimal.valueOf(hours));

        // 3. 构建插入对象
        MeetingRoomSelection selection = new MeetingRoomSelection();
        selection.setMeetingRoomId(meetingRoomId);
        selection.setCustomerId(customerId);
        selection.setStartTime(startTime);
        selection.setEndTime(endTime);
        selection.setScore(0.0);
        selection.setStatus("pending_payment");
        selection.setPaymentStatus("unpaid");
        selection.setTotalPrice(totalPrice);

        // 插入
        return meetingRoomSelectionMapper.insert(selection) > 0;
    }


    /**
     * 顾客退选会议室
     *
     * @param meetingRoomSelection 选会议室信息（包含会议室ID、顾客ID和员工ID）
     * @return 是否退选成功
     */
    @Override
    public boolean dropMeetingRoom(MeetingRoomSelection meetingRoomSelection) {
        return meetingRoomSelectionMapper.delete(
                new LambdaQueryWrapper<MeetingRoomSelection>()
                        .eq(MeetingRoomSelection::getMeetingRoomId, meetingRoomSelection.getMeetingRoomId())
                        .eq(MeetingRoomSelection::getCustomerId, meetingRoomSelection.getCustomerId())) > 0;
    }

    /**
     * 获取顾客已选会议室列表
     *
     * @param customerId 顾客ID
     * @return 已选会议室列表
     */
    @Override
    public List<MeetingRoomSelectView> getCustomerMeetingRooms(String customerId) {
        return meetingRoomSelectViewMapper.selectList(new LambdaQueryWrapper<MeetingRoomSelectView>()
                .eq(MeetingRoomSelectView::getCustomerId, customerId));
    }

    /**
     * 获取顾客已选会议室列表（分页）
     *
     * @param customerId 顾客ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 分页已选会议室列表
     */
    @Override
    public Page<MeetingRoomSelectView> getCustomerMeetingRoomsPage(String customerId, long current, long size) {
        Page<MeetingRoomSelectView> page = new Page<>(current, size);
        return meetingRoomSelectViewMapper.selectPage(page, new LambdaQueryWrapper<MeetingRoomSelectView>()
                .eq(MeetingRoomSelectView::getCustomerId, customerId));
    }

    /**
     * 更新顾客成绩
     *
     * @param meetingRoomSelection 选会议室信息（包含会议室ID、顾客ID、员工ID和成绩）
     * @return 是否更新成功
     */
    @Override
    public boolean updateScore(MeetingRoomSelection meetingRoomSelection) {
        return meetingRoomSelectionMapper.update(meetingRoomSelection,
                new LambdaQueryWrapper<MeetingRoomSelection>()
                        .eq(MeetingRoomSelection::getMeetingRoomId, meetingRoomSelection.getMeetingRoomId())
                        .eq(MeetingRoomSelection::getCustomerId, meetingRoomSelection.getCustomerId())) > 0;
    }

    @Override
    public Page<MeetingRoomSelectView> getCustomerMeetingRoomSelections(String customerId, long current, long size) {
        Page<MeetingRoomSelectView> page = new Page<>(current, size);
        return meetingRoomSelectViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomSelectView>().eq(MeetingRoomSelectView::getCustomerId, customerId));
    }

    @Override
    public Page<MeetingRoomSelectView> getMeetingRoomCustomers(Integer meetingRoomId, long current, long size) { // 移除employeeId参数
        Page<MeetingRoomSelectView> page = new Page<>(current, size);
        return meetingRoomSelectViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomSelectView>()
                        .eq(MeetingRoomSelectView::getMeetingRoomId, meetingRoomId)); // 移除employeeId查询条件
    }

    @Override
    public boolean setMeetingRoomScore(Integer meetingRoomId,  String customerId, Double score) {
        MeetingRoomSelection meetingRoomSelection = new MeetingRoomSelection();
        meetingRoomSelection.setMeetingRoomId(meetingRoomId);
        meetingRoomSelection.setCustomerId(customerId);
        meetingRoomSelection.setScore(score);

        return meetingRoomSelectionMapper.update(meetingRoomSelection,
                new LambdaQueryWrapper<MeetingRoomSelection>()
                        .eq(MeetingRoomSelection::getMeetingRoomId, meetingRoomId)
                        .eq(MeetingRoomSelection::getCustomerId, customerId)) > 0;
    }

    @Override
    public Page<MeetingRoomView> getMeetingRoomDetails(Integer meetingRoomId, long current, long size) {
        Page<MeetingRoomView> page = new Page<>(current, size);
        return meetingRoomViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomView>()
                        .eq(MeetingRoomView::getMeetingRoomId, meetingRoomId));
    }
}