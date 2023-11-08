<%--
  Created by IntelliJ IDEA.
  User: 123
  Date: 2023/11/4
  Time: 21:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
    <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
</head>

<body>

<div id="app"><button @click="sendDataToBackend">Send Data to Backend</button></div>

<%--<script>--%>
<%--    new Vue({--%>
<%--        el: '#app',--%>
<%--        methods: {--%>
<%--            sendDataToBackend() {--%>
<%--                const jsonData = {--%>
<%--                    "name": "Qiu",--%>
<%--                    "number": "1",--%>
<%--                };--%>

<%--                axios.post('/test/e', jsonData, {--%>
<%--                    headers: {--%>
<%--                        'Content-Type': 'application/json'--%>
<%--                    }--%>
<%--                })--%>
<%--                    .then(response => {--%>
<%--                        console.log("Response from the backend:", response.data);--%>
<%--                    })--%>
<%--                    .catch(error => {--%>
<%--                        console.error("Error:", error);--%>
<%--                    });--%>
<%--            }--%>
<%--        }--%>
<%--    });--%>
<%--</script>--%>


<script>
    new Vue({
        el: '#app',
        methods: {
            sendDataToBackend() {
                axios.get('/test/g?', {
                    params: {
                        "name": "Qiu",
                        "number": 1,
                    },
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                    .then(response => {
                        console.log("Response from the backend:", response.data);
                    })
                    .catch(error => {
                        console.error("Error:", error);
                    });
            }
        }
    });
</script>

</body>
</html>
