<script setup lang="ts">
import { ref, watch } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { meetingRoomService, departmentService } from '../api/index';
import type { MeetingRoomInfo, MeetingRoomPublishInfo } from '../api/types';
import { ElMessage } from 'element-plus';

const props = defineProps<{
  meetingRoom?: MeetingRoomInfo;
}>();

const emit = defineEmits<{
  success: [];
  close: [];
}>();

const meetingRoomForm = ref<MeetingRoomPublishInfo>({
  meetingRoom: {
    meetingRoomName: '',
    pricePerHour: undefined,
    departmentId: '',
    description: '',
    capacity: 20,
    type: 'classroom',
    status: 'available',
    hasProjector: false, // 必须初始化为布尔值
    hasAudio: false,
    hasNetwork: false
  },
  employeeIds: [] // 保留字段但不再使用
});

// 获取院系列表数据
const { data: departmentList } = useRequest(
    departmentService.getDepartmentList,
);

// 表单验证规则（保留必要验证）
const rules = {
  'meetingRoom.meetingRoomName': [
    { required: true, message: '请输入会议室名称', trigger: 'blur' },
    { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  'meetingRoom.departmentId': [
    { required: true, message: '请选择所属院系', trigger: 'change' }
  ],
  'meetingRoom.pricePerHour': [
    { required: true, message: '请选择会议室学分', trigger: 'change' }
  ],
  'meetingRoom.capacity': [
    { required: true, message: '请输入容量', trigger: 'blur' },
    { type: 'number', min: 1, max: 200, message: '容量范围 1-200', trigger: 'blur' }
  ]
}

const formRef = ref()
const submitLoading = ref(false)

// 提交逻辑保持不变
const handleSubmit = () => {
  if (!formRef.value) return
  formRef.value.validate(async (valid: boolean) => {
    if (valid) {
      submitLoading.value = true
      try {
        const response = await meetingRoomService.publishMeetingRoom(meetingRoomForm.value)
        ElMessage.success(`操作成功，会议室ID：${String(response.data).padStart(6, '0')}`);
        emit('success');
        emit('close');
      } catch (error) {
        ElMessage.error('操作失败，请重试')
      } finally {
        submitLoading.value = false
      }
    }
  })
}

// 监听会议室信息变化（移除员工相关逻辑）
watch(() => props.meetingRoom, (newMeetingRoom) => {
  if (newMeetingRoom) {
    meetingRoomForm.value.meetingRoom = {
      meetingRoomId: newMeetingRoom.meetingRoomId,
      meetingRoomName: newMeetingRoom.meetingRoomName,
      pricePerHour: newMeetingRoom.pricePerHour,
      departmentId: newMeetingRoom.departmentId,
      description: newMeetingRoom.description || '',
      // 显式同步新增字段
      capacity: newMeetingRoom.capacity,
      type: newMeetingRoom.type,
      status: newMeetingRoom.status,
      hasProjector: newMeetingRoom.hasProjector,
      hasAudio: newMeetingRoom.hasAudio,
      hasNetwork: newMeetingRoom.hasNetwork
    }
  } else {
    meetingRoomForm.value = {
      meetingRoom: {
        meetingRoomId: undefined,
        meetingRoomName: '',
        pricePerHour: undefined,
        departmentId: '',
        description: '',
        capacity: 20,
        type: 'classroom',
        status: 'available',
        hasProjector: false,
        hasAudio: false,
        hasNetwork: false
      },
      employeeIds: []
    }
  }
}, { immediate: true });

const pricePerHourOptions = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8]
const statusOptions = [
  { value: 'available', label: '可用' },
  { value: 'locked', label: '锁定' },
  { value: 'reserved', label: '已预订' },
  { value: 'in_use', label: '使用中' },
  { value: 'maintenance', label: '维护中' }
]
const typeOptions = [
  { value: 'classroom', label: '教室' },
  { value: 'round_table', label: '圆桌会议室' }
]
</script>

<template>
  <div class="editor-container">
    <div class="form-container">
      <el-form ref="formRef" :model="meetingRoomForm" :rules="rules">
        <!-- 保留原有基础字段 -->
        <el-form-item label="会议室名称" prop="meetingRoom.meetingRoomName">
          <el-input
              placeholder="请输入会议室名称"
              v-model="meetingRoomForm.meetingRoom.meetingRoomName"
          />
        </el-form-item>

        <el-form-item label="所属院系" prop="meetingRoom.departmentId">
          <el-select
              v-model="meetingRoomForm.meetingRoom.departmentId"
              placeholder="请选择所属院系"
          >
            <el-option
                v-for="item in departmentList?.data"
                :key="item.departmentId"
                :label="item.departmentName"
                :value="item.departmentId"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="每小时价格" prop="meetingRoom.pricePerHour">
          <el-select
              v-model="meetingRoomForm.meetingRoom.pricePerHour"
              placeholder="价格"
          >
            <el-option
                v-for="item in pricePerHourOptions"
                :key="item"
                :value="item"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="容量（人）" prop="meetingRoom.capacity">
          <el-input-number
              v-model="meetingRoomForm.meetingRoom.capacity"
              :min="1"
              :max="200"
              controls-position="right"
          />
        </el-form-item>

        <el-form-item label="会议室类型">
          <el-select
              v-model="meetingRoomForm.meetingRoom.type"
              placeholder="请选择类型"
          >
            <el-option
                v-for="item in typeOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="当前状态">
          <el-select
              v-model="meetingRoomForm.meetingRoom.status"
              placeholder="请选择状态"
          >
            <el-option
                v-for="item in statusOptions"
                :key="item.value"
                :label="item.label"
                :value="item.value"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="设备配置">
          <el-checkbox v-model="meetingRoomForm.meetingRoom.hasProjector">投影仪</el-checkbox>
          <el-checkbox v-model="meetingRoomForm.meetingRoom.hasAudio">音响</el-checkbox>
          <el-checkbox v-model="meetingRoomForm.meetingRoom.hasNetwork">网络</el-checkbox>
        </el-form-item>

        <el-form-item label="会议室简介">
          <el-input
              type="textarea"
              placeholder="请输入会议室简介"
              v-model="meetingRoomForm.meetingRoom.description"
          />
        </el-form-item>

        <!-- 删除员工相关代码 -->

        <el-form-item>
          <el-button
              type="primary"
              @click="handleSubmit"
              :loading="submitLoading"
          >{{ props.meetingRoom ? '更新' : '发布' }}</el-button>
          <el-button @click="emit('close')">取消</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<style lang="scss" scoped>
.editor-container {
  display: flex;
  gap: 20px;
  max-width: 100%;
  margin: 0 auto;

  .form-container {
    flex: 1;
    max-width: 600px; // 调整宽度适应新布局
  }

  /* 删除原 employee-list-container 相关样式 */
}
</style>