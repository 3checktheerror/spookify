<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/wow/wow.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js"></script>

    <link href="${pageContext.request.contextPath}/lib/animate/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
          rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>
    <script src="//unpkg.com/element-ui/lib/umd/locale/en.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>


    <title>Contact Me</title>
</head>

<body class="body">

<div id="app">

    <el-container>
        <el-aside width="isCollapse ? '64px' : '150px'">
            <template>
                <div class="fixed-aside">
                    <el-radio-group v-model="isCollapse" :collapse-transition="false"
                                    style="display: flex; flex-direction: column;">
                        <el-radio-button :label="!isCollapse" width="100">
                            <i :class="isCollapse ? 'fa fa-angle-double-right' : 'fa fa-angle-double-left'"
                               style="color: #333"></i>
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
            <el-header>
                <h2>Contact Me</h2>
            </el-header>
            <el-main>
                <el-card style="width: 1325px; margin-left: 125px">
                    <el-row :gutter="20">
                        <el-col :span="15" style="width: 1000px">
                            <el-input
                                    placeholder="Please enter ID or name (support fuzzy search)"
                                    v-model="queryInfo.query"
                                    clearable
                                    @clear="getData"
                            >
                                <el-button
                                        slot="append"
                                        icon="el-icon-search"
                                        @click="filterItems"
                                ></el-button>
                            </el-input>
                        </el-col>
                        <el-col :span="4">
                            <el-button type="primary" @click="addDialogVisible = true"
                            >Add a new form
                            </el-button
                            >
                        </el-col>
                    </el-row>
                    <!--主表单-->
                    <template>
                        <div>
                            <el-table class="table" stripe
                                      :data="responseData.slice((queryInfo.currentPage -1) * queryInfo.pageSize, queryInfo.pageSize * queryInfo.currentPage)"
                                      :default-sort="{prop: 'itModified', order: 'descending'}">
                                <el-table-column prop="iId" label="ID" width="250" sortable></el-table-column>
                                <el-table-column prop="name" label="Name" width="250"
                                                 sortable></el-table-column>
                                <el-table-column prop="itModified" label="Last Modified" width="380" sortable>
                                    <template slot-scope="{ row }">
                                        {{ formatDate(row.itModified) }}
                                    </template>
                                </el-table-column>
                                <el-table-column label="Actions" width="380">
                                    <template slot-scope="{ row }">
                                        <el-button type="text"
                                                   @click="viewDetail(row); detailInfoVisible = true"
                                                   style="font-size: 16px;">View
                                        </el-button>
                                        <el-button type="text" @click="deleteItem(row)"
                                                   style="font-size: 16px;">Delete
                                        </el-button>
                                        <el-button type="text"
                                                   @click="modifyItem(row) ; modifyDialogVisible = true"
                                                   style="font-size: 16px;">Modify
                                        </el-button>
                                    </template>
                                </el-table-column>
                            </el-table>
                        </div>
                    </template>
                    <el-pagination
                            @size-change="handleSizeChange"
                            @current-change="handleCurrentChange"
                            :current-page="queryInfo.currentPage"
                            :page-sizes="[1, 2, 5, 10]"
                            :page-size="queryInfo.pageSize"
                            layout="total, sizes, prev, pager, next, jumper"

                    >
                    </el-pagination>


                </el-card>


                <el-dialog
                        title="Add a new form"
                        :visible.sync="addDialogVisible"
                        width="50%"
                >
                    <el-form :model="addForm" ref="form" :rules="formRules" label-width="100px">

                        <el-form-item label="Name" prop="name">
                            <el-input v-model="addForm.name"></el-input>
                        </el-form-item>
                        <el-form-item label="Gender" prop="gender">
                            <el-select v-model="addForm.gender" placeholder="Select">
                                <el-option label="Male" value="male"></el-option>
                                <el-option label="Female" value="female"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="Age" prop="age">
                            <el-input v-model.number="addForm.age"></el-input>
                        </el-form-item>
                        <el-form-item label="Email" prop="email">
                            <el-input v-model="addForm.email"></el-input>
                        </el-form-item>
                        <el-form-item label="Message" prop="message">
                            <el-input type="textarea" v-model="addForm.message"></el-input>
                        </el-form-item>
                        <el-form-item label="Phone" prop="phone">
                            <el-input v-model="addForm.phone"></el-input>
                        </el-form-item>
                        <el-form-item label="Occupation" prop="occupation">
                            <el-input v-model="addForm.occupation"></el-input>
                        </el-form-item>
                        <el-form-item label="File" prop="file">
                            <el-upload
                                    class="upload-demo"
                                    action="#"
                                    :file-list="fileList"
                                    :show-file-list="true"
                                    :before-upload="beforeUpload"
                                    :on-remove="handleRemove"
                                    :on-preview="handlePreview"
                            >
                                <el-button size="small" type="primary">Click to Upload<i
                                        class="el-icon-upload el-icon--right"></i></el-button>
                                <div slot="tip" class="el-upload__tip">(Only one file can be uploaded)</div>
                            </el-upload>
                        </el-form-item>

                    </el-form>
                    <span slot="footer" class="dialog-footer">
        <el-button @click="closeDialog">Cancle</el-button>
            <el-button type="primary" @click="validateAndSubmit()">Submit</el-button>

        </span>
                </el-dialog>
                <el-dialog
                        title="Create Successful"
                        :visible.sync="successDialogVisible"
                        width="50%"
                >
                    <p v-if="getResponse">Successfully submitted {{ getResponse }} form</p>
                    <div slot="footer" class="dialog-footer">
                        <el-button type="primary" @click="closeSuccessDialog">OK</el-button>
                    </div>
                </el-dialog>


                <el-dialog
                        title="Item Detail"
                        :visible.sync="detailInfoVisible"
                        width="80%"

                >

                    <el-descriptions title="Information">
                        <el-descriptions-item label="Id">{{detailForm.iId}}</el-descriptions-item>
                        <el-descriptions-item label="name">{{detailForm.name}}</el-descriptions-item>
                        <el-descriptions-item label="Last Modified">{{formatDate(detailForm.itModified)}}
                        </el-descriptions-item>
                        <el-descriptions-item label="Gender">{{ detailForm.gender }}</el-descriptions-item>
                        <el-descriptions-item label="Age">{{ parsedData.age }}</el-descriptions-item>
                        <el-descriptions-item label="Email">{{ detailForm.email }}</el-descriptions-item>
                        <el-descriptions-item label="Phone">{{ parsedData.phone }}</el-descriptions-item>
                        <el-descriptions-item label="Occupation">{{ parsedData.occupation }}</el-descriptions-item>
                    </el-descriptions>
                    <el-row>
                        <el-descriptions>
                            <el-descriptions-item label="Message">
                                <el-tag size="small">{{ parsedData.message }}</el-tag>
                            </el-descriptions-item>
                        </el-descriptions>
                    </el-row>

                    <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="detailInfoVisible = false">OK</el-button>
        </span>
                </el-dialog>


                <el-dialog
                        title="Modify form"
                        :visible.sync="modifyDialogVisible"
                        width="50%"

                >

                    <el-form :model="modifyForm" ref="newform" :rules="formRules" label-width="100px">

                        <el-form-item label="Name" prop="name">
                            <el-input v-model="modifyForm.name"></el-input>
                        </el-form-item>
                        <el-form-item label="Gender" prop="gender">
                            <el-select v-model="modifyForm.gender" placeholder="Select">
                                <el-option label="Male" value="male"></el-option>
                                <el-option label="Female" value="female"></el-option>
                            </el-select>
                        </el-form-item>
                        <el-form-item label="Age" prop="age">
                            <el-input v-model.number="modifyForm.age"></el-input>
                        </el-form-item>
                        <el-form-item label="Email" prop="email">
                            <el-input v-model="modifyForm.email"></el-input>
                        </el-form-item>
                        <el-form-item label="Message" prop="message">
                            <el-input type="textarea" v-model="modifyForm.message"></el-input>
                        </el-form-item>
                        <el-form-item label="Phone" prop="phone">
                            <el-input v-model="modifyForm.phone"></el-input>
                        </el-form-item>
                        <el-form-item label="Occupation" prop="occupation">
                            <el-input v-model="modifyForm.occupation"></el-input>
                        </el-form-item>
                        <el-form-item label="File" prop="file">
                            <el-upload
                                    class="upload-demo"
                                    action="#"
                                    :file-list="fileList"
                                    :show-file-list="true"
                                    :before-upload="beforeUpload"
                                    :on-remove="handleRemove"
                                    :on-preview="handlePreview"
                            >
                                <el-button size="small" type="primary">Click to Upload<i
                                        class="el-icon-upload el-icon--right"></i></el-button>
                                <div slot="tip" class="el-upload__tip">(Only one file can be uploaded)</div>
                            </el-upload>
                        </el-form-item>
                    </el-form>

                    <span slot="footer" class="dialog-footer">
        <el-button @click="closeDialog2">Cancle</el-button>
            <el-button type="primary" @click="validateAndUpdate">Update</el-button>

        </span>
                </el-dialog>
                <el-dialog
                        title="Modify Successful"
                        :visible.sync="updatesuccessDialogVisible"
                        width="50%"
                >
                    <p>Form updated successfully </p>
                    <div slot="footer" class="dialog-footer">
                        <el-button type="primary" @click="closeupdateSuccessDialog">OK</el-button>
                    </div>
                </el-dialog>


            </el-main>

        </el-container>

    </el-container>
    <div class="container-fluid bg-dark text-light footer mt-5 pt-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container py-5">
            <div class="row g-5">
                <div class="col-lg-3 col-md-6">
                    <h5 class="text-light mb-4">Address</h5>
                    <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                    <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                    <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                    <div class="d-flex pt-2">
                        <a class="btn btn-outline-light btn-social rounded-circle" href=""><i
                                class="fab fa-twitter"></i></a>
                        <a class="btn btn-outline-light btn-social rounded-circle" href=""><i
                                class="fab fa-facebook-f"></i></a>
                        <a class="btn btn-outline-light btn-social rounded-circle" href=""><i
                                class="fab fa-youtube"></i></a>
                        <a class="btn btn-outline-light btn-social rounded-circle" href=""><i
                                class="fab fa-linkedin-in"></i></a>
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
                        <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">
                            SignUp
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="copyright">
                <div class="row">
                    <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                        Copyright &copy; <a class="border-bottom" href=https://github.com/3checktheerror/spookify>
                        SPOOKIFY</a>. 2023. All Right Reserved.
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                        Designed By <a class="border-bottom" href="https://htmlcodex.com">Myself</a>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>

