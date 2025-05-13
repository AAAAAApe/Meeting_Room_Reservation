<script setup lang="ts">
import { ref, watch } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { meetingRoomService, departmentService } from '../api/index';
import type { MeetingRoomInfo, MeetingRoomPublishInfo } from '../api/types';
import { ElMessage } from 'element-plus';
import EmployeeList from './EmployeeList.vue';

const props = defineProps<{
    meetingRoom?: MeetingRoomInfo;
}>();

const emit = defineEmits<{
    success: [];
    close: [];
}>();

const { run: fetchMeetingRoomEmployeeIds } = useRequest(
    meetingRoomService.getEmployeeIdsByMeetingRoomId,
    {
        manual: true,
        onSuccess: (response) => {
            meetingRoomForm.value.employeeIds = response.data;
        }
    }
)

const meetingRoomForm = ref<MeetingRoomPublishInfo>({
    meetingRoom: {
        meetingRoomName: '',
        credit: undefined,
        departmentId: '',
        description: ''
    },
    employeeIds: []
});

// 获取院系列表数据，用于下拉筛选框
const { data: departmentList } = useRequest(
    departmentService.getDepartmentList,
);

// 表单验证规则
const rules = {
    'meetingRoom.meetingRoomName': [
        { required: true, message: '请输入会议室名称', trigger: 'blur' },
        { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
    ],
    'meetingRoom.departmentId': [
        { required: true, message: '请选择所属院系', trigger: 'change' }
    ],
    'meetingRoom.credit': [
        { required: true, message: '请选择会议室学分', trigger: 'change' }
    ]
}

// 表单引用，用于表单验证
const formRef = ref()

// 提交状态
const submitLoading = ref(false)

// 处理会议室提交
const handleSubmit = () => {
    if (!formRef.value) return

    formRef.value.validate(async (valid: boolean) => {
        if (valid) {
            submitLoading.value = true
            try {
                const response = await meetingRoomService.publishMeetingRoom(meetingRoomForm.value)
                const meetingRoomId = response.data
                ElMessage.success(`会议室发布成功，会议室ID：${String(meetingRoomId).padStart(6, '0')}`);
                emit('success');
                emit('close');
            } catch (error) {
                console.error('操作失败:', error)
                ElMessage.error('操作失败，请重试')
            } finally {
                submitLoading.value = false
            }
        }
    })
}

// 重置表单
const resetForm = () => {
    if (formRef.value) {
        formRef.value.resetFields()
    }
    meetingRoomForm.value = {
        meetingRoom: {
            meetingRoomName: '',
            credit: undefined,
            departmentId: '',
            description: ''
        },
        employeeIds: []
    }
}

// 监听会议室信息变化
watch(() => props.meetingRoom, (newMeetingRoom) => {
    if (newMeetingRoom) {
        meetingRoomForm.value = {
            meetingRoom: {
                meetingRoomId: newMeetingRoom.meetingRoomId,
                meetingRoomName: newMeetingRoom.meetingRoomName,
                credit: newMeetingRoom.credit,
                departmentId: newMeetingRoom.departmentId,
                description: newMeetingRoom.description || ''
            },
            employeeIds: []
        }
        fetchMeetingRoomEmployeeIds(newMeetingRoom.meetingRoomId);
    } else {
        resetForm();
    }
}, { immediate: true });

const creditOptions = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8]
</script>

<template>
    <div class="editor-container">
        <div class="form-container">
            <el-form ref="formRef" :model="meetingRoomForm" :rules="rules">
                <el-form-item label="会议室名称" prop="meetingRoom.meetingRoomName">
                    <el-input placeholder="请输入会议室名称" :maxLength="20" v-model="meetingRoomForm.meetingRoom.meetingRoomName" />
                </el-form-item>

                <el-form-item label="所属院系" prop="meetingRoom.departmentId">
                    <el-select v-model="meetingRoomForm.meetingRoom.departmentId" placeholder="请选择所属院系">
                        <el-option v-for="item in departmentList?.data" :key="item.departmentId"
                            :label="item.departmentName" :value="item.departmentId" />
                    </el-select>
                </el-form-item>

                <el-form-item label="会议室学分" prop="meetingRoom.credit">
                    <el-select v-model="meetingRoomForm.meetingRoom.credit" placeholder="学分">
                        <el-option v-for="item in creditOptions" :key="item" :value="item" />
                    </el-select>
                </el-form-item>

                <el-form-item label="会议室简介" prop="meetingRoom.description">
                    <el-input type="textarea" placeholder="请输入会议室简介" :maxLength="200"
                        v-model="meetingRoomForm.meetingRoom.description" />
                </el-form-item>

                <el-form-item label="会议室员工">
                    <h3>请在右侧选择员工</h3>
                    <div v-if="meetingRoomForm.employeeIds.length > 0" class="selected-employees">
                        <el-table
                            :data="meetingRoomForm.employeeIds.map((id, index) => ({ index: index + 1, employeeId: id }))"
                            border stripe>
                            <el-table-column type="index" label="序号" width="80" />
                            <el-table-column label="员工ID" prop="employeeId" width="120" />
                        </el-table>
                    </div>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="handleSubmit" :loading="submitLoading">{{ props.meetingRoom ? '更新' :
                        '发布'
                        }}</el-button>
                    <el-button @click="emit('close')">取消</el-button>
                </el-form-item>
            </el-form>
        </div>
        <div class="employee-list-container">
            <EmployeeList isSelector v-model="meetingRoomForm.employeeIds" />
        </div>
    </div>
</template>

<style lang="scss" scoped>
.editor-container {
    display: flex;
    gap: 20px;
    max-width: 100%;
    height: 80vh;
    margin: 0 auto;

    .form-container {
        flex: 1;
        max-width: 300px;
    }

    .employee-list-container {
        flex: 1;
        max-width: 1200px;
    }

    .el-form {
        .selected-employees {
            h3 {
                margin-bottom: 15px;
                font-size: 16px;
                color: #606266;
            }
        }
    }
}
</style>