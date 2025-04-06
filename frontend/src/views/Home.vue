<template>
  <!-- 整体布局容器 -->
  <el-container class="layout-container">
    <!-- 顶栏 -->
    <!-- 顶部导航栏 -->
    <el-header class="main-header">
      <div class="header-content">
        <!-- title -->
        <h1>你好，{{ userName }}</h1>
        <!-- 工具栏 -->
        <div class="toolbar">
          <el-button type="danger" @click="handleSignOut">退出登录</el-button>
        </div>
      </div>
    </el-header>

    <el-container class="main-container">
      <!-- 侧边栏 -->
      <!-- 左侧导航菜单 -->
      <el-aside class="sidebar-container">
        <el-scrollbar height="100vh">
          <Sidebar />
        </el-scrollbar>
      </el-aside>

      <!-- 主内容区 -->
      <router-view class="main-content-container" />

    </el-container>
  </el-container>
</template>

<script lang="ts" setup>
import Sidebar from '../components/Sidebar.vue'  // 导入侧边栏组件
import { useRouter } from 'vue-router'
import { RouterView } from 'vue-router'
import { ElMessageBox } from 'element-plus'
import { useUserStore } from '../stores/userStore'
import tokenService from '../utils/http/tokenService'
import { userService } from '../api/index'
import { computed } from 'vue';

const router = useRouter()
const userStore = useUserStore()

// 初始化时获取当前用户信息
userService.fetchCurrentUser();

// 计算用户名显示逻辑：优先显示用户名，若不存在则显示用户ID
const userName = computed(() => userStore.user?.name ?? userStore.user?.userId);

// 处理退出登录
const handleSignOut = async () => {
  try {
    await ElMessageBox.confirm('确定要退出登录吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })

    // 1. 调用登出API接口
    // 2. 清除Pinia用户状态
    // 3. 移除本地存储的token
    // 4. 跳转至登录页面
    await userService.logout()
    // 清除用户信息
    userStore.clearUser()
    // 清除 cookie
    tokenService.clearToken()
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
    height: $main-header-height;
    /* 顶部导航栏固定高度 */
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
    height: calc(100% - $main-header-height);
    /* 动态计算内容区高度避免溢出 */

    .sidebar-container {
      width: 250px;
      /* 侧边栏固定宽度保持导航结构稳定 */
      border-right: 1px solid #ddd;
    }

    .main-content-container {
      height: 100%;
      width: 100%;
    }
  }
}
</style>