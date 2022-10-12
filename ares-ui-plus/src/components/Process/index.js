import workflowBpmnModeler from './index.vue'

workflowBpmnModeler.install = (Vue) =>
  createApp(App).component(workflowBpmnModeler.name, workflowBpmnModeler) // 给组件配置install方法

export default workflowBpmnModeler
