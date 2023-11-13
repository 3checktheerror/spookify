<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <title>hello</title>
</head>
<body>
<div id="app">
    <el-header>
        <h2>Manage forms</h2>
    </el-header>
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

    new Vue( {
        el: '#app',
        data() {
            return {
                responseData: [],

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
