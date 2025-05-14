<script setup lang="ts">
import { computed, ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { meetingRoomService, departmentService } from '../api/index';
import type { MeetingRoomInfo, PaginationParams } from '../api/types';
import MeetingRoomEditor from './MeetingRoomEditor.vue';
import { useUserStore } from '../stores/userStore';
import dayjs from 'dayjs'
import {ElMessage} from "element-plus"; // 确保安装了 dayjs

const userStore = useUserStore();
const userRole = computed(() => userStore.user?.roleName || '');

// 存储会议室列表数据，用于表格展示
const meetingRoomList = ref<MeetingRoomInfo[]>([]);

// 存储用户选择的院系ID数组，用于筛选会议室
const departmentsSelected = ref([]);

// 翻页时携带参数，作用是提交筛选后，翻页时保留筛选条件
let departmentIdsParams: string[] = [];

// 获取院系列表数据，用于下拉筛选框
const { data: departmentList } = useRequest(
    departmentService.getDepartmentList,
);

const showFilterDialog = ref(false)

// 分页参数配置
const pagination = ref({
  current: 1,
  size: 16,
  total: 0
});

const filterForm = ref({
  date: '',
  startHour: 8,
  endHour: 9,
  attendees: 1,
  hasProjector: false,
  hasAudio: false,
  hasNetwork: false,
  minPrice: null,
  maxPrice: null,
  minCapacity: null
})

const params = ref<PaginationParams>({
  current: pagination.value.current,
  size: pagination.value.size,
});

const { run: fetchMeetingRoomList, loading } = useRequest(
    meetingRoomService.getMeetingRoomList,
    {
      onSuccess: data => {
        meetingRoomList.value = data.data.records;
        pagination.value.current = data.data.current;
        pagination.value.total = data.data.total;
        pagination.value.size = data.data.size;
      },
    }
);

const handleCurrentChange = (current: number) => {
  params.value.current = current;
  fetchMeetingRoomList(params.value, departmentIdsParams);
};

const handleDepartmentChange = () => {
  departmentIdsParams = departmentsSelected.value;
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

// 状态中文显示
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

// 设备图标显示
const formatEquipment = (room: MeetingRoomInfo) => {
  return [
    room.hasProjector ? '投影仪' : null,
    room.hasAudio ? '音响' : null,
    room.hasNetwork ? '网络' : null
  ].filter(Boolean).join(' / ') || '无'
}

// 添加状态
const showTimePicker = ref(false)
const selectedMeetingRoom = ref<MeetingRoomInfo>()

const selectedDate = ref('')
const startHour = ref(8)
const endHour = ref(9)
// 添加处理方法
const handleSelectMeetingRoom = (room: MeetingRoomInfo) => {
  selectedMeetingRoom.value = room
  selectedDate.value = ''
  startHour.value = 8
  endHour.value = 9
  showTimePicker.value = true
}
const handleTimeConfirm = async () => {
  if (startHour.value >= endHour.value) {
    ElMessage.error('开始时间不能晚于结束时间')
    return
  }

  if (!selectedDate.value) {
    ElMessage.error('请选择日期')
    return
  }

  const roomId = selectedMeetingRoom.value?.meetingRoomId
  const userId = userStore.user?.userId
  if (!roomId || !userId) {
    ElMessage.error('用户或会议室信息缺失')
    return
  }

  const formatTime = (date: string | Date, hour: string | number): string => {
    const fullTime = `${dayjs(date).format('YYYY-MM-DD')} ${hour.toString().padStart(2, '0')}:00:00`
    const parsed = dayjs(fullTime)
    if (!parsed.isValid()) {
      throw new Error(`无效时间: ${fullTime}`)
    }
    return parsed.format('YYYY-MM-DD HH:mm:ss')
  }

  const startTime = formatTime(selectedDate.value, startHour.value)
  const endTime = formatTime(selectedDate.value, endHour.value)

  try {
    await meetingRoomService.reserve({
      meetingRoomId: roomId,
      startTime,
      endTime
    })
    ElMessage.success('预订成功')
    showTimePicker.value = false
  } catch (e) {
    ElMessage.error('预订失败')
  }
}

const handleFilterConfirm = async () => {
  const start = filterForm.value.startHour
  const end = filterForm.value.endHour
  if (start >= end) {
    ElMessage.error('开始时间不能晚于结束时间')
    return
  }

  // const time = dayjs(filterForm.value.date).format('YYYY-MM-DD')
  // const startTime = `${time} ${String(start).padStart(2, '0')}:00:00`
  // const endTime = `${time} ${String(end).padStart(2, '0')}:00:00`

  const query = {
    current: 1,
    size: pagination.value.size,
    departmentIds: departmentIdsParams,
    minPrice: filterForm.value.minPrice,
    maxPrice: filterForm.value.maxPrice,
    minCapacity: filterForm.value.minCapacity
    // 如果你后续扩展了 hasProjector/hasAudio/hasNetwork 筛选也可以加
  }

  try {
    const result = await meetingRoomService.getMeetingRoomList(query, departmentIdsParams)
    meetingRoomList.value = result.data.records
    showFilterDialog.value = false
  } catch (e) {
    ElMessage.error('查询失败')
  }
}
</script>

<template>
  <el-container class="main-container">
    <el-dialog :title="currentMeetingRoom ? '编辑会议室' : '发布会议室'" width="95%" align-center v-model="showEditor" destroy-on-close>
      <MeetingRoomEditor
          :meetingRoom="currentMeetingRoom"
          @success="handleEditorSuccess"
          @close="showEditor = false"
      />
    </el-dialog>

    <el-dialog v-model="showEmployeeList" title="会议室员工列表" align-center width="1000px" destroy-on-close>
      <MeetingRoomWithEmployeesList v-if="currentMeetingRoomId" :meetingRoomId="currentMeetingRoomId" />
    </el-dialog>
    <el-dialog v-model="showTimePicker" title="选择时间" width="30%" align-center>
      <el-form label-width="100px">
        <el-form-item label="日期">
          <el-date-picker
              v-model="selectedDate"
              type="date"
              placeholder="选择日期"
              :disabled-date="(date) => {
          const today = new Date()
          const max = new Date()
          max.setDate(today.getDate() + 60)
          return date < today || date > max
        }"
          />
        </el-form-item>

        <el-form-item label="开始时间">
          <el-select v-model="startHour" placeholder="选择开始时间">
            <el-option
                v-for="h in 13"
                :key="h"
                :label="`${h + 7}:00`"
                :value="h + 7"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="结束时间">
          <el-select v-model="endHour" placeholder="选择结束时间">
            <el-option
                v-for="h in 13"
                :key="h"
                :label="`${h + 8}:00`"
                :value="h + 8"
            />
          </el-select>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="handleTimeConfirm">确认</el-button>
          <el-button @click="showTimePicker = false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <el-dialog v-model="showFilterDialog" title="预约条件筛选" width="40%">
      <el-form label-width="100px">
        <el-form-item label="日期">
          <el-date-picker v-model="filterForm.date" type="date" />
        </el-form-item>
        <el-form-item label="开始时间">
          <el-select v-model="filterForm.startHour">
            <el-option v-for="h in 13" :key="h" :label="`${h + 7}:00`" :value="h + 7" />
          </el-select>
        </el-form-item>
        <el-form-item label="结束时间">
          <el-select v-model="filterForm.endHour">
            <el-option v-for="h in 13" :key="h" :label="`${h + 8}:00`" :value="h + 8" />
          </el-select>
        </el-form-item>
        <el-form-item label="参会人数">
          <el-input-number v-model="filterForm.attendees" :min="1" />
        </el-form-item>
        <el-form-item label="价格区间">
          <el-input-number v-model="filterForm.minPrice" placeholder="最小价格" :min="0" />
          <el-input-number v-model="filterForm.maxPrice" placeholder="最大价格" :min="0" style="margin-left: 10px;" />
        </el-form-item>
        <el-form-item label="最低容量">
          <el-input-number v-model="filterForm.minCapacity" :min="1" />
        </el-form-item>
        <el-form-item label="设备要求">
          <el-checkbox v-model="filterForm.hasProjector">投影仪</el-checkbox>
          <el-checkbox v-model="filterForm.hasAudio">音响</el-checkbox>
          <el-checkbox v-model="filterForm.hasNetwork">网络</el-checkbox>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleFilterConfirm">提交</el-button>
          <el-button @click="showFilterDialog = false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <el-header class="main-header">
      <div class="title-container">
        <h2>会议室列表</h2>
        &nbsp;记录数：{{ pagination.total }}
      </div>
      <div class="tool-bar">
        <el-select class="dp-selector" v-model="departmentsSelected" placeholder="院系筛选" multiple collapse-tags
                   collapse-tags-tooltip>
          <el-option v-for="item in departmentList?.data" :key="item.departmentId" :label="item.departmentName"
                     :value="item.departmentId" />
        </el-select>
        <el-button type="success" plain @click="handleDepartmentChange">搜索</el-button>
        <el-button type="primary" plain @click="showFilterDialog = true">提交预约要求</el-button>
        <el-divider v-if="userRole === 'admin'" direction="vertical" />
        <el-button v-if="userRole === 'admin'" type="primary" plain @click="handleEditMeetingRoom()">发布会议室</el-button>
      </div>
    </el-header>
    <el-main class="table-container">
      <el-table class="table-content" :data="meetingRoomList" border stripe v-loading="loading">
        <el-table-column label="编号" prop="meetingRoomId" width="100px">
          <template #default="scope">
            {{ String(scope.row.meetingRoomId).padStart(6, '0') }}
          </template>
        </el-table-column>
        <el-table-column label="院系" prop="departmentName" />
        <el-table-column label="名称" prop="meetingRoomName" />
        <el-table-column label="价格" prop="pricePerHour" width="100px">
          <template #default="scope">
            {{ scope.row.pricePerHour.toFixed(1) }}
          </template>
        </el-table-column>
        <el-table-column label="容量" prop="capacity" width="90px" />
        <el-table-column label="类型" prop="type" width="120px">
          <template #default="scope">
            {{ scope.row.type === 'classroom' ? '教室' : '圆桌' }}
          </template>
        </el-table-column>
        <el-table-column label="状态" width="100px">
          <template #default="scope">
            <el-tag :type="statusTagType(scope.row.status)" size="small">
              {{ formatStatus(scope.row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="设备" show-overflow-tooltip>
          <template #default="scope">
            {{ formatEquipment(scope.row) }}
          </template>
        </el-table-column>
        <el-table-column label="简介" prop="description" show-overflow-tooltip />
        <el-table-column label="创建者" width="150px">
          <template #default="scope">
            {{ scope.row.creatorName || scope.row.creatorId }}
          </template>
        </el-table-column>
        <el-table-column label="员工数" prop="employeeCount" width="90px" />
        <el-table-column label="操作" width="200">
          <template #default="{ row }">
            <el-button size="small" @click="handleSelectMeetingRoom(row)">选择</el-button>
            <el-button size="small" type="info" @click="handleMeetingRoomEmployeeList(row)">员工</el-button>
            <el-button v-if="userRole === 'admin'" size="small" type="warning" @click="handleEditMeetingRoom(row)">编辑</el-button>
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