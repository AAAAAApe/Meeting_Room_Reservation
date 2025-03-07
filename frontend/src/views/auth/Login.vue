<template>
  <div class="login-container">
    <div class="login-box">
      <h1 class="title">Login Here</h1>

      <el-form ref="form" :model="loginForm">
        <!-- 用户名输入 -->
        <el-form-item label="用户名" prop="username">
          <el-input placeholder="请输入用户名" v-model="loginForm.username" />
        </el-form-item>

        <!-- 密码输入 -->
        <el-form-item label="密码" prop="password">
          <el-input type="password" placeholder="请输入密码" v-model="loginForm.password" />
        </el-form-item>

        <!-- 登陆按钮 -->
        <el-button type="primary" @click="handleLogin">登陆</el-button>
      </el-form>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import axios from 'axios'

const loginForm = ref({
  username: '',
  password: ''
})

const handleLogin = async () => {
  try {
    const response = await axios.post('/login', {
      userId: loginForm.value.username,
      password: loginForm.value.password
    })
  } catch (error) {
    console.error(error)
  }
}
</script>

<style></style>