import request from '../../utils/http/request';
import type { department } from '../types';

const departmentService = {
    getDepartmentList() {
        return request.get<department[]>('/department/getAll');
    },
};

export default departmentService;