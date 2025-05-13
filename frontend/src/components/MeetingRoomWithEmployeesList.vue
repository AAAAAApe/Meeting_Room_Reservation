<script setup lang="ts">
import { computed, ref, watch } from 'vue';
import { meetingRoomService, type MeetingRoomWithEmployeeInfo } from '../api';
import { useRequest } from 'vue-hooks-plus';
import type { PaginationParams } from '../api/types';
import { useUserStore } from '../stores/userStore';
import { ElMessage, ElMessageBox } from 'element-plus';

const userStore = useUserStore();
const userRole = computed(() => userStore.user?.roleName || '');

const props = defineProps({
    meetingRoomId: {
        type: Number,
        required: true,
    },
})
const pagination = ref({
    current: 1,
    size: 16,
    total: 0
});

const params = ref<PaginationParams>({
    current: pagination.value.current,
    size: pagination.value.size,
});

const meetingRoomWithEmployeeList = ref<MeetingRoomWithEmployeeInfo[]>([])
const { run: fetchMeetingRoomWithEmployeeList, loading } = useRequest(
    meetingRoomService.getMeetingRoomWithEmployees,
    {
        manual: true,
        onSuccess: data => {
            // 更新会议室列表数据
            meetingRoomWithEmployeeList.value = data.data.records;
            // 更新分页信息
            pagination.value.current = data.data.current;
            pagination.value.total = data.data.total;
            pagination.value.size = data.data.size;
        },
    }
)

// 处理分页变化事件
const handleCurrentChange = (current: number) => {
    params.value.current = current;
    fetchMeetingRoomWithEmployeeList(params.value, props.meetingRoomId);
};

// 监听meetingRoomId的变化，当弹窗打开时重新获取数据
watch(() => props.meetingRoomId, (newId) => {
    if (newId) {
        params.value.current = 1; // 重置页码
        meetingRoomWithEmployeeList.value = [];
        fetchMeetingRoomWithEmployeeList(params.value, newId);
    }
}, { immediate: true });

const { run: selectMeetingRoom } = useRequest(
    meetingRoomService.selectMeetingRoom,
    {
        manual: true,
        onSuccess: data => {
            ElMessage.success(data.data ? '选课成功' : '选课失败');
        },
        onError: () => {
            ElMessage.error('选课失败');
        }
    }
)

const handleSelectMeetingRoom = (meetingRoom?: MeetingRoomWithEmployeeInfo) => {
    if (meetingRoom) {
        ElMessageBox.confirm(
            `确认选择会议室：${meetingRoom.meetingRoomName}\n授课员工：${meetingRoom.employeeName}\n员工职称：${meetingRoom.employeeTitleName}\n所属院系：${meetingRoom.employeeDepartmentName}`,
            '选课确认',
            {
                confirmButtonText: '确认',
                cancelButtonText: '取消',
                type: 'info',
            }
        ).then(() => {
            selectMeetingRoom(meetingRoom.meetingRoomId, meetingRoom.employeeId);
        }).catch(() => {
            ElMessage.info('已取消选课');
        });
    } else {
        ElMessage.error('请选择会议室');
    }
}
</script>

<template>
    <div class="meetingRoom-with-employees-list">
        <el-table v-loading="loading" :data="meetingRoomWithEmployeeList" style="width: 100%">
            <el-table-column prop="meetingRoomName" label="会议室名称" />
            <el-table-column prop="employeeName" label="员工姓名" />
            <el-table-column prop="employeeDepartmentName" label="员工所属院系" />
            <el-table-column prop="employeeTitleName" label="员工职称" />
            <el-table-column prop="customerCount" label="顾客人数" />
            <el-table-column fixed="right" label="操作">
                <template #default="scope">
                    <el-button v-if="userRole === 'customer'" type="primary" plain size="small"
                        @click="handleSelectMeetingRoom(scope.row)">选课</el-button>
                </template>
            </el-table-column>
        </el-table>

        <div class="pagination-container" style="margin-top: 20px; text-align: center;">
            <el-pagination v-model:current-page="pagination.current" :page-size="pagination.size"
                :total="pagination.total" @current-change="handleCurrentChange" layout="prev, pager, next" />
        </div>
    </div>
</template>