<script setup lang="ts">
import { ref, watch } from 'vue';
import { courseService, type CourseWithTeacherInfo } from '../api';
import { useRequest } from 'vue-hooks-plus';
import type { PaginationParams } from '../api/types';

const props = defineProps({
    courseId: {
        type: Number,
        required: true,
    },
})
const pagination = ref({
    current: 1,
    size: 16,
    total: 0
});

const params = ref<PaginationParams>({
    current: pagination.value.current,
    size: pagination.value.size,
});

const courseWithTeacherList = ref<CourseWithTeacherInfo[]>([])
const { run: fetchCourseWithTeacherList, loading } = useRequest(
    courseService.getCourseWithTeachers,
    {
        manual: true,
        onSuccess: data => {
            // 更新课程列表数据
            courseWithTeacherList.value = data.data.records;
            // 更新分页信息
            pagination.value.current = data.data.current;
            pagination.value.total = data.data.total;
            pagination.value.size = data.data.size;
        },
    }
)

// 处理分页变化事件
const handleCurrentChange = (current: number) => {
    params.value.current = current;
    fetchCourseWithTeacherList(params.value, props.courseId);
};

// 监听courseId的变化，当弹窗打开时重新获取数据
watch(() => props.courseId, (newId) => {
    if (newId) {
        params.value.current = 1; // 重置页码
        courseWithTeacherList.value = [];
        fetchCourseWithTeacherList(params.value, newId);
    }
}, { immediate: true });
</script>

<template>
    <div class="course-with-teachers-list">
        <el-table v-loading="loading" :data="courseWithTeacherList" style="width: 100%">
            <el-table-column prop="courseName" label="课程名称" />
            <el-table-column prop="teacherName" label="教师姓名" />
            <el-table-column prop="teacherDepartmentName" label="教师所属院系" />
            <el-table-column prop="teacherTitleName" label="教师职称" />
            <el-table-column prop="studentCount" label="学生人数" />
        </el-table>

        <div class="pagination-container" style="margin-top: 20px; text-align: center;">
            <el-pagination v-model:current-page="pagination.current" :page-size="pagination.size"
                :total="pagination.total" @current-change="handleCurrentChange" layout="prev, pager, next" />
        </div>
    </div>
</template>