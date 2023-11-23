<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
    <meta charset="UTF-8">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/wow/wow.js"></script>
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
    <title>Blog Articles</title>

    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/images/LuoImg/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Roboto:wght@500;700;900&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/lib/animate/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
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
            <el-main>
                <template>
                    <!-- Topbar Start -->
                    <div class="container-fluid bg-light p-0 wow fadeIn" data-wow-delay="0.1s">
                        <div class="row gx-0 d-none d-lg-flex">
                            <div class="col-lg-7 px-5 text-start">
                                <div class="h-100 d-inline-flex align-items-center py-3 me-4">
                                    <small class="fa fa-map-marker-alt text-primary me-2"></small>
                                    <small>123 Street, New York, USA</small>
                                </div>
                                <div class="h-100 d-inline-flex align-items-center py-3">
                                    <small class="far fa-clock text-primary me-2"></small>
                                    <small>Working time: 8:00am ~ 6:00pm</small>
                                </div>
                            </div>
                            <div class="col-lg-5 px-5 text-end">
                                <div class="h-100 d-inline-flex align-items-center py-3 me-4">
                                    <small class="fa fa-phone-alt text-primary me-2"></small>
                                    <small>+012 345 6789</small>
                                </div>
                                <div class="h-100 d-inline-flex align-items-center">
                                    <a class="btn btn-sm-square rounded-circle bg-white text-primary me-1" href=""><i class="fab fa-facebook-f"></i></a>
                                    <a class="btn btn-sm-square rounded-circle bg-white text-primary me-1" href=""><i class="fab fa-twitter"></i></a>
                                    <a class="btn btn-sm-square rounded-circle bg-white text-primary me-1" href=""><i class="fab fa-linkedin-in"></i></a>
                                    <a class="btn btn-sm-square rounded-circle bg-white text-primary me-0" href=""><i class="fab fa-instagram"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Topbar End -->


                    <!-- Navbar Start -->
                    <nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0 wow fadeIn" data-wow-delay="0.1s">
                        <a href="blogArticles" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
                            <h1 class="m-0 text-primary"><i class="far fa-hospital me-3"></i>Steve Jobs</h1>
                        </a>
                        <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarCollapse">
                            <div class="navbar-nav ms-auto p-4 p-lg-0">
                                <a href="blogArticles" class="nav-item nav-link active">Home</a>
                                <a href="blogArticles" class="nav-item nav-link">About</a>
                                <a href="blogArticles" class="nav-item nav-link">Blog</a>
                                <div class="nav-item dropdown">
                                    <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Achievement</a>
                                    <div class="dropdown-menu rounded-0 rounded-bottom m-0">
                                        <a href="blogArticles" class="dropdown-item">Apple</a>
                                        <a href="blogArticles" class="dropdown-item">The Origin</a>
                                        <a href="blogArticles" class="dropdown-item">Design Idea</a>
                                        <a href="blogArticles" class="dropdown-item">Production Chain</a>
                                        <a href="blogArticles" class="dropdown-item">Recycling</a>
                                    </div>
                                </div>
                                <a href="blogArticles" class="nav-item nav-link">Contact</a>
                            </div>
                            <a href="" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">Ask a Question<i class="fa fa-arrow-right ms-3"></i></a>
                        </div>
                    </nav>
                    <!-- Navbar End -->


                    <!-- Header Start -->
                    <div class="container-fluid header bg-primary p-0 mb-5">
                        <div class="row g-0 align-items-center flex-column-reverse flex-lg-row">
                            <div class="col-lg-6 p-5 wow fadeIn" data-wow-delay="0.1s">
                                <h1 class="display-4 text-white mb-5">“The people who are crazy enough to think they can change the world are the ones who do.” -Steve Jobs</h1>
                                <div class="row g-4">
                                    <div class="col-sm-4">
                                        <div class="border-start border-light ps-4">
                                            <h2 class="text-white mb-1" data-toggle="counter-up"> 21</h2>
                                            <p class="text-light mb-0">Years Old</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="border-start border-light ps-4">
                                            <h2 class="text-white mb-1" data-toggle="counter-up">1976</h2>
                                            <p class="text-light mb-0">Founded Apple</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-4">
                                        <div class="border-start border-light ps-4">
                                            <h2 class="text-white mb-1" data-toggle="counter-up">$3 trillion</h2>
                                            <p class="text-light mb-0">Apple Total Market Value</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s">
                                <div class="d-flex flex-column">
                                    <img class="img-fluid rounded w-75 align-self-end" src="${pageContext.request.contextPath}/images/LuoImg/about-1.jpg" alt="">
                                    <img class="img-fluid rounded w-50 bg-white pt-3 pe-3" src="${pageContext.request.contextPath}/images/LuoImg/about-2.jpg" alt="" style="margin-top: -25%;">
                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- Header End -->


                    <!-- About Start -->
                    <div class="container-xxl py-5">
                        <div class="container">
                            <div class="row g-5">
                                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.1s">
                                    <div class="d-flex flex-column">
                                        <img class="img-fluid rounded w-75 align-self-end" src="${pageContext.request.contextPath}/images/LuoImg/about-1.jpg" alt="">
                                        <img class="img-fluid rounded w-50 bg-white pt-3 pe-3" src="${pageContext.request.contextPath}/images/LuoImg/about-2.jpg" alt="" style="margin-top: -25%;">
                                    </div>
                                </div>
                                <div class="col-lg-6 wow fadeIn" data-wow-delay="0.5s">
                                    <p class="d-inline-block border rounded-pill py-1 px-4">About Steve</p>
                                    <h1 class="mb-4">Who is Steve Jobs? Get Know About Steve!</h1>
                                    <p>Steve Jobs was an American inventor, designer, and entrepreneur who was the cofounder, chief executive, and chairman of Apple Inc. Born in 1955 to two University of Wisconsin graduate students who gave him up for adoption, Jobs was smart but directionless, dropping out of college and experimenting with different pursuits before cofounding Apple with Steve Wozniak in 1976.</p>
                                    <p class="mb-4">Jobs left the company in 1985, launching Pixar Animation Studios, then returned to Apple more than a decade later. The tech giant’s revolutionary products, which include the iPhone, iPad, and iPod, have dictated the evolution of modern technology. Jobs died in 2011 following a long battle with pancreatic cancer.</p>
                                    <p><i class="far fa-check-circle text-primary me-3"></i>Co-founder of the Apple</p>
                                    <p><i class="far fa-check-circle text-primary me-3"></i>Launcher of Pixar Animation</p>
                                    <p><i class="far fa-check-circle text-primary me-3"></i>American inventor</p>
                                    <a class="btn btn-primary rounded-pill py-3 px-5 mt-3" href="">Read More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- About End -->


                    <!-- Service Start -->
                    <div class="container-xxl py-5">
                        <div class="container">
                            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                                <p class="d-inline-block border rounded-pill py-1 px-4">Articles</p>
                                <h1>Technology Changed the Health of Humanity Forever</h1>
                            </div>
                            <div class="row g-4">
                                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                                    <div class="service-item bg-light rounded h-100 p-5">
                                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                                            <i class="fa fa-heartbeat text-primary fs-4"></i>
                                        </div>
                                        <h4 class="mb-3">How Steve Jobs' Medical Experience Informed the Apple Watch</h4>
                                        <p class="mb-4">The Apple Watch recently celebrated its first birthday. While Apple won’t say exactly how many units have been sold, we estimate the number is in the 13-15 million range, bringing in $2-3 billion in revenue. That’s not bad for what some consider a failed product.</p>
                                        <a class="btn" href=""><i class="fa fa-plus text-primary me-3"></i>Read More</a>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                                    <div class="service-item bg-light rounded h-100 p-5">
                                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                                            <i class="fa fa-x-ray text-primary fs-4"></i>
                                        </div>
                                        <h4 class="mb-3">The Real Leadership Lessons of Steve Jobs, a Valuable One</h4>
                                        <p class="mb-4">His saga is the entrepreneurial creation myth writ large: Steve Jobs cofounded Apple in his parents’ garage in 1976, was ousted in 1985, returned to rescue it from near bankruptcy in 1997, and by the time he died, in October 2011, had built it into the world’s most valuable...</p>
                                        <a class="btn" href=""><i class="fa fa-plus text-primary me-3"></i>Read More</a>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                                    <div class="service-item bg-light rounded h-100 p-5">
                                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                                            <i class="fa fa-brain text-primary fs-4"></i>
                                        </div>
                                        <h4 class="mb-3">The Long Shadow of Steve Jobs Looms Over the Turmoil at OpenAI</h4>
                                        <p class="mb-4">Steve Jobs, driven by his genius and his gut, invented the iPhone and built Apple into the world’s most valuable company. He was uncompromising, larger than life and irreplaceable. His life was creating the future, which would be filled with devices controlled by their users.</p>
                                        <a class="btn" href=""><i class="fa fa-plus text-primary me-3"></i>Read More</a>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                                    <div class="service-item bg-light rounded h-100 p-5">
                                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                                            <i class="fa fa-wheelchair text-primary fs-4"></i>
                                        </div>
                                        <h4 class="mb-3">The Health Journey of Steve Jobs: Navigating Challenges</h4>
                                        <p class="mb-4">Beyond the boardrooms and product launches, Steve Jobs faced health challenges that added a layer of complexity to his extraordinary life. Diagnosed with a rare form of pancreatic cancer, Jobs exemplified resilience in the face of adversity. To interact with technology, he...</p>
                                        <a class="btn" href=""><i class="fa fa-plus text-primary me-3"></i>Read More</a>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                                    <div class="service-item bg-light rounded h-100 p-5">
                                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                                            <i class="fa fa-tooth text-primary fs-4"></i>
                                        </div>
                                        <h4 class="mb-3">Steve Jobs Visionary Approach to Dentistry: Change the Industry</h4>
                                        <p class="mb-4">Steve Jobs, renowned for his visionary pursuits in technology, might seem an unlikely figure in the world of dentistry. However, much like his approach to revolutionizing the smartphone industry, Jobs' influence casts a long shadow over unexpected domains...</p>
                                        <a class="btn" href=""><i class="fa fa-plus text-primary me-3"></i>Read More</a>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                                    <div class="service-item bg-light rounded h-100 p-5">
                                        <div class="d-inline-flex align-items-center justify-content-center bg-white rounded-circle mb-4" style="width: 65px; height: 65px;">
                                            <i class="fa fa-vials text-primary fs-4"></i>
                                        </div>
                                        <h4 class="mb-3">Steve Jobs: A Legacy of Innovation and Impact on Technology</h4>
                                        <p class="mb-4">Steve Jobs, a visionary and technological pioneer, left an indelible mark on the world with his groundbreaking innovations. Best known as the co-founder of Apple Inc., Jobs transformed the way we interact with technology. From the iconic iPhone to the sleek MacBook...</p>
                                        <a class="btn" href=""><i class="fa fa-plus text-primary me-3"></i>Read More</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Service End -->


                    <!-- Feature Start -->
                    <div class="container-fluid bg-primary overflow-hidden my-5 px-lg-0">
                        <div class="container feature px-lg-0">
                            <div class="row g-0 mx-lg-0">
                                <div class="col-lg-6 feature-text py-5 wow fadeIn" data-wow-delay="0.1s">
                                    <div class="p-lg-5 ps-lg-0">
                                        <p class="d-inline-block border rounded-pill text-light py-1 px-4">Achievement</p>
                                        <h1 class="text-white mb-4">Why We Love Steve</h1>
                                        <p class="text-white mb-4 pb-2">Steve Jobs, driven by his genius and his gut, invented the iPhone and built Apple into the world’s most valuable company. He was uncompromising, larger than life and irreplaceable. His life was creating the future, which would be filled with devices controlled by their users.</p>
                                        <div class="row g-4">
                                            <div class="col-6">
                                                <div class="d-flex align-items-center">
                                                    <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light" style="width: 55px; height: 55px;">
                                                        <i class="fa fa-user-md text-primary"></i>
                                                    </div>
                                                    <div class="ms-4">
                                                        <p class="text-white mb-2">Experience</p>
                                                        <h5 class="text-white mb-0">Programmer</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="d-flex align-items-center">
                                                    <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light" style="width: 55px; height: 55px;">
                                                        <i class="fa fa-check text-primary"></i>
                                                    </div>
                                                    <div class="ms-4">
                                                        <p class="text-white mb-2">Quality</p>
                                                        <h5 class="text-white mb-0">Innovative</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="d-flex align-items-center">
                                                    <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light" style="width: 55px; height: 55px;">
                                                        <i class="fa fa-comment-medical text-primary"></i>
                                                    </div>
                                                    <div class="ms-4">
                                                        <p class="text-white mb-2">Positive</p>
                                                        <h5 class="text-white mb-0">Joy of Creating</h5>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="d-flex align-items-center">
                                                    <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-light" style="width: 55px; height: 55px;">
                                                        <i class="fa fa-headphones text-primary"></i>
                                                    </div>
                                                    <div class="ms-4">
                                                        <p class="text-white mb-2">Patient</p>
                                                        <h5 class="text-white mb-0">Opportunist</h5>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 pe-lg-0 wow fadeIn" data-wow-delay="0.5s" style="min-height: 400px;">
                                    <div class="position-relative h-100">
                                        <img class="position-absolute img-fluid w-100 h-100" src="${pageContext.request.contextPath}/images/LuoImg/feature.jpg" style="object-fit: cover;" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Feature End -->


                    <!-- Team Start -->
                    <div class="container-xxl py-5">
                        <div class="container">
                            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                                <p class="d-inline-block border rounded-pill py-1 px-4">Family</p>
                                <h1>Meet Steve's Family</h1>
                            </div>
                            <div class="row g-4">
                                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                                    <div class="team-item position-relative rounded overflow-hidden">
                                        <div class="overflow-hidden">
                                            <img class="img-fluid" src="${pageContext.request.contextPath}/images/LuoImg/team-1.jpg" alt="">
                                        </div>
                                        <div class="team-text bg-light text-center p-4">
                                            <h5>Laurene Powell Jobs</h5>
                                            <p class="text-primary">Wife</p>
                                            <div class="team-social text-center">
                                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
                                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
                                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.3s">
                                    <div class="team-item position-relative rounded overflow-hidden">
                                        <div class="overflow-hidden">
                                            <img class="img-fluid" src="${pageContext.request.contextPath}/images/LuoImg/team-2.jpg" alt="">
                                        </div>
                                        <div class="team-text bg-light text-center p-4">
                                            <h5>Abdulfattah Jandali</h5>
                                            <p class="text-primary">Father</p>
                                            <div class="team-social text-center">
                                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
                                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
                                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.5s">
                                    <div class="team-item position-relative rounded overflow-hidden">
                                        <div class="overflow-hidden">
                                            <img class="img-fluid" src="${pageContext.request.contextPath}/images/LuoImg/team-3.jpg" alt="">
                                        </div>
                                        <div class="team-text bg-light text-center p-4">
                                            <h5>Lisa Brennan-Jobs</h5>
                                            <p class="text-primary">Daughter</p>
                                            <div class="team-social text-center">
                                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
                                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
                                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.7s">
                                    <div class="team-item position-relative rounded overflow-hidden">
                                        <div class="overflow-hidden">
                                            <img class="img-fluid" src="${pageContext.request.contextPath}/images/LuoImg/team-4.jpg" alt="">
                                        </div>
                                        <div class="team-text bg-light text-center p-4">
                                            <h5>Reed Paul Jobs</h5>
                                            <p class="text-primary">Son</p>
                                            <div class="team-social text-center">
                                                <a class="btn btn-square" href=""><i class="fab fa-facebook-f"></i></a>
                                                <a class="btn btn-square" href=""><i class="fab fa-twitter"></i></a>
                                                <a class="btn btn-square" href=""><i class="fab fa-instagram"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Team End -->


                    <!-- Appointment Start -->
                    <div class="container-xxl py-5">
                        <div class="container">
                            <div class="row g-5">
                                <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.1s">
                                    <p class="d-inline-block border rounded-pill py-1 px-4">Question</p>
                                    <h1 class="mb-4">Make Us A Question About Steve JObs</h1>
                                    <p class="mb-4">Welcome to our interactive session where you get to steer the conversation. Have burning questions about the iconic tech visionary, Steve Jobs? Whether it's about his groundbreaking contributions to the tech industry, his leadership philosophy, or intriguing aspects of his personal life, we're here to provide answers!</p>
                                    <div class="bg-light rounded d-flex align-items-center p-5 mb-4">
                                        <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-white" style="width: 55px; height: 55px;">
                                            <i class="fa fa-phone-alt text-primary"></i>
                                        </div>
                                        <div class="ms-4">
                                            <p class="mb-2">Call Us Now</p>
                                            <h5 class="mb-0">+012 345 6789</h5>
                                        </div>
                                    </div>
                                    <div class="bg-light rounded d-flex align-items-center p-5">
                                        <div class="d-flex flex-shrink-0 align-items-center justify-content-center rounded-circle bg-white" style="width: 55px; height: 55px;">
                                            <i class="fa fa-envelope-open text-primary"></i>
                                        </div>
                                        <div class="ms-4">
                                            <p class="mb-2">Mail Us Now</p>
                                            <h5 class="mb-0">info@example.com</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6 wow fadeInUp" data-wow-delay="0.5s">
                                    <div class="bg-light rounded h-100 d-flex align-items-center p-5">
                                        <form>
                                            <div class="row g-3">
                                                <div class="col-12 col-sm-6">
                                                    <input type="text" class="form-control border-0" placeholder="Your Name" style="height: 55px;">
                                                </div>
                                                <div class="col-12 col-sm-6">
                                                    <input type="email" class="form-control border-0" placeholder="Your Email" style="height: 55px;">
                                                </div>
                                                <div class="col-12 col-sm-6">
                                                    <input type="text" class="form-control border-0" placeholder="Your Mobile" style="height: 55px;">
                                                </div>
                                                <div class="col-12 col-sm-6">
                                                    <select class="form-select border-0" style="height: 55px;">
                                                        <option selected>Choose Advisor</option>
                                                        <option value="1">Bill Jobs</option>
                                                        <option value="2">Jun Jobs</option>
                                                        <option value="3">Loh Jobs</option>
                                                    </select>
                                                </div>
                                                <div class="col-12 col-sm-6">
                                                    <div class="date" id="date" data-target-input="nearest">
                                                        <input type="text"
                                                               class="form-control border-0 datetimepicker-input"
                                                               placeholder="Choose Date" data-target="#date" data-toggle="datetimepicker" style="height: 55px;">
                                                    </div>
                                                </div>
                                                <div class="col-12 col-sm-6">
                                                    <div class="time" id="time" data-target-input="nearest">
                                                        <input type="text"
                                                               class="form-control border-0 datetimepicker-input"
                                                               placeholder="Choose Date" data-target="#time" data-toggle="datetimepicker" style="height: 55px;">
                                                    </div>
                                                </div>
                                                <div class="col-12">
                                                    <textarea class="form-control border-0" rows="5" placeholder="Describe your problem"></textarea>
                                                </div>
                                                <div class="col-12">
                                                    <button class="btn btn-primary w-100 py-3" type="submit">Ask the Question</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Appointment End -->



                    <!-- Footer Start -->
                    <div class="container-fluid bg-dark text-light footer mt-5 pt-5 wow fadeIn" data-wow-delay="0.1s">
                        <div class="container py-5">
                            <div class="row g-5">
                                <div class="col-lg-3 col-md-6">
                                    <h5 class="text-light mb-4">Address</h5>
                                    <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                                    <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                                    <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                                    <div class="d-flex pt-2">
                                        <a class="btn btn-outline-light btn-social rounded-circle" href=""><i class="fab fa-twitter"></i></a>
                                        <a class="btn btn-outline-light btn-social rounded-circle" href=""><i class="fab fa-facebook-f"></i></a>
                                        <a class="btn btn-outline-light btn-social rounded-circle" href=""><i class="fab fa-youtube"></i></a>
                                        <a class="btn btn-outline-light btn-social rounded-circle" href=""><i class="fab fa-linkedin-in"></i></a>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <h5 class="text-light mb-4">Services</h5>
                                    <a class="btn btn-link" href="">Introduction</a>
                                    <a class="btn btn-link" href="">How to be Success</a>
                                    <a class="btn btn-link" href="">Apply Product</a>
                                    <a class="btn btn-link" href="">Device Repair</a>
                                    <a class="btn btn-link" href="">Laboratory</a>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <h5 class="text-light mb-4">Quick Links</h5>
                                    <a class="btn btn-link" href="">About Us</a>
                                    <a class="btn btn-link" href="">Contact Us</a>
                                    <a class="btn btn-link" href="">Our Services</a>
                                    <a class="btn btn-link" href="">Terms & Condition</a>
                                    <a class="btn btn-link" href="">Support</a>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <h5 class="text-light mb-4">Newsletter</h5>
                                    <p>Sign up and find out more about our Steve Jobs!</p>
                                    <div class="position-relative mx-auto" style="max-width: 400px;">
                                        <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                                        <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="container">
                            <div class="copyright">
                                <div class="row">
                                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                                        &copy; <a class="border-bottom" href="#">SteveJobs.info</a>, All Right Reserved.
                                    </div>
                                    <div class="col-md-6 text-center text-md-end">
                                        <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                                        Designed By <a class="border-bottom" href="https://htmlcodex.com">Myself</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Footer End -->


                    <!-- Back to Top -->
                    <a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="lib/wow/wow.min.js"></script>
                    <script src="lib/easing/easing.min.js"></script>
                    <script src="lib/waypoints/waypoints.min.js"></script>
                    <script src="lib/counterup/counterup.min.js"></script>
                    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
                    <script src="lib/tempusdominus/js/moment.min.js"></script>
                    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
                    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="js/main.js"></script>

                </template>


            </el-main>

        </el-container>
    </el-container>
