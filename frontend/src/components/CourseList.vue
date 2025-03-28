<script setup lang="ts">
import { ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { courseService, departmentService } from '../api/index';
import type { CourseInfo, PaginationParams } from '../api/types';

// 存储课程列表数据，用于表格展示
const courseList = ref<CourseInfo[]>([]);

// 存储用户选择的院系ID数组，用于筛选课程
const departmentsSelected = ref([]);

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
  size: pagination.value.size
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
  fetchCourseList(params.value);
};

// 处理院系筛选变化事件
// 当用户点击确认按钮时触发
const handleDepartmentChange = () => {
  console.log(departmentsSelected.value);
  // 重置页码为1并重新获取数据
  fetchCourseList({
    current: 1,
    size: pagination.value.size
  },
    departmentsSelected.value);
};
</script>

<template>
  <el-container class="main-container">
    <el-header class="main-header">
      <div class="title-container">
        <h2>课程列表</h2>
      </div>
      <div class="tool-bar">
        <!-- 院系筛选 多选下拉框 -->
        <el-select class="toolbar-item dp-selector" v-model="departmentsSelected" placeholder="院系筛选" multiple collapse-tags collapse-tags-tooltip>
          <el-option v-for="item in departmentList?.data" :key="item.departmentId" :label="item.departmentName"
            :value="item.departmentId" />
        </el-select>
        <!-- 确认按钮 -->
        <el-button class="toolbar-item" type="success" plain @click="handleDepartmentChange">确认</el-button>
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
        <el-table-column label="课程学分" prop="credit">
          <template #default="scope">
            {{ scope.row.credit.toFixed(1) }}
          </template>
        </el-table-column>
        <el-table-column label="课程简介" prop="description" show-overflow-tooltip>
        </el-table-column>
        <el-table-column label="创建者" prop="creatorName">
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

    .tool-bar {
      height: 100%;
      display: flex;
      align-items: center;

      .toolbar-item {
        margin-left: 10px;
      }

      .dp-selector {
        width: 240px;
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