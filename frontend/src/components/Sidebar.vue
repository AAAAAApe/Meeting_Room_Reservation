<template>
  <el-menu :default-openeds="['1']" router>
    <!-- 管理员菜单 -->
    <div v-if="userRole === 'admin'">
      <el-menu-item index="/courses">
        <el-icon>
          <Reading />
        </el-icon>
        <span>课程管理</span>
      </el-menu-item>

      <el-sub-menu index="2">
        <template #title>
          <el-icon>
            <User />
          </el-icon>
          <span>用户管理</span>
        </template>
        <el-menu-item index="/teachers">教师管理</el-menu-item>
        <el-menu-item index="/students">学生管理</el-menu-item>
      </el-sub-menu>
    </div>

    <!-- 教师菜单 -->
    <template v-if="userRole === 'teacher'">
      <el-sub-menu index="1">
        <template #title>
          <el-icon>
            <Reading />
          </el-icon>课程管理
        </template>
        <el-menu-item index="/teacher/courses">我的课程</el-menu-item>
      </el-sub-menu>
    </template>

    <!-- 学生菜单 -->
    <template v-if="userRole === 'student'">
      <el-sub-menu index="1">
        <template #title>
          <el-icon>
            <Reading />
          </el-icon>课程学习
        </template>
        <el-menu-item index="/courses">课程列表</el-menu-item>
        <el-menu-item index="/student/courses">我的课程</el-menu-item>
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