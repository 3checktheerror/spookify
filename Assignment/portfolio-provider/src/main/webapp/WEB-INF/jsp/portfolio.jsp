<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Portfolio</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="//unpkg.com/element-ui/lib/umd/locale/en.js"></script>
    <!-- Custom CSS -->
    <style>
        .ipadPro {
            width: 855px;
            height: 600px;
            background-color: white;
            overflow: hidden;
            position: relative;
            border: 5px solid #111;
            border-radius: 4.29vmin;
            margin: 0 auto 2em; /* 居中 */
            box-shadow: 0 0.5em 2em 0.2em rgba(0, 0, 0, 0.33), 0 0 0 0.5px #000 inset;
            transition: all .1s linear, line-height 0s linear;
            background-position: 50% 100%, center;
            transform-origin: bottom center;
        }



        .ipad-container {
            display: flex;
            justify-content: space-around;
        }

        .ipad {
            width: 57vmin;
            height: 40vmin;
            background-color: white;
            overflow: hidden;
            position: relative;
            border: 5px solid #111;
            border-radius: 4.29vmin;
            margin-bottom: 2em;
            box-shadow: 0 0.5em 2em 0.2em rgba(0, 0, 0, 0.33), 0 0 0 0.5px #000 inset;
            transition: all .1s linear, line-height 0s linear;
            background-position: 50% 100%, center;
            transform-origin: bottom center;
        }

        .ipadPro, .ipad {
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: white;
        }

        .ipadPro img, .ipad img {
            width: auto;
            height: auto;
            max-width: 100%;
            max-height: 100%;
            margin: auto;
        }

        .ipad-text {
            text-align: left;
            margin-top: 1em;
            margin-left: 1em;
        }
        .fixed-aside {
            position: fixed;
            z-index: 1;
            top: 40px;
            left: 0;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);

        }
        .el-radio-button__inner{
            width: 100%;
        }
    </style>

