<template>
    <div class="admin-dashboard">
        <!-- 欢迎信息 -->
        <el-card class="welcome-card">
            <template #header>
                <div class="card-header">
                    <span>欢迎回来</span>
                </div>
            </template>
            <div class="user-info">
                <el-avatar :size="64" :src="userStore.user?.avatar">
                    {{ userStore.user?.username?.charAt(0).toUpperCase() }}
                </el-avatar>
                <div class="info-details">
                    <h3>{{ userStore.user?.userId || '管理员' }}</h3>
                    <p>上次登录时间: {{ userStore.user?.lastLoginTime || '未知' }}</p>
                </div>
            </div>
        </el-card>

        <!-- 统计卡片 -->
        <el-row :gutter="20" class="statistics">
            <el-col :span="6">
                <el-card class="statistic-card">
                    <template #header>
                        <div class="card-header">
                            <span>总课程数</span>
                        </div>
                    </template>
                    <div class="statistic-value">
                        <el-statistic :value="statistics.courses">
                            <template #prefix>
                                <el-icon><Reading /></el-icon>
                            </template>
                        </el-statistic>
                    </div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card class="statistic-card">
                    <template #header>
                        <div class="card-header">
                            <span>总教师数</span>
                        </div>
                    </template>
                    <div class="statistic-value">
                        <el-statistic :value="statistics.teachers">
                            <template #prefix>
                                <el-icon><User /></el-icon>
                            </template>
                        </el-statistic>
                    </div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card class="statistic-card">
                    <template #header>
                        <div class="card-header">
                            <span>总学生数</span>
                        </div>
                    </template>
                    <div class="statistic-value">
                        <el-statistic :value="statistics.students">
                            <template #prefix>
                                <el-icon><User /></el-icon>
                            </template>
                        </el-statistic>
                    </div>
                </el-card>
            </el-col>
            <el-col :span="6">
                <el-card class="statistic-card">
                    <template #header>
                        <div class="card-header">
                            <span>待审核课程</span>
                        </div>
                    </template>
                    <div class="statistic-value">
                        <el-statistic :value="statistics.pendingCourses">
                            <template #prefix>
                                <el-icon><Document /></el-icon>
                            </template>
                        </el-statistic>
                    </div>
                </el-card>
            </el-col>
        </el-row>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useUserStore } from '../../stores/userStore'
import { User, Reading, Document } from '@element-plus/icons-vue'
import request from '../../utils/request'

const userStore = useUserStore()

// 统计数据
const statistics = ref({
    courses: 0,
    teachers: 0,
    students: 0,
    pendingCourses: 0
})

// 获取统计数据
const fetchStatistics = async () => {
    try {
        const response = await request.get('/admin/statistics')
        if (response.data.code === 200) {
            statistics.value = response.data.data
        }
    } catch (error) {
        console.error('获取统计数据失败:', error)
    }
}

onMounted(() => {
    fetchStatistics()
})
</script>

<style lang="scss" scoped>
.admin-dashboard {
    padding: 20px;

    .welcome-card {
        margin-bottom: 20px;

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;

            .info-details {
                h3 {
                    margin: 0 0 8px 0;
                }
                p {
                    margin: 0;
                    color: #666;
                }
            }
        }
    }

    .statistics {
        .statistic-card {
            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .statistic-value {
                text-align: center;
                padding: 20px 0;

                :deep(.el-statistic) {
                    --el-statistic-content-font-size: 24px;
                }

                .el-icon {
                    margin-right: 8px;
                    font-size: 20px;
                }
            }
        }
    }
}
</style>