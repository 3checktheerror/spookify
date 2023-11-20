<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
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

    <el-container>
        <el-aside width="isCollapse ? '64px' : '150px'">
            <template>
                <div>
                    <el-radio-group v-model="isCollapse" style="margin-bottom: 20px;display: flex; flex-direction: column;">
                        <el-radio-button :label="false">展开</el-radio-button>
                        <el-radio-button :label="true">收起</el-radio-button>
                    </el-radio-group>
                    <el-menu default-active="1-4-1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose" :collapse="isCollapse">
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
            <el-header>

            </el-header>
            <el-main>
                <template>
                    <nav class="navbar navbar-expand-lg bg-body-tertiary">
                        <div class="container-fluid">
                            <a class="navbar-brand" href="#">My Blog</a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <li class="nav-item">
                                        <a class="nav-link active" aria-current="page" href="#">Home</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="#">Link</a>
                                    </li>

                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Categories
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="#">Action</a></li>
                                            <li><a class="dropdown-item" href="#">Another action</a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link disabled" aria-disabled="true">Disabled</a>
                                    </li>
                                </ul>

                                <form class="d-flex" role="search">
                                    <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                                    <button class="btn btn-outline-success" type="submit">Search</button>
                                </form>
                            </div>
                        </div>
                    </nav>

                    <div class="row">
                        <div class="row-3" >
                            <div id="list-example" class="list-group">
                                <a class="list-group-item">Articles</a>
                                <a class="list-group-item list-group-item-action" href="#list-item" :key="1">1. The Quantum Leap of Artificial Intelligence</a>
                                <a class="list-group-item list-group-item-action" href="#list-item" :key="2">2. Mindfulness in the Digital Age</a>
                                <a class="list-group-item list-group-item-action" href="#list-item" :key="3">3. The Next Frontiers of Space Exploration</a>

                            </div>
                        </div>
                        <div class="container mt-5">
                            <h1 class="mb-4">My Artistic Blog</h1>
                            <div data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">

                                <div v-for="post in blogPosts" :key="post.id" class="card mb-5">
                                    <div class="card-body">
                                        <h5 class="card-title" id="list-item" :key="post.id">{{ post.title }}</h5>
                                        <div v-if="!post.showDetails">
                                            <p class="card-text">{{ summarizeContent(post.content) }}</p>
                                            <button @click="toggleDetails(post)">Read More</button>
                                        </div>
                                        <div v-else>
                                            <p class="card-text">{{ post.content }}</p>
                                            <button @click="toggleDetails(post)">Show Less</button>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="pagination-container">
                        <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">Free Download</button>

                        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                            <div class="offcanvas-header">
                                <h5 class="offcanvas-title" id="offcanvasRightLabel">Offcanvas right</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body">
                                <p>
                                    Thank you for choosing to download our content! This offcanvas provides additional information or options related to the free download.
                                </p>
                                <p>
                                    You can customize the content of this offcanvas body to include details about the download, instructions, or any other relevant information.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="pagination-container">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">
                                <li class="page-item"><a class="page-link" href="#">Previous</a></li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">Next</a></li>
                            </ul>
                        </nav>
                    </div>
                    <form id="search">
                        Search <input name="query" v-model="searchQuery">
                    </form>
                    <DemoGrid
                            :data="gridData"
                            :columns="gridColumns"
                            :filter-key="searchQuery">
                    </DemoGrid>
                </template>


            </el-main>
            <el-footer>Footer</el-footer>
        </el-container>
    </el-container>
</div>


<script>

    new Vue( {
        el: '#app',
        data() {
            return {
                blogPosts: [
                    { id: 1, title: 'The Quantum Leap of Artificial Intelligence', content: 'Introduction: Explore the cutting-edge intersection of quantum computing and artificial intelligence. This article delves into the potential of quantum computing to revolutionize AI algorithms, unlocking unprecedented computational power and solving complex problems that were once deemed impossible.', showDetails: false },
                    { id: 2, title: 'Mindfulness in the Digital Age', content: 'Introduction: In an era dominated by constant digital stimuli, this article explores the importance of mindfulness practices to maintain focus and well-being. Discover strategies for navigating information overload, fostering digital mindfulness, and striking a balance between technology and mental health.', showDetails: false },
                    { id: 3, title: 'The Next Frontiers of Space Exploration', content: 'Introduction: Journey beyond the red planet as we unravel the exciting prospects and challenges of future space exploration. From the exploration of distant exoplanets to the establishment of lunar colonies, this article paints a visionary picture of humanity next great leaps into the cosmos.', showDetails: false }

                ],
                isCollapse : true
            };
        },
        methods: {
            summarizeContent(content) {
                return content.slice(0, 50) + '...'; // Display only the first 50 characters for summary
            },
            toggleDetails(post) {
                post.showDetails = !post.showDetails;
            },
            handleIndexPage1(){
                window.location.href = 'https://www.baidu.com';
            }
        }
    });
</script>
<style>
    .el-upload-list__item-name [class^=el-icon] {
        height: 5%;
        margin-right: 7px;
        color: #909399;
        line-height: inherit;
    }
    .pagination-container {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 20vh; /* Adjust the height as needed */
    }
    .container {
        max-width: 800px;
        margin: 0 auto;
    }

    .card {
        border: 1px solid #ddd;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease-in-out;
    }

    .card:hover {
        transform: scale(1.02);
    }

    .card-body {
        padding: 20px;
    }

    h1 {
        text-align: center;
        color: #3498db;
    }

    button {
        background-color: #3498db;
        color: #fff;
        border: none;
        padding: 8px 12px;
        cursor: pointer;
        transition: background-color 0.3s ease-in-out;
    }

    button:hover {
        background-color: #2980b9;
    }
</style>


</body>

</html>
