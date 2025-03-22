<script setup lang="ts">
import { ref, onMounted } from 'vue';
import useRequest from '../hooks/useRequest';
import courseService from '../api/service/course';
import type { CourseInfo, PaginationParams } from '../api/types';

// 课程列表数据
const courseList = ref<CourseInfo[]>([]);

// 分页参数
const pagination = ref({
  current: 1,
  size: 10,
  total: 0
});

// 加载状态
const loading = ref(false);

// 使用useRequest hook获取课程列表数据
const { run: fetchCourseList, loading: fetchLoading } = useRequest(
  courseService.getCourseList,
  {
    onSuccess: (data) => {
      // 更新课程列表数据
      courseList.value = data.records;
      // 更新分页信息
      pagination.value.total = data.total;
      pagination.value.current = data.current;
      pagination.value.size = data.size;
    },
    showErrorMessage: true
  }
);

// 监听分页变化
const handleCurrentChange = (current: number) => {
  pagination.value.current = current;
  loadCourseList();
};

// 加载课程列表数据
const loadCourseList = () => {
  loading.value = true;
  const params: PaginationParams = {
    current: pagination.value.current,
    size: pagination.value.size
  };

  fetchCourseList(params).finally(() => {
    loading.value = false;
  });
};

// 组件挂载时加载数据
onMounted(() => {
  loadCourseList();
});
</script>

<template>
  <el-container class="main-container">
    <el-header class="main-header">
      <div class="title-container">
        <h2>课程列表</h2>
      </div>
      <div class="tool-bar">
        toolbar
      </div>
    </el-header>
    <el-main class="table-container">
      <el-table class="table-content" :data="courseList" border stripe v-loading="loading">
        <el-table-column label="课程编号" prop="courseId" width="100">
          <template #default="scope">
            {{ String(scope.row.courseId).padStart(6, '0') }}
          </template>
        </el-table-column>
        <el-table-column label="所属院系" prop="departmentName">
        </el-table-column>
        <el-table-column label="课程名称" prop="courseName">
        </el-table-column>
        <el-table-column label="授课教师" prop="teacherName">
        </el-table-column>
        <el-table-column label="课程学分" prop="credit">
        </el-table-column>
        <el-table-column label="已选人数" prop="studentCount">
        </el-table-column>
        <el-table-column label="课程简介" prop="description">
        </el-table-column>
        <el-table-column label="创建者" prop="creatorName">
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