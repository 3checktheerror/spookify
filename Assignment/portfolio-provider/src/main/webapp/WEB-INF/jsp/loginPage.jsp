<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html lang="en">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
        <div class="center-container">
            <el-col>
                <el-row style="margin-left: 50px; margin-top: 50px;">
                    <div class="social-media-icons">
                        <a href="https://github.com/3checktheerror/spookify" target="_blank" rel="noopener noreferrer">
                            <i class="fa fa-github"></i>
                        </a>
                        <a href="https://twitter.com" target="_blank" rel="noopener noreferrer">
                            <i class="fa fa-twitter"></i>
                        </a>
                        <a href="https://www.linkedin.com" target="_blank" rel="noopener noreferrer">
                            <i class="fa fa-linkedin"></i>
                        </a>
                        <a href="https://www.facebook.com" target="_blank" rel="noopener noreferrer">
                            <i class="fa fa-facebook"></i>
                        </a>
                        <a href="https://www.instagram.com" target="_blank" rel="noopener noreferrer">
                            <i class="fa fa-instagram"></i>
                        </a>
                    </div>
                </el-row>
                <el-row>
                    <el-form :rules="rules" ref="loginForm" :model="loginForm" class="loginContainer">
                        <h3 class="loginTitle">Sign in to Website</h3>
                        <el-form-item prop="selectedUser">
                            <el-select v-model="loginForm.selectedUser" placeholder="Select a user"
                                       @change="updatePassword">
                                <el-option v-for="user in users" :key="user.username" :label="user.username"
                                           :value="user.username"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item prop="password">
                            <el-input type="password" v-model="loginForm.password"
                                      placeholder="Please enter the password"></el-input>
                        </el-form-item>
                        <el-form-item prop="code" label-width="0">
                            <div style="display: flex; align-items: center;">
                                <el-input type="text" auto-complete="false" v-model="loginForm.code"
                                          style="width: 250px;"></el-input>
                                <el-button type="text" @click="changeCaptcha" style="padding: 0; margin-left: 20px">
                                    <canvas ref="captchaCanvas" width="80" height="40"
                                            style="border: 1px solid #a8a4a4; border-radius: 5px;"></canvas>
                                </el-button>
                            </div>
                        </el-form-item>
                        <el-checkbox v-model="checked" class="loginRemember">Remember Me</el-checkbox>
                        <el-button type="primary" style="width:100%" @click="submitLogin">Login</el-button>
                    </el-form>
                </el-row>
            </el-col>
        </div>
    </el-container>
</div>

<script>
    new Vue({
        el: "#app",
        name: "Login",
        data() {
            return {
                captcha: null,
                users: [
                    {username: "admin", password: "123456"},
                    {username: "user1", password: "123456"},
                    {username: "user2", password: "123456"},
                    {username: "user3", password: "123456"},
                    {username: "user4", password: "123456"},
                    // Add more users as needed
                ],
                loginForm: {
                    selectedUser: "admin", // Default selected user
                    password: "123456",
                    code: ""
                },
                checked: true,
                rules: {
                    username: [
                        {required: true, message: "Please enter the username", trigger: "blur"},
                        {
                            min: 5,
                            max: 14,
                            message: 'Length should be between 5 and 14 characters',
                            trigger: 'blur'
                        }
                    ],
                    password: [
                        {required: true, message: "Please enter the password", trigger: "blur"},
                        {
                            min: 6,
                            message: 'Password length must be greater than 6',
                            trigger: 'blur'
                        }
                    ],
                    code: [{required: true, message: "Please enter the verification code", trigger: "blur"}],
                }
            }
        },
        mounted() {
            this.generateCaptcha();
            this.updatePassword();
        },
        methods: {
            submitLogin() {
                const selectedUser = this.users.find(user => user.username === this.loginForm.selectedUser);
                if (!selectedUser) {
                    this.$message.error('Invalid user selected');
                    return;
                }

                this.$refs.loginForm.validate((valid) => {
                    if (valid) {
                        if (this.loginForm.code === this.captcha.toString() && this.loginForm.password === selectedUser.password) {
                            alert('Login successful');
                            window.location.href = 'http://localhost:8082/getPage/Feedback';
                        } else {
                            this.$message.error('Incorrect verification code or password. Please try again.');
                        }
                    } else {
                        this.$message.error('Login error, please enter again');
                    }
                });
            },
            updatePassword() {
                const selectedUser = this.users.find(user => user.username === this.loginForm.selectedUser);
                if (selectedUser) {
                    this.loginForm.password = selectedUser.password;
                }
            },
            changeCaptcha() {
                this.generateCaptcha();
            },
            generateCaptcha() {
                const canvas = this.$refs.captchaCanvas;
                const context = canvas.getContext('2d');
                this.captcha = this.generateRandomCaptcha(1000, 9999);

                context.clearRect(0, 0, canvas.width, canvas.height);
                context.font = '20px Arial';
                context.fillText(this.captcha, 10, 30);
            },
            generateRandomCaptcha(min, max) {
                return Math.floor(Math.random() * (max - min + 1)) + min;
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
        margin-top: 60px;
        width: 350px;
        padding: 15px 35px 15px 35px;
        background: aliceblue;
        border: 1px solid blueviolet;
        box-shadow: 0 0 25px #f885ff;
    }

    .loginTitle {
        margin: 0px auto 48px auto;
        text-align: center;
        font-size: 30px;
    }

    .loginRemember {
        text-align: left;
        margin: 0px 0px 15px 0px;
    }

    .body {
        width: 100vw;
        height: 100vh;
        background-image: url("/images/background.png");
        background-size: 100%;
        overflow: hidden;
    }

    .center-container {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-left: 550px;
    }

    .social-media-icons {
        display: flex;
        font-size: 30px;
        justify-content: space-between;
        width: 300px;
    }

    .social-media-icons a {
        background-color: #f0f0f0;
        text-decoration: none;
        color: #333;
        display: inline-block;
        padding: 10px;
        border: 2px solid #333;
        border-radius: 10px;
        transition: background-color 0.3s;
    }

    .social-media-icons a:hover {
        background-color: #333;
        color: #fff;
    }

</style>


</body>
</html>

