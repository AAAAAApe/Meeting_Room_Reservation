<script setup lang="ts">
import { ref, onMounted } from 'vue'
import type { ElForm } from 'element-plus'
import request from '../../utils/request'
import { requestWithoutAuth } from '../../utils/request'
import { useUserStore } from '../../stores/userStore'
import { useRouter } from 'vue-router'
import tokenService from '../../utils/tokenService'

const router = useRouter()
const userStore = useUserStore()

// 在组件挂载时检查token是否有效
onMounted(async () => {
  const token = tokenService.getToken()
  if (token) {
    try {
      const response = await request.get('/user')
      if (response.data.code === 200) {
        // 创建用户对象
        const userData = {
          userId: response.data.userId,
          role: response.data.roleName,
          name: response.data.userName
        }
        // 使用 userStore 存储用户信息
        userStore.setUser(userData)
        // 跳转到首页
        router.push('/')
      }
    }
    catch (error) {
      // 请求失败，可能是token无效或已过期
      // 拦截器会自动处理token刷新和重试
      // 如果刷新失败，拦截器会清除token并重定向到登录页
      console.error('获取用户信息失败', error)
    }
  }
})

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

const form = ref<InstanceType<typeof ElForm>>()

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
      // 发送登录请求（使用不带token验证的请求实例）
      const response = await requestWithoutAuth.post('/login', {
        userId: loginForm.value.username,
        password: loginForm.value.password
      })

      if (response.data.code === 200) {
        // 存储 Token
        tokenService.setToken(response.data.token)
        // refreshToken由服务器通过httpOnly cookie管理，不需要在前端处理

        // 创建用户对象
        const userData = {
          userId: loginForm.value.username,
          role: response.data.role,
          name: response.data.userName
        }

        // 使用 userStore 存储用户信息
        userStore.setUser(userData)

        // 跳转到首页
        router.push('/')
      } else {
        errorMessage.value = response.data.message || '账号或密码错误'
      }
    } catch (error: any) {
      console.error(error)
      errorMessage.value = error.response?.data?.message || '登录失败，请稍后重试'
    } finally {
      loading.value = false
    }
  })
}
</script>



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

        <!-- 错误信息显示 -->
        <div v-if="errorMessage" class="error-message">{{ errorMessage }}</div>

        <!-- 登陆按钮 -->
        <el-button class="login-btn" type="primary" :loading="loading" @click="handleLogin">登陆</el-button>
      </el-form>

    </div>
  </div>
</template>

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

      .error-message {
        color: #f56c6c;
        font-size: 12px;
        margin-bottom: 10px;
        text-align: center;
      }
    }
  }
}
</style>