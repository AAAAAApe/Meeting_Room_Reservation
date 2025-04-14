<script setup lang="ts">
import { computed, ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { courseService, departmentService } from '../api/index';
import type { CourseInfo, PaginationParams } from '../api/types';
import CourseWithTeachersList from './CourseWithTeachersList.vue';
import CourseEditor from './CourseEditor.vue';
import { useUserStore } from '../stores/userStore';

const userStore = useUserStore();
const userRole = computed(() => userStore.user?.roleName || '');

// 存储课程列表数据，用于表格展示
const courseList = ref<CourseInfo[]>([]);

// 存储用户选择的院系ID数组，用于筛选课程
const departmentsSelected = ref([]);

// 翻页时携带参数，作用是提交筛选后，翻页时保留筛选条件
let departmentIdsParams: string[] = [];

// 获取院系列表数据，用于下拉筛选框
// 使用vue-hooks-plus的useRequest自动处理请求状态
const { data: departmentList } = useRequest(
  departmentService.getDepartmentList,
);

// 分页参数配置
// current: 当前页码
// size: 每页显示数量
// total: 总记录数
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
// run: 手动执行请求的方法
// loading: 请求加载状态
const { run: fetchCourseList, loading } = useRequest(
  courseService.getCourseList,
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
// current: 新的页码
const handleCurrentChange = (current: number) => {
  params.value.current = current;
  fetchCourseList(params.value, departmentIdsParams);
};

// 处理院系筛选变化事件
// 当用户点击确认按钮时触发
const handleDepartmentChange = () => {
  departmentIdsParams = departmentsSelected.value;
  // 重置页码为1并重新获取数据
  fetchCourseList({
    current: 1,
    size: pagination.value.size
  },
    departmentsSelected.value);
};

const showEditor = ref(false);
const showTeacherList = ref(false);
const currentCourseId = ref<number | null>(null);
const currentCourse = ref<CourseInfo | undefined>();

const handleCourseTeacherList = (course: CourseInfo) => {
  showTeacherList.value = true;
  currentCourseId.value = course.courseId;
}

const handleEditCourse = (course?: CourseInfo) => {
  currentCourse.value = course;
  showEditor.value = true;
}

const handleEditorSuccess = () => {
  fetchCourseList(params.value, departmentIdsParams);
}
</script>

<template>
  <el-container class="main-container">
    <!-- 课程编辑器弹窗 -->
    <el-dialog :title="currentCourse ? '编辑课程' : '发布课程'" width="95%" align-center v-model="showEditor" destroy-on-close>
      <CourseEditor
        :course="currentCourse"
        @success="handleEditorSuccess"
        @close="showEditor = false"
      />
    </el-dialog>

    <!-- 查看教师列表弹窗 -->
    <el-dialog v-model="showTeacherList" title="课程教师列表" align-center width="1000px" destroy-on-close>
      <CourseWithTeachersList v-if="currentCourseId" :courseId="currentCourseId" />
    </el-dialog>

    <el-header class="main-header">
      <div class="title-container">
        <h2>课程列表</h2>
      </div>
      <div class="tool-bar">
        <!-- 院系筛选 多选下拉框 -->
        <el-select class="dp-selector" v-model="departmentsSelected" placeholder="院系筛选" multiple collapse-tags
          collapse-tags-tooltip>
          <el-option v-for="item in departmentList?.data" :key="item.departmentId" :label="item.departmentName"
            :value="item.departmentId" />
        </el-select>
        <!-- 确认按钮 -->
        <el-button type="success" plain @click="handleDepartmentChange">搜索</el-button>
        <el-divider direction="vertical" />
        <el-button v-if="userRole === 'admin'" type="primary" plain @click="handleEditCourse()">发布课程</el-button>
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
        <el-table-column label="课程学分" prop="credit" width="100px">
          <template #default="scope">
            {{ scope.row.credit.toFixed(1) }}
          </template>
        </el-table-column>
        <el-table-column label="课程简介" prop="description" show-overflow-tooltip />
        <el-table-column label="创建者" prop="creatorName" width="150px">
          <template #default="scope">
            {{ scope.row.creatorName || scope.row.creatorId }}
          </template>
        </el-table-column>
        <el-table-column label="教师人数" prop="teacherCount" width="100px" />
        <el-table-column fixed="right" label="操作">
          <template #default="scope">
            <el-button type="primary" plain size="small" @click="handleCourseTeacherList(scope.row)">查看教师</el-button>
            <el-button v-if="userRole === 'admin'" type="warning" plain size="small" @click="handleEditCourse(scope.row)">编辑</el-button>
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