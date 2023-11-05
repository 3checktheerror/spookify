<%--
  Created by IntelliJ IDEA.
  User: 123
  Date: 2023/11/4
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>hello</title>
</head>
<body>
success
<span> ${requestScope.TestVO }</span>
<button onclick="getData()">获取数据</button>
<script>
    function getData() {
        fetch('http://localhost:8082/test/testOk')
            .then(response => response.json())
            .then(data => {
                // 对数据进行处理和展示
                // 例如，假设数据为JSON格式，可以直接操作数据
                console.log(data); // 在控制台打印数据
                // 进行页面操作，将数据展示在页面上
                //document.getElementById('dataElement').innerText = data.property; // 展示数据中的某个属性值
            })
            .catch(error => console.error('发生错误:', error));
    }

</script>
<script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<div id="app">
</div>
<script>
    new Vue({
        el:'#app',
   data:{
       //定义初始值
       userList:[]  //接收接口返回的data数据
   },
    created(){
        //在页面渲染之前执行
        //调用方法
        this.getList()

    },
    methods:{
        //定义方法
        getList(){
            axios.get('http://localhost:8082/test/testOk')  //url是后端提供的接口地址    除了get（）还有post（）
                .then(res=>{
                    this.userList = res.data  //赋值
                })  //请求接口成功会触发
                .catch(
                    error=>{
                        console.log(error)
                    }
                ) //请求接口失败会触发
        }
    }
    })
</script>

</body>
</html>
