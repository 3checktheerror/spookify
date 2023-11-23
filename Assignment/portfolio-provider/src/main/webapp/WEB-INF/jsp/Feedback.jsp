<%--
  Created by IntelliJ IDEA.
  User: 123
  Date: 2023/11/21
  Time: 18:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>





<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portfolio Review Section</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>

    <style>
        .review-card {

            margin-bottom: 10px;
            position: relative;
        }

        .review-header {
            font-size: 20px;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .user-info {
            margin-bottom: 5px;
        }

        .name {
            font-weight: bold;
        }

        .time {
            color: #888;
        }

        .user-feedback {
            margin-top: 10px;
        }

        .feedback-container {
            margin-left: 100px;
            overflow-y: auto;
        }

        .like-icon {
            position: absolute;
            font-size: 25px;
            top: 20px;
            right: 30px;
            cursor: pointer;
            color: #888;
        }

        .like-count {
            position: absolute;
            top: 27px;
            right: 10px;
            color: #888;
        }

        .you-marker {
            color: #409EFF;
            font-weight: bold;
        }

        .el-menu-vertical-demo {
            border: 1px solid #ebeef5;
            border-radius: 4px;
            width: 100%;

        }

        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .el-progress {
            white-space: nowrap;
        }

        .el-progress-bar {
            width: 95%;
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
        .el-header, .el-footer {
            /*background-color: #B3C0D1;*/
            color: #333;
            text-align: center;
            display: flex; /* Use flexbox */
            align-items: center; /* Center vertically */
            justify-content: center; /* Center horizontally */
            line-height: 90px;
            font-size: 30px;
            letter-spacing: 0px;
        }
        .el-main {
            /*background-color: #E9EEF3;*/
            color: #333;
            text-align: left;
            line-height: 50px;
        }
        .body {

            background-image: url("/images/feedback.png");
            background-size: 100%;

        }
        .backbutton {
            position: fixed;
            z-index: 1;
            bottom: 50px;
            right: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }





    </style>
</head>
<body class="body">

<div id="app">
    <el-container class="body">
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

        <el-container >
            <el-header height="100px">
                <h2>Feedback</h2>
            </el-header>
            <el-main :style="{ width: '100%'}">


                <div class="feedback-container" ref="feedbackContainer">

                    <el-row type="flex">
                        <el-col style="margin-left: 0px;width: 1000px">
                            <el-card class="review-card" v-for="(feedback, index) in otherFeedbackList" :key="index">
                                <el-row type="flex">
                                    <el-col span="20px">
                                        <el-avatar class="avatar" :src="feedback.avatar"
                                                   :alt="feedback.userName"></el-avatar>
                                    </el-col>
                                    <el-col style="margin-top: -19px">
                                        <div class="user-info">
                                            <div class="name" style="height: 25px;"
                                                 :class="{ 'you-marker': feedback.isYou }">
                                                {{ feedback.userName }}
                                            </div>
                                            <div class="time">{{ feedback.timestamp }}</div>
                                        </div>
                                    </el-col>
                                </el-row>

                                <div class="rate">
                                    <el-rate v-model="feedback.rating" disabled></el-rate>
                                </div>
                                <div class="feedback-content">{{ feedback.content }}</div>
                                <div class="like-icon" @click="toggleLike(index)" style="margin-top: 19px">
                                    <i :class="feedback.isLiked ? 'fa fa-thumbs-up' : 'fa fa-thumbs-o-up'"
                                       :style="{ color: feedback.isLiked ? 'red' : '' }"></i>
                                </div>
                                <div class="like-count">{{ feedback.likeCount }}</div>

                            </el-card>
                        </el-col>
                        <el-col style="margin-left: 40px; width: 350px">
                            <el-card class="review-card">
                                <div class="review-header">Statistics</div>
                                <div>

                                    <h2 style="font-size: 2em; color: #3498db; font-weight: bold;">
                                        {{ ratingStatistics.averageRating }}
                                    </h2>

                                </div>
                                <div v-for="(percentage, index) in ratingStatistics.percentages" :key="index">
                                    <div>
                                        <el-row type="flex" style="height: 30px">
                                            <el-col style="width: 20%; margin-top: -19px">
                                                {{ index + 1 }}
                                                <i class="fa fa-star" style="color: #FFD700; margin-right: 5px;"></i>
                                                <!-- Font Awesome star icon -->
                                            </el-col>
                                            <el-col>
                                                <el-progress :percentage="parseFloat(percentage)"
                                                             :color="getProgressBarColor(parseFloat(percentage))">
                                                    <span class="progress-label">{{ percentage }}</span>
                                                </el-progress>
                                            </el-col>
                                        </el-row>
                                    </div>
                                </div>

                            </el-card>
                            <div style="margin-top: 10px; text-align: center; display: flex; justify-content: center;">
                                <el-button type="primary" @click="scrollToReviewSection"
                                           style="width: 100%; height: 50px; display: flex; align-items: center; justify-content: center;">
                                    <p style="font-size: medium; color: white; font-weight: bold; margin: 0;">Add Your
                                        Review</p>
                                </el-button>
                            </div>


                        </el-col>
                    </el-row>
                    <el-card class="review-card">
                        <div class="review-header">Add Your Review</div>

                        <div class="user-feedback">
                            <el-form :model="newFeedback" label-width="80px">
                                <el-form-item label="Rating">
                                    <el-rate v-model="newFeedback.rating"></el-rate>
                                </el-form-item>
                                <el-form-item label="Review">
                                    <el-input type="textarea" v-model="newFeedback.content"
                                              placeholder="Write your review..."></el-input>
                                </el-form-item>
                                <el-form-item>
                                    <el-button type="primary" @click="addFeedback">Submit</el-button>
                                </el-form-item>
                            </el-form>
                        </div>
                    </el-card>


                </div>


                <el-button class="backbutton" @click="back" icon="fa fa-angle-up"></el-button>
            </el-main>
            <el-footer>

                Copyright @ SPOOKIFY. 2023. All Rights Reserved.

            </el-footer>
        </el-container>
    </el-container>
</div>

<script>
    new Vue({
        el: '#app',
        data() {
            return {
                otherFeedbackList: [
                    {
                        userName: 'HiringManager',
                        rating: 5,
                        content: 'The projects showcased are outstanding, demonstrating a high level of expertise.',
                        timestamp: '2023-10-15 10:30',
                        isLiked: false,
                        likeCount: 5,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'FellowDeveloper',
                        rating: 4,
                        content: 'Impressive work experience! Particularly enjoyed the detailed project descriptions.',
                        timestamp: '2023-08-23 15:45',
                        isLiked: false,
                        likeCount: 7,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'IndustryExpert',
                        rating: 3,
                        content: 'The education section is well-documented. Could provide more details about technical skills.',
                        timestamp: '2023-04-27 20:12',
                        isLiked: false,
                        likeCount: 3,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'DesignEnthusiast',
                        rating: 4,
                        content: 'Beautifully designed portfolio! It reflects a great sense of aesthetics.',
                        timestamp: '2023-02-03 18:30',
                        isLiked: false,
                        likeCount: 8,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'CodeEnthusiast',
                        rating: 5,
                        content: 'Your coding skills are exceptional! The code samples in your projects showcase a high level of proficiency.',
                        timestamp: '2023-11-10 09:30',
                        isLiked: false,
                        likeCount: 12,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'UXDesigner',
                        rating: 4,
                        content: 'Great attention to user experience! Your design choices demonstrate a thoughtful and user-friendly approach.',
                        timestamp: '2022-10-05 14:15',
                        isLiked: false,
                        likeCount: 9,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'OpenSourceContributor',
                        rating: 5,
                        content: 'Impressive contributions to open-source projects! Your commitment to the community is commendable.',
                        timestamp: '2021-09-18 20:00',
                        isLiked: false,
                        likeCount: 15,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'TechEnthusiast',
                        rating: 4,
                        content: 'Diverse skill set and passion for technology! Your portfolio reflects a keen interest in staying updated with the latest trends.',
                        timestamp: '2023-09-01 12:30',
                        isLiked: false,
                        likeCount: 11,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'TeamPlayer',
                        rating: 5,
                        content: 'Excellent teamwork demonstrated in collaborative projects! Your ability to work effectively with others is commendable.',
                        timestamp: '2022-02-15 17:45',
                        isLiked: false,
                        likeCount: 14,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'InnovationMaestro',
                        rating: 5,
                        content: 'The showcased projects are a testament to your unparalleled innovation and vision. Truly inspiring work!',
                        timestamp: '2022-05-25 14:00',
                        isLiked: false,
                        likeCount: 8,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'TechAficionado',
                        rating: 4,
                        content: 'Your work experience speaks volumes! The detailed project descriptions showcase a deep understanding of technology.',
                        timestamp: '2022-09-20 12:15',
                        isLiked: false,
                        likeCount: 5,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'EducationExplorer',
                        rating: 3,
                        content: 'Thorough documentation in the education section, but there\'s room for more detail on technical skills.',
                        timestamp: '2021-11-18 09:45',
                        isLiked: false,
                        likeCount: 25,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'DesignAesthete',
                        rating: 5,
                        content: 'Impeccably designed portfolio! It reflects a keen sense of aesthetics and design.',
                        timestamp: '2022-11-12 16:30',
                        isLiked: false,
                        likeCount: 17,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'InnovationEnthusiast',
                        rating: 5,
                        content: 'Your interests section showcases a diverse range of skills and an unwavering passion for innovation. Impressive!',
                        timestamp: '2022-12-05 10:00',
                        isLiked: false,
                        likeCount: 21,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'TechEnthusiast123',
                        rating: 5,
                        content: "Apple's products are always cutting-edge and user-friendly. The attention to detail in design is remarkable.",
                        timestamp: '2023-01-30 14:45',
                        isLiked: false,
                        likeCount: 8,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'AppleFanatic789',
                        rating: 4,
                        content: "The innovation showcased in Apple's products is unmatched. Each release sets new standards in the tech industry.",
                        timestamp: '2023-11-22 12:30',
                        isLiked: false,
                        likeCount: 5,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'GadgetGuru456',
                        rating: 5,
                        content: "As a tech enthusiast, I appreciate Apple's commitment to quality. Their products seamlessly integrate into my digital lifestyle.",
                        timestamp: '2022-11-28 09:15',
                        isLiked: false,
                        likeCount: 12,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'DesignAficionado789',
                        rating: 5,
                        content: "Apple's design philosophy is inspiring. The sleek and intuitive designs of their products elevate the user experience.",
                        timestamp: '2023-03-27 17:30',
                        isLiked: false,
                        likeCount: 7,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'AndroidUser456',
                        rating: 2,
                        content: "As an Android user, I find Apple products overpriced. Comparable features can be found in more affordable Android devices.",
                        timestamp: '2022-08-15 10:30',
                        isLiked: false,
                        likeCount: 3,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'BudgetConsciousUser',
                        rating: 3,
                        content: "The cost of Apple products is a major drawback. While the quality is good, more budget-friendly options are available in the market.",
                        timestamp: '2022-06-27 20:12',
                        isLiked: false,
                        likeCount: 2,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },

                    {
                        userName: 'CriticaliPhoneUser',
                        rating: 2,
                        content: "One major drawback of iPhones is the limited customization options. Android devices offer more flexibility in personalization.",
                        timestamp: '2022-04-05 14:00',
                        isLiked: false,
                        likeCount: 4,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },
                    {
                        userName: 'BatteryConcernedUser',
                        rating: 3,
                        content: "Battery life on iPhones could be better. Some Android devices provide longer-lasting battery performance.",
                        timestamp: '2022-02-20 12:15',
                        isLiked: false,
                        likeCount: 6,
                        avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                    },

                ],
                newFeedback: {
                    rating: 0,
                    content: ''
                },
                isCollapse: true,
            };
        },
        mounted() {
            this.sortFeedbackListByTimestamp();
            document.body.style.zoom = '80%';
        },
        computed: {
            ratingStatistics() {
                const totalFeedback = this.otherFeedbackList.length;
                const ratingCounts = [0, 0, 0, 0, 0];

                let totalRating = 0;
                this.otherFeedbackList.forEach((feedback) => {
                    totalRating += feedback.rating;
                    ratingCounts[feedback.rating - 1]++;
                });

                const percentages = ratingCounts.map(count => (count / totalFeedback * 100).toFixed(2) + '%');
                const averageRating = (totalRating / totalFeedback).toFixed(2);

                return {percentages, averageRating};
            },
        },
        methods: {
            addFeedback() {
                const timestamp = new Date().toLocaleString();
                const newFeedback = {
                    userName: 'You',
                    rating: this.newFeedback.rating,
                    content: this.newFeedback.content,
                    timestamp: timestamp,
                    isLiked: false,
                    likeCount: 0,
                    isYou: true,
                    avatar: "https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png"
                };

                this.otherFeedbackList.unshift(newFeedback);

                this.newFeedback = {
                    rating: 0,
                    content: ''
                };

                window.scrollTo({top: 0, behavior: 'smooth'});
            },
            toggleLike(index) {
                // Toggle the like status
                this.otherFeedbackList[index].isLiked = !this.otherFeedbackList[index].isLiked;

                // Update the like count
                if (this.otherFeedbackList[index].isLiked) {
                    this.otherFeedbackList[index].likeCount++;
                } else {
                    this.otherFeedbackList[index].likeCount--;
                }
            },
            sortFeedbackListByTimestamp() {
                this.otherFeedbackList.sort((a, b) => {
                    const timeA = new Date(a.timestamp).getTime();
                    const timeB = new Date(b.timestamp).getTime();
                    return timeB - timeA;
                });
            },

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
            getProgressBarColor(percentage) {
                if (percentage >= 30) {
                    return '#67C23A'; // Green for percentages >= 80
                } else if (percentage >= 20) {
                    return '#E6A23C'; // Yellow for percentages >= 60 and < 80
                } else {
                    return '#F56C6C'; // Red for percentages < 60
                }
            },
            scrollToReviewSection() {
                window.scrollTo({top: document.body.scrollHeight, behavior: 'smooth'});
            },
            back(){
                window.scrollTo({top: 0, behavior: 'smooth'});
            }
        }
    });

</script>

</body>
</html>
















