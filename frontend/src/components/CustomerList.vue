<script setup lang="ts">
import { ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { userService } from '../api/index';
import type { PaginationParams, CustomerInfo } from '../api/types';

// 存储顾客列表数据，用于表格展示
const customerList = ref<CustomerInfo[]>([]);

// 筛选条件
const nameFilter = ref('');
const userIdFilter = ref('');
const departmentsSelected = ref([]);

// 翻页时携带参数，作用是提交筛选后，翻页时保留筛选条件
let filterParams: {
  name?: string;
  userId?: string;
  departmentNames?: string[];
} = {};

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

// 获取顾客列表数据
// run: 手动执行请求的方法
// loading: 请求加载状态
const { run: fetchCustomerList, loading } = useRequest(
  userService.getCustomerList,
  {
    // 请求成功回调
    onSuccess: data => {
      // 更新顾客列表数据
      customerList.value = data.data.records;
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
  fetchCustomerList({
    ...params.value,
    ...filterParams
  });
};

// 处理筛选条件变化事件
// 当用户点击确认按钮时触发
const handleFilterChange = () => {
  // 构建筛选参数
  filterParams = {};

  if (nameFilter.value) {
    filterParams.name = nameFilter.value;
  }

  if (userIdFilter.value) {
    filterParams.userId = userIdFilter.value;
  }

  if (departmentsSelected.value.length > 0) {
    filterParams.departmentNames = departmentsSelected.value;
  }

  // 重置页码为1并重新获取数据
  fetchCustomerList({
    current: 1,
    size: pagination.value.size,
    ...filterParams
  });
};

</script>

<template>
  <el-container class="main-container">
    <el-header class="main-header">
      <div class="title-container">
        <h2 class="title">顾客列表</h2>
        <span class="record-count">记录数：{{ pagination.total }}</span>
      </div>
      <div class="tool-bar">
        <!-- 姓名筛选 -->
        <el-input v-model="nameFilter" placeholder="姓名筛选" clearable class="filter-input" prefix-icon="el-icon-search" />

        <!-- 顾客ID筛选 -->
        <el-input v-model="userIdFilter" placeholder="顾客ID筛选" clearable class="filter-input"
          prefix-icon="el-icon-user" />

        <!-- 院系筛选 多选下拉框 -->
        <!-- <el-select class="dp-selector" v-model="departmentsSelected" placeholder="院系筛选" multiple collapse-tags
          collapse-tags-tooltip>
          <el-option v-for="item in departmentList?.data" :key="item.departmentId" :label="item.departmentName"
            :value="item.departmentName" />
        </el-select> -->

        <!-- 确认按钮 -->
        <el-button type="primary" @click="handleFilterChange" class="search-button">
          <i class="el-icon-search"></i>
          搜索
        </el-button>
      </div>
    </el-header>
    <el-main class="table-container">
      <el-table class="table-content" :data="customerList" border stripe v-loading="loading"
        :header-cell-class-name="'table-header'" :row-class-name="tableRowClassName">
        <el-table-column label="客户ID" prop="userId" width="120">
          <template #default="scope">
            <span class="customer-id">{{ scope.row.userId }}</span>
          </template>
        </el-table-column>
        <el-table-column label="姓名" prop="name" width="100">
          <template #default="scope">
            <span class="customer-name">{{ scope.row.name }}</span>
          </template>
        </el-table-column>
        <el-table-column label="注册时间" prop="startYear" width="100">
          <template #default="scope">
            <span class="start-year">{{ scope.row.startYear || '未设置' }}</span>
          </template>
        </el-table-column>
        <el-table-column label="联系电话" prop="phoneNumber" width="150">
          <template #default="scope">
            <span class="phone-number">{{ scope.row.phoneNumber || '未设置' }}</span>
          </template>
        </el-table-column>
        <el-table-column label="邮箱" prop="email" show-overflow-tooltip>
          <template #default="scope">
            <span class="email">{{ scope.row.email || '未设置' }}</span>
          </template>
        </el-table-column>
      </el-table>
    </el-main>
    <el-footer class="main-footer">
      <el-pagination class="pagination" background layout="prev, pager, next, jumper" :total="pagination.total"
        :current-page="pagination.current" :page-size="pagination.size" @current-change="handleCurrentChange" />
    </el-footer>
  </el-container>
</template>

<style lang="scss" scoped>
.main-container {
  height: 100%;
  background-color: #f5f7fa;

  .main-header {
    height: $main-content-header-footer-height;
    background-color: #fff;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
    border-bottom: 1px solid #ebeef5;

    .title-container {
      height: 100%;
      display: flex;
      align-items: center;

      .title {
        margin: 0;
        font-size: 18px;
        font-weight: 600;
        color: #303133;
      }

      .record-count {
        margin-left: 10px;
        color: #909399;
        font-size: 14px;
      }
    }

    .tool-bar {
      height: 100%;
      display: flex;
      align-items: center;
      gap: 10px;

      .filter-input {
        width: 160px;
        transition: all 0.3s;

        &:focus-within {
          width: 180px;
        }
      }

      .dp-selector {
        width: 240px;
      }

      .search-button {
        margin-left: 5px;
      }
    }
  }

  .table-container {
    height: calc(100% - 2 * $main-content-header-footer-height);
    overflow: auto;
    padding: 20px;

    .table-content {
      height: 100%;
      background-color: #fff;
      border-radius: 4px;
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);

      .customer-id {
        font-family: monospace;
        color: #606266;
      }

      .customer-name {
        font-weight: 500;
        color: #303133;
      }

      .company-name {
        color: #409EFF;
      }

      .start-year {
        color: #606266;
      }

      .phone-number {
        font-family: monospace;
        color: #606266;
      }

      .email {
        color: #606266;
      }
    }

    :deep(.table-header) {
      background-color: #f5f7fa;
      color: #303133;
      font-weight: 600;
    }
  }

  .main-footer {
    height: $main-content-header-footer-height;
    background-color: #fff;
    padding: 0 20px;
    display: flex;
    justify-content: center;
    align-items: center;
    box-shadow: 0 -2px 12px rgba(0, 0, 0, 0.05);
    border-top: 1px solid #ebeef5;

    .pagination {
      height: 100%;
      display: flex;
      align-items: center;
    }
  }
}

// 表格行样式
:deep(.el-table__row) {
  &:hover {
    background-color: #f5f7fa !important;
  }
}

// 添加表格行交替样式
:deep(.el-table--striped .el-table__body tr.el-table__row--striped td) {
  background-color: #fafafa;
}
</style>