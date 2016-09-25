<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PersonManage</title>
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" >
    </head>
    <body>
        <div class="container">
            <h1>I come from PersonManage.jsp ~~</h1>
        </div>
        

        <script src="<%=path%>/js/jquery.min.js"></script> 
        <script src="<%=path%>/js/base.min.js"></script>
        <script src="<%=path%>/js/project.min.js"></script>
    </body>
</html>