</head>
<body>
<div id="app">
    <el-container>
        <el-aside width="isCollapse ? '64px' : '150px'">
            <template>
                <div class="fixed-aside">
                    <el-radio-group v-model="isCollapse" :collapse-transition="false" style="display: flex; flex-direction: column;">
                        <el-radio-button :label="!isCollapse" width="100">
                            <i :class="isCollapse ? 'fa fa-angle-double-right' : 'fa fa-angle-double-left'" style="color: #333"></i>
                        </el-radio-button>
                    </el-radio-group>
                    <el-menu default-active="1-4-1" class="el-menu-vertical-demo" @open="handleOpen"
                             @close="handleClose" :collapse="isCollapse">
                        <el-menu-item index="1">
                            <i class="el-icon-user-solid" @click="handleIndexPage1"></i>
                            <a v-if="!isCollapse" @click="handleIndexPage1">Biography</a>
                        </el-menu-item>
                        <el-menu-item index="2">
                            <i class="el-icon-picture" @click="handleIndexPage2"></i>
                            <a v-if="!isCollapse" @click="handleIndexPage2">Portfolio</a>
                        </el-menu-item>
                        <el-menu-item index="3">
                            <i class="el-icon-document" @click="handleIndexPage3"></i>
                            <a v-if="!isCollapse" @click="handleIndexPage3">Blog Articles</a>
                        </el-menu-item>
                        <el-menu-item index="4">
                            <i class="el-icon-s-comment" @click="handleIndexPage4"></i>
                            <a v-if="!isCollapse" @click="handleIndexPage4">Feedback</a>
                        </el-menu-item>
                        <el-menu-item index="5">
                            <i class="el-icon-message" @click="handleIndexPage5"></i>
                            <a v-if="!isCollapse" @click="handleIndexPage5">Contact Me</a>
                        </el-menu-item>
                    </el-menu>
                </div>
            </template>
        </el-aside>


        <el-container>
            <el-main>
                <div class="ipadPro">
                    <div id="ipadProCarousel" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="/images/imagesForPortfolio/pro1.jpg" class="d-block w-100" alt="First iPad Pro Image">
                            </div>
                            <div class="carousel-item">
                                <img src="/images/imagesForPortfolio/pro2.jpg" class="d-block w-100" alt="Second iPad Pro Image">
                            </div>
                            <div class="carousel-item">
                                <img src="/images/imagesForPortfolio/pro3.jpg" class="d-block w-100" alt="Second iPad Pro Image">
                            </div>
                            <div class="carousel-item">
                                <img src="/images/imagesForPortfolio/pro4.jpg" class="d-block w-100" alt="Second iPad Pro Image">
                            </div>


                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#ipadProCarousel"
                                data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#ipadProCarousel"
                                data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>

                <div class="text-center my-5">
                    <h1>Established Enterprises</h1>
                    <hr/>
                </div>

                <div class="ipad-container">

                    <div class="ipad">
                        <div id="ipadCarousel1" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="/images/imagesForPortfolio/apple3.jpg" class="d-block w-100" alt="First iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/apple1.jpg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/apple2.jpg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/apple4.jpg" class="d-block w-100" alt="Second iPad Image">
                                </div>

                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#ipadCarousel1"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#ipadCarousel1"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>


                    <div class="ipad">
                        <div id="ipadCarousel2" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="/images/imagesForPortfolio/next1.jpg" class="d-block w-100" alt="Third iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/next2.jpg" class="d-block w-100" alt="Fourth iPad Image">
                                </div>

                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#ipadCarousel2"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#ipadCarousel2"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>

                    <div class="ipad">
                        <div id="ipadCarousel3" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="/images/imagesForPortfolio/pixar3.jpeg" class="d-block w-100" alt="Fifth iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/pixar5.jpg" class="d-block w-100" alt="Sixth iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/pixar1.jpg" class="d-block w-100" alt="Sixth iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/pixar2.jpg" class="d-block w-100" alt="Sixth iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/pixar4.jpeg" class="d-block w-100" alt="Sixth iPad Image">
                                </div>

                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#ipadCarousel3"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#ipadCarousel3"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="ipad-text">Steven Jobs was the co-founder of AppleInc., where he served as chairman and CEO. As of June 2022, Apple is the 4th-largest personal computer vendor by unit sales; the largest manufacturing company by revenue; and the 2nd-largest mobile phone manufacturer in the world. </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-4 offset-lg-0.5">
                        <div class="ipad-text">Jobs was also the founder and CEO of NeXT. He established this computer company in 1985, after being dismissed by Apple. The world's first website, info.cern.ch, was installed on a NeXT workstation, and the world's first web browser, WorldWideWeb, also ran on the NeXT system. In 1996, NeXT was acquired by Apple </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-4 offset-lg-0.5">
                        <div class="ipad-text">Jobs played a crucial role in founding and serving as CEO of Pixar Animation Studios. It is a computer animation studio known for its critically and commercially successful computer-animated feature films. 11 Pixar films have won the Academy Award for Best Animated Feature, including Finding Nemo (2003) ,Coco (2017), Toy Story 4 (2019)</div>
                    </div>
                </div>

                <div class="text-center my-5">
                    <h1>Inventions and Innovations</h1>
                    <hr/>
                </div>

                <div class="ipad-container">
                    <div class="ipad">
                        <div id="ipadCarousel4" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="/images/imagesForPortfolio/mac1.jpg" class="d-block w-100" alt="First iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/mac2.png" class="d-block w-100" alt="Second iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/mac3.jpg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/mac4.jpg" class="d-block w-100" alt="Second iPad Image">
                                </div>

                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#ipadCarousel4"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#ipadCarousel4"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>

                    <div class="ipad">
                        <div id="ipadCarousel5" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="/images/imagesForPortfolio/iphone1.jpg" class="d-block w-100" alt="First iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/iphone2.jpeg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/iphone3.jpeg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/iphone4.jpeg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#ipadCarousel5"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#ipadCarousel5"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>

                    <div class="ipad">
                        <div id="ipadCarousel6" class="carousel slide" data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="/images/imagesForPortfolio/ipad1.jpg" class="d-block w-100" alt="First iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/ipad2.jpg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/ipad3.jpg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                                <div class="carousel-item">
                                    <img src="/images/imagesForPortfolio/ipad4.jpg" class="d-block w-100" alt="Second iPad Image">
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#ipadCarousel6"
                                    data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#ipadCarousel6"
                                    data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-12 col-md-6 col-lg-4">
                        <div class="ipad-text">
                            The Mac, short for Macintosh (its official name
                            until 1999), is a family of personal computers designed
                            and marketed by Apple Inc. The Macintosh 128k is the first successful personal computer
                            for the mass market, featuring a graphical user interface, built-in screen, and mouse.
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-4 offset-lg-0.5">
                        <div class="ipad-text">
                            iPhone is a line of smartphones produced
                            by Apple Inc. that use Apple's own iOS mobile operating system.
                            The first-generation iPhone was announced by then-Apple CEO
                            Steve Jobs on January 9, 2007. The iPhone was the first mobile phone to
                            use multi-touch technology. Since the iPhone's launch, it has gained larger screen
                            sizes, video-recording, waterproofing, and many accessibility features.
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-4 offset-lg-0.5">
                        <div class="ipad-text">
                            The iPad is a brand of iOS and iPadOS-based tablet computers
                            that are developed by Apple Inc., first introduced on January 27, 2010.
                            The user interface of the iPad is mainly designed with a multi touch screen,
                            including a virtual keyboard.
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
            handleOpen(key, keyPath) {
                console.log(key, keyPath);
            },
            handleClose(key, keyPath) {
                console.log(key, keyPath);
            },
            handleIndexPage1() {
                window.location.href = 'http://localhost:8082/getPage/Biography';
            },
            handleIndexPage2() {
                window.location.href = 'http://localhost:8082/getPage/portfolio';
            },
            handleIndexPage3() {
                window.location.href = 'http://localhost:8082/getPage/blogArticles';
            },
            handleIndexPage4() {
                window.location.href = 'http://localhost:8082/getPage/Feedback';
            },
            handleIndexPage5() {
                window.location.href = 'http://localhost:8082/getPage/contactMe';
            },
        }
    });
</script>
</body>
</html>
