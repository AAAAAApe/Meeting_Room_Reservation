<template>
  <el-container class="layout-container">
    <!-- 顶栏 -->
    <el-header class="main-header">
      <div class="header-content">
        <h1>你好</h1>
        <div class="toolbar">
          <el-button type="danger">button</el-button>
        </div>
      </div>
    </el-header>

    <el-container class="main-container">

      <el-aside class="sidebar-container">
        <el-scrollbar height="100vh">
          <Sidebar />
        </el-scrollbar>
      </el-aside>

      <el-main>
        <el-scrollbar height="100vh">
          <el-table :data="tableData">
            <el-table-column prop="date" label="Date" width="140" />
            <el-table-column prop="name" label="Name" width="120" />
            <el-table-column prop="address" label="Address" />
          </el-table>
        </el-scrollbar>
      </el-main>

    </el-container>
  </el-container>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import Sidebar from '../components/Sidebar.vue'  // 导入侧边栏组件

const item = {
  date: '2016-05-02',
  name: 'Tom',
  address: 'No. 189, Grove St, Los Angeles',
}
const tableData = ref(Array.from({ length: 40 }).fill(item))
</script>

<style lang="scss" scoped>
.layout-container {
  height: 100vh;

  .main-header {
    height: $header-height;
    border-bottom: 1px solid #ddd;

    .header-content {
      display: flex;
      align-items: center;
      height: 100%;

      .toolbar {
        margin-left: auto;
      }
    }
  }

  .main-container {
    height: calc(100% - $header-height);

    .sidebar-container {
      width: 250px;
    }
  }
}
</style>