<script setup lang="ts">
import { ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { courseService } from '../api/index';
import type { CourseWithTeacherInfo, PaginationParams } from '../api/types';

// 存储课程列表数据，用于表格展示
const courseList = ref<CourseWithTeacherInfo[]>([]);

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
  courseService.getTeacherCourses,
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
</script>

<template>
  <el-container class="main-container">
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
        <el-table-column label="所属院系" prop="departmentName">
        </el-table-column>
        <el-table-column label="课程名称" prop="courseName">
        </el-table-column>
        <el-table-column label="课程学分" prop="credit" width="100px">
          <template #default="scope">
            {{ scope.row.credit.toFixed(1) }}
          </template>
        </el-table-column>
        <el-table-column label="课程简介" prop="description" show-overflow-tooltip>
        </el-table-column>
        <el-table-column label="学生人数" prop="studentCount">
        </el-table-column>
        <el-table-column label="创建者" prop="creatorName" width="150px">
          <template #default="scope">
            {{ scope.row.creatorName || scope.row.creatorId }}
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