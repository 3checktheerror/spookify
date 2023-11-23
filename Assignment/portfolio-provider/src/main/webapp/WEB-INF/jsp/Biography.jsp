<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Biography page</title>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="//unpkg.com/element-ui/lib/umd/locale/en.js"></script>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div id="root">
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
            <el-header height="800px">
                <el-row type="flex" justify="center" >
                    <el-col :span="9" :offset="15">
                        <div class="introduction">
                            <span class="Beg-name">Steve Jobs</span><br>
                            <span class="Beg-l">A Legend</span><br>
                            <span class="life">February 24, 1955 – October 5, 2011</span>
                        </div>

                    </el-col>
                </el-row>

            </el-header>
            <el-container>
                <el-aside width="500px">

                    <h1>Profile of Jobs</h1>
                    <div class="card-BI">
                        <div class="card-BI-info">
                            <div class="card-BI-avatar"></div>
                            <div class="card-BI-title">Steve Jobs</div>
                            <div class="card-BI-subtitle">CEO &amp; Co-Founder of Apple</div>
                        </div>
                    </div>
                    <br>
                    <el-card class="basic-info-card" >
                        <div slot="header" class="clearfix">
                            <h3>Basic Information</h3>
                        </div>
                        <div class="text">
                            <i class="el-icon-date"></i> Date of birth: 24 February 1955
                            <br>
                            <i class="el-icon-house"></i> Place of birth: San Francisco, California, USA<br>
                            <i class="el-icon-sunset"></i> Date of death: 5 October 2011<br>
                            <i class="el-icon-school"></i> Education: Reed College, University of California, Berkeley
                        </div>
                    </el-card>
                    <br>
                    <div class="book">
                        <div style="margin-left: 50px; line-height: 1.75">
                            “Being the richest man in the cemetery doesn't matter to me. … Going to bed at night saying we've done something wonderful – that's what matters to me.”<br><br>
                            “Technology is nothing. What's important is that you have a faith in people, that they're basically good and smart, and if you give them tools, they'll do wonderful things with them."

                        </div>
                        <div class="cover">
                            <p>Steve Jobs Quotes</p>
                        </div>
                    </div>
                    <br><br>
                    <div class="card-c">
                        <p class="card-c-title">Comment</p>
                        <p class="small-c-desc">
                            He is a <span class="emphasized-text">Dreamer and Creator</span> in the pursuit of
                            excellence.
                            He values <span class="emphasized-text">Innovative Spirit</span> in the field of
                            technology, has the courage to disrupt traditions and keep pushing technology forward.
                            As well, he has a unique perspective on art and technology, as well as a high level of
                            commitment to product design and user experience.
                            At the same time, he continues to inspire creativity and drive the <span
                                class="emphasized-text">Collaborative aspect</span> of the team.
                            Generally, he is a <span class="emphasized-text">Practitioner</span> who is constantly
                            challenging himself in the fields of technology, design and business.
                        </p>
                        <div class="go-corner-c">
                            <div class="go-arrow-c">→</div>
                        </div>
                    </div>
                    <br><br>
                </el-aside>
                <el-container>
                    <el-main>
                        <el-card class="Education-card" shadow="hover" >
                            <div slot="header" class="clearfix">
                                <h3>Education Experience</h3>
                            </div>
                            <div class="text">
                                High School Education: <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Steve Jobs received his high school education at <span
                                    class="emphasized-text">Homestead</span> High School in Cupertino, California.<br>
                                College Experience: <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;He is enrolled at <span
                                    class="emphasized-text">Reed College</span> in 1972, but dropped out after only one
                                semester. While in college <span class="emphasized-text">Berkeley</span>, he took a
                                number of computer science-related classes and befriended <span class="emphasized-text">Steve Wozniak</span>,
                                who would later become a partner.
                                <div class="block">
                                    <el-carousel height="300px">
                                        <el-carousel-item v-for="item in image_ED" :key="item">
                                            <img :src="item" alt="carousel-image">
                                        </el-carousel-item>
                                    </el-carousel>
                                    <p class="emphasized-text-image">Young Steve Jobs</p>
                                </div>
                            </div>
                        </el-card>
                        <br>

                        <el-card class="Experience-card" shadow="hover">
                            <div slot="header" class="clearfix">
                                <h3>Entrepreneurial & Investment Experience</h3>
                            </div>
                            <div class="text">
                                &nbsp;&nbsp;&nbsp;&nbsp;Steve Jobs' entrepreneurial and investment history demonstrates
                                that he has not only achieved great success in hardware and software,
                                but also has had a profound impact on the <span class="emphasized-text">Entertainment and Animation Industries</span>.<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;His innovative spirit and focus on the user experience have laid
                                a solid foundation for his influence in technology and entertainment.
                            </div>

                            <el-button type="primary" @click="dialogVisible_EI = true" size="medium">Timeline
                            </el-button>
                            <el-dialog
                                    title="Timeline of Entrepreneurial & Investment"
                                    :visible.sync="dialogVisible_EI"
                                    width="80%"
                                    :before-close="handleCloseT">
                                <div class="timeline">
                                    <el-timeline>
                                        <el-timeline-item timestamp="1976" placement="top" class="Timeline_subtitle">
                                            <el-card>
                                                <h4>Apple Inc.</h4>
                                                <el-row type="flex" class="image_in_box">
                                                    <el-col :span="16">
                                                        <div class="content-timeline" >Co-founded Apple Computer Inc. with Steve Wozniak and
                                                            Ronald Wayne.
                                                            They initially introduced the Apple I and later developed
                                                            the successful Apple II.
                                                            However, internal conflicts led to Jobs being ousted by
                                                            the board in 1985.</div>
                                                    </el-col>
                                                    <el-col :span="8">
                                                        <img src="/images/Bimage/1976.png" alt="Apple_and_Jobs">
                                                    </el-col>
                                                </el-row>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="1985" placement="top" class="Timeline_subtitle">
                                            <el-card>
                                                <h4>NeXT Computer Inc</h4>
                                                <el-row type="flex" class="image_in_box">
                                                    <el-col :span="16">
                                                        <div class="content-timeline">After leaving Apple, Jobs founded NeXT Computer Inc.,
                                                            focusing on advanced workstations.
                                                            Although NeXT's computers had a modest market presence,
                                                            the company's operating system became the foundation for
                                                            Apple's macOS.</div>
                                                    </el-col>
                                                    <el-col :span="8">
                                                        <img src="/images/Bimage/1985.png" alt="Apple_and_Jobs">
                                                    </el-col>
                                                </el-row>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="1986" placement="top" class="Timeline_subtitle">
                                            <el-card>
                                                <h4>Pixar Animation Studios</h4>
                                                <el-col :span="16">
                                                    <div class="content-timeline">Jobs acquired The Graphics Group, later known as Pixar Animation
                                                        Studios.
                                                        Pixar achieved tremendous success in the animated film
                                                        industry with classics like
                                                        "Toy Story," "The Incredibles," and "Monsters, Inc."</div>
                                                </el-col>
                                                <el-col :span="8">
                                                    <img src="/images/Bimage/1986.png" alt="Apple_and_Jobs">
                                                </el-col>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="1996" placement="top" class="Timeline_subtitle">
                                            <el-card>
                                                <h4>Return to Apple and Innovation</h4>
                                                <el-col :span="16">
                                                    <div class="content-timeline">In 1996, Apple acquired NeXT, marking Jobs' return to the company.
                                                        He was reappointed as CEO in 1997. Under his
                                                        leadership, Apple launched groundbreaking products such as
                                                        the iMac, iPod, iPhone, and iPad.</div>
                                                </el-col>
                                                <el-col :span="8">
                                                    <img src="/images/Bimage/1996.png" alt="Apple_and_Jobs">
                                                </el-col>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="2001, 2008" placement="top"
                                                          class="Timeline_subtitle">
                                            <el-card>
                                                <h4>iTunes and App Store</h4>
                                                <el-col :span="16">
                                                    <div class="content-timeline"> Jobs led the introduction of iTunes (2001) and the App Store
                                                        <br>(2008), pivotal platforms for digital media and application
                                                        <br>distribution that had a profound impact on Apple's
                                                        <br>performance.</div>
                                                </el-col>
                                                <el-col :span="8">
                                                    <img src="/images/Bimage/Appstore.png" alt="Apple_and_Jobs">
                                                </el-col>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="1986" placement="top" class="Timeline_subtitle">
                                            <el-card>
                                                <h4>Disney and Personal Success</h4>
                                                <el-col :span="16">
                                                    <div class="content-timeline">Due to Pixar's success, Jobs became Disney's largest
                                                        shareholder and joined the board in 2006. His influence on
                                                        Disney's animation and entertainment industry was
                                                        significant.</div>
                                                </el-col>
                                                <el-col :span="8">
                                                    <img src="/images/Bimage/Apple_and_Jobs.png" alt="Apple_and_Jobs">
                                                </el-col>
                                            </el-card>
                                        </el-timeline-item>
                                    </el-timeline>
                                </div>
                                <span slot="footer" class="dialog-footer">
                                <el-button type="primary" @click="dialogVisible_EI = false">Exit</el-button>
                                </span>
                            </el-dialog>
                        </el-card>
                        <br><br>

                        <el-card class="Practice-card" shadow="hover">
                            <div slot="header" class="clearfix">
                                <h3>Apple and Steve Jobs</h3>
                            </div>
                            <div class="text">
                                &nbsp;&nbsp;&nbsp;&nbsp;The story of Steve Jobs and Apple is a remarkable journey marked
                                by innovation and challenges. Co-founding Apple in 1976, Jobs, along with Steve Wozniak,
                                introduced groundbreaking products like the Apple I and II.<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Despite early success, internal conflicts led to Jobs' ousting
                                in the 1980s.
                                He then founded NeXT and acquired Pixar, contributing to advancements in computing and
                                animation.
                                Jobs returned to Apple in 1996, becoming CEO in 1997, ushering in an era of iconic
                                products such as the iMac, iPod, iPhone, and iPad.
                                <br>&nbsp;&nbsp;&nbsp;&nbsp;Despite health struggles, Jobs continued to lead until his
                                passing in 2011,
                                leaving a lasting legacy as a visionary entrepreneur who transformed the tech
                                industry.<br>
                                <el-button type="primary" @click="dialogVisible_Apple_Jobs = true" size="medium">Timeline
                                </el-button>
                                <br><br>
                                <el-dialog
                                        title="Timeline "
                                        :visible.sync="dialogVisible_Apple_Jobs"
                                        width="60%"
                                        :before-close="handleCloseT">
                                    <div class="timeline">
                                        <el-timeline>
                                            <el-timeline-item timestamp="1976" placement="top"
                                                              class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>Co-founding Apple</h4>
                                                    <el-row type="flex" class="image_in_box">
                                                        <div class="content-timeline">Steve Jobs, along with Steve Wozniak and Ronald Wayne,
                                                            co-founded Apple Computer Inc. in Jobs' parents' garage.
                                                            They introduced the Apple I and later the Apple II, which
                                                            played a significant role in the personal computer
                                                            revolution.</div>
                                                    </el-row>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="1980s" placement="top"
                                                              class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>NeXT Computer Inc</h4>
                                                    <el-row type="flex" class="image_in_box">
                                                        <div class="content-timeline">Apple experienced substantial success in the early years, but
                                                            internal conflicts arose. In 1985, Jobs was ousted from the
                                                            company by the board of directors due to disagreements over
                                                            the company's direction and leadership style.</div>
                                                    </el-row>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="1985-1986" placement="top"
                                                              class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>NeXT and Pixar</h4>
                                                    <div class="content-timeline">After leaving Apple, Jobs founded NeXT Computer Inc., a company
                                                        focused on creating advanced workstations. Simultaneously, he
                                                        purchased The Graphics Group, later renamed Pixar Animation
                                                        Studios. While NeXT had a limited impact on the computer market,
                                                        Pixar became a powerhouse in the animation industry.</div>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="1996" placement="top"
                                                              class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>Return to Apple and Innovation</h4>
                                                    <div class="content-timeline">Apple faced financial challenges in the 1990s, and in 1996, the
                                                        company acquired NeXT. This move brought Jobs back to Apple, and
                                                        in 1997, he became the CEO again. His return marked a period of
                                                        significant innovation and revitalization for the company.</div>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="Late 1990s to 2011" placement="top"
                                                              class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>iMac, iPod, iPhone, and iPad Era</h4>
                                                    <div class="content-timeline"> Under Jobs' leadership, Apple introduced iconic products,
                                                        including the colorful iMac, the revolutionary iPod, the
                                                        game-changing iPhone, and the iPad. These products not only
                                                        transformed Apple's fortunes but also had a profound impact on
                                                        the entire tech industry.</div>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="1986" placement="top"
                                                              class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>Struggles and Health Issues</h4>
                                                    <div class="content-timeline">Jobs faced health challenges, including a rare type of pancreatic
                                                        cancer known as a pancreatic neuroendocrine tumor. Despite his
                                                        health struggles, he continued to lead Apple and participate in
                                                        product launches.</div>
                                                </el-card>
                                            </el-timeline-item>
                                        </el-timeline>
                                    </div>
                                    <span slot="footer" class="dialog-footer">
                                <el-button type="primary" @click="dialogVisible_Apple_Jobs = false">Exit</el-button>
                                </span>
                                </el-dialog>

                                <div class="block">
                                    <el-carousel height="400px">
                                        <el-carousel-item v-for="item in image_AP" :key="item">
                                            <img :src="item" alt="carousel-image" class="carousel-image">
                                        </el-carousel-item>
                                    </el-carousel>
                                    <p class="emphasized-text-image">Jobs and His Masterpieces </p>
                                </div>
                            </div>
                        </el-card>
                        <br><br>

                        <el-card class="Award-card" shadow="hover">
                            <div slot="header" class="clearfix">
                                <h3>Steve Jobs' Impact</h3>
                            </div>
                            <div class="text">
                                Helped the environment<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Jobs' innovation led to the creation of products that save trees
                                and help the environment. In situations where someone would typically use paper, such as
                                in a presentation or a script reading, technology on devices like the iPad replaced it.
                                The iPhone and iPad – groundbreaking products that ushered in a new generation of smart
                                mobile technologies – ensure "paperless" is more and more the status quo. [Learn how to
                                create a paperless office for your business.]<br><br>

                                Revolutionized technology<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;While the iPhone wasn't the first smartphone, it catapulted the
                                mobile revolution forward and gave more freedom to individuals in their professional and
                                personal lives. With an iPhone, professionals could answer calls, respond to emails,
                                join webinars and more from their cellular device – in addition to having immediate
                                access to music, movies and messages that fulfill their personal likes, needs and
                                passions. [These are the tech trends we're seeing in 2023.]<br><br>

                                Created a faster world<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Today's world is more instantaneous than ever before, thanks to
                                advancements by Jobs. His innovations ensure productivity thrives, like being able to
                                make an appointment or reservation from your mobile phone and use your iPad as a
                                point-of-sale (POS) system. With Jobs' technology, businesses and customers have much
                                smoother and quicker interactions. [Don't miss our picks for the best POS
                                systems.]<br><br>
                            </div>
                        </el-card>
                    </el-main>
                </el-container>

            </el-container>
            <el-footer>
                Copyright @ SPOOKIFY. 2023. All Rights Reserved.
            </el-footer>
        </el-container>
    </el-container>


</div>
<script>

    const vm = new Vue({
        data() {
            return {
                image_ED: ['/images/Bimage/Jobs_Kid.png', '/images/Bimage/Jobs_High_School.png', '/images/Bimage/Jobs_teenager.png', '/images/Bimage/Jobs_Young.png'],
                dialogVisible_EI: false,
                dialogVisible_Apple_Jobs: false,
                image_AP: ['/images/Bimage/Apple1.png', '/images/Bimage/Apple2.png', '/images/Bimage/iMac.png', '/images/Bimage/iPhone.png', '/images/Bimage/iPad.png'],
                isCollapse: true
            }
        },
        methods: {
            handleCloseT(done) {
                this.$confirm('Confirm to Exit？')
                    .then(_ => {
                        done();
                    })
                    .catch(_ => {
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
            }
        }
    }).$mount('#root')
</script>
</body>
<style>
    .el-header {
        background-image: url("/images/Bimage/img_9.png");
        background-size: cover;
        background-repeat: no-repeat;
        background-position: left;
        background-attachment: fixed;
        align-items: center;
        text-align: center;
        line-height: 1;
    }
    .el-footer{
        background-color: #B3C0D1;
        color: #333;
        line-height: 60px;
        text-align: center;
    }
    .el-aside {
        background-color: #b1becf;
        color: #333;
        text-align: left;
        line-height: 50px;
    }
    .el-main {
        background-color: #D3DCE6;
        color: #333;
        text-align: left;
        line-height: 50px;
    }
    body > .el-container {
        margin-bottom: 50px;
    }
    .introduction{
        position: relative;
        top: 360px;
    }
    .Beg-name{
        margin-bottom: 10px;
        font-size: 40px;
        font-weight: bold;
    }
    .Beg-l{
        margin-bottom: 10px;
        font-size: 20px;
        font-weight: 1;
    }
    .life{
        margin-bottom: 10px;
        font-size: 18px;
        font-weight: normal;
    }


    .emphasized-text{
        font-style: italic;
        font-weight: bold;
        color: #000000;
        font-size:20px ;
    }
    .emphasized-text-image{
        text-align: center;
        font-style: italic;
        font-weight: bold;
        color: #000000;
        font-size:20px ;

    }
    h1{
        text-align: center;
        font-size:32px;
        margin-top: 10px;
        margin-bottom: 20px;
    }
    h2{
        text-align: center;
        padding-top: 3px;
        margin-bottom: 20px;
        font-size: 22px;
        margin-top: 1px;
        margin-bottom: 1px;
    }

    .quote{
        font-style: italic;
        line-height: 1.5;
    }
    img {
        display: block;
        margin: 0 auto;
        max-width: 100%;
        height: auto;
    }
    .text {
        font-size: 17px;
        line-height: 2;
        text-align: left;
    }

    .self-text{
        font-size: 16px;
        line-height: 2;
    }

    h3{
        margin-bottom: auto;
        margin-top: auto;
        margin-left: auto;
    }
    .clearfix{
        margin-top: auto;
        font-size: 15px;
    }

    .basic-info-card {
        width: 325px;
        margin-left: auto;
        margin-right: auto;
        border-radius: 30px;
        background: #f5f5f5;
        padding: 2rem 1.5rem;
        transition: box-shadow .3s ease, transform .2s ease;
    }
    .basic-info-card:hover {
        box-shadow: 0 8px 50px #23232333;
    }
    .skills-certificate-card{
        width: 480px;
        margin-left: auto;
        margin-right: auto;
        border-radius: 30px
    }
    .Commnet-card{
        width: 480px;
        margin-left: auto;
        margin-right: auto;
        border-radius: 30px
    }



    .card-c-title {
        color: #262626;
        font-size: 1.5em;
        line-height: normal;
        font-weight: 700;
        margin-bottom: 0.5em;
    }

    .small-c-desc {
        font-size: 1em;
        font-weight: 400;
        line-height: 1.5em;
        color: #452c2c;
    }

    .small-c-desc {
        font-size: 1em;
    }

    .go-corner-c {
        display: flex;
        align-items: center;
        justify-content: center;
        position: absolute;
        width: 2em;
        height: 2em;
        overflow: hidden;
        top: 0;
        right: 0;
        background: linear-gradient(135deg, #6293c8, #384c6c);
        border-radius: 0 4px 0 32px;
    }

    .go-arrow-c {
        margin-top: -4px;
        margin-right: -4px;
        color: white;
        font-family: courier, sans;
    }

    .card-c {
        margin-right: auto;
        margin-left: auto;
        display: block;
        position: relative;
        width: 325px;
        height: 440px;
        max-width: 1000px;
        max-height: 900px;
        background-color: #f2f8f9;
        border-radius: 10px;
        padding: 2em 1.2em;
        text-decoration: none;
        z-index: 0;
        overflow: hidden;
        background: linear-gradient(to bottom, #c3e6ec, #a7d1d9);
        font-family: Arial, Helvetica, sans-serif;
    }

    .card-c:before {
        content: '';
        position: absolute;
        z-index: -1;
        top: -16px;
        right: -16px;
        background: linear-gradient(135deg, #364a60, #384c6c);
        height: 32px;
        width: 32px;
        border-radius: 32px;
        transform: scale(1);
        transform-origin: 50% 50%;
        transition: transform 0.35s ease-out;
    }

    .card-c:hover:before {
        transform: scale(50);
    }

    .card-c:hover .small-c-desc {
        transition: all 0.5s ease-out;
        color: rgba(255, 255, 255, 0.8);
    }

    .card-c:hover .card-c-title {
        transition: all 0.5s ease-out;
        color: #ffffff;
    }
    .card-c:hover .emphasized-text{
        transition: all 0.5s ease-out;
        color: #ffffff;
    }



    .Education-card{
        width:670px;
        margin-left: auto;
        margin-right: auto;
        border-radius: 30px
    }
    .Experience-card{
        width:670px;
        margin-left: auto;
        margin-right: auto;
        border-radius: 30px
    }

    .Practice-card{
        width:670px;
        margin-left: auto;
        margin-right: auto;
        border-radius: 30px
    }
    .Award-card{
        width:670px;
        margin-left: auto;
        margin-right: auto;
        border-radius: 30px
    }
    .el-carousel__item h3 {
        color: #475669;
        font-size: 14px;
        opacity: 0.75;
        line-height: 150px;
        margin: 0;
    }

    .el-carousel__item:nth-child(2n) {
        background-color: #ffffff;
    }

    .el-carousel__item:nth-child(2n+1) {
        background-color: #ffffff;
    }
    .demonstration{
        margin-right: auto;
        margin-left: auto;
        text-align: center;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100%;
        font-size: 15px;
    }
    .carousel-image {
        width: 100%;
        height: 100%;

    }
    .card-BI {
        width: 280px;
        height: 150px;
        margin-left: auto;
        margin-right: auto;
        margin-top:20px;
        background: #f5f5f5;
        padding: 2rem 1.5rem;
        transition: box-shadow .3s ease, transform .2s ease;
        border-radius: 30px;

    }

    .card-BI-info {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        transition: transform .2s ease, opacity .2s ease;
        width: auto;
        height: auto;
    }

    /*Image*/
    .card-BI-avatar {
        --size: 80px;
        background-image: url("/images/Bimage/Jobs.png");
        background-position: center;
        background-size: 80px;
        background-repeat: no-repeat;
        width: var(--size);
        height: var(--size);
        border-radius: 100%;
        transition: transform .2s ease;
        margin-bottom: 1rem;
    }



    /*Text*/
    .card-BI-title {
        color: #333;
        font-size: 1em;
        font-weight: 600;
        line-height: 2rem;
    }

    .card-BI-subtitle {
        color: #859ba8;
        font-size: 0.8em;
    }

    /*Hover*/
    .card-BI:hover {
        box-shadow: 0 8px 50px #23232333;
    }
    .card-BI-avatar:hover {
        transform: scale(1.1);
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
    .book {
        margin-left: auto;
        margin-right: auto;
        position: relative;
        border-radius: 10px;
        width: 325px;
        height: 443px;
        background-color: whitesmoke;
        -webkit-box-shadow: 1px 1px 12px #000;
        box-shadow: 1px 1px 12px #000;
        -webkit-transform: preserve-3d;
        /*-ms-transform: preserve-3d;*/
        /*transform: preserve-3d;*/
        -webkit-perspective: 2000px;
        perspective: 2000px;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
        color: #000;
    }

    .cover {
        top: 0;
        position: absolute;
        background-color: #e7ecf1;
        width: 100%;
        height: 100%;
        border-radius: 10px;
        cursor: pointer;
        -webkit-transition: all 0.5s;
        transition: all 0.5s;
        -webkit-transform-origin: 0;
        -ms-transform-origin: 0;
        transform-origin: 0;
        -webkit-box-shadow: 1px 1px 12px #000;
        box-shadow: 1px 1px 12px #000;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
    }

    .book:hover .cover {
        -webkit-transition: all 0.5s;
        transition: all 0.5s;
        -webkit-transform: rotatey(-80deg);
        -ms-transform: rotatey(-80deg);
        transform: rotatey(-80deg);
    }

    p {
        font-size: 20px;
        font-weight: bolder;
    }
    .Timeline_subtitle{
        font-size: 30px;
        line-height: 1.5;
        justify-content: flex-start;

    }
    .content-timeline{
        text-align: left;
        font-size: 17px;
        overflow-wrap: break-word
    }
</style>
</html>