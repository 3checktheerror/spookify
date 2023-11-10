<%--
  Created by IntelliJ IDEA.
  User: 123
  Date: 2023/11/4
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
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
    <el-form :model="formData" label-width="100px">
        <el-form-item label="Name">
            <el-input v-model="formData.name"></el-input>
        </el-form-item>
        <el-form-item label="Gender">
            <el-select v-model="formData.gender" placeholder="Select">
                <el-option label="Male" value="male"></el-option>
                <el-option label="Female" value="female"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="Email">
            <el-input v-model="formData.email"></el-input>
        </el-form-item>
        <el-form-item label="Message">
            <el-input type="textarea" v-model="formData.message"></el-input>
        </el-form-item>
        <el-form-item label="Phone">
            <el-input v-model="formData.phone"></el-input>
        </el-form-item>
        <el-form-item label="Occupation">
            <el-input v-model="formData.occupation"></el-input>
        </el-form-item>
        <el-form-item label="File">
            <el-upload
                    class="upload-demo"
                    action="/item/insertItem"
                    :show-file-list="false"
                    :on-success="handleUploadSuccess"
                    :before-upload="beforeUpload"
            >
                <el-button size="small" type="primary">Click to Upload</el-button>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="submitForm">Submit</el-button>
        </el-form-item>
    </el-form>
    <el-dialog
            title="Insert Successful"
            :visible.sync="successDialogVisible"
            width="40%"
    >
        <p>Data has been successfully inserted.</p>
        <p v-if="responseData">Insert {{ responseData }} item</p>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="closeSuccessDialog">OK</el-button>
        </div>
    </el-dialog>

</div>
<script>

    new Vue( {
        el: '#app',
        data() {
            return {
                formData: {
                    name: '',
                    gender: '',
                    email: '',
                    message: '',
                    phone: '',
                    occupation: ''
                },
                successDialogVisible: false, // 控制弹窗显示/隐藏
                responseData: null // 存储后端响应数据
            };
        },
        methods: {
            submitForm() {
                // 构建要提交的数据
                const postData = {
                    name: this.formData.name,
                    gender: this.formData.gender,
                    email: this.formData.name,
                    message: this.formData.message,
                    map: {
                        "phone": "a",
                        "occupation": "a"
                    },
                    igroupId: "a",
                    file: this.file,
                    md5: null,
                    token: null,
                    sessionId: null,
                    vIdFk: "SPVT000001"
                };
                console.log(postData);
                //console.log(decodeURIComponent(escape(atob("5rWL6K+V"))));
                // 使用 Axios 发送 GET 请求到后端
                axios.post('/item/insertItem', postData, {headers: {
                    'Content-Type': 'multipart/form-data'
                }})
                    .then(response => {
                        // 请求成功的处理逻辑
                        console.log('后端响应:', response.data);
                        this.responseData = response.data.data.num;
                        this.showSuccessDialog();
                    })
                    .catch(error => {
                        // 请求失败的处理逻辑
                        console.error('请求失败:', error);
                    });
            },
            showSuccessDialog() {
                this.successDialogVisible = true;
            },
            closeSuccessDialog() {
                this.successDialogVisible = false;
                this.responseData = null; // 关闭弹窗时清空响应数据
            },
            beforeUpload(file) {
                // 预处理上传的文件
                this.file = file;
                return false; // 防止自动上传
            },
            handleUploadSuccess(response, file) {
                // 处理文件上传成功后的逻辑
                console.log('文件上传成功:', response);
            }
        }
    });
</script>

</body>
</html>
