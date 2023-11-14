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
                        placeholder="Please enter the content"
                        v-model="queryInfo.query"
                        clearable
                        @clear="getData"
                >
                    <el-button
                            slot="append"
                            icon="el-icon-search"
                            @click="getData"
                    ></el-button>
                </el-input>
            </el-col>
            <el-col :span="4">
                <el-button type="primary" @click="addDialogVisible = true"
                >Add a new form</el-button
                >
            </el-col>
        </el-row>

        <!--用户列表区域-->
<%--        <el-table :data="userList" border stripe>--%>
<%--            <el-table-column type="index" label="#"></el-table-column>--%>
<%--            <el-table-column label="姓名" prop="username"></el-table-column>--%>
<%--            <el-table-column label="邮箱" prop="email"></el-table-column>--%>
<%--            <el-table-column label="电话" prop="mobile"></el-table-column>--%>
<%--            <el-table-column label="角色" prop="role_name"></el-table-column>--%>
<%--            <el-table-column label="状态">--%>
<%--                <template slot-scope="scope">--%>
<%--                    <el-switch--%>
<%--                            v-model="scope.row.mg_state"--%>
<%--                            @change="userStateChanged(scope.row)"--%>
<%--                    ></el-switch>--%>
<%--                </template>--%>
<%--            </el-table-column>--%>
<%--            <el-table-column label="操作" width="180px">--%>
<%--                <template slot-scope="scope">--%>
<%--                    <!-- 修改按钮 -->--%>
<%--                    <el-button--%>
<%--                            type="primary"--%>
<%--                            icon="el-icon-edit"--%>
<%--                            size="mini"--%>
<%--                            @click="showEditDialog(scope.row.id)"--%>
<%--                    ></el-button>--%>
<%--                    <!-- 删除按钮 -->--%>
<%--                    <el-button--%>
<%--                            type="danger"--%>
<%--                            icon="el-icon-delete"--%>
<%--                            size="mini"--%>
<%--                            @click="removeUserById(scope.row.id)"--%>
<%--                    ></el-button>--%>
<%--                    <el-tooltip--%>
<%--                            effect="dark"--%>
<%--                            content="分配角色"--%>
<%--                            placement="top-start"--%>
<%--                            :enterable="false"--%>
<%--                    >--%>
<%--                        <el-button--%>
<%--                                type="warning"--%>
<%--                                icon="el-icon-setting"--%>
<%--                                size="mini"--%>
<%--                        ></el-button>--%>
<%--                    </el-tooltip>--%>
<%--                </template>--%>
<%--            </el-table-column>--%>
<%--        </el-table>--%>

        <!--分页区域-->
        <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="queryInfo.pagenum"
                :page-sizes="[1, 2, 5, 10]"
                :page-size="queryInfo.pagesize"
                layout="total, sizes, prev, pager, next, jumper"
                :total="total"
        >
        </el-pagination>
    </el-card>

    <template>
        <div>
            <el-table :data="responseData" :default-sort="{prop: 'itModified', order: 'descending'}" style="width: 100%">
                <el-table-column prop="iId" label="ID" width="200" sortable></el-table-column>
                <el-table-column prop="name" label="Name" width="200" sortable></el-table-column>
                <el-table-column prop="itModified" label="Last Modified" width="300" sortable>
                    <template slot-scope="{ row }">
                        {{ formatDate(row.itModified) }}
                    </template>
                </el-table-column>
                <el-table-column label="Actions" width="300">
                    <template slot-scope="{ row }">
                        <el-button type="text" @click="viewDetail(row)" style="font-size: 16px;">View Detail</el-button>
                        <el-button type="text" @click="deleteItem(row)" style="font-size: 16px;">Delete</el-button>
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
                    // 当前的页数
                    pagenum: 1,
                    // 当前每页显示的条数
                    pagesize: 2
                },

            };
        },

        mounted() {
            this.getData();
        },
        methods: {
            getData() {

                axios.get('/item/getAllItems')
                    .then(response => {
                        // 请求成功的处理逻辑
                        console.log('Response from backend:', response.data);
                        this.responseData = response.data.data;
                    })
                    .catch(error => {
                        // 请求失败的处理逻辑
                        console.error('请求失败:', error);
                    });
            },
            formatDate(dateString) {

                return moment(dateString).format('YYYY-MM-DD HH:mm:ss');
            },
            viewDetail(row) {
                // 处理查看详情的逻辑，可以跳转到详情页或弹出模态框等
                console.log('View Detail:', row);
            },
            deleteItem(row) {

            },



        }
    });
</script>

</body>
</html>
