<template>
  <div class="login-container">
    <div class="login-box">
      <h1 class="title">Login Here</h1>

      <el-form ref="form" :model="loginForm" :rules="rules">
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

// 定义登录表单数据
const loginForm = ref({
  username: '',
  password: ''
})

// 定义加载状态和错误信息
const loading = ref(false)
const errorMessage = ref('')

// 定义表单验证规则
const rules: {
  name: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }
}

// 处理登录事件
const handleLogin = async () => {
  loading.value = true
  errorMessage.value = ''

  try {
    // 发送登录请求
    const response = await axios.post('/login', {
      userId: loginForm.value.username,
      password: loginForm.value.password
    })

    // 如果登录成功，保存token并跳转到首页
    if (response.data.code === 200) {
      localStorage.setItem('token', response.data.token)
      
      window.location.href = '/'
    } else {
      // 如果登录失败，显示错误信息
      errorMessage.value = response.data.message || '登录失败'
    }
  } catch (error) {
    // 如果发生错误，打印错误信息
    console.error(error)
  } finally {
    // 无论登录成功与否，都关闭加载状态
    loading.value = false
  }
}
</script>

<style></style>