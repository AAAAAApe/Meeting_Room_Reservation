package com.BookRoom.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.entity.meetingRoom.MeetingRoom;
import com.BookRoom.entity.meetingRoom.MeetingRoomSelection;
import com.BookRoom.entity.meetingRoom.MeetingRoomEmployee;
import com.BookRoom.entity.view.MeetingRoomSelectView;
import com.BookRoom.entity.view.MeetingRoomView;
import com.BookRoom.entity.view.MeetingRoomWithEmployeeView;
import com.BookRoom.mapper.*;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 会议室服务实现类
 * 处理会议室的创建、查询、更新和删除等业务逻辑
 * 继承自ServiceImpl以利用MyBatis-Plus提供的通用CRUD功能
 */
@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
    private final MeetingRoomMapper meetingRoomMapper;
    private final MeetingRoomEmployeeMapper meetingRoomEmployeeMapper;
    private final MeetingRoomSelectionMapper meetingRoomSelectionMapper;
    private final MeetingRoomViewMapper meetingRoomViewMapper;
    private final MeetingRoomSelectViewMapper meetingRoomSelectViewMapper;
    private final MeetingRoomWithEmployeeViewMapper meetingRoomWithEmployeeViewMapper;

    /**
     * 构造函数，通过依赖注入初始化所有数据访问对象
     *
     * @param meetingRoomMapper           会议室数据访问对象
     * @param meetingRoomEmployeeMapper    会议室员工关系数据访问对象
     * @param meetingRoomSelectionMapper  选课数据访问对象
     * @param meetingRoomViewMapper       会议室视图数据访问对象
     * @param meetingRoomSelectViewMapper 选课视图数据访问对象
     */
    public MeetingRoomServiceImpl(MeetingRoomMapper meetingRoomMapper, MeetingRoomEmployeeMapper meetingRoomEmployeeMapper,
                             MeetingRoomSelectionMapper meetingRoomSelectionMapper, MeetingRoomViewMapper meetingRoomViewMapper,
                             MeetingRoomSelectViewMapper meetingRoomSelectViewMapper, MeetingRoomWithEmployeeViewMapper meetingRoomWithEmployeeViewMapper) {
        this.meetingRoomMapper = meetingRoomMapper;
        this.meetingRoomEmployeeMapper = meetingRoomEmployeeMapper;
        this.meetingRoomSelectionMapper = meetingRoomSelectionMapper;
        this.meetingRoomViewMapper = meetingRoomViewMapper;
        this.meetingRoomSelectViewMapper = meetingRoomSelectViewMapper;
        this.meetingRoomWithEmployeeViewMapper = meetingRoomWithEmployeeViewMapper;
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
     * 根据员工ID获取会议室列表（分页）
     *
     * @param employeeId 员工ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 包含分页会议室信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @Override
    public Page<MeetingRoomWithEmployeeView> getMeetingRoomsByEmployeePage(String employeeId, long current, long size) {
        Page<MeetingRoomWithEmployeeView> page = new Page<>(current, size);
        return meetingRoomWithEmployeeViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomWithEmployeeView>().eq(MeetingRoomWithEmployeeView::getEmployeeId, employeeId));
    }

    /**
     * 根据顾客ID获取会议室列表（分页）
     *
     * @param customerId 顾客ID
     * @param current   当前页码
     * @param size      每页大小
     * @return 包含分页选课信息的Page对象，包含总记录数、总页数、当前页数据等信息
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
    public Page<MeetingRoomView> getAllMeetingRoomsByPage(long current, long size, List<String> departmentIds) {
        Page<MeetingRoomView> page = new Page<>(current, size);
        LambdaQueryWrapper<MeetingRoomView> queryWrapper = new LambdaQueryWrapper<>();
        if (departmentIds != null && !departmentIds.isEmpty()) {
            queryWrapper.in(MeetingRoomView::getDepartmentId, departmentIds);
        }
        return meetingRoomViewMapper.selectPage(page, queryWrapper);
    }

    @Override
    public Page<MeetingRoomWithEmployeeView> getMeetingRoomWithEmployeesByMeetingRoomId(Integer meetingRoomId, long current, long size) {
        Page<MeetingRoomWithEmployeeView> page = new Page<>(current, size);
        return meetingRoomWithEmployeeViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomWithEmployeeView>().eq(MeetingRoomWithEmployeeView::getMeetingRoomId, meetingRoomId));
    }

    /**
     * 创建或更新会议室信息，同时更新会议室与员工的关联关系
     *
     * @param meetingRoom     会议室信息
     * @param employeeIds 员工ID列表
     * @return 会议室ID
     */
    @Override
    public Integer createOrUpdateMeetingRoom(MeetingRoom meetingRoom, List<String> employeeIds, String creatorId) {
        meetingRoom.setCreatorId(creatorId);
        if (meetingRoomMapper.insertOrUpdate(meetingRoom)) {
            // 将employeeIds转换为Set以提高查找效率
            Set<String> employeeIdSet = new HashSet<>(employeeIds);

            // 只有在编辑已存在会议室时才执行删除操作
            if (meetingRoom.getMeetingRoomId() != null) {
                // 查询该会议室现有的员工关系
                List<MeetingRoomEmployee> existingEmployees = meetingRoomEmployeeMapper.selectList(
                        new LambdaQueryWrapper<MeetingRoomEmployee>().eq(MeetingRoomEmployee::getMeetingRoomId, meetingRoom.getMeetingRoomId()));

                // 删除不再需要的员工关系
                for (MeetingRoomEmployee existingEmployee : existingEmployees) {
                    String employeeId = existingEmployee.getUserId();
                    if (!employeeIdSet.contains(employeeId)) {
                        // 使用LambdaQueryWrapper构建删除条件，同时指定meetingRoomId和userId
                        meetingRoomEmployeeMapper.delete(
                                new LambdaQueryWrapper<MeetingRoomEmployee>()
                                        .eq(MeetingRoomEmployee::getMeetingRoomId, meetingRoom.getMeetingRoomId())
                                        .eq(MeetingRoomEmployee::getUserId, employeeId));
                    } else {
                        // 从集合中移除已存在的员工ID
                        employeeIdSet.remove(employeeId);
                    }
                }
            }

            // 添加新的员工关系
            for (String employeeId : employeeIdSet) {
                MeetingRoomEmployee meetingRoomEmployee = new MeetingRoomEmployee();
                meetingRoomEmployee.setMeetingRoomId(meetingRoom.getMeetingRoomId());
                meetingRoomEmployee.setUserId(employeeId);
                meetingRoomEmployeeMapper.insert(meetingRoomEmployee);
            }

            return meetingRoom.getMeetingRoomId();
        }
        return null;
    }

    // /**
    //  * 创建或更新会议室信息
    //  *
    //  * @param meetingRoom 会议室信息
    //  * @return 会议室ID
    //  */
    // @Override
    // public Integer createOrUpdateMeetingRoom(MeetingRoom meetingRoom, String creatorId) {
    //     meetingRoom.setCreatorId(creatorId);
    //     if (meetingRoomMapper.insertOrUpdate(meetingRoom)) {
    //         return meetingRoom.getMeetingRoomId();
    //     }
    //     return null;
    // }

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
    public boolean selectMeetingRoom(Integer meetingRoomId, String customerId, String employeeId) {
        MeetingRoomSelection meetingRoomSelection = new MeetingRoomSelection();
        meetingRoomSelection.setMeetingRoomId(meetingRoomId);
        meetingRoomSelection.setCustomerId(customerId);
        meetingRoomSelection.setEmployeeId(employeeId);
        meetingRoomSelection.setScore(0.0);
        return meetingRoomSelectionMapper.insert(meetingRoomSelection) > 0;
    }

    /**
     * 顾客退选会议室
     *
     * @param meetingRoomSelection 选课信息（包含会议室ID、顾客ID和员工ID）
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
     * @param meetingRoomSelection 选课信息（包含会议室ID、顾客ID、员工ID和成绩）
     * @return 是否更新成功
     */
    @Override
    public boolean updateScore(MeetingRoomSelection meetingRoomSelection) {
        return meetingRoomSelectionMapper.update(meetingRoomSelection,
                new LambdaQueryWrapper<MeetingRoomSelection>()
                        .eq(MeetingRoomSelection::getMeetingRoomId, meetingRoomSelection.getMeetingRoomId())
                        .eq(MeetingRoomSelection::getCustomerId, meetingRoomSelection.getCustomerId())
                        .eq(MeetingRoomSelection::getEmployeeId, meetingRoomSelection.getEmployeeId())) > 0;
    }


    @Override
    public List<String> getMeetingRoomEmployeesByMeetingRoomId(Integer meetingRoomId) {
        return meetingRoomEmployeeMapper.selectList(
                new LambdaQueryWrapper<MeetingRoomEmployee>()
                        .select(MeetingRoomEmployee::getUserId)
                        .eq(MeetingRoomEmployee::getMeetingRoomId, meetingRoomId)
        ).stream().map(MeetingRoomEmployee::getUserId).toList();
    }

    @Override
    public MeetingRoomWithEmployeeView getEmployeeMeetingRoomDetail(String employeeId, Integer meetingRoomId) {
        return meetingRoomWithEmployeeViewMapper.selectOne(
                new LambdaQueryWrapper<MeetingRoomWithEmployeeView>()
                        .eq(MeetingRoomWithEmployeeView::getEmployeeId, employeeId)
                        .eq(MeetingRoomWithEmployeeView::getMeetingRoomId, meetingRoomId));
    }

    @Override
    public Page<MeetingRoomWithEmployeeView> getMeetingRoomWithEmployeesByEmployeeId(String employeeId, long current, long size) {
        Page<MeetingRoomWithEmployeeView> page = new Page<>(current, size);
        return meetingRoomWithEmployeeViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomWithEmployeeView>().eq(MeetingRoomWithEmployeeView::getEmployeeId, employeeId));
    }

    @Override
    public Page<MeetingRoomSelectView> getCustomerMeetingRoomSelections(String customerId, long current, long size) {
        Page<MeetingRoomSelectView> page = new Page<>(current, size);
        return meetingRoomSelectViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomSelectView>().eq(MeetingRoomSelectView::getCustomerId, customerId));
    }

    @Override
    public Page<MeetingRoomSelectView> getMeetingRoomCustomers(Integer meetingRoomId, String employeeId, long current, long size) {
        Page<MeetingRoomSelectView> page = new Page<>(current, size);
        return meetingRoomSelectViewMapper.selectPage(page,
                new LambdaQueryWrapper<MeetingRoomSelectView>().eq(MeetingRoomSelectView::getMeetingRoomId, meetingRoomId)
                        .eq(MeetingRoomSelectView::getEmployeeId, employeeId));
    }

    @Override
    public boolean setMeetingRoomScore(Integer meetingRoomId, String employeeId, String customerId, Double score) {
        MeetingRoomSelection meetingRoomSelection = new MeetingRoomSelection();
        meetingRoomSelection.setMeetingRoomId(meetingRoomId);
        meetingRoomSelection.setEmployeeId(employeeId);
        meetingRoomSelection.setCustomerId(customerId);
        meetingRoomSelection.setScore(score);

        return meetingRoomSelectionMapper.update(meetingRoomSelection,
                new LambdaQueryWrapper<MeetingRoomSelection>()
                        .eq(MeetingRoomSelection::getMeetingRoomId, meetingRoomId)
                        .eq(MeetingRoomSelection::getEmployeeId, employeeId)
                        .eq(MeetingRoomSelection::getCustomerId, customerId)) > 0;
    }
}