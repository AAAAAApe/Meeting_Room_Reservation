<script setup lang="ts">
import { ref } from 'vue';
import { useRequest } from 'vue-hooks-plus';
import type {MeetingRoomInfo, MeetingRoomPublishInfo, PaginationParams} from '../api/types';
import { meetingRoomService } from '../api/index';
import MeetingRoomDetail from './MeetingRoomDetail.vue';
import {ElMessage} from "element-plus";

// 会议室列表
const meetingRoomList = ref<MeetingRoomInfo[]>([]);

// 分页参数
const pagination = ref({
  current: 1,
  size: 16,
  total: 0,
});

// 请求参数
const params = ref<PaginationParams>({
  current: pagination.value.current,
  size: pagination.value.size,
});

// 请求数据
const { run: fetchMeetingRooms, loading } = useRequest(
    meetingRoomService.getMeetingRoomList, // 假设你有这个 API 方法
    {
      onSuccess: data => {
        meetingRoomList.value = data.data.records;
        pagination.value.current = data.data.current;
        pagination.value.total = data.data.total;
        pagination.value.size = data.data.size;
      },
      manual: true, // 不自动执行
    }
);

// 分页变化
const handleCurrentChange = (current: number) => {
  params.value.current = current;
  fetchMeetingRooms(params.value);
};

// 查看详情逻辑
const showDetailDialog = ref(false);
const selectedMeetingRoom = ref<MeetingRoomInfo>();

const handleShowDetail = (room: MeetingRoomInfo) => {
  selectedMeetingRoom.value = room;
  showDetailDialog.value = true;
};
const handleStatusChange = async (row: MeetingRoomInfo, newStatus: string) => {
  try {
    // 创建临时更新对象
    const updatePayload = ref<MeetingRoomPublishInfo>({
      meetingRoom: {
        // 保留原有字段
        ...row,
        // 强制转换状态类型
        status: newStatus as 'available' | 'locked' | 'reserved' | 'in_use' | 'maintenance',
      }
    });

    // 调用更新接口
    const response = await meetingRoomService.publishMeetingRoom(updatePayload.value);

    if (response !== null && response !== undefined) {
      ElMessage.success('状态更新成功');
      // 局部更新列表数据（避免全量刷新）
      const index = meetingRoomList.value.findIndex(
          item => item.meetingRoomId === row.meetingRoomId
      );
      if (index !== -1) {
        newStatus as typeof meetingRoomList.value[number]['status'];
      }
    } else {
      ElMessage.error('状态更新失败');
    }
  } catch (error) {
    ElMessage.error('更新状态时发生错误');
    console.error('状态更新错误:', error);
  }
};

// 初始化请求
fetchMeetingRooms(params.value);
</script>

<template>
  <el-container class="main-container">
    <!-- 会议室详情弹窗 -->
    <el-dialog v-model="showDetailDialog" width="90%" destroy-on-close>
      <MeetingRoomDetail
          v-if="selectedMeetingRoom"
          :meetingRoomId="selectedMeetingRoom.meetingRoomId"
      />
    </el-dialog>

    <!-- 页面头部 -->
    <el-header class="main-header">
      <div class="title-container">
        <h2>会议室展示</h2>
      </div>
    </el-header>

    <!-- 表格主体 -->
    <el-main class="table-container">
      <el-table
          class="table-content"
          :data="meetingRoomList"
          border
          stripe
          v-loading="loading"
      >
        <el-table-column label="会议室编号" prop="meetingRoomId" width="120px">
          <template #default="scope">
            {{ String(scope.row.meetingRoomId).padStart(6, '0') }}
          </template>
        </el-table-column>

        <el-table-column label="会议室名称" prop="meetingRoomName" />
        <el-table-column label="元/小时" prop="pricePerHour" width="100px">
          <template #default="scope">
            {{ scope.row.pricePerHour.toFixed(1) }}
          </template>
        </el-table-column>
        <el-table-column label="容纳人数" prop="capacity" width="100px" />
        <el-table-column label="类型" prop="type" width="120px" />
        <el-table-column label="状态" width="120px">
          <template #default="scope">
            <el-table-column label="状态" width="120px">
              <template #default="scope">
                <el-select
                    v-model="scope.row.status"
                    @change="(val) => handleStatusChange(scope.row, val)"
                    size="small"
                    placeholder="选择状态"
                >
                  <el-option label="空闲" value="available" />
                  <el-option label="锁定" value="locked" />
                  <el-option label="预定" value="reserved" />
                  <el-option label="使用中" value="in_use" />
                  <el-option label="维护" value="maintenance" />
                </el-select>
              </template>
            </el-table-column>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="120px">
          <template #default="scope">
            <el-button type="primary" size="small" @click="handleShowDetail(scope.row)">
              查看详情
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-main>

    <!-- 分页 -->
    <el-footer class="main-footer">
      <el-pagination
          class="pagination"
          background
          layout="prev, pager, next"
          :total="pagination.total"
          :current-page="pagination.current"
          :page-size="pagination.size"
          @current-change="handleCurrentChange"
      />
    </el-footer>
  </el-container>
</template>

<style lang="scss" scoped>
.main-container {
  height: 100%;

  .main-header {
    height: 60px;
    background-color: #f5f7fa;
    padding: 0 20px;
    display: flex;
    align-items: center;

    .title-container {
      font-size: 20px;
      font-weight: bold;
    }
  }

  .table-container {
    padding: 20px;
  }

  .main-footer {
    height: 60px;
    background-color: #f5f7fa;
    padding: 0 20px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
}
</style>