<style>
    .el-upload-list__item-name [class^=el-icon] {
        height: 5%;
        margin-right: 7px;
        color: #909399;
        line-height: inherit;
    }
</style>

<script>
    ELEMENT.locale(ELEMENT.lang.en)
    new Vue({
        el: '#app',
        data() {
            return {
                responseData: [],
                url: '/images/contactMe.jpg',
                fill: 'fill',
                queryInfo: {
                    query: '',
                    currentPage: 1,
                    pageSize: 5,
                    totalPage: 20
                },
                addForm: {
                    name: '',
                    gender: '',
                    age: '',
                    email: '',
                    message: '',
                    phone: '',
                    occupation: ''

                },
                detailForm: {},
                modifyForm: {
                    iId: '',
                    name: '',
                    gender: '',
                    age: '',
                    email: '',
                    message: '',
                    phone: '',
                    occupation: ''

                },
                filItems: [],
                addDialogVisible: false,
                detailInfoVisible: false,
                modifyDialogVisible: false,
                fileList: [],
                updatesuccessDialogVisible: false,
                successDialogVisible: false,
                beforeUploadCancelled: true,
                getResponse: null,
                ID: null,
                formRules: {
                    name: [
                        {required: true, message: 'Please enter your name', trigger: 'blur'},

                    ],
                    age: [
                        {validator: this.validateAge, trigger: 'blur'},

                    ],
                    email: [
                        {required: true, message: 'Please enter your email', trigger: 'blur'},
                        {pattern: /^[^@\s]+@[^@\s]+\.[a-zA-Z]+$/, message: 'Invalid email format', trigger: 'blur'},

                    ],
                    phone: [
                        {required: true, message: 'Please enter your phone number', trigger: 'blur'},
                        {pattern: /^[()+,\-\d]*\d[()+,\-\d]*$/, message: 'Invalid phone number', trigger: 'blur'},
                    ],
                    message: [
                        {required: true, message: 'Please enter your message', trigger: 'blur'},
                    ],


                },
                isCollapse: true,
            };
        },
        computed: {
            parsedData() {
                return this.detailForm.data ? JSON.parse(this.detailForm.data) : {};
            }
        },
        mounted() {
            this.getData();
            document.body.style.zoom = '80%';
        },
        methods: {
            getData() {

                axios.get('/item/getAllItems')
                    .then(response => {

                        console.log('Response from backend:', response.data);
                        this.responseData = response.data.data;
                    })
                    .catch(error => {

                        console.error(error);
                    });
            },
            filterItems() {
                if (this.queryInfo.query === '') {
                    this.getData();
                }
                console.log(this.queryInfo.query);
                this.responseData = this.responseData.filter((i) => {
                    return (i.iId || '').toString().toLowerCase().includes(this.queryInfo.query.toLowerCase()) ||
                        (i.name || '').toString().toLowerCase().includes(this.queryInfo.query.toLowerCase())
                });
                console.log(this.responseData);
                return this.responseData;
            },
            formatDate(dateString) {

                return moment(dateString).format('YYYY-MM-DD HH:mm:ss');
            },
            viewDetail(row) {
                this.detailForm = this.responseData.find(elem => elem.iId === row.iId);
                console.log(this.detailForm);

            },
            deleteItem(row) {
                axios.get('/item/deleteItem/' + row.iId)
                    .then(() => {
                        this.$message.success('delete success');
                        this.getData();
                    })
                    .catch(error => {
                        console.error(error);
                    });

            },
            modifyItem(row) {
                console.log(row.iId);
                if (row.iId !== undefined) {
                    this.modifyForm.iId = row.iId;
                }
            },


            handleSizeChange(newSize) {
                this.queryInfo.pageSize = newSize
                this.getData()
                console.log(newSize)
            },

            handleCurrentChange(newPage) {
                this.queryInfo.currentPage = newPage
                this.getData()
                console.log(newPage)
            },


            validateAndSubmit() {
                this.$refs.form.validate((valid) => {
                    if (valid) {

                        this.submitForm();
                    } else {

                        console.log('Form validation failed');
                    }
                });
            },
            submitForm() {

                const postData = {
                    name: this.addForm.name,
                    gender: this.addForm.gender,
                    email: this.addForm.email,
                    map: {
                        "phone": this.addForm.phone,
                        "occupation": this.addForm.occupation,
                        "age": this.addForm.age,
                        "message": this.addForm.message,
                    },
                    igroupId: "a",
                    file: this.fileList[0],
                    md5: null,
                    token: null,
                    sessionId: null,
                    vIdFk: "SPVT000001"
                };
                console.log(postData);


                axios.post('/item/insertItem', postData, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                })
                    .then(response => {
                        console.log('Response from backend:', response.data);
                        this.getResponse = response.data.data.num;
                        this.showSuccessDialog();
                        this.addDialogVisible = false;
                        this.$refs.form.resetFields();
                        this.getData();

                    })
                    .catch(error => {
                        console.error(error);
                    });

            },
            validateAndUpdate() {
                this.$refs.newform.validate((valid) => {
                    if (valid) {
                        this.updateForm();
                    } else {
                        console.log('Form validation failed');
                    }
                });
            },
            updateForm() {
                const newData = {
                    iId: this.modifyForm.iId,
                    name: this.modifyForm.name,
                    gender: null,
                    email: this.modifyForm.email,
                    map: {
                        "phone": this.modifyForm.phone,
                        "occupation": null,
                        "age": null,
                        "message": this.modifyForm.message,
                    },
                    igroupId: "ITG1",
                    file: null,
                    md5: null,
                    token: null,
                    sessionId: null,
                };
                if (this.modifyForm.occupation !== "") {
                    newData.map.occupation = this.modifyForm.occupation;
                }
                if (this.modifyForm.age !== "") {
                    newData.map.age = this.modifyForm.occupation;
                }
                if (this.modifyForm.gender !== "") {
                    newData.gender = this.modifyForm.gender;
                }
                if (this.modifyForm.gender !== "") {
                    newData.file = this.fileList[0];
                }

                console.log(newData);

                axios.post('/item/modifyItem', newData, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                })
                    .then(response => {

                        console.log('Response from backend:', response.data);
                        this.showupdateSuccessDialog();
                        this.modifyDialogVisible = false;
                        this.$refs.newform.resetFields();
                        this.getData()
                    })
                    .catch(error => {

                        console.error(error);
                    });

            },
            showSuccessDialog() {
                this.successDialogVisible = true;
            },
            showupdateSuccessDialog() {
                this.updatesuccessDialogVisible = true;
            },
            closeSuccessDialog() {
                this.successDialogVisible = false;
            },
            closeupdateSuccessDialog() {
                this.updatesuccessDialogVisible = false;
            },
            closeDialog() {
                this.addDialogVisible = false;
            },
            closeDialog2() {
                this.modifyDialogVisible = false;
            },
            beforeUpload(file) {

                if (this.fileList.length >= 1) {
                    this.$message.error('Only one file can be uploaded');
                } else {
                    this.fileList.push(file);
                }
                if (this.beforeUploadCancelled) {
                    this.beforeUploadCancelled = false;
                }
                return false;
            },
            handleRemove() {

                if (this.beforeUploadCancelled) {
                    this.fileList = [];
                } else {
                    this.beforeUploadCancelled = true;
                }
            },
            handlePreview() {
                var a = document.createElement('a');
                var event = new MouseEvent('click');
                a.download = this.fileList[0].name;
                const tempData = {
                    name: "temp",
                    gender: "male",
                    email: "temp",
                    message: "temp",
                    map: null,
                    igroupId: "temp",
                    file: this.fileList[0],
                    md5: null,
                    token: null,
                    sessionId: null,
                    vIdFk: "SPVT000001"
                };
                axios.post('/item/insertItem', tempData, {
                    headers: {
                        'Content-Type': 'multipart/form-data'
                    }
                })
                    .then(response => {
                        this.ID = response.data.data.id;
                        a.href = ("http://localhost:8082/item/download/" + this.ID);
                        a.dispatchEvent(event);
                        axios.get('/item/deleteItem/' + this.ID);
                    })
                    .catch(error => {
                        console.error(error);
                    });
            },
            validateAge(rule, value, callback) {
                if (value === '') {
                    callback();
                } else {
                    const isNumber = /^[0-9]*$/.test(value);
                    if (isNumber) {
                        const numericValue = parseInt(value, 0);
                        if (numericValue >= 1 && numericValue <= 150) {
                            callback();
                        } else {
                            callback(new Error('Age must be an integer between 0 and 150'));
                        }
                    } else {
                        callback(new Error('Age must be a number'));
                    }
                }
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

        }
    });
</script>

<style>

    .fixed-aside {
        position: fixed;
        z-index: 1;
        top: 40px;
        left: 0;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    .el-radio-button__inner {
        width: 100%;
    }

    .el-main {
        height: 800px;

        color: #333;
        text-align: left;
        line-height: 50px;
    }

    .el-header, .el-footer {

        color: #333;
        text-align: center;
        display: flex; /* Use flexbox */
        align-items: center; /* Center vertically */
        justify-content: center; /* Center horizontally */
        line-height: 90px;
        font-size: 30px;
        letter-spacing: 0px;
    }

    .el-card-body {
        width: 100%;
    }

    .body {
        background-image: url("/images/contactMe.png");
    }

</style>

</body>
</html>

