<%-- 
    Document   : json_test
    Created on : 2015-11-5, 13:27:28
    Author     : Name : liubingxu Email : 2727826327qq.com
--%>
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSON test</title>
        <script type="text/javascript" src="<%=path%>/css/jquery.min.js"></script>
        <script type="text/javascript">
        function textJson(){
            $.ajax({
                type:'post',
                url:'${pageContext.request.contextPath}/json_test12.action',
                contentType:'application/json;charset= utf-8',
                date,'{"teacherName:"手机","teacherIdcard"999}',
                success:funtion(date){
                    alert(date);
                }
            });
            
        }
            
        </script>
    </head>
    <body>
        <input type="button" onclick="textJson()" value="requestJson" /> 
         
    </body>
</html>
