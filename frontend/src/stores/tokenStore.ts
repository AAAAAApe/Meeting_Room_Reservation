import { defineStore } from "pinia";
import { ref, computed } from "vue";

// 定义一个名为token的store (使用组合式API)
export const useTokenStore = defineStore('token', () => {

    const token = ref<string | null>(null);

    // getters
    const isAuthenticated = computed(() => !!token.value);

    // 设置 access token
    function setToken(tokenValue: string | null) {
        token.value = tokenValue;
        if (tokenValue) {
            localStorage.setItem('token', tokenValue);
        } else {
            localStorage.removeItem('token');
        }
    }

    // 从localStorage加载token
    function loadTokenFromStorage() {
        const storedToken = localStorage.getItem('token');
        if (storedToken) {
            token.value = storedToken;
        }
    }

    // 清除所有token
    function clearToken() {
        token.value = null;
        localStorage.removeItem('token');
    }

    // 返回所有状态和方法
    return {
        token,
        isAuthenticated,
        setToken,
        loadTokenFromStorage,
        clearToken
    };
});