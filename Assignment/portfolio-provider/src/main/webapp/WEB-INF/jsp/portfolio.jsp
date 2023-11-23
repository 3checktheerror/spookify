<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Portfolio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="//unpkg.com/element-ui/lib/umd/locale/en.js"></script>
    <!-- Custom CSS -->
    <style>
        .carousel-item.active {
            opacity: 1;
        }

        .carousel-item:not(.active) {
            opacity: 0;
        }

        /* 自定义箭头位置 */
        .carousel-control-prev, .carousel-control-next {
            top: 50%;
            transform: translateY(-50%);
        }

        .carousel-item {
            display: flex;
            align-items: center;
            overflow: hidden; /* 确保溢出部分被隐藏 */
            height: 80vh; /* 设置容器高度，这里是视窗高度的一半，你可以根据需要调整 */
            transition: opacity 1s ease-in-out;
        }

        .carousel-item img {
            object-fit: cover; /* 保持图片宽高比并裁剪到容器大小 */
            object-position: center bottom;
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
<div id="app">
    <el-container>
        <el-aside width="isCollapse ? '64px' : '150px'">
            <template>
                <div>
                    <el-radio-group v-model="isCollapse"
                                    style="margin-bottom: 20px;display: flex; flex-direction: column;">
                        <el-radio-button :label="false">展开</el-radio-button>
                        <el-radio-button :label="true">收起</el-radio-button>
                    </el-radio-group>
                    <el-menu default-active="1-4-1" class="el-menu-vertical-demo" @open="handleOpen"
                             @close="handleClose" :collapse="isCollapse">
                        <el-submenu index="1">
                            <template slot="title">
                                <i class="el-icon-location"></i>
                                <a v-if="!isCollapse" @click="handleIndexPage1">导航页1</a>
                            </template>
                            <el-menu-item-group>
                                <span slot="title">分组一</span>
                                <el-menu-item index="1-1">选项1</el-menu-item>
                                <el-menu-item index="1-2">选项2</el-menu-item>
                            </el-menu-item-group>
                            <el-menu-item-group title="分组2">
                                <el-menu-item index="1-3">选项3</el-menu-item>
                            </el-menu-item-group>
                            <el-submenu index="1-4">
                                <span slot="title">选项4</span>
                                <el-menu-item index="1-4-1">选项1</el-menu-item>
                            </el-submenu>
                        </el-submenu>
                        <el-menu-item index="2">
                            <i class="el-icon-menu"></i>
                            <span slot="title">导航二</span>
                        </el-menu-item>
                        <el-menu-item index="3" disabled>
                            <i class="el-icon-document"></i>
                            <span slot="title">导航三</span>
                        </el-menu-item>
                        <el-menu-item index="4">
                            <i class="el-icon-setting"></i>
                            <span slot="title">导航四</span>
                        </el-menu-item>
                    </el-menu>
                </div>
            </template>
        </el-aside>
        <el-container>
            <el-main>
                <div id="carouselExampleFade" class="carousel slide carousel-fade">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="/images/imagesForPortfolio/lake.jpg" class="d-block w-100" alt="Projects Participated">
                        </div>
                        <div class="carousel-item">
                            <img src="/images/imagesForPortfolio/fox.jpg" class="d-block w-100" alt="Certificates">
                        </div>
                        <div class="carousel-item">
                            <img src="/images/imagesForPortfolio/lion.jpg" class="d-block w-100" alt="published papers">
                        </div>
                        <!-- Add more carousel items as needed -->
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleFade"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleFade"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
                <div class="text-center my-5">
                    <h1>Portfolio</h1>
                    <hr/>
                </div>

                <div class="row">
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="card mb-5 shadow-sm">
                            <img src="/images/imagesForPortfolio/fox.jpg" class="img-fluid">
                            <div class="card-body">
                                <h5 class="card-title">Participated Projects</h5>
                                <div class="card-text">
                                    <p>参加过的项目</p>
                                </div>
                                <a href="#" class="btn btn-outline-primary rounded-1 float-end">
                                    Read More
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-4 offset-lg-0.5">
                        <div class="card mb-5 shadow-sm">
                            <img src="/images/imagesForPortfolio/lion.jpg" class="img-fluid">
                            <div class="card-body">
                                <h5 class="card-title">Certificates</h5>
                                <div class="card-text">
                                    <p>获得的证书</p>
                                </div>
                                <a href="#" class="btn btn-outline-primary rounded-1 float-end">
                                    Read More
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="card mb-5 shadow-sm">
                            <img src="/images/imagesForPortfolio/lake.jpg" class="img-fluid">
                            <div class="card-body">
                                <h5 class="card-title">Published Papers</h5>
                                <div class="card-text">
                                    <p>发表的论文</p>
                                </div>
                                <a href="#" class="btn btn-outline-primary rounded-1 float-end">
                                    Read More
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

            </el-main>
            <el-footer>Footer</el-footer>
        </el-container>
    </el-container>
</div>


<!-- Bootstrap JS and Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>

<script>
    new Vue({
        el: '#app',
        data() {
            return {
                isCollapse: true
            }
        },
        methods: {
            handleIndexPage1(){
                window.location.href = 'http://www.baidu.com';
            }
        }
    });
    document.addEventListener("DOMContentLoaded", function () {
        var fadeCarousel = new bootstrap.Carousel(document.getElementById('carouselExampleFade'));

        // 手动暂停轮播
        fadeCarousel.pause();

        document.addEventListener("keydown", function (event) {
            if (event.key === "ArrowLeft") {
                // 左箭头按键被按下
                fadeCarousel.prev();
                // 延迟一段时间后重新启动轮播

            } else if (event.key === "ArrowRight") {
                // 右箭头按键被按下
                fadeCarousel.next();
                // 延迟一段时间后重新启动轮播
            }
        });
    });
</script>


</body>
</html>



