import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import Login from "../views/auth/Login.vue";

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
                path: "teacher",
                component: () => import("../views/teacher/TeacherDashboard.vue"),
                meta: { requiresAuth: true, role: 'teacher' }
            },
            {
                path: "student",
                component: () => import("../views/student/StudentDashboard.vue"),
                meta: { requiresAuth: true, role: 'student' }
            },
            {
                path: "courses",
                component: () => import("../components/CourseList.vue"),
                meta: { requiresAuth: false }
            },
            {
                path: "profile",
                component: () => import("../components/Profile.vue"),
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

// 全局导航守卫：根据用户角色自动重定向
import { useUserStore } from "../stores/userStore";
import { useTokenStore } from "../stores/tokenStore";

router.beforeEach((to, from, next) => {
    const userStore = useUserStore();
    const tokenStore = useTokenStore();
    
    // 如果需要认证但没有token，重定向到登录页
    if (to.meta.requiresAuth && !tokenStore.isAuthenticated) {
        next('/login');
        return;
    }
    
    // 当访问根路径时，根据用户角色重定向
    if (to.path === '/' && tokenStore.isAuthenticated && userStore.user?.roleName) {
        switch (userStore.user.roleName) {
            case 'admin':
                next('/admin');
                break;
            case 'teacher':
                next('/teacher');
                break;
            case 'student':
                next('/student');
                break;
            default:
                next();
                break;
        }
    } else {
        next();
    }
});

export default router;