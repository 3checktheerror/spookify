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
        <el-aside class="Asidef-direction" width="100px">
            Direction
        </el-aside>
        <el-container >
            <el-header height="100px">
                Steven Paul Jobs
            </el-header>
            <el-container>
                <el-aside width="600px">
                    <h1>Brief Introduction</h1>
                    <img src="Bimages/Jobs.png" alt="Jobs">
                    <h1>Steven Jobs</h1>
                    <h2>Business Investor, Co-founder of Apple</h2>
                    <el-card class="basic-info-card" shadow="always">
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
                    </el-card><br><br>

                    <el-card class="skills-certificate-card" shadow="always">
                        <div slot="header" class="clearfix">
                            <h3>Steve Jobs Quotes</h3>
                        </div>
                        <div class="text">
                            <span class="quote">
                            “Being the richest man in the cemetery doesn't matter to me. … Going to bed at night saying we've done something wonderful – that's what matters to me.”
                            </span>
                            <br><br>
                            <span class="quote">
                            “Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma – which is living with the results of other people's thinking. Don't let the noise of others' opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition.”
                            </span>
                            <br><br>
                            <span class="quote">
                            “Technology is nothing. What's important is that you have a faith in people, that they're basically good and smart, and if you give them tools, they'll do wonderful things with them."
                            </span>

                        </div>
                    </el-card><br><br>

                    <el-card class="self-esteem-card" shadow="always">
                        <div slot="header" class="clearfix">
                            <h3>Comment</h3>
                        </div>
                        <div class="self-text">
                            <p>He is a <span class="emphasized-text">Dreamer and Creator</span> in the pursuit of excellence.
                                He values <span class="emphasized-text">Innovative Spirit</span> in the field of technology, has the courage to disrupt traditions and keep pushing technology forward.
                                As well, he has a unique perspective on art and technology, as well as a high level of commitment to product design and user experience.
                                At the same time, he continues to inspire creativity and drive the <span class="emphasized-text">Collaborative aspect</span> of the team.
                                Generally, he is a <span class="emphasized-text">Practitioner</span> who is constantly challenging himself in the fields of technology, design and business.
                            </p>
                        </div>
                    </el-card><br><br>
                </el-aside>
                <el-container>
                    <el-main>
                        <el-card class="Education-card" shadow="always">
                            <div slot="header" class="clearfix">
                                <h3>Education Experience</h3>
                            </div>
                            <div class="text">
                                High School Education: <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Steve Jobs received his high school education at <span class="emphasized-text">Homestead</span> High School in Cupertino, California.<br>
                                COLLEGE EXPERIENCE: <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;He is enrolled at <span class="emphasized-text">Reed College</span> in 1972, but dropped out after only one semester. While in college <span class="emphasized-text">Berkeley</span>, he took a number of computer science-related classes and befriended <span class="emphasized-text">Steve Wozniak</span>, who would later become a partner.
                                <div class="block">
                                    <el-carousel height="300px">
                                        <el-carousel-item v-for="item in image_ED" :key="item">
                                            <img :src="item" alt="carousel-image" >
                                        </el-carousel-item>
                                    </el-carousel>
                                    <p class="emphasized-text-image" >Young Steve Jobs</p>
                                </div>
                            </div>
                        </el-card><br><br>

                        <el-card class="Experience-card" shadow="always">
                            <div slot="header" class="clearfix">
                                <h3>Entrepreneurial & Investment  Experience</h3>
                            </div>
                            <div class="text">
                                &nbsp;&nbsp;&nbsp;&nbsp;Steve Jobs' entrepreneurial and investment history demonstrates that he has not only achieved great success in hardware and software,
                                but also has had a profound impact on the <span class="emphasized-text">Entertainment and Animation Industries</span>.<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;His innovative spirit and focus on the user experience have laid a solid foundation for his influence in technology and entertainment.
                            </div>

                            <el-button type="text" @click="dialogVisible_EI = true">Click here to Check the Timeline</el-button>
                            <el-dialog
                                    title="Timeline of Entrepreneurial & Investment"
                                    :visible.sync="dialogVisible_EI"
                                    width="80%"
                                    :before-close="handleClose">
                                <div class="timeline">
                                    <el-timeline>
                                        <el-timeline-item timestamp="1976" placement="top" class="Timeline_subtitle">
                                            <el-card>
                                                <h4>Apple Inc.</h4>
                                                <el-row type="flex" class="image_in_box" >
                                                    <el-col :span="16">
                                                        <p>Co-founded Apple Computer Inc. with Steve Wozniak and<br> Ronald Wayne.
                                                            They initially introduced the Apple I and later <br>developed the successful Apple II.
                                                            However, internal conflicts <br>led to Jobs being ousted by the board in 1985.</p>
                                                    </el-col>
                                                    <el-col :span="8">
                                                        <img src="Bimages/1976.png" alt="Apple_and_Jobs">
                                                    </el-col>
                                                </el-row>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="1985" placement="top"class="Timeline_subtitle">
                                            <el-card>
                                                <h4>NeXT Computer Inc</h4>
                                                <el-row type="flex" class="image_in_box" >
                                                    <el-col :span="16">
                                                        <p>After leaving Apple, Jobs founded NeXT Computer Inc.,
                                                            <br>focusing on advanced workstations.
                                                            Although NeXT's computers had a modest market presence,
                                                            the company's operating <br>system became the foundation for Apple's macOS.</p>
                                                    </el-col>
                                                    <el-col :span="8">
                                                        <img src="Bimages/1985.png" alt="Apple_and_Jobs">
                                                    </el-col>
                                                </el-row>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="1986" placement="top"class="Timeline_subtitle">
                                            <el-card>
                                                <h4>Pixar Animation Studios</h4>
                                                <el-col :span="16">
                                                    <p>Jobs acquired The Graphics Group, later known as Pixar <br>Animation Studios.
                                                        Pixar achieved tremendous success in the <br>animated film industry with classics like <br>
                                                        "Toy Story," "The Incredibles," and "Monsters, Inc."</p>
                                                </el-col>
                                                <el-col :span="8">
                                                    <img src="Bimages/1986.png" alt="Apple_and_Jobs">
                                                </el-col>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="1996" placement="top"class="Timeline_subtitle">
                                            <el-card>
                                                <h4>Return to Apple and Innovation</h4>
                                                <el-col :span="16">
                                                    <p>In 1996, Apple acquired NeXT, marking Jobs' return to the <br>company.
                                                        He was reappointed as CEO in 1997. Under his
                                                        <br>leadership, Apple launched groundbreaking products such as
                                                        <br>the iMac, iPod, iPhone, and iPad.</p>
                                                </el-col>
                                                <el-col :span="8">
                                                    <img src="Bimages/1996.png" alt="Apple_and_Jobs">
                                                </el-col>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="2001, 2008" placement="top"class="Timeline_subtitle">
                                            <el-card>
                                                <h4>iTunes and App Store</h4>
                                                <el-col :span="16">
                                                    <p> Jobs led the introduction of iTunes (2001) and the App Store
                                                        <br>(2008), pivotal platforms for digital media and application
                                                        <br>distribution that had a profound impact on Apple's
                                                        <br>performance.</p>
                                                </el-col>
                                                <el-col :span="8">
                                                    <img src="Bimages/AppleStore-and-iTunes.png" alt="Apple_and_Jobs">
                                                </el-col>
                                            </el-card>
                                        </el-timeline-item>
                                        <el-timeline-item timestamp="1986" placement="top"class="Timeline_subtitle">
                                            <el-card>
                                                <h4>Disney and Personal Success</h4>
                                                <el-col :span="16">
                                                    <p>Due to Pixar's success, Jobs became Disney's largest
                                                        <br>shareholder and joined the board in 2006. His influence on
                                                        <br>Disney's animation and entertainment industry was significant.</p>
                                                </el-col>
                                                <el-col :span="8">
                                                    <img src="Bimages/Apple_and_Jobs.png" alt="Apple_and_Jobs">
                                                </el-col>
                                            </el-card>
                                        </el-timeline-item>
                                    </el-timeline>
                                </div>
                                <span slot="footer" class="dialog-footer">
                                <el-button type="primary" @click="dialogVisible_EI = false">Leave</el-button>
                                </span>
                            </el-dialog>
                        </el-card><br><br>

                        <el-card class="Practice-card" shadow="always">
                            <div slot="header" class="clearfix">
                                <h3>Apple and Steve Jobs</h3>
                            </div>
                            <div class="text">
                                &nbsp;&nbsp;&nbsp;&nbsp;The story of Steve Jobs and Apple is a remarkable journey marked by innovation and challenges. Co-founding Apple in 1976, Jobs, along with Steve Wozniak,
                                introduced groundbreaking products like the Apple I and II.<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Despite early success, internal conflicts led to Jobs' ousting in the 1980s.
                                He then founded NeXT and acquired Pixar, contributing to advancements in computing and animation.
                                Jobs returned to Apple in 1996, becoming CEO in 1997, ushering in an era of iconic products such as the iMac, iPod, iPhone, and iPad.
                                <br>&nbsp;&nbsp;&nbsp;&nbsp;Despite health struggles, Jobs continued to lead until his passing in 2011,
                                leaving a lasting legacy as a visionary entrepreneur who transformed the tech industry.<br>
                                <el-button type="text" @click="dialogVisible_Apple_Jobs = true">Click Here to Check the Timeline</el-button>
                                <el-dialog
                                        title="Timeline "
                                        :visible.sync="dialogVisible_Apple_Jobs"
                                        width="60%"
                                        :before-close="handleClose">
                                    <div class="timeline">
                                        <el-timeline>
                                            <el-timeline-item timestamp="1976" placement="top" class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>Co-founding Apple</h4>
                                                    <el-row type="flex" class="image_in_box" >
                                                        <p>Steve Jobs, along with Steve Wozniak and Ronald Wayne, co-founded Apple Computer Inc. in Jobs' parents' garage. They introduced the Apple I and later the Apple II, which played a significant role in the personal computer revolution.</p>
                                                    </el-row>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="1980s" placement="top"class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>NeXT Computer Inc</h4>
                                                    <el-row type="flex" class="image_in_box" >
                                                        <p>Apple experienced substantial success in the early years, but internal conflicts arose. In 1985, Jobs was ousted from the company by the board of directors due to disagreements over the company's direction and leadership style.</p>
                                                    </el-row>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="1985-1986" placement="top"class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>NeXT and Pixar</h4>
                                                    <p>After leaving Apple, Jobs founded NeXT Computer Inc., a company focused on creating advanced workstations. Simultaneously, he purchased The Graphics Group, later renamed Pixar Animation Studios. While NeXT had a limited impact on the computer market, Pixar became a powerhouse in the animation industry.</p>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="1996" placement="top"class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>Return to Apple and Innovation</h4>
                                                    <p>Apple faced financial challenges in the 1990s, and in 1996, the company acquired NeXT. This move brought Jobs back to Apple, and in 1997, he became the CEO again. His return marked a period of significant innovation and revitalization for the company.</p>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="Late 1990s to 2011" placement="top"class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>iMac, iPod, iPhone, and iPad Era</h4>
                                                    <p>  Under Jobs' leadership, Apple introduced iconic products, including the colorful iMac, the revolutionary iPod, the game-changing iPhone, and the iPad. These products not only transformed Apple's fortunes but also had a profound impact on the entire tech industry.</p>
                                                </el-card>
                                            </el-timeline-item>
                                            <el-timeline-item timestamp="1986" placement="top"class="Timeline_subtitle">
                                                <el-card>
                                                    <h4>Struggles and Health Issues</h4>
                                                    <p>Jobs faced health challenges, including a rare type of pancreatic cancer known as a pancreatic neuroendocrine tumor. Despite his health struggles, he continued to lead Apple and participate in product launches.</p>
                                                </el-card>
                                            </el-timeline-item>
                                        </el-timeline>
                                    </div>
                                    <span slot="footer" class="dialog-footer">
                                <el-button type="primary" @click="dialogVisible_Apple_Jobs = false">Leave</el-button>
                                </span>
                                </el-dialog>

                                <div class="block">
                                    <el-carousel height="400px" >
                                        <el-carousel-item v-for="item in image_AP" :key="item">
                                            <img :src="item" alt="carousel-image" class="carousel-image">
                                        </el-carousel-item>
                                    </el-carousel>
                                    <p class="emphasized-text-image" >Jobs and His Masterpieces </p>
                                </div>
                            </div>
                        </el-card><br><br>

                        <el-card class="Award-card" shadow="always">
                            <div slot="header" class="clearfix">
                                <h3>Steve Jobs' Impact</h3>
                            </div>
                            <div class="text">
                                Helped the environment<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Jobs' innovation led to the creation of products that save trees and help the environment. In situations where someone would typically use paper, such as in a presentation or a script reading, technology on devices like the iPad replaced it. The iPhone and iPad – groundbreaking products that ushered in a new generation of smart mobile technologies – ensure "paperless" is more and more the status quo. [Learn how to create a paperless office for your business.]<br><br>

                                Revolutionized technology<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;While the iPhone wasn't the first smartphone, it catapulted the mobile revolution forward and gave more freedom to individuals in their professional and personal lives. With an iPhone, professionals could answer calls, respond to emails, join webinars and more from their cellular device – in addition to having immediate access to music, movies and messages that fulfill their personal likes, needs and passions. [These are the tech trends we're seeing in 2023.]<br><br>

                                Created a faster world<br>
                                &nbsp;&nbsp;&nbsp;&nbsp;Today's world is more instantaneous than ever before, thanks to advancements by Jobs. His innovations ensure productivity thrives, like being able to make an appointment or reservation from your mobile phone and use your iPad as a point-of-sale (POS) system. With Jobs' technology, businesses and customers have much smoother and quicker interactions. [Don't miss our picks for the best POS systems.]<br><br>
                            </div>
                        </el-card>
                    </el-main>
                </el-container>

            </el-container>
            <el-footer height="300px">
                Privacy
            </el-footer>
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
                image_ED:['Bimages/Jobs_Kid.png','Bimages/Jobs_High_School.png','Bimages/Jobs_teenager.png','Bimages/Jobs_Young.png'],
                dialogVisible_EI:false,
                dialogVisible_Apple_Jobs:false,
                image_AP:['Bimages/Apple1.png','Bimages/Apple2.png','Bimages/iMac.png','Bimages/iPhone.png','Bimages/iPad.png']
            }
        },
        methods: {
            handleClose(done) {
                this.$confirm('Confirm to Leave？')
                    .then(_ => {
                        done();
                    })
                    .catch(_ => {});
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
        line-height: 90px;
        font-size: 50px;
        letter-spacing: 0px;
    }
    .Subtitle{
        font-size: 20px;
        text-align: center;
        line-height: 0.8;
    }

    .el-aside {
        background-color: #D3DCE6;
        color: #333;
        text-align: left;
        line-height: 50px;
    }
    .Asidef-direction{
        background: #475669;
    }

    .el-main {
        background-color: #E9EEF3;
        color: #333;
        text-align: left;
        line-height: 50px;
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
    body > .el-container {
        margin-bottom: 50px;
    }
    h1{
        text-align: center;
        font-size:40px;
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
    .el-container:nth-child(5) .el-aside,
    .el-container:nth-child(6) .el-aside {
        line-height: 260px;
    }

    .el-container:nth-child(7) .el-aside {
        line-height: 320px;
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
        font-size: 20px;
        line-height: 2;

    }
    .Timeline_subtitle{
        font-size: 30px;
        line-height: 1.5;
        justify-content: flex-start;
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
        margin-bottom: auto;
        margin-top: auto;
        margin-left: auto;
        font-size: 21px;
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
        margin-right: auto;
    }
    .Experience-card{
        width:900px;
        margin-left: auto;
        margin-right: auto;
    }

    .Practice-card{
        width:900px;
        margin-left: auto;
        margin-right: auto;
    }
    .Skill-card{
        width:900px;
        margin-left: auto;
        margin-right: auto;
    }

    .Award-card{
        width:900px;
        margin-left: auto;
        margin-right: auto;
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
        height: 100%;
        font-size: 15px;
    }
    .carousel-image {
        width: 100%;
        height: 100%;

    }
</style>
</html>