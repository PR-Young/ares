import { constantRoutes } from '@/router'
import { getRouters } from '@/api/menu'
import Layout from '@/layout/index'
import { defineComponent } from 'vue'

const permission = {
  state: {
    routes: [],
    addRoutes: [],
  },
  mutations: {
    SET_ROUTES: (state, routes) => {
      state.addRoutes = routes
      state.routes = constantRoutes.concat(routes)
    },
  },
  actions: {
    // 生成路由
    GenerateRoutes({ commit }) {
      return new Promise((resolve) => {
        // 向后端请求路由数据
        getRouters().then((res) => {
          //const accessedRoutes = filterAsyncRouter(res.data)
          const accessedRoutes = []
          let data = res.data;
          for (let i = 0; i < data.length; i++) {
            let routerObj = {
              name: data[i].name,
              alwaysShow: data[i].alwaysShow,
              children: [],
              component: data[i].component === "Layout" ? Layout : () => import(`@/views/${data[i].component}`),
              hidden: data[i].hidden,
              meta: data[i].meta,
              path: data[i].path,
              redirect: data[i].redirect
            }
            if (data[i].children.length > 0) {
              let child = data[i].children
              for (let j = 0; j < child.length; j++) {
                let children = {
                  component: child[j].component === "Layout" ? Layout : defineComponent(() => import(`@/views/${child[j].component}`)),
                  hidden: child[j].hidden,
                  meta: child[j].meta,
                  name: child[j].name,
                  path: child[j].path
                }
                routerObj.children.push(children)
              }
            }
            accessedRoutes.push(routerObj)
          }
          accessedRoutes.push({ path: '/:catchAll(.*)', redirect: '/404', hidden: true })
          commit('SET_ROUTES', accessedRoutes)
          resolve(accessedRoutes)
        })
      })
    },
  },
}

// 遍历后台传来的路由字符串，转换为组件对象
function filterAsyncRouter(asyncRouterMap) {
  return asyncRouterMap.filter((route) => {
    if (route.component) {
      // Layout组件特殊处理
      if (route.component === 'Layout') {
        route.component = Layout
      } else {
        route.component = loadView(route.component)
      }
    }
    if (route.children != null && route.children && route.children.length) {
      route.children = filterAsyncRouter(route.children)
    }
    return true
  })
}

export const loadView = (view) => {
  // 路由懒加载
  return () => import(`@/views/${view}`)
}

export default permission
