import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import Login from "../views/auth/Login.vue";
import tokenService from '../utils/tokenService';

const routes = [
    {
        path: "/",
        name: "home",
        component: Home,
        meta: {
            requiresAuth: true
        },
        children: [
            {
                path: "admin",
                component: () => import("../views/admin/AdminDashboard.vue"),
                meta: { requiresAuth: true, role: 'admin' }
            },
            {
                path: "courses",
                component: () => import("../components/CourseList.vue"),
                meta: { requiresAuth: false }
            }
        ]
    },
    {
        path: "/login",
        component: Login            
    }
]

const router = createRouter({
    history: createWebHistory(),
    routes
})

router.beforeEach(async (to, from, next) => {
    const token = tokenService.getToken();
    const userStr = localStorage.getItem("user");
    const user = userStr ? JSON.parse(userStr) : null;

    if (to.meta.requiresAuth) {
        if (!token) {
            next("/login");
        } else {
            console.log("token", token);

            // 验证token是否有效
            const isValid = await tokenService.validateToken();
            if (!isValid) {
                // token无效，清除用户信息并跳转到登录页
                tokenService.handleAuthFailure();
                return;
            }
            
            // 检查角色权限
            if (to.meta.role && to.meta.role !== user?.role) {
                next('/'); // 如果角色不匹配，重定向到首页
            } else {
                next();
            }
        }
    } else {
        // 如果是访问登录页面且已有token，验证token是否有效
        if (to.path === '/login' && token) {
            const isValid = await tokenService.validateToken();
            if (isValid) {
                next('/');
            } else {
                // token无效，清除用户信息
                tokenService.handleAuthFailure();
                next();
            }
            return;
        }
        next();
    }
})

export default router;