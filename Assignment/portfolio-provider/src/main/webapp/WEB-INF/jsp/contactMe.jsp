<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="//unpkg.com/element-ui/lib/umd/locale/en.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <title>hello</title>
</head>
<body>
<div id="app">
    <el-header>
        <h2>Contact Me</h2>
    </el-header>
    <el-card>
        <!--搜索与添加区域-->
        <el-row :gutter="20">
            <el-col :span="15">
                <el-input
                        placeholder="Please enter ID or name (support fuzzy search)"
                        v-model="queryInfo.query"
                        clearable
                        @clear="getData"
                >
                    <el-button
                            slot="append"
                            icon="el-icon-search"
                            @click="filterItems"
                    ></el-button>
                </el-input>
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="addDialogVisible = true"
                >Add a new form</el-button
                >
            </el-col>
        </el-row>


        <!--分页区域-->
        <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="queryInfo.currentPage"
                :page-sizes="[1, 2, 5, 10]"
                :page-size="queryInfo.pageSize"
                layout="total, sizes, prev, pager, next, jumper"
                :total="total"
        >
        </el-pagination>
    </el-card>

    <!--插入Item-->
    <el-dialog
            title="添加用户"
            :visible.sync="addDialogVisible"
            width="50%"
            @close="addDialogClosed"
    >
        <!--插入数据表单-->
        <el-form
                :model="addForm"
                :rules="addFormRules"
                ref="addFormRef"
                label-width="70px"
        >

            <el-form-item label="ID" >
                <el-input v-model="addForm.iId"></el-input>
            </el-form-item>
            <el-form-item label="名字" >
                <el-input v-model="addForm.name"></el-input>
            </el-form-item>
            <el-form-item label="修改时间" >
                <el-input v-model="addForm.itModified"></el-input>
            </el-form-item>
        </el-form>
        <!--底部区域-->
        <span slot="footer" class="dialog-footer">
        <el-button @click="addDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="addItem">确 定</el-button>
        </span>
    </el-dialog>

<!--    Detail表单-->
    <el-dialog
            title="Item Detail"
            :visible.sync="detailInfoVisible"
            width="50%"
            @close="detailInfoDialogClosed"
    >
        <!--主体区域-->
        <el-descriptions title="Information">
            <el-descriptions-item label="iId">{{detailForm.iId}}</el-descriptions-item>
            <el-descriptions-item label="name">{{detailForm.name}}</el-descriptions-item>
            <el-descriptions-item label="itModified">{{formatDate(detailForm.itModified)}}</el-descriptions-item>
            <el-descriptions-item label="others">
                <el-tag size="small">至尊item</el-tag>
            </el-descriptions-item>
        </el-descriptions>
        <!--底部区域-->
        <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="detailInfoVisible = false">确 定</el-button>
        </span>
    </el-dialog>

<!--    修改表单-->
    <el-dialog
            title="修改用户"
            :visible.sync="modifyDialogVisible"
            width="50%"
            @close="modifyDialogClosed"
    >
        <el-form
                :model="modifyForm"
                :rules="modifyFormRules"
                ref="addFormRef"
                label-width="70px"
        >


            </el-form-item>
            <el-form-item label="ID" >
                <el-input v-model="modifyForm.iId" readonly="true"></el-input>
            </el-form-item>
            <el-form-item label="名字" >
                <el-input v-model="modifyForm.name"></el-input>
            </el-form-item>
            <el-form-item label="修改时间" >
                <el-input v-model="modifyForm.itModified"></el-input>
            </el-form-item>
        </el-form>
        <!--底部区域-->
        <span slot="footer" class="dialog-footer">
        <el-button @click="modifyDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="modifyItem">确 定</el-button>
        </span>
    </el-dialog>






<!--主表单-->
    <template>
        <div>
            <el-table :data="responseData.slice((queryInfo.currentPage -1) * queryInfo.pageSize, queryInfo.pageSize * queryInfo.currentPage)" :default-sort="{prop: 'itModified', order: 'descending'}" style="width: 100%">
                <el-table-column prop="iId" label="ID" width="200" sortable></el-table-column>
                <el-table-column prop="name" label="Name" width="200" sortable></el-table-column>
                <el-table-column prop="itModified" label="Last Modified" width="300" sortable>
                    <template slot-scope="{ row }">
                        {{ formatDate(row.itModified) }}
                    </template>
                </el-table-column>
                <el-table-column label="Actions" width="300">
                    <template slot-scope="{ row }">
                        <el-button type="text" @click="viewDetail(row); detailInfoVisible = true" style="font-size: 16px;">View</el-button>
                        <el-button type="text" @click="deleteItem(row)" style="font-size: 16px;">Delete</el-button>
                        <el-button type="text" @click="modifyItem(row) ; modifyDialogVisible = true" style="font-size: 16px;">Modify</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </div>
    </template>


