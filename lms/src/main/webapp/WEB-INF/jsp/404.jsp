<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isErrorPage="true" %>
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>404 Error !</title>
        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
    </head>
    <body class="container-full stage-image" style="background-image: url(<%=path%>/images/bg-status-code.svg)">
        <div class="div-center lms-status-page card">
            <div class="lms-status-code">404</div>
            <p>对不起, 资源未找到 !</p>
        </div>
    </body>
</html>