<script setup lang="ts">
import { ref } from 'vue';
import { useRequest } from 'vue-hooks-plus'
import { departmentService, userService } from '../api/index';
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
        <h2>顾客列表</h2>
        &nbsp;记录数：{{ pagination.total }}
      </div>
      <div class="tool-bar">
        <!-- 姓名筛选 -->
        <el-input v-model="nameFilter" placeholder="姓名筛选" clearable style="width: 150px; margin-right: 10px;" />

        <!-- 顾客ID筛选 -->
        <el-input v-model="userIdFilter" placeholder="顾客ID筛选" clearable style="width: 150px; margin-right: 10px;" />

        <!-- 院系筛选 多选下拉框 -->
        <el-select class="dp-selector" v-model="departmentsSelected" placeholder="院系筛选" multiple collapse-tags
          collapse-tags-tooltip>
          <el-option v-for="item in departmentList?.data" :key="item.departmentId" :label="item.departmentName"
            :value="item.departmentName" />
        </el-select>

        <!-- 确认按钮 -->
        <el-button type="success" plain @click="handleFilterChange">确认</el-button>
      </div>
    </el-header>
    <el-main class="table-container">
      <el-table class="table-content" :data="customerList" border stripe v-loading="loading">
        <el-table-column label="顾客ID" prop="userId" width="120">
        </el-table-column>
        <el-table-column label="姓名" prop="name" width="100">
        </el-table-column>
        <el-table-column label="性别" width="80">
          <template #default="scope">
            {{ scope.row.gender || '未设置' }}
          </template>
        </el-table-column>
        <el-table-column label="所属院系" prop="departmentName">
        </el-table-column>
        <el-table-column label="专业" prop="major">
          <template #default="scope">
            {{ scope.row.major || '未设置' }}
          </template>
        </el-table-column>
        <el-table-column label="学分" prop="credit" width="80">
          <template #default="scope">
            {{ scope.row.credit || '0' }}
          </template>
        </el-table-column>
        <el-table-column label="入学年份" prop="startYear" width="100">
          <template #default="scope">
            {{ scope.row.startYear || '未设置' }}
          </template>
        </el-table-column>
        <el-table-column label="联系电话" prop="phoneNumber" width="150">
          <template #default="scope">
            {{ scope.row.phoneNumber || '未设置' }}
          </template>
        </el-table-column>
        <el-table-column label="邮箱" prop="email" show-overflow-tooltip>
          <template #default="scope">
            {{ scope.row.email || '未设置' }}
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