<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>
<body>
<div id="app"></div>
    <script type = "text/javascript">
        new Vue({
            el: '#app',
            data () {
                return {
                    info: null
                }
            },
            mounted () {
                axios
                    .get('http://localhost:8082/test/testOk')
                    .then(function(res){
                        console.log(res.data)
                    })
                    .catch(function (error) { // 请求失败处理
                        console.log(error);
                    });
            }
        })

</script>



</body>
</html>
