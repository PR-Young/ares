import * as Vue from 'vue'

import Cookies from 'js-cookie'

import 'normalize.css/normalize.css' // a modern alternative to CSS resets
import Element from 'element-plus'
import './assets/styles/element-variables.scss'

import '@/assets/styles/index.scss' // global css
import '@/assets/styles/ares.scss' // ares css
import App from './App'
import store from './store'
import router from './router'
import permission from './directive/permission'

import './assets/icons' // icon
import './permission' // permission control
import { getDicts } from '@/api/system/dict/data'
import { getConfigKey } from '@/api/system/config'
import {
  addDateRange,
  download,
  handleTree,
  parseTime,
  resetForm,
  selectDictLabel,
} from '@/utils/ares'
import Pagination from '@/components/Pagination'
import VueParticles from 'vue-particles'
// markdown 注册
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'

import SvgIcon from '@/components/SvgIcon' // svg component
import * as ElementPlusIcons from '@element-plus/icons-vue'
import { createApp } from 'vue'
const app = createApp(App)

// 全局方法挂载
app.config.globalProperties.getDicts = getDicts
app.config.globalProperties.getConfigKey = getConfigKey
app.config.globalProperties.parseTime = parseTime
app.config.globalProperties.resetForm = resetForm
app.config.globalProperties.addDateRange = addDateRange
app.config.globalProperties.selectDictLabel = selectDictLabel
app.config.globalProperties.download = download
app.config.globalProperties.handleTree = handleTree

app.config.globalProperties.msgSuccess = function (msg) {
  this.$message({ showClose: true, message: msg, type: 'success' })
}

app.config.globalProperties.msgError = function (msg) {
  this.$message({ showClose: true, message: msg, type: 'error' })
}

app.config.globalProperties.msgInfo = function (msg) {
  this.$message.info(msg)
}

// 全局组件挂载
app.component('Pagination', Pagination)
app.component('svg-icon', SvgIcon)

app.use(permission)
app.use(VueParticles)
app.use(mavonEditor)
/**
 * If you don't want to use mock-server
 * you want to use MockJs for mock api
 * you can execute: mockXHR()
 *
 * Currently MockJs will be used in the production environment,
 * please remove it before going online! ! !
 */

app.use(Element, {
  size: Cookies.get('size') || 'medium', // set element-ui default size
})

for (const [key, component] of Object.entries(ElementPlusIcons)) {
  app.component(key, component)
}

app.config.globalProperties.routerAppend = (path, pathToAppend) => {
  return path + (path.endsWith('/') ? '' : '/') + pathToAppend
}
app.use(store)
app.use(router)
app.mount('#app')