</div>



<script>
        new Vue({
        el: '#app',
        data() {
        return {
        blogPosts: [
    { id: 1, title: 'The Quantum Leap of Artificial Intelligence', content: 'Introduction: Explore the cutting-edge intersection of quantum computing and artificial intelligence. This article delves into the potential of quantum computing to revolutionize AI algorithms, unlocking unprecedented computational power and solving complex problems that were once deemed impossible.', showDetails: false },
    { id: 2, title: 'Mindfulness in the Digital Age', content: 'Introduction: In an era dominated by constant digital stimuli, this article explores the importance of mindfulness practices to maintain focus and well-being. Discover strategies for navigating information overload, fostering digital mindfulness, and striking a balance between technology and mental health.', showDetails: false },
    { id: 3, title: 'The Next Frontiers of Space Exploration', content: 'Introduction: Journey beyond the red planet as we unravel the exciting prospects and challenges of future space exploration. From the exploration of distant exoplanets to the establishment of lunar colonies, this article paints a visionary picture of humanity next great leaps into the cosmos.', showDetails: false }
        ],
        isCollapse: true
    };
    },
        methods: {
        initWow() {
        "use strict";
        // Initiate the wowjs
        new WOW().init();
    },
        spinner() {
        "use strict";
        // Spinner
        var spinner = function () {
        setTimeout(function () {
        if ($('#spinner').length > 0) {
        $('#spinner').removeClass('show');
    }
    }, 1);
    };
        spinner();
    },
        handleScroll() {
        "use strict";
        // Sticky Navbar
        $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
        $('.sticky-top').addClass('shadow-sm').css('top', '0px');
    } else {
        $('.sticky-top').removeClass('shadow-sm').css('top', '-100px');
    }
    });
    },
        handleBackToTop() {
        "use strict";
        // Back to top button
        $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
        $('.back-to-top').fadeIn('slow');
    } else {
        $('.back-to-top').fadeOut('slow');
    }
    });
    },
        scrollToTop() {
        "use strict";
        $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });
    },
        handleCounterUp() {
        "use strict";
        // Facts counter
        $('[data-toggle="counter-up"]').counterUp({
        delay: 10,
        time: 2000
    });
    },
        initDateTimePicker() {
        "use strict";
        // Date and time picker
        $('.date').datetimepicker({
        format: 'L'
    });
        $('.time').datetimepicker({
        format: 'LT'
    });
    },
        initHeaderCarousel() {
        "use strict";
        // Header carousel
        $(".header-carousel").owlCarousel({
        autoplay: false,
        animateOut: 'fadeOutLeft',
        items: 1,
        dots: true,
        loop: true,
        nav: true,
        navText: [
        '<i class="bi bi-chevron-left"></i>',
        '<i class="bi bi-chevron-right"></i>'
        ]
    });
    },
        initTestimonialsCarousel() {
        "use strict";
        // Testimonials carousel
        $(".testimonial-carousel").owlCarousel({
        autoplay: false,
        smartSpeed: 1000,
        center: true,
        dots: false,
        loop: true,
        nav: true,
        navText: [
        '<i class="bi bi-arrow-left"></i>',
        '<i class="bi bi-arrow-right"></i>'
        ],
        responsive: {
        0: {
        items: 1
    },
        768: {
        items: 2
    }
    }
    });
    },
        summarizeContent(content) {
        return content.slice(0, 50) + '...'; // Display only the first 50 characters for summary
    },
        toggleDetails(post) {
        post.showDetails = !post.showDetails;
    },
        handleIndexPage1() {
        window.location.href = 'https://www.baidu.com';
    }
    },
        mounted() {
        this.initWow();
        this.spinner();
        this.handleScroll();
        this.handleBackToTop();
        this.scrollToTop();
        this.handleCounterUp();
        this.initDateTimePicker();
        this.initHeaderCarousel();
        this.initTestimonialsCarousel();
    }
    });
