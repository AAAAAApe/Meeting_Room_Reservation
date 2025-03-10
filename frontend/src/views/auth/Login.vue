<template>
  <div class="login-container">
    <div class="login-box">
      <h1 class="title">Login Here</h1>

      <el-form class="login-form" ref="form" :model="loginForm" :rules="rules">
        <!-- 账号输入 -->
        <el-form-item class="id-input" prop="username">
          <el-input placeholder="请输入账号" v-model="loginForm.username" />
        </el-form-item>

        <!-- 密码输入 -->
        <el-form-item class="password-input" prop="password">
          <el-input type="password" placeholder="请输入密码" v-model="loginForm.password" />
        </el-form-item>

        <!-- 登陆按钮 -->
        <el-button class="login-btn" type="primary" @click="handleLogin">登陆</el-button>
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
const rules = ref({
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
})

// 处理登录事件
const handleLogin = async () => {
  loading.value = true
  errorMessage.value = ''

  // 校验表单
  const formRef = form.value
  if (!formRef) return
  await formRef.validate(async (valid) => {
    if (!valid) {
      loading.value = false
      return
    }

    try {
      // 发送登录请求
      const response = await axios.post('/login', {
        userId: loginForm.value.username,
        password: loginForm.value.password
      })

      if (response.data.code === 200) {
        // 存储 Token 并跳转到首页
        localStorage.setItem('token', response.data.token)
        window.location.href = '/'
      } else {
        errorMessage.value = response.data.message || '登录失败'
      }
    } catch (error) {
      console.error(error)
    } finally {
      loading.value = false
    }
  })
}
</script>

<style lang="scss" scoped>
  .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;

    .login-box {
      width: 250px;
      margin-bottom: 100px;
      .title {
        text-align: center;
        margin: 10px;
      }
      .login-form {
        .login-btn {
          width: 100%;
        }
      }
    }
  }
</style>