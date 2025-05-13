package com.BookRoom.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.BookRoom.dto.MeetingRoomRequest;
import com.BookRoom.dto.MeetingRoomSelectRequest;
import com.BookRoom.entity.view.MeetingRoomSelectView;
import com.BookRoom.entity.view.MeetingRoomView;
import com.BookRoom.entity.view.MeetingRoomWithEmployeeView;
import com.BookRoom.service.MeetingRoomService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 会议室控制器，处理会议室相关的HTTP请求
 * 包括会议室查询、分页获取等功能
 */
@RestController
public class MeetingRoomController {
    private final MeetingRoomService meetingRoomService;

    /**
     * 构造函数，通过依赖注入初始化服务
     *
     * @param meetingRoomService 会议室服务，处理会议室相关的业务逻辑
     */
    public MeetingRoomController(MeetingRoomService meetingRoomService) {
        this.meetingRoomService = meetingRoomService;
    }

    /**
     * 分页获取所有会议室信息
     * <p>
     * 该方法用于分页获取系统中所有会议室的基本信息。通过MeetingRoomService调用数据访问层，
     * 检索并返回指定页码和每页记录数的会议室记录。支持按院系ID列表筛选会议室。
     *
     * @param current 当前页码，默认为1
     * @param size    每页记录数，默认为16
     * @param departmentIds 院系ID列表，用于筛选特定院系的会议室，为空时获取所有会议室
     * @return 包含分页会议室信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @GetMapping("/meetingRoom/getPage")
    public Page<MeetingRoomView> getAllMeetingRoom(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "16") long size,
            @RequestParam(value = "departmentIds", required = false) List<String> departmentIds) {
        return meetingRoomService.getAllMeetingRoomsByPage(current, size, departmentIds);
    }

    /**
     * 根据会议室ID获取会议室信息及关联的员工信息
     * <p>
     * 该方法用于根据会议室ID获取会议室的基本信息和关联的员工信息。通过MeetingRoomService调用数据访问层，
     * 检索并返回指定会议室ID的会议室记录及其关联的员工信息。支持分页查询。
     *
     * @param current 当前页码，默认为1
     * @param size   每页记录数，默认为16
     * @param meetingRoomId 会议室ID，用于指定需要查询的会议室
     * @return 包含分页会议室信息及员工信息的Page对象，包含总记录数、总页数、当前页数据等信息
     */
    @GetMapping("/meetingRoom/{meetingRoomId}")
    public Page<MeetingRoomWithEmployeeView> getMeetingRoomWithEmployeesByMeetingRoomId(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "16") long size,
            @PathVariable Integer meetingRoomId) {
        return meetingRoomService.getMeetingRoomWithEmployeesByMeetingRoomId(meetingRoomId, current, size);
    }

    /**
     * 创建或更新会议室
     * <p>
     * 该方法用于创建新会议室或更新现有会议室的信息。通过MeetingRoomService调用数据访问层，
     * 将会议室信息和员工关联关系保存到数据库。创建者ID从当前登录用户中获取。
     *
     * @param request HTTP请求对象，用于获取当前登录用户的ID
     * @param meetingRoomRequest 包含会议室信息和员工ID列表的请求对象
     * @return 会议室ID
     */
    @PostMapping("/meetingRoom/createOrUpdate")
    public Integer createOrUpdateMeetingRoom(
            HttpServletRequest request,
            @RequestBody MeetingRoomRequest meetingRoomRequest) {
        String creatorId = (String) request.getAttribute("userId");
        return meetingRoomService.createOrUpdateMeetingRoom(
                meetingRoomRequest.meetingRoom(),
                meetingRoomRequest.employeeIds(),
                creatorId);
    }

    @GetMapping("/meetingRoom/{meetingRoomId}/employeeIds")
    public List<String> getMeetingRoomEmployeesByMeetingRoomId(@PathVariable Integer meetingRoomId) {
        return meetingRoomService.getMeetingRoomEmployeesByMeetingRoomId(meetingRoomId);
    }

    @GetMapping("/employee/meetingRoom/getPage")
    public Page<MeetingRoomWithEmployeeView> getMeetingRoomWithEmployeesByEmployeeId(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "16") long size,
            HttpServletRequest request) {
        String employeeId = (String) request.getAttribute("userId");
        return meetingRoomService.getMeetingRoomWithEmployeesByEmployeeId(employeeId, current, size);
    }

    @GetMapping("/employee/meetingRoom/{meetingRoomId}")
    public MeetingRoomWithEmployeeView getMeetingRoomWithEmployeeByMeetingRoomId(
            @RequestParam(value = "employeeId") String employeeId,
            @PathVariable Integer meetingRoomId) {
        return meetingRoomService.getEmployeeMeetingRoomDetail(employeeId, meetingRoomId);
    }

    @PostMapping("/meetingRoom/select")
    public boolean selectMeetingRoom(
            HttpServletRequest request,
            @RequestBody MeetingRoomSelectRequest meetingRoomSelectRequest
    ) {
        String customerId = (String) request.getAttribute("userId");
        return meetingRoomService.selectMeetingRoom(
            meetingRoomSelectRequest.meetingRoomId(),
            customerId,
            meetingRoomSelectRequest.employeeId()
        );
    }

    @GetMapping("/customer/meetingRoom/getPage")
    public Page<MeetingRoomSelectView> getCustomerMeetingRoomSelections(
            HttpServletRequest request,
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "16") long size) {
        String customerId = (String) request.getAttribute("userId");
        return meetingRoomService.getCustomerMeetingRoomSelections(customerId, current, size);
    }

    @GetMapping("/meetingRoom/{meetingRoomId}/customers/getPage")
    public Page<MeetingRoomSelectView> getMeetingRoomCustomers(
            @RequestParam(value = "current", defaultValue = "1") long current,
            @RequestParam(value = "size", defaultValue = "16") long size,
            @PathVariable Integer meetingRoomId,
            @RequestParam(value = "employeeId") String employeeId
    ) {
        return meetingRoomService.getMeetingRoomCustomers(meetingRoomId, employeeId, current, size);
    }

    @PutMapping("/meetingRoom/{meetingRoomId}/{customerId}/score")
    public boolean setMeetingRoomScore(
            @PathVariable Integer meetingRoomId,
            @PathVariable String customerId,
            @RequestParam(value = "employeeId") String employeeId,
            @RequestParam(value = "score") Double score
    ) {
        return meetingRoomService.setMeetingRoomScore(meetingRoomId, employeeId, customerId, score);
    }
}
