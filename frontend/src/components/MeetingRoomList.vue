<script setup lang="ts">
import { computed, ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import type { MeetingRoomInfo, PaginationParams,CustomerMeetingRoomSelection } from '../api/types';
import MeetingRoomEditor from './MeetingRoomEditor.vue';
import { useUserStore } from '../stores/userStore';
import dayjs from 'dayjs'
import { ElMessage, ElMessageBox } from "element-plus";
import { meetingRoomService } from '../api/index';;

const userStore = useUserStore();
const userRole = computed(() => userStore.user?.value?.roleName || '');

// 存储会议室列表数据，用于表格展示
const meetingRoomList = ref<MeetingRoomInfo[]>([]);
const meetingRoomChooseList = ref<CustomerMeetingRoomSelection[]>([]);
const isFiltering = ref(false);

// 存储用户选择的ID数组，用于筛选会议室
const departmentsSelected = ref([]);

// 翻页时携带参数，作用是提交筛选后，翻页时保留筛选条件
let departmentIdsParams: string[] = [];

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
  fetchMeetingRoomList(params.value);
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
      let startTime = '', endTime = '';
      if (filterForm.value.date) {
        const dateStr = dayjs(filterForm.value.date).format('YYYY-MM-DD');
        startTime = `${dateStr} ${filterForm.value.startHour.toString().padStart(2,'0')}:00:00`;
        endTime = `${dateStr} ${filterForm.value.endHour.toString().padStart(2,'0')}:00:00`;
      }

      const res = await meetingRoomService.getAvailableRooms({
        current: 1,
        size: pagination.value.size,
        startTime,
        endTime,
        hasProjector: filterForm.value.hasProjector,
        hasAudio: filterForm.value.hasAudio,
        hasNetwork: filterForm.value.hasNetwork
      });

      meetingRoomChooseList.value = res.data.records;
      pagination.value.current = res.data.current;
      pagination.value.total = res.data.total;
      pagination.value.size = res.data.size;

      isFiltering.value = true; // ⬅️ 切换为筛选状态
      showFilterDialog.value = false; // 可选：关闭弹窗
    }
;
const clearFilter = () => {
  isFiltering.value = false;
  meetingRoomChooseList.value = [];
};

// 新增用于弹窗和数据的变量
const showOrderDialog = ref(false);
const orderList = ref<any[]>([]);
const orderLoading = ref(false);

// 预约订单表格字段映射（根据后端返回实际字段调整）
const fetchOrders = async () => {
  orderLoading.value = true;
  try {
    const { data } = await fetchEmployeeMeetingRoomOrders();
    orderList.value = data;
  } finally {
    orderLoading.value = false;
  }
};

// 删除会议室的处理方法
const handleDeleteMeetingRoom = async (meetingRoom: MeetingRoomInfo) => {
  try {
    const confirmed = await ElMessageBox.confirm(
      `确定要删除会议室"${meetingRoom.meetingRoomName}"吗？此操作不可恢复。`,
      '删除确认',
      {
        confirmButtonText: '确认删除',
        cancelButtonText: '取消',
        type: 'warning'
      }
    ).catch(() => false);

    if (!confirmed) return;

    await meetingRoomService.deleteMeetingRoom(meetingRoom.meetingRoomId);
    ElMessage.success('会议室删除成功');
    // 刷新会议室列表
    fetchMeetingRoomList(params.value);
  } catch (error) {
    ElMessage.error('删除会议室失败');
    console.error('删除会议室失败:', error);
  }
};
</script>