</div>

<script>
    ELEMENT.locale(ELEMENT.lang.en)
    new Vue( {
        el: '#app',
        data() {
            return {
                responseData: [],

                queryInfo: {
                    query: '',
                    currentPage: 1,
                    pageSize: 5,
                    totalPage: 20
                },
                addForm: {
                    iId: '',
                    name: '',
                    itModified: '',
                },
                detailForm: [{
                    iId: '',
                    name: '',
                    itModified: '',
                }],
                modifyForm: {
                    iId: '',
                    name: '',
                    itModified: '',
                },
                filItems: [],
                addDialogVisible: false,
                detailInfoVisible: false,
                modifyDialogVisible: false,

            };
        },

        mounted() {
            this.getData();
        },
        methods: {
            getData() {
                this.responseData = [];
                this.responseData.push({ iId: "SPIT000001", name: "QIU", itModified: "2023-11-08 15:06:21" });
                this.responseData.push({ iId: "SPIT000002", name: "Xu", itModified: "2023-11-08 15:06:21" });
                this.responseData.push({ iId: "SPIT000003", name: "Liu", itModified: "2023-11-08 15:06:21" });

                // axios.get('/item/getAllItems')
                //     .then(response => {
                //         // 请求成功的处理逻辑
                //         console.log('Response from backend:', response.data);
                //         this.responseData = response.data.data;
                //     })
                //     .catch(error => {
                //         // 请求失败的处理逻辑
                //         console.error('请求失败:', error);
                //     });
            },
            filterItems() {
                if(this.queryInfo.query === '') {
                    this.getData();
                }
                console.log(this.queryInfo.query);
                this.responseData = this.responseData.filter((i)=>{
                    return (i.iId || '').toString().toLowerCase().includes(this.queryInfo.query.toLowerCase()) ||
                    (i.name || '').toString().toLowerCase().includes(this.queryInfo.query.toLowerCase())
                });
                console.log(this.responseData);
                return this.responseData;
            },
            formatDate(dateString) {

                return moment(dateString).format('YYYY-MM-DD HH:mm:ss');
            },
            viewDetail(row) {
                this.detailForm = this.responseData.find(elem => elem.iId === row.iId);
                console.log(this.detailForm);

            },
            deleteItem(row) {
                var idx = this.responseData.findIndex(elem => elem.iId === row.iId);
                let newArray = this.responseData.slice(0, idx).concat(this.responseData.slice(idx + 1));
                this.responseData = newArray;
                this.$message.success('delete success');
            },
            modifyItem(row) {
                console.log(row.iId);
                if(row.iId !== undefined) {
                    this.modifyForm.iId = row.iId;
                    return;
                }
                var targetObject = this.responseData.find(obj => obj.iId === this.modifyForm.iId);
                for (const field in this.modifyForm){
                    targetObject[field] = this.modifyForm[field];
                }
                this.modifyDialogVisible = false
            },
            addItem() {
                    // 添加成功
                    this.$message.success("add item success")
                    // 隐藏弹出框
                    this.addDialogVisible = false
                    // 刷新用户列表
                    this.getItemList()

            },

            // 监听 pagesize 改变的事件
            handleSizeChange(newSize) {
                this.queryInfo.pageSize = newSize
                this.getItemList()
                console.log(newSize)
            },
            // 监听页码值改变的事件
            handleCurrentChange(newPage) {
                this.queryInfo.currentPage = newPage
                this.getItemList()
                console.log(newPage)
            },

            async getItemList() {
                this.responseData = [],
                this.responseData.push({ iId: "SPIT000001", name: "QIU", itModified: "2023-11-08 15:06:21" });
                this.responseData.push({ iId: "SPIT000002", name: "Xu", itModified: "2023-11-08 15:06:21" });
                this.responseData.push({ iId: "SPIT000003", name: "Liu", itModified: "2023-11-08 15:06:21" });
                this.responseData.push({ iId: this.addForm.iId, name: this.addForm.name, itModified: this.addForm.itModified });
            },
        }
    });
</script>

</body>
</html>
