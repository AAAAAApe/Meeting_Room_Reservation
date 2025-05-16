<template>
  <div>
    <h2>取消申请审批</h2>
    <el-table :data="cancelRequests" border style="width: 100%">
      <el-table-column prop="meetingRoomId" label="会议室ID" />
      <el-table-column prop="customerId" label="顾客ID" />
      <el-table-column prop="requestTime" label="申请时间" />
      <el-table-column prop="status" label="状态" />
      <el-table-column prop="reason" label="理由" />
      <el-table-column label="操作">
        <template #default="{ row }">
          <el-space>
            <el-button type="primary" @click="approveRequest(row.id)">同意</el-button>
            <el-button type="danger" @click="rejectRequest(row.id)">拒绝</el-button>
          </el-space>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import request from '../utils/http/request';
import { ElMessage } from 'element-plus';

interface CancelRequestInfo {
  id: number;
  meetingRoomId: number;
  customerId: string;
  requestTime: string;
  status: string;
  reason?: string;
}

const cancelRequests = ref<CancelRequestInfo[]>([]);

const loadData = async () => {
  const response = await request.get<CancelRequestInfo[]>('/cancelRequest/pending');
  cancelRequests.value = response.data;
};

const approveRequest = async (id: number) => {
  await request.put(`/cancelRequest/${id}/approve`);
  ElMessage.success('已同意取消请求');
  loadData();
};

const rejectRequest = async (id: number) => {
  await request.put(`/cancelRequest/${id}/reject`);
  ElMessage.warning('已拒绝取消请求');
  loadData();
};

onMounted(loadData);
</script>

<style scoped>
h2 {
  margin-bottom: 20px;
}
</style>
