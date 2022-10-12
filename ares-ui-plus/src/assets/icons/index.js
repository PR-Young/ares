//import SvgIcon from '@/components/SvgIcon' // svg component

// register globally
//createApp(App).component('svg-icon', SvgIcon)

const req = require.context('./svg', false, /\.svg$/)
const requireAll = (requireContext) => requireContext.keys().map(requireContext)
requireAll(req)
