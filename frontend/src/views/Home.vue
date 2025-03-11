<template>
  <el-container class="layout-container">
    <!-- 顶栏 -->
    <el-header class="main-header">
      <div class="header-content">
        <!-- title -->
        <h1>你好</h1>
        <!-- 工具栏 -->
        <div class="toolbar">
          <el-button type="danger" @click="handleSignOut">Sign Out</el-button>
        </div>
      </div>
    </el-header>

    <el-container class="main-container">
      <!-- 侧边栏 -->
      <el-aside class="sidebar-container">
        <el-scrollbar height="100vh">
          <Sidebar />
        </el-scrollbar>
      </el-aside>

      <!-- 主内容区 -->
      <el-main>
        <el-scrollbar>
          <router-view />
        </el-scrollbar>
      </el-main>

    </el-container>
  </el-container>
</template>

<script lang="ts" setup>
import Sidebar from '../components/Sidebar.vue'  // 导入侧边栏组件
import { useRouter } from 'vue-router'
import { RouterView } from 'vue-router'
import { ElMessageBox } from 'element-plus'

const router = useRouter()

// 处理退出登录
const handleSignOut = async () => {
  try {
    await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    // 清除本地存储的用户信息和token
    localStorage.removeItem('token')
    localStorage.removeItem('user')
    
    // 跳转到登录页
    router.push('/login')
  } catch {
    // 用户取消退出登录，不做任何操作
  }
}
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