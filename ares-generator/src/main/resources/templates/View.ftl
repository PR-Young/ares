<template>
    <div class="app-container">
        <el-form
                :model="queryParams"
                ref="queryForm"
                :inline="true"
                label-width="68px"
        >
            <el-form-item label="" prop="">
                <el-input
                        v-model="queryParams."
                        placeholder="请输入"
                        clearable
                        size="small"
                        @keyup.enter.native="handleQuery"
                />
            </el-form-item>
            <el-form-item label="" prop="">
                <el-input
                        v-model="queryParams."
                        placeholder="请输入"
                        clearable
                        size="small"
                        @keyup.enter.native="handleQuery"
                />
            </el-form-item>
            <el-form-item>
                <el-button
                        type="primary"
                        :icon="Search"
                        size="default"
                        @click="handleQuery"
                >搜索
                </el-button>
                <el-button :icon="Refresh" size="default" @click="resetQuery">重置</el-button>
            </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
            <el-col :span="1.5">
                <el-button
                        type="primary"
                        :icon="Plus"
                        size="default"
                        @click="handleAdd"
                        v-hasPermi="['${entityName1}:edit']"
                >新增
                </el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button
                        type="success"
                        :icon="Edit"
                        size="default"
                        :disabled="single"
                        @click="handleUpdate"
                        v-hasPermi="['${entityName1}:edit']"
                >修改
                </el-button>
            </el-col>
            <el-col :span="1.5">
                <el-button
                        type="danger"
                        :icon="Delete"
                        size="default"
                        :disabled="multiple"
                        @click="handleDelete"
                        v-hasPermi="['${entityName1}:delete']"
                >删除
                </el-button
                >
            </el-col>
            <el-col :span="1.5">
                <el-button
                        type="warning"
                        :icon="Download"
                        size="default"
                        @click="handleExport"
                        v-hasPermi="['${entityName1}:export']"
                >导出
                </el-button
                >
            </el-col>
        </el-row>

        <el-table
                border
                v-loading="loading"
                :data="${entityName1}List"
                @selection-change="handleSelectionChange"
        >
            <el-table-column type="selection" width="55" align="center"/>
            <#list columns as column>
                <el-table-column label="" align="center" prop="${column.name}"/>
            </#list>
            <el-table-column
                    label="创建时间"
                    align="center"
                    prop="createTime"
                    width="180"
            >
                <template slot-scope="scope">
                    <span>{{ parseTime(scope.row.createTime) }}</span>
                </template>
            </el-table-column>
            <el-table-column
                    label="操作"
                    align="center"
                    class-name="small-padding fixed-width"
            >
                <template slot-scope="scope">
                    <el-button
                            size="default"
                            type="text"
                            :icon="Edit"
                            @click="handleUpdate(scope.row)"
                            v-hasPermi="['${entityName1}:edit']"
                    >修改
                    </el-button>
                    <el-button
                            size="default"
                            type="text"
                            :icon="Delete"
                            @click="handleDelete(scope.row)"
                            v-hasPermi="['${entityName1}:delete']"
                    >删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

        <pagination
                v-show="total > 0"
                :total="total"
                :page.sync="queryParams.pageNum"
                :limit.sync="queryParams.pageSize"
                @pagination="getList"
        />

        <!-- 添加或修改岗位对话框 -->
        <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
            <el-form ref="addFormRef" :model="form" :rules="rules" label-width="80px">
                <#list columns as column>
                    <el-form-item label="" prop="${column.name}">
                        <el-input v-model="form.${column.name}" placeholder="请输入"/>
                    </el-form-item>
                </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" @click="submitForm">确 定</el-button>
                <el-button @click="cancel">取 消</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script setup name="${entityName}">
    import {
        Search,
        Refresh,
        Plus,
        Edit,
        Delete,
        Download,
    } from "@element-plus/icons-vue";
    import {
        add${entityName},
        del${entityName},
        export${entityName},
        get${entityName},
        list${entityName},
        update${entityName}
    } from "@/api/system/";
    import { getCurrentInstance, onMounted, reactive, ref } from "vue";
    import { useRouter } from "vue-router";

    const { proxy } = getCurrentInstance();
    const addFormRef = ref();
    const router = useRouter();

    // 遮罩层
    const loading = ref(true);
    // 选中数组
    const ids = ref([]);
    // 非单个禁用
    const single = ref(true);
    // 非多个禁用
    const multiple = ref(true);
    // 总条数
    const total = ref(0);
    // 岗位表格数据
    const ${entityName1}List = ref([]);
    // 弹出层标题
    const title = ref();
    // 是否显示弹出层
    const open = ref(false);
    // 状态数据字典
    const statusOptions = ref([]);
    // 查询参数
    const queryParams = reactive({
        pageNum: 1,
        pageSize: 10,
    });
    // 表单参数
    const form = ref({});
    // 表单校验
    const rules = ref({});

    onMounted(() => {
        getList();
    });
    /** 查询岗位列表 */
    const getList = () => {
        loading.value = true;
        list${entityName}(queryParams).then((response) => {
            ${entityName1}List.value = response.rows;
            total.value = response.total;
            loading.value = false;
        });
    }
    // 取消按钮
    const cancel = () => {
        open.value = false;
        reset();
    }
    // 表单重置
    const reset = () => {
        form.value = {
            id: undefined,
            <#list columns as column>
            ${column.name}: undefined,
            </#list>
        };
        proxy.resetForm("form");
    }
    /** 搜索按钮操作 */
    const handleQuery = () => {
        queryParams.pageNum = 1;
        getList();
    }
    /** 重置按钮操作 */
    const resetQuery = () => {
        proxy.resetForm("queryForm");
        handleQuery();
    }
            // 多选框选中数据
    const handleSelectionChange = (selection) => {
        ids.value = selection.map((item) => item.id);
        single.value = selection.length != 1;
        multiple.value = !selection.length;
    }
    /** 新增按钮操作 */
    const handleAdd = () => {
        reset();
        open.value = true;
        title.value = "添加";
    }
    /** 修改按钮操作 */
    const handleUpdate = (row) => {
        reset();
        const id = row.id || ids;
        get${entityName}(id).then((response) => {
            form.value = response.data;
            open.value = true;
            title.value = "修改";
        });
    }
    /** 提交按钮 */
    const submitForm = () => {
        addFormRef.value.validate((valid) => {
            if (valid) {
                if (form.value.id != undefined) {
                    update${entityName}(form.value).then((response) => {
                        if (response.code === 200) {
                            proxy.msgSuccess("修改成功");
                            open.value = false;
                            getList();
                        } else {
                            proxy.msgError(response.msg);
                        }
                    });
                } else {
                    add${entityName}(form.value).then((response) => {
                        if (response.code === 200) {
                            proxy.msgSuccess("新增成功");
                            open.value = false;
                            getList();
                        } else {
                            proxy.msgError(response.msg);
                        }
                    });
                }
            }
        });
    }
    /** 删除按钮操作 */
    const handleDelete = (row) => {
        const ids = row.id || ids;
        proxy
            .$confirm('是否确认删除编号为"' + ids + '"的数据项?', "警告", {
                    confirmButtonText: "确定",
                    cancelButtonText: "取消",
                    type: "warning",
            }).then(function () {
                return del${entityName}(ids);
            }).then(() => {
                getList();
                proxy.msgSuccess("删除成功");
            }).catch(function () {});
    }
    /** 导出按钮操作 */
    const handleExport = () => {
        const queryParams = queryParams;
        proxy.$confirm("是否确认导出所有数据项?", "警告", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning",
        }).then(function () {
            return export${entityName}(queryParams);
        }).then((response) => {
            proxy.download(response.msg);
        }).catch(function () {});
    }
</script>
