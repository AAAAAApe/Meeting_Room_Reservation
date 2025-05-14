<script setup lang="ts">
import { useRequest } from 'vue-hooks-plus';
import { meetingRoomService, type MeetingRoomAssignment, type MeetingRoomWithEmployeeInfo, type PaginationParams, type CustomerMeetingRoomSelection } from '../api';
import { ref } from 'vue';
import { ElMessage } from 'element-plus';
import { useUserStore } from '../stores/userStore';

const userStore = useUserStore();

const props = defineProps<{
    meetingRoomId: number,
    employeeId: string
}>();
const meetingRoomDetail = ref<MeetingRoomWithEmployeeInfo>();
const { } = useRequest(
    meetingRoomService.getEmployeeMeetingRoomDetail,
    {
        defaultParams: [props.meetingRoomId, props.employeeId],
        onSuccess: response => {
            meetingRoomDetail.value = response.data;
        },
    }
);

// 作业列表相关
const assignmentPagination = ref({
    current: 1,
    size: 16,
    total: 0
});
const assignmentParams = ref<PaginationParams>({
    current: assignmentPagination.value.current,
    size: assignmentPagination.value.size,
});
const assignments = ref<MeetingRoomAssignment[]>();
const { run: fetchAssignmentList, loading: assignmentLoading } = useRequest(
    meetingRoomService.getMeetingRoomAssignments,
    {
        defaultParams: [props.meetingRoomId, props.employeeId, assignmentParams.value],
        onSuccess: response => {
            assignments.value = response.data.records;
            assignmentPagination.value.current = response.data.current;
            assignmentPagination.value.total = response.data.total;
            assignmentPagination.value.size = response.data.size;
        },
    }
);

// 顾客列表相关
const customerPagination = ref({
    current: 1,
    size: 16,
    total: 0
});
const customerParams = ref<PaginationParams>({
    current: customerPagination.value.current,
    size: customerPagination.value.size,
});
const customers = ref<CustomerMeetingRoomSelection[]>();
const { run: fetchCustomerList, loading: customerLoading } = useRequest(
    meetingRoomService.getMeetingRoomCustomers,
    {
        defaultParams: [props.meetingRoomId, props.employeeId, customerParams.value],
        onSuccess: response => {
            customers.value = response.data.records;
            customerPagination.value.current = response.data.current;
            customerPagination.value.total = response.data.total;
            customerPagination.value.size = response.data.size;
        },
    }
);

// 成绩编辑相关
const isEditingScores = ref(false);
const savingScores = ref(false);

// 切换编辑模式
const toggleEditMode = () => {
    isEditingScores.value = !isEditingScores.value;
};

// 保存顾客成绩
const saveCustomerScore = async (customerId: string, score: number) => {
    try {
        savingScores.value = true;
        await meetingRoomService.setMeetingRoomScore(props.meetingRoomId, props.employeeId, customerId, score);
        ElMessage.success('成绩保存成功');
    } catch (error) {
        console.error('保存成绩失败:', error);
        ElMessage.error('保存成绩失败');
    } finally {
        savingScores.value = false;
    }
};


// 状态标签类型映射
const statusTagType = (status: string) => {
  switch (status) {
    case 'available': return 'success'
    case 'locked': return 'danger'
    case 'reserved': return 'warning'
    case 'in_use': return ''
    case 'maintenance': return 'info'
    default: return 'info'
  }
}
const formatStatus = (status: string) => {
  const statusMap: Record<string, string> = {
    available: '可用',
    locked: '锁定',
    reserved: '已预订',
    in_use: '使用中',
    maintenance: '维护中'
  }
  return statusMap[status] || status
}
</script>

