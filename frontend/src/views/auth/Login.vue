<template>
    <div class="login-container">
        <div class="login-box">
            <h1 class="title">Login Here</h1>
            
            <el-form ref="form" :model="loginForm">
              <el-form-item label="用户名" prop="username">
                <el-input placeholder="请输入用户名" v-model="loginForm.username" />
              </el-form-item>
              <el-form-item label="密码" prop="password">
                <el-input type="password" placeholder="请输入密码" v-model="loginForm.password" />
              </el-form-item>

              <el-button type="primary" @click="">登陆</el-button>
            </el-form>

        </div>
    </div>
</template>

<script setup lang="ts">
    import { ref } from 'vue'
    
    const loginForm = ref({
      username: '',
      password: ''
    })
</script>

<style>
</style>