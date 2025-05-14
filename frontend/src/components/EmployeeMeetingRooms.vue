<script setup lang="ts">
import { ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { meetingRoomService } from '../api/index';
import type { MeetingRoomWithEmployeeInfo, PaginationParams } from '../api/types';
import MeetingRoomDetail from './MeetingRoomDetail.vue';
import {ElMessage, ElMessageBox} from "element-plus";

// 存储会议室列表数据，用于表格展示
const meetingRoomList = ref<MeetingRoomWithEmployeeInfo[]>([]);

// 分页参数配置
const pagination = ref({
  current: 1,
  size: 16,
  total: 0
});

// 请求参数，初始值与分页参数同步
const params = ref<PaginationParams>({
  current: pagination.value.current,
  size: pagination.value.size,
});

// 获取会议室列表数据
const { run: fetchEmployeeMeetingRooms, loading } = useRequest(
  meetingRoomService.getCustomerMeetingRoomSelections,
  {
    // 请求成功回调
    onSuccess: data => {
      // 更新会议室列表数据
      meetingRoomList.value = data.data.records;
      // 更新分页信息
      pagination.value.current = data.data.current;
      pagination.value.total = data.data.total;
      pagination.value.size = data.data.size;
    },
  }
);

// 处理分页变化事件
const handleCurrentChange = (current: number) => {
  params.value.current = current;
  fetchEmployeeMeetingRooms(params.value);
};

const showDetailDialog = ref(false);
const selectedMeetingRoom = ref<MeetingRoomWithEmployeeInfo>();

const handleCancelReservation = async (room: MeetingRoomWithEmployeeInfo) => {
  const confirmed = await ElMessageBox.confirm(
      '确定取消预约？需提前24小时申请，审核通过后将执行退款。',
      '取消预约确认',
      {
        confirmButtonText: '确认取消',
        cancelButtonText: '我再想想',
        type: 'warning'
      }
  ).catch(() => false)

  if (!confirmed) return;

  try {
    await meetingRoomService.cancelReservation({ meetingRoomId: room.meetingRoomId })
    ElMessage.success('已提交取消申请，等待审核')
  } catch (e) {
    ElMessage.error('提交失败，请稍后重试')
  }
}
const handleShowDetail = (meetingRoom: MeetingRoomWithEmployeeInfo) => {
  selectedMeetingRoom.value = meetingRoom;
  showDetailDialog.value = true;
};
</script>

<template>
  <el-container class="main-container">
    <el-dialog v-model="showDetailDialog" width="90%" destroy-on-close>
      <MeetingRoomDetail v-if="selectedMeetingRoom" :meetingRoomId="selectedMeetingRoom.meetingRoomId" :employeeId="selectedMeetingRoom.employeeId" />
    </el-dialog>
    <el-header class="main-header">
      <div class="title-container">
        <h2>我的会议室</h2>
      </div>
    </el-header>
    <el-main class="table-container">
      <el-table class="table-content" :data="meetingRoomList" border stripe v-loading="loading">
        <el-table-column label="会议室编号" prop="meetingRoomId" width="100px">
          <template #default="scope">
            {{ String(scope.row.meetingRoomId).padStart(6, '0') }}
          </template>
        </el-table-column>
        <el-table-column label="所属院系" prop="departmentName">
        </el-table-column>
        <el-table-column label="会议室名称" prop="meetingRoomName">
        </el-table-column>
        <el-table-column label="会议室学分" prop="pricePerHour" width="100px">
          <template #default="scope">
            {{ scope.row.pricePerHour.toFixed(1) }}
          </template>
        </el-table-column>
        <el-table-column label="会议室简介" prop="description" show-overflow-tooltip>
        </el-table-column>
        <el-table-column label="顾客人数" prop="customerCount">
        </el-table-column>
        <el-table-column label="创建者" prop="creatorName" width="150px">
          <template #default="scope">
            {{ scope.row.creatorName || scope.row.creatorId }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200px">
          <template #default="scope">
            <el-button type="primary" size="small" @click="handleShowDetail(scope.row)">查看详情</el-button>
            <el-button
                type="danger"
                size="small"
                @click="handleCancelReservation(scope.row)"
            >
              取消预约
            </el-button>
          </template>
        </el-table-column>

      </el-table>
    </el-main>
    <el-footer class="main-footer">
      <el-pagination class="pagination" background layout="prev, pager, next" :total="pagination.total"
        :current-page="pagination.current" :page-size="pagination.size" @current-change="handleCurrentChange" />
    </el-footer>
  </el-container>
</template>

<style lang="scss" scoped>
.main-container {
  height: 1px;

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

  .table-container {
    height: calc(100% - 2 * $main-content-header-footer-height);
    overflow: auto;
    padding: 20px;

    .table-content {
      height: 100%;
    }
  }

  .main-footer {
    height: $main-content-header-footer-height;
    background-color: #f5f7fa;
    padding: 0 20px;
    display: flex;
    justify-content: center;
    align-items: center;

    .pagination {
      height: 100%;
    }
  }
}
</style>