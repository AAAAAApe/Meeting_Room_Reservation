<template>
    <div class="layout-container">
        <!-- 个人信息表格 -->
        <el-descriptions title="个人信息" border>
            <el-descriptions-item :label="userIdLabelName">
                {{ userStore.user?.userId }}
            </el-descriptions-item>

            <span v-if="userStore.user?.roleName === 'employee' || userStore.user?.roleName === 'customer'">
                <el-descriptions-item label="姓名">{{ profile?.name }}</el-descriptions-item>
                <el-descriptions-item label="性别">{{ profile?.gender }}</el-descriptions-item>
                <el-descriptions-item label="生日">{{ profile?.birthday }}</el-descriptions-item>
                <el-descriptions-item label="电话">{{ profile?.phoneNumber }}</el-descriptions-item>
                <el-descriptions-item label="电子邮件">{{ profile?.email }}</el-descriptions-item>
                <el-descriptions-item :label="startYearLabelName">{{ profile?.startYear }}</el-descriptions-item>
                <el-descriptions-item label="所属部门">{{ profile?.departmentName }}</el-descriptions-item>
                <el-descriptions-item label="职称" v-if="userStore.user.roleName === 'employee'">{{ profile?.title }}</el-descriptions-item>
                <el-descriptions-item label="专业名称" v-if="userStore.user?.roleName === 'customer'">
                    {{ profile?.major }}
                </el-descriptions-item>
            </span>
        </el-descriptions>
    </div>
</template>
<style lang="scss" scoped>
.layout-container {
    padding: 10px;
}
</style>

<script setup lang="ts">
import { ref } from "vue";
import { userService } from "../api";
import { useUserStore } from "../stores/userStore";
import { useRequest } from "vue-hooks-plus";
import type { EmployeeInfo, CustomerInfo } from "../api/types";

// 确保 roleName 存在
const userStore = useUserStore();
if (userStore.user?.roleName) {
    userService.fetchCurrentUser();
}

// 根据角色显示不同的标签名
const userIdLabelName = (() => {
    switch (userStore.user?.roleName) {
        case "admin":
            return "管理员ID";
        case "employee":
            return "教工号";
        case "customer":
            return "学号";
    }
})();
const startYearLabelName = userStore.user?.roleName === "employee" ? "入职年份" : "入学年份";

// 个人信息
const profile = ref<(EmployeeInfo & CustomerInfo) | null>(null);

// 根据角色获取个人信息
switch (userStore.user?.roleName) {
    case "admin":
        break;
    case "employee":
        useRequest(userService.getEmployeeProfile, {
            onSuccess: (data) => {
                profile.value = data.data;
            },
        });
        break;
    case "customer":
        useRequest(userService.getCustomerProfile, {
            onSuccess: (data) => {
                profile.value = data.data;
            },
        });
        break;
}
</script>
