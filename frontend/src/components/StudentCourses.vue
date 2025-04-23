<script setup lang="ts">
import { ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { courseService } from '../api/index';
import type { CourseWithTeacherInfo, PaginationParams, StudentCourseSelection } from '../api/types';
import CourseDetail from './CourseDetail.vue';

// 存储课程列表数据，用于表格展示
const courseList = ref<StudentCourseSelection[]>([]);

// 分页参数配置
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

// 获取课程列表数据
const { run: fetchTeacherCourses, loading } = useRequest(
    courseService.getStudentCourseSelections,
    {
        // 请求成功回调
        onSuccess: data => {
            // 更新课程列表数据
            courseList.value = data.data.records;
            // 更新分页信息
            pagination.value.current = data.data.current;
            pagination.value.total = data.data.total;
            pagination.value.size = data.data.size;
        },
    }
);

// 处理分页变化事件
const handleCurrentChange = (current: number) => {
    params.value.current = current;
    fetchTeacherCourses(params.value);
};

const showDetailDialog = ref(false);
const selectedCourse = ref<CourseWithTeacherInfo>();

const handleShowDetail = (course: CourseWithTeacherInfo) => {
    selectedCourse.value = course;
    showDetailDialog.value = true;
};
</script>

<template>
    <el-container class="main-container">
        <el-dialog v-model="showDetailDialog" width="80%" destroy-on-close>
            <CourseDetail v-if="selectedCourse" :courseId="selectedCourse.courseId"
                :teacherId="selectedCourse.teacherId" />
        </el-dialog>
        <el-header class="main-header">
            <div class="title-container">
                <h2>我的课程</h2>
            </div>
        </el-header>
        <el-main class="table-container">
            <el-table class="table-content" :data="courseList" border stripe v-loading="loading">
                <el-table-column label="课程编号" prop="courseId" width="100px">
                    <template #default="scope">
                        {{ String(scope.row.courseId).padStart(6, '0') }}
                    </template>
                </el-table-column>
                <el-table-column label="所属院系" prop="departmentName" />
                <el-table-column label="课程名称" prop="courseName" />
                <el-table-column label="教师" prop="teacherName" />
                <el-table-column label="课程学分" prop="credit" width="100px">
                    <template #default="scope">
                        {{ scope.row.credit.toFixed(1) }}
                    </template>
                </el-table-column>
                <el-table-column label="课程简介" prop="description" show-overflow-tooltip />
                <el-table-column label="操作" width="120px">
                    <template #default="scope">
                        <el-button type="primary" size="small" @click="handleShowDetail(scope.row)">
                            查看详情
                        </el-button>
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