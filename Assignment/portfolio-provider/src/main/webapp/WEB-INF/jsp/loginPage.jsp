<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="//unpkg.com/element-ui/lib/umd/locale/en.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <title>hello</title>
</head>

<body class="body">
    <div id="app">

        <el-container>
            <el-aside width="600px"></el-aside>
            <template>
                <div>
                    <el-form :rules="rules" ref="loginForm" :model="loginForm" class="loginContainer">
                        <h3 class="loginTitle">
                            欢迎登录
                        </h3>
                        <el-form-item prop="username">
                            <el-input type="text" v-model="loginForm.username" placeholder="亲，请输入用户名" >
                            </el-input>
                        </el-form-item>
                        <el-form-item prop="password">
                            <el-input type="password" v-model="loginForm.password" placeholder="亲，请输入密码" >
                            </el-input>
                        </el-form-item>
                        <el-form-item prop="code">
                            <el-input type="text" auto-complete="false" v-model="loginForm.code" placeholder="点击图片更换验证码" style="width: 250px;margin-right: 5px">
                            </el-input>
                            <img :src="captchaUrl">

                        </el-form-item>
                        <el-checkbox v-model="checked" class="loginRemember">记住我</el-checkbox>
                        <el-button type="primary" style="width:100%" @click="submitLogin">登录</el-button>
                    </el-form>
                </div>
            </template>
        </el-container>

    </div>


<script>
    new Vue({
        el:"#app",
        name: "Login",
        data(){
            return{
                captchaUrl: "",
                loginForm:{
                    username:"admin",
                    password:"ssssss",
                    code:''
                },
                checked: true,
                rules:{
                    username:[{required:true,message:"请输入用户名",trigger:"blur"},{ min: 5, max: 14, message: '长度在 5 到 14 个字符', trigger: 'blur' }
                    ],
                    password:[{required:true,message:"请输入密码",trigger:"blur"},,{ min: 6,  message: '密码长度要大于6', trigger: 'blur' }],
                    code:[{required:true,message:"请输入验证码",trigger:"blur"}],
                }

            }
        },
        methods:{
            submitLogin(){
                this.$refs.loginForm.validate((valid) => {
                    if (valid) {
                        alert('提交成功');
                        window.location.href = 'http://localhost:8082/getPage/Feedback';
                    } else {
                        this.$message.error('登录出错请重新输入');
                        return false;
                    }
                });
            }
        }
    });
</script>

    <style lang="scoped">
        .loginContainer {
            border-radius: 15px;
            background-clip: padding-box;
            text-align: left;
            margin: auto;
            margin-top: 180px;
            width: 350px;
            padding: 15px 35px 15px 35px;
            background: aliceblue;
            border:1px solid blueviolet;
            box-shadow: 0 0 25px #f885ff;
        }

        .loginTitle {
            margin: 0px auto 48px auto;
            text-align: center;
            font-size: 40px;
        }

        .loginRemember {
            text-align: left;
            margin: 0px 0px 15px 0px;
        }

        .body {
            width: 100vw;
            height: 100vh;
            background-image: url("/images/background.png") ;
            background-size:100%;
            overflow: hidden;
        }
    </style>





</body>
</html>
