<script setup lang="ts">
import { useRequest } from 'vue-hooks-plus';
import { courseService, type CourseAssignment, type CourseWithTeacherInfo, type PaginationParams, type StudentCourseSelection } from '../api';
import { ref } from 'vue';
import { ElMessage } from 'element-plus';
import { useUserStore } from '../stores/userStore';

const userStore = useUserStore();

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

// 作业列表相关
const assignmentPagination = ref({
    current: 1,
    size: 16,
    total: 0
});
const assignmentParams = ref<PaginationParams>({
    current: assignmentPagination.value.current,
    size: assignmentPagination.value.size,
});
const assignments = ref<CourseAssignment[]>();
const { run: fetchAssignmentList, loading: assignmentLoading } = useRequest(
    courseService.getCourseAssignments,
    {
        defaultParams: [props.courseId, props.teacherId, assignmentParams.value],
        onSuccess: response => {
            assignments.value = response.data.records;
            assignmentPagination.value.current = response.data.current;
            assignmentPagination.value.total = response.data.total;
            assignmentPagination.value.size = response.data.size;
        },
    }
);

// 学生列表相关
const studentPagination = ref({
    current: 1,
    size: 16,
    total: 0
});
const studentParams = ref<PaginationParams>({
    current: studentPagination.value.current,
    size: studentPagination.value.size,
});
const students = ref<StudentCourseSelection[]>();
const { run: fetchStudentList, loading: studentLoading } = useRequest(
    courseService.getCourseStudents,
    {
        defaultParams: [props.courseId, props.teacherId, studentParams.value],
        onSuccess: response => {
            students.value = response.data.records;
            studentPagination.value.current = response.data.current;
            studentPagination.value.total = response.data.total;
            studentPagination.value.size = response.data.size;
        },
    }
);

// 成绩编辑相关
const isEditingScores = ref(false);
const savingScores = ref(false);

// 切换编辑模式
const toggleEditMode = () => {
    isEditingScores.value = !isEditingScores.value;
};

// 保存学生成绩
const saveStudentScore = async (studentId: string, score: number) => {
    try {
        savingScores.value = true;
        await courseService.setCourseScore(props.courseId, props.teacherId, studentId, score);
        ElMessage.success('成绩保存成功');
    } catch (error) {
        console.error('保存成绩失败:', error);
        ElMessage.error('保存成绩失败');
    } finally {
        savingScores.value = false;
    }
};
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

                <div class="content-container">
                    <div class="assignments-section">
                        <h3>作业列表</h3>
                        <el-table :data="assignments" border stripe v-loading="assignmentLoading">
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
                        <el-pagination class="pagination" background layout="prev, pager, next" :total="assignmentPagination.total"
                            :current-page="assignmentPagination.current" :page-size="assignmentPagination.size" @current-change="(current: number) => {
                                assignmentParams.current = current;
                                fetchAssignmentList(courseId, teacherId, assignmentParams);
                            }" />
                    </div>

                    <div class="students-section" v-if="userStore.user?.roleName === 'teacher'">
                        <div class="section-header">
                            <h3>学生列表</h3>
                            <el-button 
                                type="primary" 
                                size="small" 
                                @click="toggleEditMode"
                            >
                                {{ isEditingScores ? '完成' : '编辑成绩' }}
                            </el-button>
                        </div>
                        <el-table :data="students" border stripe v-loading="studentLoading || savingScores">
                            <el-table-column label="学号" prop="studentId"></el-table-column>
                            <el-table-column label="姓名" prop="studentName"></el-table-column>
                            <el-table-column label="选课时间" prop="selectionTime">
                                <template #default="{ row }">
                                    {{ new Date(row.selectionTime).toLocaleString() }}
                                </template>
                            </el-table-column>
                            <el-table-column label="成绩" prop="score">
                                <template #default="{ row }">
                                    <template v-if="isEditingScores">
                                        <el-input-number 
                                            v-model="row.score" 
                                            :min="0" 
                                            :max="100" 
                                            size="small"
                                            @change="(value) => saveStudentScore(row.studentId, value)"
                                        ></el-input-number>
                                    </template>
                                    <span v-else>{{ row.score || '-' }}</span>
                                </template>
                            </el-table-column>
                        </el-table>
                        <el-pagination class="pagination" background layout="prev, pager, next" :total="studentPagination.total"
                            :current-page="studentPagination.current" :page-size="studentPagination.size" @current-change="(current: number) => {
                                studentParams.current = current;
                                fetchStudentList(courseId, teacherId, studentParams);
                            }" />
                    </div>
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

        .content-container {
            margin-top: 20px;
            display: flex;
            gap: 20px;

            .assignments-section, .students-section {
                flex: 1;
                min-width: 0;
                
                .section-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 16px;
                    
                    h3 {
                        margin: 0;
                    }
                }

                .pagination {
                    margin-top: 16px;
                    display: flex;
                    justify-content: center;
                }
            }
        }
    }
}
</style>