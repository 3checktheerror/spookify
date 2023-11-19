<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Biography page</title>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div id="root">
    <el-container>
        <el-header height="100px">Biography- Miss Seven</el-header>
        <el-container>
            <el-aside width="600px">
                <h1>Brief Introduction</h1>
                <img src="/images/Bimage/img.png" alt="ABC">
                <h1>Miss Seven</h1>
                <h2>Undergraduate Graduates from the Class of 2023</h2>
                <el-card class="basic-info-card" shadow="always">
                    <div slot="header" class="clearfix">
                        <h3>Basic Information</h3>
                    </div>
                    <div class="text">
                        <i class="el-icon-date"></i> Birthday: 1991.12.15 <br>
                        <i class="el-icon-house"></i> Residence: BeiJing, China<br>
                        <i class="el-icon-phone"></i> Phone Number:1234135<br>
                        <i class="el-icon-message"></i> Email :1234123@qq.com
                    </div>
                </el-card><br><br>

                <el-card class="skills-certificate-card" shadow="always">
                    <div slot="header" class="clearfix">
                        <h3>Skills Certificate</h3>
                    </div>
                    <div class="text">
                        Foreign Language Certificate: English CET6, CET4<br>
                        Qualification: Adobe International Certification<br>
                        Software Operation: Computer Level 3 Network Engineering
                    </div>
                </el-card><br><br>

                <el-card class="self-esteem-card" shadow="always">
                    <div slot="header" class="clearfix">
                        <h3>Self-Esteem</h3>
                    </div>
                    <div class="slef-text">
                        Good sense of public relations, good communication, event planning and organisation and coordination skills.
                        Good mentality and sense of responsibility, hard-working, good at management, and willing to face challenges.
                        Good independent learning ability, used to make learning plans, diligent learning and continuous improvement.
                    </div>
                </el-card><br><br>

            </el-aside>
            <el-main>
                <el-card class="Education-card" shadow="always">
                    <div slot="header" class="clearfix">
                        <h3>Education Experience</h3>
                        <el-button style="float: right; padding: 3px 0" type="text">More</el-button>
                    </div>
                    <div class="text">
                        asdfadss <br>
                        adf
                        <div class="block">
                            <el-carousel height="150px">
                                <el-carousel-item v-for="item in 4" :key="item">
                                    <h3 class="small">{{ item }}</h3>
                                </el-carousel-item>
                            </el-carousel>
                            <span class="demonstration">Graduation Photographs, Degree Certificates</span>
                        </div>
                    </div>
                </el-card><br><br>

                <el-card class="Experience-card" shadow="always">
                    <div slot="header" class="clearfix">
                        <h3>Work Experience</h3>
                        <el-button style="float: right; padding: 3px 0" type="text">More</el-button>
                    </div>
                    <div class="text">
                        asdfadss <br>
                        adf
                        <div class="block">
                            <el-carousel height="150px">
                                <el-carousel-item v-for="item in 4" :key="item">
                                    <h3 class="small">{{ item }}</h3>
                                </el-carousel-item>
                            </el-carousel>
                            <span class="demonstration">默认 Hover 指示器触发</span>
                        </div>
                    </div>
                </el-card><br><br>

                <el-card class="Practice-card" shadow="always">
                    <div slot="header" class="clearfix">
                        <h3>Practical Project</h3>
                        <el-button style="float: right; padding: 3px 0" type="text">More</el-button>
                    </div>
                    <div class="text">
                        asdfadss <br>
                        adf
                        <div class="block">
                            <el-carousel height="150px">
                                <el-carousel-item v-for="item in image" :key="item">
                                    <img :src="item" alt="carousel-image" class="carousel-image">
                                </el-carousel-item>
                            </el-carousel>
                            <span class="demonstration">默认 Hover 指示器触发</span>
                        </div>
                    </div>
                </el-card><br><br>

                <el-card class="Skill-card" shadow="always">
                    <div slot="header" class="clearfix">
                        <h3>Skill and Capability</h3>
                        <el-button style="float: right; padding: 3px 0" type="text">More</el-button>
                    </div>
                    <div class="text">
                        asdfadss <br>
                        adf
                        <div class="block">
                            <el-carousel height="150px">
                                <el-carousel-item v-for="item in 4" :key="item">
                                    <h3 class="small">{{ item }}</h3>
                                </el-carousel-item>
                            </el-carousel>
                            <span class="demonstration">默认 Hover 指示器触发</span>
                        </div>
                    </div>
                </el-card><br>

                <el-card class="Award-card" shadow="always">
                    <div slot="header" class="clearfix">
                        <h3>Award</h3>
                        <el-button style="float: right; padding: 3px 0" type="text">操作按钮</el-button>
                    </div>
                    <div class="text">
                        asdfadss <br>
                        adf
                        <div class="block">
                            <el-carousel height="150px">
                                <el-carousel-item v-for="item in 4" :key="item">
                                    <h3 class="small">{{ item }}</h3>
                                </el-carousel-item>
                            </el-carousel>
                            <span class="demonstration">默认 Hover 指示器触发</span>
                        </div>
                    </div>
                </el-card><br><br>



            </el-main>
        </el-container>
    </el-container>
