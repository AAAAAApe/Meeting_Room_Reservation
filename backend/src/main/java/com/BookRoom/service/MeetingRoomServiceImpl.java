package com.BookRoom.service;

import com.BookRoom.dto.MeetingRoomOrderSearchParams;
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
import java.util.Optional;

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
            BigDecimal minPrice,
            BigDecimal maxPrice,
            Integer minCapacity
    ) {
        Page<MeetingRoomView> page = new Page<>(current, size);
        LambdaQueryWrapper<MeetingRoomView> queryWrapper = new LambdaQueryWrapper<>();

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
    public Integer createOrUpdateMeetingRoom(MeetingRoom meetingRoom) {
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
    public Page<MeetingRoomView> getMeetingRoomDetails(Integer meetingRoomId, long current, long size) {
        Page<MeetingRoomView> page = new Page<>(current, size);
        return meetingRoomViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomView>()
                        .eq(MeetingRoomView::getMeetingRoomId, meetingRoomId));
    }
    @Override
    public boolean confirmPayment(Integer meetingRoomId, String customerId,LocalDateTime startTime, LocalDateTime endTime) {
        // 查找订单
        LambdaQueryWrapper<MeetingRoomSelection> query = new LambdaQueryWrapper<>();
        query.eq(MeetingRoomSelection::getMeetingRoomId, meetingRoomId)
                .eq(MeetingRoomSelection::getCustomerId, customerId)
                .eq(MeetingRoomSelection::getStatus, "pending_payment")
                .eq(MeetingRoomSelection::getStartTime, startTime) // 新增时间条件
                .eq(MeetingRoomSelection::getEndTime, endTime);

        MeetingRoomSelection order = meetingRoomSelectionMapper.selectOne(query);
        if (order == null) return false;
        System.out.println("订单信息：" + order);
        // 更新状态为已确认
        order.setStatus("confirmed");
        order.setPaymentStatus("paid");
        order.setPaymentTime(LocalDateTime.now());

        return meetingRoomSelectionMapper.updateById(order) > 0;
    }

    @Override
    public BigDecimal calculateRefundAmount(LocalDateTime startTime, BigDecimal totalPrice) {
        long hours = ChronoUnit.HOURS.between(LocalDateTime.now(), startTime);
        if (hours >= 72) return totalPrice;
        else if (hours >= 48) return totalPrice.multiply(BigDecimal.valueOf(0.75));
        else if (hours >= 24) return totalPrice.multiply(BigDecimal.valueOf(0.25));
        else return BigDecimal.ZERO;
    }
    @Override
    public Page<MeetingRoom> getAvailableRooms(Page<MeetingRoom> page,
                                                   LocalDateTime startTime,
                                                   LocalDateTime endTime,
                                                   Boolean hasProjector,
                                                   Boolean hasAudio,
                                                   Boolean hasNetwork) {
        LambdaQueryWrapper<MeetingRoom> queryWrapper = new LambdaQueryWrapper<>();

        // 增强版时间冲突检测
        if (startTime != null && endTime != null) {
            String conflictCondition = String.format(
                    "(start_time < '%s' AND end_time > '%s')",
                    endTime, startTime
            );

            queryWrapper.notInSql(
                    MeetingRoom::getMeetingRoomId,
                    "SELECT DISTINCT meeting_room_id FROM meetingroom_selection " +
                            "WHERE status NOT IN ('completed', 'cancelled') " +
                            "AND " + conflictCondition
            );
        }

        // 设备筛选逻辑（严格包含）
        Optional.ofNullable(hasProjector).ifPresent(v ->
                queryWrapper.eq(MeetingRoom::getHasProjector, v));
        Optional.ofNullable(hasAudio).ifPresent(v ->
                queryWrapper.eq(MeetingRoom::getHasAudio, v));
        Optional.ofNullable(hasNetwork).ifPresent(v ->
                queryWrapper.eq(MeetingRoom::getHasNetwork, v));

        return meetingRoomMapper.selectPage(page, queryWrapper);
    }

    @Override
    public List<MeetingRoomSelection> searchMeetingRoomOrders(MeetingRoomOrderSearchParams params) {
        LambdaQueryWrapper<MeetingRoomSelection> wrapper = new LambdaQueryWrapper<>();
        if (params.getMeetingRoomId() != null) wrapper.eq(MeetingRoomSelection::getMeetingRoomId, params.getMeetingRoomId());
        if (params.getCustomerId() != null) wrapper.eq(MeetingRoomSelection::getCustomerId, params.getCustomerId());
        if (params.getStatus() != null) wrapper.eq(MeetingRoomSelection::getStatus, params.getStatus());
        if (params.getStartTime() != null) wrapper.ge(MeetingRoomSelection::getStartTime, params.getStartTime());
        if (params.getEndTime() != null) wrapper.le(MeetingRoomSelection::getEndTime, params.getEndTime());
        return meetingRoomSelectionMapper.selectList(wrapper);
    }
}