<script setup lang="ts">
import { useRequest } from 'vue-hooks-plus';
import { courseService, type CourseAssignment, type CourseWithTeacherInfo, type PaginationParams } from '../api';
import { ref } from 'vue';

const props = defineProps<{
    courseId: number,
    teacherId: string
}>();
const courseDetail = ref<CourseWithTeacherInfo>();
const { } = useRequest(
    courseService.getTeacherCourseDetail,
    {
        defaultParams: [props.courseId, props.teacherId],
        onSuccess: response => {
            courseDetail.value = response.data;
        },
    }
);

const pagination = ref({
    current: 1,
    size: 16,
    total: 0
});
const params = ref<PaginationParams>({
    current: pagination.value.current,
    size: pagination.value.size,
});
const assignments = ref<CourseAssignment[]>();
const { run: fetchAssignmentList, loading } = useRequest(
    courseService.getCourseAssignments,
    {
        defaultParams: [props.courseId, props.teacherId, params.value],
        onSuccess: response => {
            assignments.value = response.data.records;
            pagination.value.current = response.data.current;
            pagination.value.total = response.data.total;
            pagination.value.size = response.data.size;
        },
    }
);
</script>

<template>
    <div>
        <el-container class="main-container">
            <el-header class="main-header">
                <div class="title-container">
                    <h2>课程详情</h2>
                </div>
            </el-header>
            <el-main class="main-content">
                <el-descriptions v-if="courseDetail" :column="2" border>
                    <el-descriptions-item label="课程编号">{{ String(courseDetail.courseId).padStart(6, '0')
                        }}</el-descriptions-item>
                    <el-descriptions-item label="所属院系">{{ courseDetail.departmentName }}</el-descriptions-item>
                    <el-descriptions-item label="课程名称">{{ courseDetail.courseName }}</el-descriptions-item>
                    <el-descriptions-item label="课程学分">{{ courseDetail.credit.toFixed(1) }}</el-descriptions-item>
                    <el-descriptions-item label="课程简介" :span="2">{{ courseDetail.description }}</el-descriptions-item>
                    <el-descriptions-item label="学生人数">{{ courseDetail.studentCount }}</el-descriptions-item>
                    <el-descriptions-item label="创建者">{{ courseDetail.creatorName || courseDetail.creatorId
                        }}</el-descriptions-item>
                </el-descriptions>

                <div class="assignments-section">
                    <h3>作业列表</h3>
                    <el-table :data="assignments" border stripe v-loading="loading">
                        <el-table-column label="作业标题" prop="assignmentTitle"></el-table-column>
                        <el-table-column label="截止时间" prop="submissionDeadline">
                            <template #default="{ row }">
                                {{ new Date(row.submissionDeadline).toLocaleString() }}
                            </template>
                        </el-table-column>
                        <el-table-column label="作业内容" prop="content" show-overflow-tooltip></el-table-column>
                        <el-table-column label="提交链接" prop="submissionUrl">
                            <template #default="{ row }">
                                <el-link v-if="row.submissionUrl" type="primary" :href="row.submissionUrl" target="_blank">查看</el-link>
                                <span v-else>-</span>
                            </template>
                        </el-table-column>
                        <el-table-column label="成绩" prop="grade">
                            <template #default="{ row }">
                                <el-tag v-if="row.grade" :type="row.grade === 'A' || row.grade === 'B' ? 'success' : row.grade === 'C' ? 'warning' : 'danger'">
                                    {{ row.grade }}
                                </el-tag>
                                <span v-else>-</span>
                            </template>
                        </el-table-column>
                    </el-table>
                    <el-pagination class="pagination" background layout="prev, pager, next" :total="pagination.total"
                        :current-page="pagination.current" :page-size="pagination.size" @current-change="(current: number) => {
                            params.current = current;
                            fetchAssignmentList(courseId, teacherId, params);
                        }" />
                </div>
            </el-main>
        </el-container>
    </div>
</template>

<style lang="scss" scoped>
.main-container {
    height: 100%;

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

    .main-content {
        padding: 20px;
        overflow: auto;

        .assignments-section {
            margin-top: 20px;

            h3 {
                margin-bottom: 16px;
            }

            .pagination {
                margin-top: 16px;
                display: flex;
                justify-content: center;
            }
        }
    }
}
</style>