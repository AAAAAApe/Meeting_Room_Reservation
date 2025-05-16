<script setup lang="ts">
import { ref, watch } from 'vue';
import { meetingRoomService } from '../api/index';
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
    capacity: 20,
    type: 'classroom',
    status: 'available',
    hasProjector: false, // 必须初始化为布尔值
    hasAudio: false,
    hasNetwork: false
  }
});

// 表单验证规则（保留必要验证）
const rules = {
  'meetingRoom.meetingRoomName': [
    { required: true, message: '请输入会议室名称', trigger: 'blur' },
    { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  'meetingRoom.pricePerHour': [
    { required: true, message: '请输入每小时价格', trigger: 'change' }
  ],
  'meetingRoom.capacity': [
    { required: true, message: '请输入会议室容量', trigger: 'blur' },
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
      <h2 class="editor-title">{{ props.meetingRoom ? '编辑会议室' : '新增会议室' }}</h2>
      <el-form ref="formRef" :model="meetingRoomForm" :rules="rules" label-position="top">
        <!-- 保留原有基础字段 -->
        <el-form-item label="会议室名称" prop="meetingRoom.meetingRoomName">
          <el-input placeholder="请输入会议室名称" v-model="meetingRoomForm.meetingRoom.meetingRoomName" />
        </el-form-item>

        <div class="form-row">
          <el-form-item label="每小时价格" prop="meetingRoom.pricePerHour" class="form-item-half">
            <el-input v-model="meetingRoomForm.meetingRoom.pricePerHour"
              :precision="1" controls-position="right" placeholder="请输入每小时价格" class="full-width" />
          </el-form-item>

          <el-form-item label="容量（人）" prop="meetingRoom.capacity" class="form-item-half">
            <el-input-number v-model="meetingRoomForm.meetingRoom.capacity" :min="1" :max="200"
              controls-position="right" class="full-width" />
          </el-form-item>
        </div>

        <div class="form-row">
          <el-form-item label="会议室类型" class="form-item-half">
            <el-select v-model="meetingRoomForm.meetingRoom.type" placeholder="请选择类型" class="full-width">
              <el-option v-for="item in typeOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>

          <el-form-item label="当前状态" class="form-item-half">
            <el-select v-model="meetingRoomForm.meetingRoom.status" placeholder="请选择状态" class="full-width">
              <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
            </el-select>
          </el-form-item>
        </div>

        <el-form-item label="设备配置" class="equipment-section">
          <div class="equipment-options">
            <el-checkbox v-model="meetingRoomForm.meetingRoom.hasProjector">
              <div class="equipment-item">
                <i class="el-icon-video-camera"></i>
                <span>投影仪</span>
              </div>
            </el-checkbox>
            <el-checkbox v-model="meetingRoomForm.meetingRoom.hasAudio">
              <div class="equipment-item">
                <i class="el-icon-headset"></i>
                <span>音响</span>
              </div>
            </el-checkbox>
            <el-checkbox v-model="meetingRoomForm.meetingRoom.hasNetwork">
              <div class="equipment-item">
                <i class="el-icon-connection"></i>
                <span>网络</span>
              </div>
            </el-checkbox>
          </div>
        </el-form-item>

        <!-- 删除员工相关代码 -->

        <el-form-item class="form-actions">
          <div class="button-container">
            <el-button type="primary" @click="handleSubmit" :loading="submitLoading" class="submit-button">{{
              props.meetingRoom ? '更新会议室' : '发布会议室' }}</el-button>
            <el-button @click="emit('close')" class="cancel-button">取消</el-button>
          </div>
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
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  padding: 20px;

  .form-container {
    flex: 1;
    max-width: 800px;
    margin: 0 auto;
  }

  .editor-title {
    font-size: 20px;
    font-weight: 600;
    margin-bottom: 24px;
    color: #303133;
    text-align: center;
    border-bottom: 1px solid #ebeef5;
    padding-bottom: 16px;
  }

  .form-row {
    display: flex;
    gap: 20px;
    margin-bottom: 10px;

    @media (max-width: 768px) {
      flex-direction: column;
      gap: 0;
    }
  }

  .form-item-half {
    flex: 1;
    min-width: 0;
  }

  .full-width {
    width: 100%;
  }

  .equipment-section {
    margin-top: 10px;
  }

  .equipment-options {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
  }

  .equipment-item {
    display: flex;
    align-items: center;
    gap: 5px;

    i {
      font-size: 18px;
      color: #409EFF;
    }
  }

  .form-actions {
    margin-top: 30px;
    width: 100%;

    .button-container {
      display: flex;
      justify-content: center;
      gap: 20px;
      width: 100%;
    }

    .submit-button {
      min-width: 120px;
    }

    .cancel-button {
      min-width: 80px;
    }
  }

  :deep(.el-form-item__label) {
    font-weight: 500;
  }

  :deep(.el-input-number) {
    width: 100%;
  }
}
</style>