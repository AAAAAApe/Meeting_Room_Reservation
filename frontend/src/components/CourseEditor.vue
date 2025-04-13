<script setup lang="ts">
import { ref, watch } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { courseService, departmentService } from '../api/index';
import type { CourseInfo, CoursePublishInfo } from '../api/types';
import { ElMessage } from 'element-plus';
import TeacherList from './TeacherList.vue';

const props = defineProps<{
    course?: CourseInfo;
}>();

const emit = defineEmits<{
    success: [];
    close: [];
}>();

const { run: fetchCourseTeacherIds } = useRequest(
    courseService.getTeacherIdsByCourseId,
    {
        manual: true,
        onSuccess: (response) => {
            courseForm.value.teacherIds = response.data;
        }
    }
)

const courseForm = ref<CoursePublishInfo>({
    course: {
        courseName: '',
        credit: undefined,
        departmentId: '',
        description: ''
    },
    teacherIds: []
});

// 获取院系列表数据，用于下拉筛选框
const { data: departmentList } = useRequest(
    departmentService.getDepartmentList,
);

// 表单验证规则
const rules = {
    'course.courseName': [
        { required: true, message: '请输入课程名称', trigger: 'blur' },
        { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
    ],
    'course.departmentId': [
        { required: true, message: '请选择所属院系', trigger: 'change' }
    ],
    'course.credit': [
        { required: true, message: '请选择课程学分', trigger: 'change' }
    ]
}

// 表单引用，用于表单验证
const formRef = ref()

// 提交状态
const submitLoading = ref(false)

// 处理课程提交
const handleSubmit = () => {
    if (!formRef.value) return

    formRef.value.validate(async (valid: boolean) => {
        if (valid) {
            submitLoading.value = true
            try {
                const response = await courseService.publishCourse(courseForm.value)
                const courseId = response.data
                ElMessage.success(`课程发布成功，课程ID：${String(courseId).padStart(6, '0')}`);
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
    courseForm.value = {
        course: {
            courseName: '',
            credit: undefined,
            departmentId: '',
            description: ''
        },
        teacherIds: []
    }
}

// 监听课程信息变化
watch(() => props.course, (newCourse) => {
    if (newCourse) {
        courseForm.value = {
            course: {
                courseId: newCourse.courseId,
                courseName: newCourse.courseName,
                credit: newCourse.credit,
                departmentId: newCourse.departmentId,
                description: newCourse.description || ''
            },
            teacherIds: []
        }
        fetchCourseTeacherIds(newCourse.courseId);
    } else {
        resetForm();
    }
}, { immediate: true });

const creditOptions = [0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5, 8]
</script>

<template>
    <div class="editor-container">
        <div class="form-container">
            <el-form ref="formRef" :model="courseForm" :rules="rules">
                <el-form-item label="课程名称" prop="course.courseName">
                    <el-input placeholder="请输入课程名称" :maxLength="20" v-model="courseForm.course.courseName" />
                </el-form-item>

                <el-form-item label="所属院系" prop="course.departmentId">
                    <el-select v-model="courseForm.course.departmentId" placeholder="请选择所属院系">
                        <el-option v-for="item in departmentList?.data" :key="item.departmentId"
                            :label="item.departmentName" :value="item.departmentId" />
                    </el-select>
                </el-form-item>

                <el-form-item label="课程学分" prop="course.credit">
                    <el-select v-model="courseForm.course.credit" placeholder="学分">
                        <el-option v-for="item in creditOptions" :key="item" :value="item" />
                    </el-select>
                </el-form-item>

                <el-form-item label="课程简介" prop="course.description">
                    <el-input type="textarea" placeholder="请输入课程简介" :maxLength="200"
                        v-model="courseForm.course.description" />
                </el-form-item>

                <el-form-item label="课程教师">
                    <h3>请在右侧选择教师</h3>
                    <div v-if="courseForm.teacherIds.length > 0" class="selected-teachers">
                        <el-table
                            :data="courseForm.teacherIds.map((id, index) => ({ index: index + 1, teacherId: id }))"
                            border stripe>
                            <el-table-column type="index" label="序号" width="80" />
                            <el-table-column label="教师ID" prop="teacherId" width="120" />
                        </el-table>
                    </div>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="handleSubmit" :loading="submitLoading">{{ props.course ? '更新' :
                        '发布'
                        }}</el-button>
                    <el-button @click="emit('close')">取消</el-button>
                </el-form-item>
            </el-form>
        </div>
        <div class="teacher-list-container">
            <TeacherList isSelector v-model="courseForm.teacherIds" />
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

    .teacher-list-container {
        flex: 1;
        max-width: 1200px;
    }

    .el-form {
        .selected-teachers {
            h3 {
                margin-bottom: 15px;
                font-size: 16px;
                color: #606266;
            }
        }
    }
}
</style>