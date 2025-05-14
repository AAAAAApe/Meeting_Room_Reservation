/**
 * 会议室相关API
 */
import request from '../../utils/http/request';
import type { MeetingRoomAssignment, MeetingRoomInfo, MeetingRoomPublishInfo, MeetingRoomWithEmployeeInfo, PaginationParams, PaginationResult, CustomerMeetingRoomSelection } from '../types';

/**
 * 会议室API服务
 */
const meetingRoomService = {
  /**
   * 获取会议室列表
   * @param params 分页参数
   * @returns Promise
   */
  getMeetingRoomList(params: PaginationParams, departmentIds?: string[]) {
    return request.get<PaginationResult<MeetingRoomInfo>>('/meetingRoom/getPage', { ...params, departmentIds });
  },

  getMeetingRoomWithEmployees(params: PaginationParams, meetingRoomId: number) {
    return request.get<PaginationResult<MeetingRoomWithEmployeeInfo>>(`/meetingRoom/${meetingRoomId}`, { ...params });
  },

  /**
   * 发布会议室
   * @param meetingRoom 会议室发布信息
   * @returns Promise<number> 返回会议室ID
   */
  publishMeetingRoom(meetingRoom: MeetingRoomPublishInfo) {
    return request.post<number>('/meetingRoom/createOrUpdate', meetingRoom);
  },

  /**
   * 删除会议室
   * @param meetingRoomId 会议室ID
   * @returns Promise
   */
  deleteMeetingRoom(meetingRoomId: string) {
    return request.delete<void>(`/meetingRooms/${meetingRoomId}`);
  },

  /**
   * 顾客选会议室
   * @param meetingRoomId 会议室ID
   * @returns Promise
   */
  enrollMeetingRoom(meetingRoomId: string) {
    return request.post<void>(`/customer/meetingRooms/${meetingRoomId}/enroll`);
  },

  /**
   * 顾客退会议室
   * @param meetingRoomId 会议室ID
   * @returns Promise
   */
  dropMeetingRoom(meetingRoomId: string) {
    return request.post<void>(`/customer/meetingRooms/${meetingRoomId}/drop`);
  },

  /**
   * 获取顾客已选会议室
   * @returns Promise
   */
  getCustomerMeetingRooms() {
    return request.get<MeetingRoomInfo[]>('/customer/meetingRooms');
  },

  getEmployeeIdsByMeetingRoomId(meetingRoomId: number) {
    return request.get<string[]>(`/meetingRoom/${meetingRoomId}/employeeIds`);
  },

  selectMeetingRoom(meetingRoomId: number, employeeId: string) {
    return request.post<boolean>('/meetingRoom/select', { meetingRoomId, employeeId });
  },

  getMeetingRoomAssignments(meetingRoomId: number, employeeId: string , params: PaginationParams) {
    return request.get<PaginationResult<MeetingRoomAssignment>>(`/meetingRoom/${meetingRoomId}/assignment/getPage`, {...params, employeeId });
  },

  getCustomerMeetingRoomSelections(params: PaginationParams) {
    return request.get<PaginationResult<CustomerMeetingRoomSelection>>('/customer/meetingRoom/getPage', {...params });
  },

  getMeetingRoomCustomers(meetingRoomId: number, employeeId: string, params: PaginationParams) {
    return request.get<PaginationResult<CustomerMeetingRoomSelection>>(`/meetingRoom/${meetingRoomId}/customers/getPage`, {...params, employeeId });
  },

  setMeetingRoomScore(meetingRoomId: number, employeeId: string, customerId: string, score: number) {
    return request.put<void>(`/meetingRoom/${meetingRoomId}/${customerId}/score?employeeId=${employeeId}&score=${score}`, {});
  },
  reserve: (data: {
    meetingRoomId: number,
    startTime: string,
    endTime: string
  }) => {
    return request.post('/meetingRoom/reverse', data)
  },

  cancelReservation: (data: { meetingRoomId: number }) => {
    return request.put('/cancelRequest/apply', data);
  },
};

export default meetingRoomService;