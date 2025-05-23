import request from '@/utils/request'

// 查询列表
export function list${entityName}(query : any) {
    return request({
        url: '/ares//list',
        method: 'get',
        params: query
    })
}

// 查询
export function get${entityName}(id : string) {
    return request({
        url: '/ares//' + id,
        method: 'get'
    })
}

// 新增
export function add${entityName}(data : any) {
    return request({
        url: '/ares//edit',
        method: 'post',
        data: data
    })
}

// 修改
export function update${entityName}(data : any) {
    return request({
        url: '/ares//edit',
        method: 'post',
        data: data
    })
}

// 删除
export function del${entityName}(postId : string) {
    return request({
        url: '/ares//' + postId,
        method: 'delete'
    })
}

// 导出
export function export${entityName}(query : any) {
    return request({
        url: '/ares//export',
        method: 'get',
        params: query
    })
}
