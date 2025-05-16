<script setup lang="ts">
import {reactive, ref} from 'vue'
import {ElMessage, type FormInstance, type FormRules} from 'element-plus'
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
// 注册相关
const registerFormRef = ref<FormInstance>()
const registerDialogVisible = ref(false)
const registerForm = reactive({
  roleType: 'employee' as 'employee' | 'customer',
  name: '',
  password: '',
  gender: undefined as 0 | 1 | undefined,
  birthday: ''
})

const registerRules = reactive<FormRules>({
  roleType: [{ required: true, message: '请选择注册类型', trigger: 'change' }],
  name: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '长度在6到20个字符', trigger: 'blur' }
  ]
})

// 显示注册对话框
const showRegisterDialog = () => {
  registerDialogVisible.value = true
}

// 处理注册提交
const handleRegister = async () => {
  try {
    // 表单验证
    await registerFormRef.value?.validate()

    // 调用注册接口
    await userService.register({
      roleType: registerForm.roleType,
      name: registerForm.name,
      password: registerForm.password,
      gender: registerForm.gender,
      birthday: registerForm.birthday
    })

    ElMessage.success('注册成功')
    registerDialogVisible.value = false

    // 清空表单
    registerFormRef.value?.resetFields()
  } catch (error: any) {
    if (error.response?.data?.message) {
      ElMessage.error(error.response.data.message)
    } else if (!error.message.includes('validate')) {
      ElMessage.error('注册失败，请稍后重试')
    }
  }
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
        <div class="register-action">
          <el-button type="text" @click="showRegisterDialog">没有账号？立即注册</el-button>
        </div>
      </el-form>
      <el-dialog v-model="registerDialogVisible" title="用户注册" width="30%">
        <el-form :model="registerForm" :rules="registerRules" ref="registerFormRef">
          <!-- 角色类型选择 -->
          <el-form-item label="注册类型" prop="roleType">
            <el-radio-group v-model="registerForm.roleType">
              <el-radio label="employee">员工</el-radio>
              <el-radio label="customer">顾客</el-radio>
            </el-radio-group>
          </el-form-item>

          <!-- 姓名 -->
          <el-form-item label="姓名" prop="name">
            <el-input v-model="registerForm.name" placeholder="请输入真实姓名"/>
          </el-form-item>

          <!-- 密码 -->
          <el-form-item label="密码" prop="password">
            <el-input
                v-model="registerForm.password"
                type="password"
                placeholder="6-20位字母数字组合"
                show-password
            />
          </el-form-item>

          <!-- 性别 -->
          <el-form-item label="性别">
            <el-radio-group v-model="registerForm.gender">
              <el-radio :label="1">男</el-radio>
              <el-radio :label="0">女</el-radio>
            </el-radio-group>
          </el-form-item>

          <!-- 出生日期 -->
          <el-form-item label="出生日期">
            <el-date-picker
                v-model="registerForm.birthday"
                type="date"
                placeholder="选择生日"
                value-format="YYYY-MM-DD"
            />
          </el-form-item>
        </el-form>

        <template #footer>
          <el-button @click="registerDialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleRegister">立即注册</el-button>
        </template>
      </el-dialog>
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