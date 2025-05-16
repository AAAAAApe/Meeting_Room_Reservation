<script setup lang="ts">
import { useRequest } from 'vue-hooks-plus';
import { meetingRoomService, type MeetingRoomInfo, type PaginationParams, type CustomerMeetingRoomSelection } from '../api';
import { ref } from 'vue';

const props = defineProps<{
  meetingRoomId: number;
}>();

const meetingRoomDetail = ref<MeetingRoomInfo>();

// 顾客列表相关
const customerPagination = ref({ current: 1, size: 16, total: 0 });
const customerParams = ref<PaginationParams>({ current: 1, size: 16 });
const customers = ref<CustomerMeetingRoomSelection[]>();
const { run: fetchCustomerList, loading: customerLoading } = useRequest(
    () => meetingRoomService.getMeetingRoomCustomers(props.meetingRoomId, '', customerParams.value),
    {
      onSuccess: response => {
        customers.value = response.data.records;
        Object.assign(customerPagination.value, {
          current: response.data.current,
          total: response.data.total,
          size: response.data.size,
        });
      },
    }
);
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
        </el-descriptions>

        <div class="content-container">

          <div class="customers-section" style="margin-top: 20px;">
            <h3>顾客列表</h3>
            <el-table :data="customers" border stripe v-loading="customerLoading">
              <el-table-column prop="customerId" label="顾客编号" />
              <el-table-column prop="customerName" label="顾客姓名" />
              <el-table-column prop="score" label="评分" />
            </el-table>
          </div>
        </div>
      </el-main>
    </el-container>
  </div>
</template>

<style scoped>
.main-container {
  padding: 16px;
}
.title-container {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.equipment-config {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}
.content-container {
  margin-top: 24px;
}
</style>