</script>




<style>
    /********** Template CSS **********/
    :root {
        --primary: #0463FA;
        --light: #EFF5FF;
        --dark: #1B2C51;
    }

    .fw-medium {
        font-weight: 500 !important;
    }

    .fw-bold {
        font-weight: 700 !important;
    }

    .fw-black {
        font-weight: 900 !important;
    }

    .back-to-top {
        position: fixed;
        display: none;
        right: 45px;
        bottom: 45px;
        z-index: 99;
    }


    /*** Spinner ***/
    #spinner {
        opacity: 0;
        visibility: hidden;
        transition: opacity .5s ease-out, visibility 0s linear .5s;
        z-index: 99999;
    }

    #spinner.show {
        transition: opacity .5s ease-out, visibility 0s linear 0s;
        visibility: visible;
        opacity: 1;
    }


    /*** Button ***/
    .btn {
        font-weight: 500;
        transition: .5s;
    }

    .btn.btn-primary,
    .btn.btn-secondary {
        color: #FFFFFF;
    }

    .btn-square {
        width: 38px;
        height: 38px;
    }

    .btn-sm-square {
        width: 32px;
        height: 32px;
    }

    .btn-lg-square {
        width: 48px;
        height: 48px;
    }

    .btn-square,
    .btn-sm-square,
    .btn-lg-square {
        padding: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: normal;
    }


    /*** Navbar ***/
    .navbar .dropdown-toggle::after {
        border: none;
        content: "\f107";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        vertical-align: middle;
        margin-left: 8px;
    }

    .navbar .navbar-nav .nav-link {
        margin-right: 30px;
        padding: 25px 0;
        color: #FFFFFF;
        font-size: 15px;
        font-weight: 500;
        text-transform: uppercase;
        outline: none;
    }

    .navbar .navbar-nav .nav-link:hover,
    .navbar .navbar-nav .nav-link.active {
        color: var(--primary);
    }

    @media (max-width: 991.98px) {
        .navbar .navbar-nav .nav-link  {
            margin-right: 0;
            padding: 10px 0;
        }

        .navbar .navbar-nav {
            border-top: 1px solid #EEEEEE;
        }
    }

    .navbar .navbar-brand,
    .navbar a.btn {
        height: 75px;
    }

    .navbar .navbar-nav .nav-link {
        color: var(--dark);
        font-weight: 500;
    }

    .navbar.sticky-top {
        top: -100px;
        transition: .5s;
    }

    @media (min-width: 992px) {
        .navbar .nav-item .dropdown-menu {
            display: block;
            border: none;
            margin-top: 0;
            top: 150%;
            opacity: 0;
            visibility: hidden;
            transition: .5s;
        }

        .navbar .nav-item:hover .dropdown-menu {
            top: 100%;
            visibility: visible;
            transition: .5s;
            opacity: 1;
        }
    }


    /*** Header ***/
    .header-carousel .owl-carousel-text {
        position: absolute;
        width: 100%;
        height: 100%;
        padding: 3rem;
        top: 0;
        left: 0;
        display: flex;
        align-items: center;
        justify-content: center;
        text-shadow: 0 0 30px rgba(0, 0, 0, .1);
    }

    .header-carousel .owl-nav {
        position: absolute;
        width: 200px;
        height: 45px;
        bottom: 30px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        justify-content: space-between;
    }

    .header-carousel .owl-nav .owl-prev,
    .header-carousel .owl-nav .owl-next {
        width: 45px;
        height: 45px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #FFFFFF;
        background: transparent;
        border: 1px solid #FFFFFF;
        border-radius: 45px;
        font-size: 22px;
        transition: .5s;
    }

    .header-carousel .owl-nav .owl-prev:hover,
    .header-carousel .owl-nav .owl-next:hover {
        background: var(--primary);
        border-color: var(--primary);
    }

    .header-carousel .owl-dots {
        position: absolute;
        height: 45px;
        bottom: 30px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .header-carousel .owl-dot {
        position: relative;
        display: inline-block;
        margin: 0 5px;
        width: 15px;
        height: 15px;
        background: transparent;
        border: 1px solid #FFFFFF;
        border-radius: 15px;
        transition: .5s;
    }

    .header-carousel .owl-dot::after {
        position: absolute;
        content: "";
        width: 5px;
        height: 5px;
        top: 4px;
        left: 4px;
        background: #FFFFFF;
        border-radius: 5px;
    }

    .header-carousel .owl-dot.active {
        background: var(--primary);
        border-color: var(--primary);
    }

    .page-header {
        background: url(${pageContext.request.contextPath}/images/LuoImg/header-page.jpg) top center no-repeat;
        background-size: cover;
        text-shadow: 0 0 30px rgba(0, 0, 0, .1);
    }

    .breadcrumb-item + .breadcrumb-item::before {
        color: var(--light);
    }


    /*** Service ***/
    .service-item {
        transition: .5s;
    }

    .service-item:hover {
        margin-top: -10px;
        box-shadow: 0 .5rem 1.5rem rgba(0, 0, 0, .08);
    }

    .service-item .btn {
        width: 40px;
        height: 40px;
        display: inline-flex;
        align-items: center;
        background: #FFFFFF;
        border-radius: 40px;
        white-space: nowrap;
        overflow: hidden;
        transition: .5s;
    }

    .service-item:hover .btn {
        width: 140px;
    }


    /*** Feature ***/
    @media (min-width: 992px) {
        .container.feature {
            max-width: 100% !important;
        }

        .feature-text  {
            padding-left: calc(((100% - 960px) / 2) + .75rem);
        }
    }

    @media (min-width: 1200px) {
        .feature-text  {
            padding-left: calc(((100% - 1140px) / 2) + .75rem);
        }
    }

    @media (min-width: 1400px) {
        .feature-text  {
            padding-left: calc(((100% - 1320px) / 2) + .75rem);
        }
    }


    /*** Team ***/
    .team-item img {
        position: relative;
        top: 0;
        transition: .5s;
    }

    .team-item:hover img {
        top: -30px;
    }

    .team-item .team-text {
        position: relative;
        height: 100px;
        transition: .5s;
    }

    .team-item:hover .team-text {
        margin-top: -60px;
        height: 160px;
    }

    .team-item .team-text .team-social {
        opacity: 0;
        transition: .5s;
    }

    .team-item:hover .team-text .team-social {
        opacity: 1;
    }

    .team-item .team-social .btn {
        display: inline-flex;
        color: var(--primary);
        background: #FFFFFF;
        border-radius: 40px;
    }

    .team-item .team-social .btn:hover {
        color: #FFFFFF;
        background: var(--primary);
    }


    /*** Appointment ***/
    .bootstrap-datetimepicker-widget.bottom {
        top: auto !important;
    }

    .bootstrap-datetimepicker-widget .table * {
        border-bottom-width: 0px;
    }

    .bootstrap-datetimepicker-widget .table th {
        font-weight: 500;
    }

    .bootstrap-datetimepicker-widget.dropdown-menu {
        padding: 10px;
        border-radius: 2px;
    }

    .bootstrap-datetimepicker-widget table td.active,
    .bootstrap-datetimepicker-widget table td.active:hover {
        background: var(--primary);
    }

    .bootstrap-datetimepicker-widget table td.today::before {
        border-bottom-color: var(--primary);
    }


    /*** Testimonial ***/
    .testimonial-carousel::before {
        position: absolute;
        content: "";
        top: 0;
        left: 0;
        height: 100%;
        width: 0;
        background: linear-gradient(to right, rgba(255, 255, 255, 1) 0%, rgba(255, 255, 255, 0) 100%);
        z-index: 1;
    }

    .testimonial-carousel::after {
        position: absolute;
        content: "";
        top: 0;
        right: 0;
        height: 100%;
        width: 0;
        background: linear-gradient(to left, rgba(255, 255, 255, 1) 0%, rgba(255, 255, 255, 0) 100%);
        z-index: 1;
    }

    @media (min-width: 768px) {
        .testimonial-carousel::before,
        .testimonial-carousel::after {
            width: 200px;
        }
    }

    @media (min-width: 992px) {
        .testimonial-carousel::before,
        .testimonial-carousel::after {
            width: 300px;
        }
    }

    .testimonial-carousel .owl-item .testimonial-text {
        background: var(--light);
        transform: scale(.8);
        transition: .5s;
    }

    .testimonial-carousel .owl-item.center .testimonial-text {
        background: var(--primary);
        transform: scale(1);
    }

    .testimonial-carousel .owl-item .testimonial-text *,
    .testimonial-carousel .owl-item .testimonial-item img {
        transition: .5s;
    }

    .testimonial-carousel .owl-item.center .testimonial-text * {
        color: var(--light) !important;
    }

    .testimonial-carousel .owl-item.center .testimonial-item img {
        background: var(--primary) !important;
    }

    .testimonial-carousel .owl-nav {
        position: absolute;
        width: 350px;
        top: 15px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        justify-content: space-between;
        opacity: 0;
        transition: .5s;
        z-index: 1;
    }

    .testimonial-carousel:hover .owl-nav {
        width: 300px;
        opacity: 1;
    }

    .testimonial-carousel .owl-nav .owl-prev,
    .testimonial-carousel .owl-nav .owl-next {
        position: relative;
        color: var(--primary);
        font-size: 45px;
        transition: .5s;
    }

    .testimonial-carousel .owl-nav .owl-prev:hover,
    .testimonial-carousel .owl-nav .owl-next:hover {
        color: var(--dark);
    }


    /*** Footer ***/
    .footer .btn.btn-social {
        margin-right: 5px;
        width: 35px;
        height: 35px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--light);
        border: 1px solid #FFFFFF;
        transition: .3s;
    }

    .footer .btn.btn-social:hover {
        color: var(--primary);
    }

    .footer .btn.btn-link {
        display: block;
        margin-bottom: 5px;
        padding: 0;
        text-align: left;
        color: #FFFFFF;
        font-size: 15px;
        font-weight: normal;
        text-transform: capitalize;
        transition: .3s;
    }

    .footer .btn.btn-link::before {
        position: relative;
        content: "\f105";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        margin-right: 10px;
    }

    .footer .btn.btn-link:hover {
        color: var(--primary);
        letter-spacing: 1px;
        box-shadow: none;
    }

    .footer .copyright {
        padding: 25px 0;
        font-size: 15px;
        border-top: 1px solid rgba(256, 256, 256, .1);
    }

    .footer .copyright a {
        color: var(--light);
    }

    .footer .copyright a:hover {
        color: var(--primary);
    }
</style>



</body>

</html>