<template>
  <el-container class="main-container">
    <el-dialog :title="currentMeetingRoom ? '编辑会议室' : '发布会议室'" width="500px" align-center v-model="showEditor"
      destroy-on-close>
      <MeetingRoomEditor :meetingRoom="currentMeetingRoom" @success="handleEditorSuccess" @close="showEditor = false" />
    </el-dialog>

    <el-dialog v-model="showEmployeeList" title="会议室员工列表" align-center width="1000px" destroy-on-close>
      <MeetingRoomWithEmployeesList v-if="currentMeetingRoomId" :meetingRoomId="currentMeetingRoomId" />
    </el-dialog>

    <!-- 时间选择对话框 -->
    <el-dialog v-model="showTimePicker" title="选择预订时间" width="30%" align-center custom-class="time-picker-dialog">
      <el-form label-width="100px">
        <el-form-item label="日期">
          <el-date-picker v-model="selectedDate" type="date" placeholder="选择日期" class="full-width" :disabled-date="(date) => {
            const today = new Date()
            const max = new Date()
            max.setDate(today.getDate() + 60)
            return date < today || date > max
          }" />
        </el-form-item>

        <el-form-item label="开始时间">
          <el-select v-model="startHour" placeholder="选择开始时间" class="full-width">
            <el-option v-for="h in 13" :key="h" :label="`${h + 7}:00`" :value="h + 7" />
          </el-select>
        </el-form-item>

        <el-form-item label="结束时间">
          <el-select v-model="endHour" placeholder="选择结束时间" class="full-width">
            <el-option v-for="h in 13" :key="h" :label="`${h + 8}:00`" :value="h + 8" />
          </el-select>
        </el-form-item>

        <el-form-item class="dialog-footer">
          <el-button type="primary" @click="handleTimeConfirm">确认预订</el-button>
          <el-button @click="showTimePicker = false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <!-- 筛选对话框 -->
    <el-dialog v-model="showFilterDialog" title="预约条件筛选" width="40%" custom-class="filter-dialog">
      <el-form label-width="100px">
        <el-form-item label="日期">
          <el-date-picker v-model="filterForm.date" type="date" placeholder="选择日期" class="full-width" :disabled-date="(date) => {
            const today = new Date()
            const max = new Date()
            max.setDate(today.getDate() + 60)
            return date < today || date > max
          }" />
        </el-form-item>

        <div class="form-row">
          <el-form-item label="开始时间" class="form-item-half">
            <el-select v-model="filterForm.startHour" class="full-width">
              <el-option v-for="h in 13" :key="h" :label="`${h + 7}:00`" :value="h + 7" />
            </el-select>
          </el-form-item>

          <el-form-item label="结束时间" class="form-item-half">
            <el-select v-model="filterForm.endHour" class="full-width">
              <el-option v-for="h in 13" :key="h" :label="`${h + 8}:00`" :value="h + 8" />
            </el-select>
          </el-form-item>
        </div>

        <div class="form-row">
          <el-form-item label="参会人数" class="form-item-half">
            <el-input-number v-model="filterForm.attendees" :min="1" class="full-width" />
          </el-form-item>

          <el-form-item label="最低容量" class="form-item-half">
            <el-input-number v-model="filterForm.minCapacity" :min="1" class="full-width" />
          </el-form-item>
        </div>

        <el-form-item label="价格区间">
          <div class="price-range">
            <el-input-number v-model="filterForm.minPrice" placeholder="最小价格" :min="0" class="price-input" />
            <span class="price-separator">至</span>
            <el-input-number v-model="filterForm.maxPrice" placeholder="最大价格" :min="0" class="price-input" />
          </div>
        </el-form-item>

        <el-form-item label="设备要求">
          <div class="equipment-options">
            <el-checkbox v-model="filterForm.hasProjector">
              <div class="equipment-item">
                <i class="el-icon-video-camera"></i>
                <span>投影仪</span>
              </div>
            </el-checkbox>
            <el-checkbox v-model="filterForm.hasAudio">
              <div class="equipment-item">
                <i class="el-icon-headset"></i>
                <span>音响</span>
              </div>
            </el-checkbox>
            <el-checkbox v-model="filterForm.hasNetwork">
              <div class="equipment-item">
                <i class="el-icon-connection"></i>
                <span>网络</span>
              </div>
            </el-checkbox>
          </div>
        </el-form-item>

        <el-form-item class="dialog-footer">
          <el-button type="primary" @click="handleFilterConfirm">提交筛选</el-button>
          <el-button @click="showFilterDialog = false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    <!-- 员工角色查看所有预约会议室订单 -->
    <el-dialog v-model="showOrderDialog" title="已预约会议室" width="60%">
      <el-table :data="orderList" v-loading="orderLoading" style="width: 100%">
        <el-table-column prop="meetingRoomName" label="会议室" />
        <el-table-column prop="userName" label="预约用户" />
        <el-table-column prop="startTime" label="开始时间" />
        <el-table-column prop="endTime" label="结束时间" />
        <!-- 可根据实际字段增加更多信息 -->
      </el-table>
      <el-empty v-if="!orderLoading && orderList.length === 0" description="暂无预约数据" />
    </el-dialog>

    <!-- 页面头部 -->
    <el-header class="main-header">
      <div class="title-container">
        <h2>会议室列表</h2>
        <span class="record-count">记录数：{{ pagination.total }}</span>
      </div>
      <div class="tool-bar">
        <el-button type="primary" plain @click="showFilterDialog = true">提交预约要求</el-button>
        <el-divider v-if="userRole === 'admin'" direction="vertical" />

        <el-button v-if="userRole === 'admin'" type="primary" plain @click="handleEditMeetingRoom()">发布会议室</el-button>
      </div>
    </el-header>

    <!-- 表格内容 -->
    <el-main class="table-container">
      <div v-if="isFiltering">
        <el-alert
            title="当前显示为筛选后的会议室结果"
            type="info"
            show-icon
            closable={false}
            class="mb-2"
        />
        <el-button type="warning" class="mb-2" @click="clearFilter">清除筛选</el-button>

        <el-table :data="meetingRoomChooseList" style="width: 100%" v-if="meetingRoomChooseList.length > 0">
          <el-table-column prop="meetingRoomName" label="会议室名称" />
          <el-table-column prop="capacity" label="容量" />
          <el-table-column label="价格" prop="pricePerHour" width="140px" >
            <template #default="scope">
              <span class="price" >¥{{ scope.row.pricePerHour.toFixed(1) }}/小时</span>
            </template>
          </el-table-column>
          <el-table-column label="类型" prop="type" width="120px" align="center">
            <template #default="scope">
              <el-tag size="small" :type="scope.row.type === 'classroom' ? 'info' : 'success'" effect="plain">
                {{ scope.row.type === 'classroom' ? '教室' : '圆桌' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="设备">
            <template #default="{ row }">{{ formatEquipment(row) }}</template>
          </el-table-column>
          <el-table-column label="操作">
            <template #default="{ row }">
              <el-button type="primary" size="small" @click="handleSelectMeetingRoom(row)">预订</el-button>
            </template>
          </el-table-column>
        </el-table>

        <el-empty description="暂无可用会议室" v-else />
      </div>
      <div v-else>
        <el-table class="table-content" :data="meetingRoomList" border stripe v-loading="loading">
          <el-table-column label="会议室编号" prop="meetingRoomId" width="100px">
            <template #default="scope">
              <span class="room-id">{{ String(scope.row.meetingRoomId).padStart(6, '0') }}</span>
            </template>
          </el-table-column>
          <el-table-column label="会议室名称" prop="meetingRoomName" min-width="50px">
            <template #default="scope">
              <div class="room-name">{{ scope.row.meetingRoomName }}</div>
            </template>
          </el-table-column>
          <el-table-column label="价格" prop="pricePerHour" width="140px" >
            <template #default="scope">
              <span class="price" >¥{{ scope.row.pricePerHour.toFixed(1) }}/小时</span>
            </template>
          </el-table-column>
          <el-table-column label="容量" prop="capacity" width="90px">
            <template #default="scope">
              <span class="capacity">{{ scope.row.capacity }}人</span>
            </template>
          </el-table-column>
          <el-table-column label="类型" prop="type" width="120px" align="center">
            <template #default="scope">
              <el-tag size="small" :type="scope.row.type === 'classroom' ? 'info' : 'success'" effect="plain">
                {{ scope.row.type === 'classroom' ? '教室' : '圆桌' }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="状态" width="100px" align="center">
            <template #default="scope">
              <el-tag :type="statusTagType(scope.row.status)" size="small">
                {{ formatStatus(scope.row.status) }}
              </el-tag>
            </template>
          </el-table-column>
          <el-table-column label="设备" show-overflow-tooltip align="center" width="300px">
            <template #default="scope">
              <div class="equipment-list">
                <el-tag v-if="scope.row.hasProjector" size="small" type="info" effect="plain"
                  class="equipment-tag">投影仪</el-tag>
                <el-tag v-if="scope.row.hasAudio" size="small" type="info" effect="plain"
                  class="equipment-tag">音响</el-tag>
                <el-tag v-if="scope.row.hasNetwork" size="small" type="info" effect="plain"
                  class="equipment-tag">网络</el-tag>
                <span v-if="!scope.row.hasProjector && !scope.row.hasAudio && !scope.row.hasNetwork"
                  class="no-equipment">无</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column label="操作" width="220">
            <template #default="{ row }">
              <div class="action-buttons">
                <el-button size="small" type="primary" plain @click="handleSelectMeetingRoom(row)">预定</el-button>
                <el-button v-if="userRole === 'admin'" size="small" type="warning" plain
                  @click="handleEditMeetingRoom(row)">编辑</el-button>
                <el-button v-if="userRole === 'admin'" type="danger" size="small" plain
                  @click="handleDeleteMeetingRoom(row)">删除</el-button>
              </div>
            </template>
          </el-table-column>
        </el-table>
      </div>
    </el-main>

    <!-- 页脚分页 -->
    <el-footer class="main-footer">
      <el-pagination class="pagination" background layout="prev, pager, next, jumper" :total="pagination.total"
        :current-page="pagination.current" :page-size="pagination.size" @current-change="handleCurrentChange" />
    </el-footer>
  </el-container>
</template>

<style lang="scss" scoped>
.main-container {
  height: 1px;
  background-color: #f5f7fa;

  .main-header {
    height: $main-content-header-footer-height;
    background-color: #fff;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
    border-bottom: 1px solid #ebeef5;

    .title-container {
      height: 100%;
      display: flex;
      align-items: center;

      h2 {
        margin: 0;
        font-size: 18px;
        font-weight: 600;
        color: #303133;
      }

      .record-count {
        margin-left: 10px;
        color: #909399;
        font-size: 14px;
      }
    }

    .tool-bar {
      height: 100%;
      display: flex;
      align-items: center;

      .dp-selector {
        width: 240px;
        margin-right: 10px;
      }

      .el-button {
        margin-left: 10px;
      }
    }
  }

  .table-container {
    height: calc(100% - 2 * $main-content-header-footer-height);
    overflow: auto;
    padding: 20px;

    .table-content {
      height: 100%;
      background-color: #fff;
      border-radius: 4px;
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);

      .room-id {
        font-family: monospace;
        color: #606266;
      }

      .room-name {
        font-weight: 500;
        color: #303133;
      }

      .price {
        color: #f56c6c;
        font-weight: 500;
      }

      .capacity {
        color: #606266;
      }

      .equipment-list {
        display: flex;
        flex-wrap: wrap;
        gap: 5px;

        .equipment-tag {
          margin-right: 5px;
        }

        .no-equipment {
          color: #909399;
          font-size: 13px;
        }
      }

      .action-buttons {
        display: flex;
        gap: 5px;
      }
    }
  }

  .main-footer {
    height: $main-content-header-footer-height;
    background-color: #fff;
    padding: 0 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0 -2px 12px rgba(0, 0, 0, 0.05);
    border-top: 1px solid #ebeef5;

    .pagination {
      height: 100%;
    }
  }

  // 对话框样式
  :deep(.time-picker-dialog),
  :deep(.filter-dialog) {
    .el-dialog__body {
      padding: 20px 30px;
    }
  }

  // 表单行样式
  .form-row {
    display: flex;
    gap: 20px;

    @media (max-width: 768px) {
      flex-direction: column;
      gap: 0;
    }

    .form-item-half {
      flex: 1;
      min-width: 0;
    }
  }

  .full-width {
    width: 100%;
  }

  .price-range {
    display: flex;
    align-items: center;

    .price-input {
      width: 45%;
    }

    .price-separator {
      margin: 0 10px;
      color: #909399;
    }
  }

  .equipment-options {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;

    .equipment-item {
      display: flex;
      align-items: center;
      gap: 5px;

      i {
        font-size: 16px;
        color: #409EFF;
      }
    }
  }

  .dialog-footer {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    gap: 15px;
  }
}

// 表格行样式
:deep(.el-table__row) {
  &:hover {
    background-color: #f5f7fa !important;
  }
}

// 添加表格行状态样式
.table-row-available {
  background-color: #f0f9eb;
}

.table-row-locked {
  background-color: #fef0f0;
}

.table-row-reserved {
  background-color: #fdf6ec;
}

.table-row-maintenance {
  background-color: #f4f4f5;
}
</style>