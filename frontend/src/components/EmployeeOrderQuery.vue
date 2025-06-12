<template>
  <div>
    <el-form :inline="true" :model="queryForm" class="query-form" @submit.native.prevent="handleQuery">
      <el-form-item label="订单ID">
        <el-input v-model="queryForm.id" placeholder="订单ID" />
      </el-form-item>
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
      <el-form-item>
        <el-button type="primary" @click="handleQuery">查询</el-button>
        <el-button @click="resetForm">重置</el-button>
      </el-form-item>
    </el-form>

    <el-table :data="orderList" stripe style="width: 100%; margin-top: 20px">
      <el-table-column prop="id" label="订单ID" width="80" />
      <el-table-column prop="meetingRoomId" label="会议室ID" width="100" />
      <el-table-column prop="customerId" label="用户ID" width="120" />
      <el-table-column prop="selectionTime" label="选定时间" width="180" />
      <el-table-column prop="startTime" label="开始时间" width="180" />
      <el-table-column prop="endTime" label="结束时间" width="180" />
      <el-table-column prop="attendeesCount" label="人数" width="80" />
      <el-table-column prop="status" label="状态" width="100" />
      <el-table-column prop="totalPrice" label="总价" width="100" />
      <el-table-column prop="paymentStatus" label="支付状态" width="100" />
      <el-table-column prop="paymentTime" label="支付时间" width="180" />
      <el-table-column prop="cancellationTime" label="取消时间" width="180" />
      <el-table-column prop="refundAmount" label="退款金额" width="100" />
      <el-table-column prop="createdAt" label="创建时间" width="180" />
      <el-table-column prop="updatedAt" label="更新时间" width="180" />
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { meetingRoomService } from '@/api/index'

const queryForm = ref({
  id: '',
  meetingRoomId: '',
  customerId: '',
  status: ''
})

const allOrders = ref([]) // 全部订单
const orderList = ref([]) // 显示的订单

const fetchAllOrders = async () => {
  try {
    const response = await meetingRoomService.fetchAllOrders()
    allOrders.value = response.data
    orderList.value = response.data // 初始显示所有
  } catch (e) {
    ElMessage.error('获取全部订单失败')
    allOrders.value = []
    orderList.value = []
  }
}

const handleQuery = () => {
  if (
      !queryForm.value.id &&
      !queryForm.value.meetingRoomId &&
      !queryForm.value.customerId &&
      !queryForm.value.status
  ) {
    ElMessage.warning('请至少填写一个查询条件')
    return
  }
  orderList.value = allOrders.value.filter(order =>
      (!queryForm.value.id || String(order.id).includes(queryForm.value.id)) &&
      (!queryForm.value.meetingRoomId || String(order.meetingRoomId).includes(queryForm.value.meetingRoomId)) &&
      (!queryForm.value.customerId || String(order.customerId).includes(queryForm.value.customerId)) &&
      (!queryForm.value.status || order.status === queryForm.value.status)
  )
}

const resetForm = () => {
  queryForm.value = { id: '', meetingRoomId: '', customerId: '', status: '' }
  orderList.value = allOrders.value
}

onMounted(fetchAllOrders)
</script>

<style scoped>
.query-form {
  margin-bottom: 20px;
}
</style>