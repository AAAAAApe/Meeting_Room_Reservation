<template>
  <div>
    <el-form :inline="true" :model="queryForm" class="query-form" @submit.native.prevent="handleQuery">
      <el-form-item label="会议室ID">
        <el-input v-model="queryForm.meetingRoomId" placeholder="会议室ID" />
      </el-form-item>
      <el-form-item label="用户ID">
        <el-input v-model="queryForm.customerId" placeholder="用户ID" />
      </el-form-item>
      <el-form-item label="订单状态">
        <el-select v-model="queryForm.status" placeholder="请选择状态" style="width: 120px">
          <el-option label="全部" value="" />
          <el-option label="待支付" value="pending_payment" />
          <el-option label="已确认" value="confirmed" />
          <el-option label="使用中" value="in_use" />
          <el-option label="已取消" value="cancelled" />
        </el-select>
      </el-form-item>
      <el-form-item label="开始时间">
        <el-date-picker
            v-model="queryForm.startTime"
            type="datetime"
            placeholder="开始时间"
            style="width: 180px"
        />
      </el-form-item>
      <el-form-item label="结束时间">
        <el-date-picker
            v-model="queryForm.endTime"
            type="datetime"
            placeholder="结束时间"
            style="width: 180px"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="handleQuery">查询</el-button>
        <el-button @click="resetForm">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table :data="orderList" stripe style="width: 100%; margin-top: 20px">
      <el-table-column prop="id" label="订单ID" width="80" />
      <el-table-column prop="meetingRoomId" label="会议室ID" width="100" />
      <el-table-column prop="customerId" label="用户ID" width="120" />
      <el-table-column prop="status" label="状态" width="100" />
      <el-table-column prop="startTime" label="开始时间" width="180" />
      <el-table-column prop="endTime" label="结束时间" width="180" />
      <!-- 你可以根据实际需求添加更多字段 -->
    </el-table>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import axios from 'axios'

// 查询表单数据
const queryForm = ref({
  meetingRoomId: '',
  customerId: '',
  status: '',
  startTime: null,
  endTime: null
})

const orderList = ref([])

const handleQuery = async () => {
  try {
    // 格式化时间（如果后端需要字符串格式可自行调整）
    const params = {
      ...queryForm.value,
      startTime: queryForm.value.startTime
          ? new Date(queryForm.value.startTime).toISOString()
          : undefined,
      endTime: queryForm.value.endTime
          ? new Date(queryForm.value.endTime).toISOString()
          : undefined
    }
    const { data } = await axios.get('/employee/query', {})
    orderList.value = data
  } catch (err) {
    ElMessage.error('查询失败，请稍后重试')

  }
}

const resetForm = () => {
  queryForm.value = {
    meetingRoomId: '',
    customerId: '',
    status: '',
    startTime: null,
    endTime: null
  }
  orderList.value = []
}
</script>

<style scoped>
.query-form {
  margin-bottom: 20px;
}
</style>
32