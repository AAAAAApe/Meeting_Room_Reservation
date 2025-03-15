import { defineStore } from "pinia";
import { ref, computed } from "vue";

// 定义用户类型
interface User {
    userId: string;
    role: 'admin' | 'teacher' | 'student';

    // 公共字段
    userName?: string;
    gender?: boolean;
    phone?: string;
    email?: string;
    lastLoginTime?: string;

    // 学生/教师
    departmentName?: string;
    
    // 教师特有字段
    birthday?: string;
    phoneNumber?: string;
    startYear?: number;
    title?: string;

    // 学生特有字段
    studentName?: string;
    major?: string;
    credit?: number;
}

// 定义一个名为user的store (使用组合式API)  
export const useUserStore = defineStore('user', () => {
    // 使用ref定义响应式状态
    const user = ref<User | null>(null);
    
    // getters
    const isLoggedIn = computed(() => !!user.value);
    const userRole = computed(() => user.value?.role);
    const userId = computed(() => user.value?.userId);
    
    // 设置用户信息
    function setUser(userData: User | null) {
        user.value = userData;
        if (userData) {
            localStorage.setItem('user', JSON.stringify(userData));
        } else {
            localStorage.removeItem('user');
        }
    }
    
    // 从localStorage加载用户信息
    function loadUserFromStorage() {
        const userStr = localStorage.getItem('user');
        if (userStr) {
            try {
                user.value = JSON.parse(userStr);
            } catch (e) {
                user.value = null;
            }
        }
    }
    
    // 清除用户信息
    function clearUser() {
        user.value = null;
        localStorage.removeItem('user');
        // token的清除已经移到tokenStore中处理
    }
    
    // 返回所有状态和方法
    return {
        user,
        isLoggedIn,
        userRole,
        userId,
        setUser,
        loadUserFromStorage,
        clearUser
    };
});