</div>



<script>

    const vm= new Vue({
        data(){
            return{
                name:'Steve Jobs',
                intro:'Steven Paul Jobs (February 24, 1955 – October 5, 2011) was an American business magnate, inventor, and investor best known as the co-founder of Apple. ' +
                    'Jobs was also chairman and majority shareholder of Pixar, and the founder of NeXT. He was a pioneer of the personal computer revolution of the 1970s and 1980s, along with his early business partner and fellow Apple co-founder Steve Wozniak.',
                image:['/images/Bimage/img_1.png','/images/Bimage/img_2.png']
            }
        }
    }).$mount('#root')
</script>

</body>

<style>
    .el-header, .el-footer {
        background-color: #B3C0D1;
        color: #333;
        text-align: center;
        line-height: 100px;
        font-size: 40px;
    }

    .el-aside {
        background-color: #D3DCE6;
        color: #333;
        text-align: left;
        line-height: 50px;
    }

    .el-main {
        background-color: #E9EEF3;
        color: #333;
        text-align: left;
        line-height: 50px;
    }

    body > .el-container {
        margin-bottom: 50px;
    }
    h1{
        text-align: center;
        font-size:40px;
    }
    h2{
        text-align: center; /* 水平居中文本 */
        padding-top: 15px;  /* 在顶部添加15像素的内边距 */
        margin-bottom: 20px;
        font-size: 20px; /* 设置字体大小为24像素 */
    }
    .el-container:nth-child(5) .el-aside,
    .el-container:nth-child(6) .el-aside {
        line-height: 260px;
    }

    .el-container:nth-child(7) .el-aside {
        line-height: 320px;
    }
    img {
        display: block; /* 使图片成为块级元素，以便能够设置宽度、高度和外边距等样式 */
        margin: 0 auto; /* 居中图片 */
        max-width: 100%; /* 确保图片不超过其容器的宽度 */
        height: auto; /* 保持图片的纵横比，防止拉伸变形 */
    }
    .text {
        font-size: 14px;
    }
    .slef-text{
        font-size: 14px;
        line-height: 2;
    }

    h3{
        margin-bottom: auto;
        margin-top: auto;
        margin-left: auto;
    }
    .clearfix{
        margin-bottom: auto;
        margin-top: auto;
        margin-left: auto;
    }


    .basic-info-card {
        width: 480px;
        margin-left: auto;
        margin-right: auto;
    }
    .skills-certificate-card{
        width: 480px;
        margin-left: auto;
        margin-right: auto;
    }
    .self-esteem-card{
        width: 480px;
        margin-left: auto;
        margin-right: auto;
    }

    .Education-card{
        width:900px;
        margin-left: auto;
    }
    .Experience-card{
        width:900px;
        margin-left: auto;
    }

    .Practice-card{
        width:900px;
        margin-left: auto;
    }
    .Skill-card{
        width:900px;
        margin-left: auto;
    }

    .Award-card{
        width:900px;
        margin-left: auto;
    }
    .el-carousel__item h3 {
        color: #475669;
        font-size: 14px;
        opacity: 0.75;
        line-height: 150px;
        margin: 0;
    }

    .el-carousel__item:nth-child(2n) {
        background-color: #99a9bf;
    }

    .el-carousel__item:nth-child(2n+1) {
        background-color: #d3dce6;
    }
    .demonstration{
        margin-right: auto;
        margin-left: auto;
        text-align: center;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%; /* 设置高度为100%确保垂直居中，但需要保证父元素有确定的高度 */
        font-size: 15px;
    }
    .carousel-image {
        width: 100%;
        height: 100%;
        object-fit: cover; /* 保持图片纵横比，填充整个容器 */
    }
</style>
</html>