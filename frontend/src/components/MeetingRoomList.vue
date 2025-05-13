<script setup lang="ts">
import { computed, ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { meetingRoomService, departmentService } from '../api/index';
import type { MeetingRoomInfo, PaginationParams } from '../api/types';
import MeetingRoomWithEmployeesList from './MeetingRoomWithEmployeesList.vue';
import MeetingRoomEditor from './MeetingRoomEditor.vue';
import { useUserStore } from '../stores/userStore';

const userStore = useUserStore();
const userRole = computed(() => userStore.user?.roleName || '');

// 存储会议室列表数据，用于表格展示
const meetingRoomList = ref<MeetingRoomInfo[]>([]);

// 存储用户选择的院系ID数组，用于筛选会议室
const departmentsSelected = ref([]);

// 翻页时携带参数，作用是提交筛选后，翻页时保留筛选条件
let departmentIdsParams: string[] = [];

// 获取院系列表数据，用于下拉筛选框
// 使用vue-hooks-plus的useRequest自动处理请求状态
const { data: departmentList } = useRequest(
  departmentService.getDepartmentList,
);

// 分页参数配置
// current: 当前页码
// size: 每页显示数量
// total: 总记录数
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
const { run: fetchMeetingRoomList, loading } = useRequest(
  meetingRoomService.getMeetingRoomList,
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
// current: 新的页码
const handleCurrentChange = (current: number) => {
  params.value.current = current;
  fetchMeetingRoomList(params.value, departmentIdsParams);
};

// 处理院系筛选变化事件
// 当用户点击确认按钮时触发
const handleDepartmentChange = () => {
  departmentIdsParams = departmentsSelected.value;
  // 重置页码为1并重新获取数据
  fetchMeetingRoomList({
    current: 1,
    size: pagination.value.size
  },
    departmentsSelected.value);
};

const showEditor = ref(false);
const showEmployeeList = ref(false);
const currentMeetingRoomId = ref<number | null>(null);
const currentMeetingRoom = ref<MeetingRoomInfo | undefined>();

const handleMeetingRoomEmployeeList = (meetingRoom: MeetingRoomInfo) => {
  showEmployeeList.value = true;
  currentMeetingRoomId.value = meetingRoom.meetingRoomId;
}

const handleEditMeetingRoom = (meetingRoom?: MeetingRoomInfo) => {
  currentMeetingRoom.value = meetingRoom;
  showEditor.value = true;
}

const handleEditorSuccess = () => {
  fetchMeetingRoomList(params.value, departmentIdsParams);
}
</script>

<template>
  <el-container class="main-container">
    <!-- 会议室编辑器弹窗 -->
    <el-dialog :title="currentMeetingRoom ? '编辑会议室' : '发布会议室'" width="95%" align-center v-model="showEditor" destroy-on-close>
      <MeetingRoomEditor
        :meetingRoom="currentMeetingRoom"
        @success="handleEditorSuccess"
        @close="showEditor = false"
      />
    </el-dialog>

    <!-- 查看员工列表弹窗 -->
    <el-dialog v-model="showEmployeeList" title="会议室员工列表" align-center width="1000px" destroy-on-close>
      <MeetingRoomWithEmployeesList v-if="currentMeetingRoomId" :meetingRoomId="currentMeetingRoomId" />
    </el-dialog>

    <el-header class="main-header">
      <div class="title-container">
        <h2>会议室列表</h2>
        &nbsp;记录数：{{ pagination.total }}
      </div>
      <div class="tool-bar">
        <!-- 院系筛选 多选下拉框 -->
        <el-select class="dp-selector" v-model="departmentsSelected" placeholder="院系筛选" multiple collapse-tags
          collapse-tags-tooltip>
          <el-option v-for="item in departmentList?.data" :key="item.departmentId" :label="item.departmentName"
            :value="item.departmentId" />
        </el-select>
        <!-- 确认按钮 -->
        <el-button type="success" plain @click="handleDepartmentChange">搜索</el-button>
        <el-divider v-if="userRole === 'admin'" direction="vertical" />
        <el-button v-if="userRole === 'admin'" type="primary" plain @click="handleEditMeetingRoom()">发布会议室</el-button>
      </div>
    </el-header>
    <el-main class="table-container">
      <el-table class="table-content" :data="meetingRoomList" border stripe v-loading="loading">
        <el-table-column label="会议室编号" prop="meetingRoomId" width="100px">
          <template #default="scope">
            {{ String(scope.row.meetingRoomId).padStart(6, '0') }}
          </template>
        </el-table-column>
        <el-table-column label="所属院系" prop="departmentName" />
        <el-table-column label="会议室名称" prop="meetingRoomName" />
        <el-table-column label="会议室学分" prop="credit" width="100px">
          <template #default="scope">
            {{ scope.row.credit.toFixed(1) }}
          </template>
        </el-table-column>
        <el-table-column label="会议室简介" prop="description" show-overflow-tooltip />
        <el-table-column label="创建者" prop="creatorName" width="150px">
          <template #default="scope">
            {{ scope.row.creatorName || scope.row.creatorId }}
          </template>
        </el-table-column>
        <el-table-column label="员工人数" prop="employeeCount" width="100px" />
        <el-table-column fixed="right" label="操作">
          <template #default="scope">
            <el-button type="primary" plain size="small" @click="handleMeetingRoomEmployeeList(scope.row)">查看员工</el-button>
            <el-button v-if="userRole === 'admin'" type="warning" plain size="small" @click="handleEditMeetingRoom(scope.row)">编辑</el-button>
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

    .tool-bar {
      height: 100%;
      display: flex;
      align-items: center;

      .dp-selector {
        width: 240px;
        margin-right: 10px;
      }
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