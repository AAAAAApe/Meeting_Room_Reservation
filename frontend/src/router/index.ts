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

export default router;