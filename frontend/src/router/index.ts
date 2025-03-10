import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import Login from "../views/auth/Login.vue";

const routes = [
    {
        path: "/",
        component: Home,
        meta: {
            requiresAuth: true
        },
        children: [
            // TODO
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

router.beforeEach((to, from, next) => {
    const token = localStorage.getItem("token");

    if (to.meta.requiresAuth && !token) {
        next("/login");
    } else {
        next();
    }
})

export default router;