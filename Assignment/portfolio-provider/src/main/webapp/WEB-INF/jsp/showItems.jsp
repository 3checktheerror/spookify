<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <title>hello</title>
</head>
<body>
<div id="app">
    <el-header>
        <h2>Contact Me</h2>
    </el-header>
    <template>
        <div>
            <p>{{ responseData[0] }}</p>
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



        }
    });
</script>

</body>
</html>
