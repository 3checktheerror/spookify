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
    <el-header>
        <h2>Contact Me</h2>
    </el-header>
    <el-form :model="formData" label-width="100px">
        <el-col :span="15">
        <el-form-item label="Name">
            <el-input v-model="formData.name"></el-input>
        </el-form-item>
        <el-form-item label="Gender">
            <el-select v-model="formData.gender" placeholder="Select">
                <el-option label="Male" value="male"></el-option>
                <el-option label="Female" value="female"></el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="Age">
            <el-input v-model="formData.age"></el-input>
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
                    action="#"
                    :file-list="fileList"
                    :show-file-list="true"
                    :before-upload="beforeUpload"
                    :on-remove="handleRemove"
                    :on-preview="handlePreview"
            >
                <el-button size="small" type="primary">Click to Upload</el-button>
                <div slot="tip" class="el-upload__tip">(Only one file can be uploaded)</div>
            </el-upload>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="submitForm">Submit</el-button>
        </el-form-item>
            </el-col >
    </el-form>
    <el-dialog
            title="Create Successful"
            :visible.sync="successDialogVisible"
            width="50%"
    >
        <p v-if="responseData">Successfully submitted {{ responseData }} form</p>
        <div slot="footer" class="dialog-footer">
            <el-button type="primary" @click="closeSuccessDialog">OK</el-button>
        </div>
    </el-dialog>

</div>
<style>
    .el-upload-list__item-name [class^=el-icon] {
        height: 5%;
        margin-right: 7px;
        color: #909399;
        line-height: inherit;
    }
</style>
<script>

    new Vue( {
        el: '#app',
        data() {
            return {
                formData: {
                    name: '',
                    gender: '',
                    age:'',
                    email: '',
                    message: '',
                    phone: '',
                    occupation: ''
                },
                fileList: [],
                successDialogVisible: false, // 控制弹窗显示/隐藏
                beforeUploadCancelled: true, // 添加标志，记录是否因为 before-upload 取消上传
                responseData: null, // 存储后端响应数据
                ID: null
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
                        "phone": this.formData.phone,
                        "occupation": this.formData.occupation,
                        "age": this.formData.age
                    },
                    igroupId: "a",
                    file: this.fileList[0],
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
                        console.log('Response from backend:', response.data);
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

                if(this.fileList.length>=1){
                    this.$message.error('Only one file can be uploaded');
                }else{
                    this.fileList.push(file);
                }
                if (this.beforeUploadCancelled) {
                    this.beforeUploadCancelled = false; // 重置标志
                }
                return false;
            },
            handleRemove() {
                    // 如果是因为 before-upload 返回 false 取消上传导致的删除，则不执行删除逻辑
                    if (this.beforeUploadCancelled) {
                        this.fileList=[];
                    } else {
                        this.beforeUploadCancelled = true; // 重置标志
                    }
            },
            handlePreview() {
                var a = document.createElement('a');
                var event = new MouseEvent('click');
                a.download = this.fileList[0].name;
                        const tempData = {
                            name: "temp",
                            gender: "male",
                            email: "temp",
                            message: "temp",
                            map: null,
                            igroupId: "temp",
                            file: this.fileList[0],
                            md5: null,
                            token: null,
                            sessionId: null,
                            vIdFk: "SPVT000001"
                        };
                        axios.post('/item/insertItem', tempData, {headers: {
                                'Content-Type': 'multipart/form-data'
                            }})
                            .then(response => {
                                // 请求成功的处理逻辑
                                console.log('Response from backend:', response.data);
                                this.ID = response.data.data.id;
                            })
                            .catch(error => {
                                console.error('请求失败:', error);
                            });
                        console.log(this.ID);
                        a.href=("http://localhost:8082/a/b/download/"+this.ID);
                        console.log(a.href);
                        // 触发模拟点击事件
                        a.dispatchEvent(event);


                }

            }
    });
</script>

</body>
</html>
