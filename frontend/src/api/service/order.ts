import { request } from '@/utils/http';

// 查询员工下所有会议室预约订单
export function fetchEmployeeMeetingRoomOrders(params = {}) {
    return request.get('/order/employee/query', { params });
}