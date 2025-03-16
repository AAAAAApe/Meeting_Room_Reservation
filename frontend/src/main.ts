import { createApp } from 'vue'
import { createPinia } from 'pinia'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import './styles/index.scss'
import router  from "./router"
import App from './App.vue'
import { useUserStore } from './stores/userStore'
import { useTokenStore } from './stores/tokenStore'

const app = createApp(App)
app.use(ElementPlus)
app.use(router)

// 初始化Pinia
const pinia = createPinia()
app.use(pinia)

// 初始化store，确保在路由守卫之前加载用户信息
const tokenStore = useTokenStore()
const userStore = useUserStore()

// 从localStorage加载token和用户信息
tokenStore.loadTokenFromStorage()
userStore.loadUserFromStorage()

app.mount('#app')
