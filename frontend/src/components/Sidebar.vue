<template>
  <el-menu :default-openeds="['1']" router>
    <!-- 管理员菜单 -->
    <div v-if="userRole === 'admin'">
      <el-menu-item index="/admin">
        <el-icon>
          <House />
        </el-icon>
        <span>仪表盘</span>
      </el-menu-item>


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

      <el-sub-menu index="3">
        <template #title>
          <el-icon>
            <Histogram />
          </el-icon>数据统计
        </template>
        <el-menu-item index="/admin/statistics/courses">课程统计</el-menu-item>
        <el-menu-item index="/admin/statistics/students">学生统计</el-menu-item>
        <el-menu-item index="/admin/statistics/teachers">教师统计</el-menu-item>
      </el-sub-menu>
    </div>

    <!-- 教师菜单 -->
    <template v-if="userRole === 'teacher'">
      <el-menu-item index="/teacher">
        <template #title>
          <el-icon>
            <House />
          </el-icon>仪表盘
        </template>
      </el-menu-item>

      <el-sub-menu index="1">
        <template #title>
          <el-icon>
            <Reading />
          </el-icon>课程管理
        </template>
        <el-menu-item index="/teacher/courses">我的课程</el-menu-item>
        <el-menu-item index="/teacher/courses/create">发布课程</el-menu-item>
      </el-sub-menu>

      <el-sub-menu index="2">
        <template #title>
          <el-icon>
            <Files />
          </el-icon>教学资源
        </template>
        <el-menu-item index="/teacher/resources">资源管理</el-menu-item>
        <el-menu-item index="/teacher/resources/upload">上传资源</el-menu-item>
      </el-sub-menu>

      <el-sub-menu index="3">
        <template #title>
          <el-icon>
            <Document />
          </el-icon>作业管理
        </template>
        <el-menu-item index="/teacher/assignments">作业列表</el-menu-item>
        <el-menu-item index="/teacher/assignments/create">布置作业</el-menu-item>
        <el-menu-item index="/teacher/assignments/grade">批改作业</el-menu-item>
      </el-sub-menu>

      <el-sub-menu index="4">
        <template #title>
          <el-icon>
            <DataLine />
          </el-icon>成绩管理
        </template>
        <el-menu-item index="/teacher/grades">成绩评定</el-menu-item>
        <el-menu-item index="/teacher/grades/analysis">成绩分析</el-menu-item>
      </el-sub-menu>
    </template>

    <!-- 学生菜单 -->
    <template v-if="userRole === 'student'">
      <el-menu-item index="/student">
        <template #title>
          <el-icon>
            <House />
          </el-icon>仪表盘
        </template>
      </el-menu-item>

      <el-sub-menu index="1">
        <template #title>
          <el-icon>
            <Reading />
          </el-icon>课程学习
        </template>
        <el-menu-item index="/student/courses">课程列表</el-menu-item>
        <el-menu-item index="/student/courses/selected">我的课程</el-menu-item>
        <el-menu-item index="/student/courses/schedule">学习计划</el-menu-item>
      </el-sub-menu>

      <el-sub-menu index="2">
        <template #title>
          <el-icon>
            <Files />
          </el-icon>学习资源
        </template>
        <el-menu-item index="/student/resources">资源下载</el-menu-item>
        <el-menu-item index="/student/resources/favorite">收藏资源</el-menu-item>
      </el-sub-menu>

      <el-sub-menu index="3">
        <template #title>
          <el-icon>
            <Document />
          </el-icon>作业管理
        </template>
        <el-menu-item index="/student/assignments">作业列表</el-menu-item>
        <el-menu-item index="/student/assignments/submitted">已交作业</el-menu-item>
      </el-sub-menu>

      <el-sub-menu index="4">
        <template #title>
          <el-icon>
            <DataLine />
          </el-icon>成绩查询
        </template>
        <el-menu-item index="/student/grades">成绩列表</el-menu-item>
        <el-menu-item index="/student/grades/analysis">成绩分析</el-menu-item>
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
      <el-menu-item index="/change-password">修改密码</el-menu-item>
      <el-menu-item index="/messages">消息通知</el-menu-item>
    </el-sub-menu>
  </el-menu>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useUserStore } from '../stores/userStore'
import {
  House,
  User,
  Reading,
  Document,
  Files,
  DataLine,
  Histogram,
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