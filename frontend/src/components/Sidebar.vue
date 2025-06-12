<template>
  <el-menu :default-openeds="['1']" router>
    <!-- 管理员菜单 -->
    <div v-if="userRole === 'admin'">
      <el-menu-item index="/meetingRooms">
        <el-icon>
          <Reading />
        </el-icon>
        <span>会议室管理</span>
      </el-menu-item>

      <el-sub-menu index="2">
        <template #title>
          <el-icon>
            <User />
          </el-icon>
          <span>用户管理</span>
        </template>
        <el-menu-item index="/employees">员工管理</el-menu-item>
        <el-menu-item index="/customers">顾客管理</el-menu-item>
      </el-sub-menu>
    </div>

    <!-- 员工菜单 -->
    <template v-if="userRole === 'employee'">
      <el-sub-menu index="1">
        <template #title>
          <el-icon>
            <Reading />
          </el-icon>会议室管理
        </template>
        <el-menu-item index="/employee/meetingRooms">我的会议室</el-menu-item>
        <el-menu-item index="/employee/cancelRequests">取消订单审核</el-menu-item>
        <el-menu-item index="/employee/query">查看预约订单</el-menu-item>
      </el-sub-menu>
    </template>

    <!-- 顾客菜单 -->
    <template v-if="userRole === 'customer'">
      <el-sub-menu index="1">
        <template #title>
          <el-icon>
            <Reading />
          </el-icon>会议室学习
        </template>
        <el-menu-item index="/meetingRooms">会议室列表</el-menu-item>
        <el-menu-item index="/customer/meetingRooms">我的会议室</el-menu-item>
      </el-sub-menu>
    </template>

    <!-- 所有角色都可见的公共菜单 -->
    <el-sub-menu index="5">
      <template #title>
        <el-icon>
          <User />
        </el-icon>个人中心
      </template>
      <el-menu-item index="/profile">个人信息</el-menu-item>

    </el-sub-menu>
  </el-menu>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useUserStore } from '../stores/userStore'
import {
  User,
  Reading,
} from '@element-plus/icons-vue'

const userStore = useUserStore()

const userRole = computed(() => userStore.user?.roleName || '')

// 添加默认导出
defineOptions({
  name: 'Sidebar'
})
</script>

<style lang="scss" scoped>
.el-aside {
  color: var(--el-text-color-primary);
  background: var(--el-color-primary-light-8);
}

.el-menu {
  border-right: none;
}
</style>