import hasRole from './hasRole'
import hasPermi from './hasPermi'

const install = function (Vue) {
  Vue.directive('hasRole', hasRole)
  Vue.directive('hasPermi', hasPermi)
}

if (window.Vue) {
  window['hasRole'] = hasRole
  window['hasPermi'] = hasPermi
  createApp(App).use(install) // eslint-disable-line
}

export default install