<template>
    <div>
        <el-container class="main-container">
            <el-header class="main-header">
                <div class="title-container">
                    <h2>会议室详情</h2>
                </div>
            </el-header>
            <el-main class="main-content">
              <el-descriptions v-if="meetingRoomDetail" :column="2" border>
                <el-descriptions-item label="会议室编号">
                  {{ String(meetingRoomDetail.meetingRoomId).padStart(6, '0') }}
                </el-descriptions-item>
                <el-descriptions-item label="所属院系">
                  {{ meetingRoomDetail.departmentName }}
                </el-descriptions-item>
                <el-descriptions-item label="会议室名称">
                  {{ meetingRoomDetail.meetingRoomName }}
                </el-descriptions-item>
                <el-descriptions-item label="每小时价格">
                  {{ meetingRoomDetail.pricePerHour.toFixed(1) }}
                </el-descriptions-item>
                <el-descriptions-item label="容量">
                  {{ meetingRoomDetail.capacity }} 人
                </el-descriptions-item>
                <el-descriptions-item label="类型">
                  {{ meetingRoomDetail.type === 'classroom' ? '教室' : '圆桌会议室' }}
                </el-descriptions-item>
                <el-descriptions-item label="状态">
                  <el-tag :type="statusTagType(meetingRoomDetail.status)">
                    {{ formatStatus(meetingRoomDetail.status) }}
                  </el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="设备配置">
                  <div class="equipment-config">
                    <el-tag v-if="meetingRoomDetail.hasProjector" type="info">投影仪</el-tag>
                    <el-tag v-if="meetingRoomDetail.hasAudio" type="info">音响</el-tag>
                    <el-tag v-if="meetingRoomDetail.hasNetwork" type="info">网络</el-tag>
                    <span v-if="!meetingRoomDetail.hasProjector &&
                                      !meetingRoomDetail.hasAudio &&
                                      !meetingRoomDetail.hasNetwork">无</span>
                  </div>
                </el-descriptions-item>
                <el-descriptions-item label="会议室简介" :span="2">
                  {{ meetingRoomDetail.description }}
                </el-descriptions-item>
                <el-descriptions-item label="顾客人数">
                  {{ meetingRoomDetail.customerCount }}
                </el-descriptions-item>
                <el-descriptions-item label="创建者">
                  {{ meetingRoomDetail.creatorName || meetingRoomDetail.creatorId }}
                </el-descriptions-item>
              </el-descriptions>

                <div class="content-container">
                    <div class="assignments-section">
                        <h3>作业列表</h3>
                        <el-table :data="assignments" border stripe v-loading="assignmentLoading">
                            <el-table-column label="作业标题" prop="assignmentTitle"></el-table-column>
                            <el-table-column label="截止时间" prop="submissionDeadline">
                                <template #default="{ row }">
                                    {{ new Date(row.submissionDeadline).toLocaleString() }}
                                </template>
                            </el-table-column>
                            <el-table-column label="作业内容" prop="content" show-overflow-tooltip></el-table-column>
                            <el-table-column label="提交链接" prop="submissionUrl">
                                <template #default="{ row }">
                                    <el-link v-if="row.submissionUrl" type="primary" :href="row.submissionUrl" target="_blank">查看</el-link>
                                    <span v-else>-</span>
                                </template>
                            </el-table-column>
                            <el-table-column label="成绩" prop="grade">
                                <template #default="{ row }">
                                    <el-tag v-if="row.grade" :type="row.grade === 'A' || row.grade === 'B' ? 'success' : row.grade === 'C' ? 'warning' : 'danger'">
                                        {{ row.grade }}
                                    </el-tag>
                                    <span v-else>-</span>
                                </template>
                            </el-table-column>
                        </el-table>
                        <el-pagination class="pagination" background layout="prev, pager, next" :total="assignmentPagination.total"
                            :current-page="assignmentPagination.current" :page-size="assignmentPagination.size" @current-change="(current: number) => {
                                assignmentParams.current = current;
                                fetchAssignmentList(meetingRoomId, employeeId, assignmentParams);
                            }" />
                    </div>

                    <div class="customers-section" v-if="userStore.user?.roleName === 'employee'">
                        <div class="section-header">
                            <h3>顾客列表</h3>
                            <el-button 
                                type="primary" 
                                size="small" 
                                @click="toggleEditMode"
                            >
                                {{ isEditingScores ? '完成' : '编辑成绩' }}
                            </el-button>
                        </div>
                        <el-table :data="customers" border stripe v-loading="customerLoading || savingScores">
                            <el-table-column label="学号" prop="customerId"></el-table-column>
                            <el-table-column label="姓名" prop="customerName"></el-table-column>
                            <el-table-column label="选会议室时间" prop="selectionTime">
                                <template #default="{ row }">
                                    {{ new Date(row.selectionTime).toLocaleString() }}
                                </template>
                            </el-table-column>
                            <el-table-column label="成绩" prop="score">
                                <template #default="{ row }">
                                    <template v-if="isEditingScores">
                                        <el-input-number 
                                            v-model="row.score" 
                                            :min="0" 
                                            :max="100" 
                                            size="small"
                                            @change="(value) => saveCustomerScore(row.customerId, value)"
                                        ></el-input-number>
                                    </template>
                                    <span v-else>{{ row.score || '-' }}</span>
                                </template>
                            </el-table-column>
                        </el-table>
                        <el-pagination class="pagination" background layout="prev, pager, next" :total="customerPagination.total"
                            :current-page="customerPagination.current" :page-size="customerPagination.size" @current-change="(current: number) => {
                                customerParams.current = current;
                                fetchCustomerList(meetingRoomId, employeeId, customerParams);
                            }" />
                    </div>
                </div>
            </el-main>
        </el-container>
    </div>
</template>

<style lang="scss" scoped>
.main-container {
    height: 100%;

    .main-header {
        height: $main-content-header-footer-height;
        background-color: #f5f7fa;
        padding: 0 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;

        .title-container {
            height: 100%;
            display: flex;
            align-items: center;
        }
    }

    .main-content {
        padding: 20px;
        overflow: auto;

        .content-container {
            margin-top: 20px;
            display: flex;
            gap: 20px;

            .assignments-section, .customers-section {
                flex: 1;
                min-width: 0;
                
                .section-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 16px;
                    
                    h3 {
                        margin: 0;
                    }
                }

                .pagination {
                    margin-top: 16px;
                    display: flex;
                    justify-content: center;
                }
            }
        }
    }
}
</style>