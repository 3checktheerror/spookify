<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
            <el-header>
                <h2>Contact Me</h2>
            </el-header>
            <el-main>


                <el-card>
                    <!--搜索-->
                    <el-row :gutter="20">
                        <el-col :span="15">
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
                    <el-row type="flex">
                        <el-col style="width: 67%;">
                            <!--主表单-->
                            <template>
                                <div>
                                    <el-table
                                            :data="responseData.slice((queryInfo.currentPage -1) * queryInfo.pageSize, queryInfo.pageSize * queryInfo.currentPage)"
                                            :default-sort="{prop: 'itModified', order: 'descending'}"
                                            style="width: 100%">
                                        <el-table-column prop="iId" label="ID" width="200" sortable></el-table-column>
                                        <el-table-column prop="name" label="Name" width="200"
                                                         sortable></el-table-column>
                                        <el-table-column prop="itModified" label="Last Modified" width="280" sortable>
                                            <template slot-scope="{ row }">
                                                {{ formatDate(row.itModified) }}
                                            </template>
                                        </el-table-column>
                                        <el-table-column label="Actions" width="280">
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
                        </el-col>
                        <el-col style="margin-top: 100px;">

                            <el-image
                                    style="height: 220px;position: relative;"
                                    :src="url"
                                    :fit="fill"
                            ></el-image>
                        </el-col>
                    </el-row>
                    <!--分页区域-->
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

                <!--插入Item-->
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
                    <!--底部区域-->
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


                <!--    Detail-->
                <el-dialog
                        title="Item Detail"
                        :visible.sync="detailInfoVisible"
                        width="80%"

                >
                    <!--主体区域-->
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
                    <!--底部区域-->
                    <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="detailInfoVisible = false">OK</el-button>
        </span>
                </el-dialog>

                <!--    修改表单-->
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
                    <!--底部区域-->
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
            <el-footer>Footer</el-footer>
        </el-container>
    </el-container>


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
        <!--数据-->
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
        },
        methods: {
            getData() {

                axios.get('/item/getAllItems')
                    .then(response => {

                        console.log('Response from backend:', response.data);
                        this.responseData = response.data.data;
                    })
                    .catch(error => {

                        console.error('请求失败:', error);
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
                        // 成功删除后的操作
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
                    email: this.addForm.name,
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
                        // 请求成功的处理逻辑
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
                    gender: this.modifyForm.gender,
                    email: this.modifyForm.name,
                    map: {
                        "phone": this.modifyForm.phone,
                        "occupation": this.modifyForm.occupation,
                        "age": this.modifyForm.age,
                        "message": this.modifyForm.message,
                    },
                    igroupId: "ITG1",
                    file: this.fileList[0],
                    md5: null,
                    token: null,
                    sessionId: null,
                };
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

                        console.error('请求失败:', error);
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
                    this.beforeUploadCancelled = false; // 重置标志
                }
                return false;
            },
            handleRemove() {
                // 如果是因为 before-upload 返回 false 取消上传导致的删除，则不执行删除逻辑
                if (this.beforeUploadCancelled) {
                    this.fileList = [];
                } else {
                    this.beforeUploadCancelled = true; // 重置标志
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
                        console.error('请求失败:', error);
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
                window.location.href = 'http://localhost:8082/getPage/test2';
            }

        }
    });
</script>

</body>
</html>
