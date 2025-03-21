<script setup lang="ts">
import { ref } from 'vue'
import type { ElForm } from 'element-plus'
import { useTokenStore } from '../../stores/tokenStore'
import { useUserStore } from '../../stores/userStore'
import { useRouter } from 'vue-router'
import { userService } from '../../api'
import tokenService from '../../utils/http/tokenService'
import useRequest from '../../hooks/useRequest'

const router = useRouter()

const tokenStore = useTokenStore()
const userStore = useUserStore()

if (tokenStore.token && userStore.user?.roleName) {
  switch (userStore.user.roleName) {
    case 'admin':
      router.push('/admin')
      break
    case 'teacher':
      router.push('/teacher')
      break
    case 'student':
      router.push('/student')
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

// 定义加载状态和错误信息
// const loading = ref(false)
const errorMessage = ref('')

// 定义表单验证规则
const rules = ref({
  userId: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
})

const form = ref<InstanceType<typeof ElForm>>()

const { loading, run: runLogin } = useRequest(
  userService.login,
  { showErrorMessage: false })

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
      const response = await runLogin(loginForm.value)
      if (response?.token) {
        // 存储 Token
        tokenService.setToken(response.token)
        // refreshToken由服务器通过httpOnly cookie管理，不需要在前端处理

        // 跳转到首页
        switch (response.roleName) {
          case 'admin':
            router.push('/admin')
            break
          case 'teacher':
            router.push('/teacher')
            break
          case 'student':
            router.push('/student')
            break
          default:
            router.push('/')
            break
        }
      } else {
        // 显示错误信息
      }
    } catch (error) {
      console.error('登录失败', error)
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
          <el-input placeholder="请输入账号" v-model="loginForm.userId" />
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