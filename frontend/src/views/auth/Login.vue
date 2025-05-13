<script setup lang="ts">
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import axios from 'axios'
import type { ElForm } from 'element-plus'
import { useTokenStore } from '../../stores/tokenStore'
import { useUserStore } from '../../stores/userStore'
import { useRouter } from 'vue-router'
import { userService } from '../../api'
import tokenService from '../../utils/http/tokenService'
import { useRequest } from 'vue-hooks-plus'

const router = useRouter()

const tokenStore = useTokenStore()
const userStore = useUserStore()

if (tokenStore.token && userStore.user?.roleName) {
  switch (userStore.user.roleName) {
    case 'admin':
      router.push('/meetingRooms')
      break
    case 'employee':
      router.push('/employee/meetingRooms')
      break
    case 'customer':
      router.push('/meetingRooms')
      break
    default:
      router.push('/')
      break
  }
}

// 定义登录表单数据
const loginForm = ref({
  userId: '',
  password: ''
})

// 定义表单验证规则
const rules = ref({
  userId: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
})

const form = ref<InstanceType<typeof ElForm>>()

const { loading, runAsync: runLogin, data } = useRequest(
  userService.login,
  { manual: true })

// 处理登录事件
const handleLogin = async () => {
  // 校验表单
  const formRef = form.value
  if (!formRef) return
  await formRef.validate(async (valid) => {
    if (!valid) {
      // loading.value = false
      return
    }

    try {
      // 发送登录请求
      await runLogin(loginForm.value)
      if (data.value?.data.token) {
        // 存储 Token
        tokenService.setToken(data.value?.data.token)
        // refreshToken由服务器通过httpOnly cookie管理，不需要在前端处理

        // 跳转到首页
        switch (data.value.data.roleName) {
          case 'admin':
            router.push('/meetingRooms')
            break
          case 'employee':
            router.push('/employee/meetingRooms')
            break
          case 'customer':
            router.push('/meetingRooms')
            break
          default:
            router.push('/')
            break
        }
      } else {
        // 显示错误信息
      }
    } catch (error) {
      console.error('登录失败', error);

      // 其他类型错误由响应拦截器处理
      if (axios.isAxiosError(error) && error.response?.status === 401) {
        ElMessage.error('账号或密码错误');
      }
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
          <el-input placeholder="请输入账号" v-model="loginForm.userId" />
        </el-form-item>

        <!-- 密码输入 -->
        <el-form-item class="password-input" prop="password">
          <el-input type="password" placeholder="请输入密码" v-model="loginForm.password" />
        </el-form-item>

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