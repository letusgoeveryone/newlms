<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
        <title>403 Error !</title>
        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
    </head>
    <body class="container-full stage-image" style="background-image: url(<%=path%>/images/bg-status-code.svg)">
        <div class="div-center lms-status-page card">
            <div class="lms-status-code">403</div>
            <p>对不起, 您无权访问该页面 !</p>
            <a class="mg-rt-1x" href="<%=path%>/login?op=ChangeUser">切换用户</a>
            <a href="<%=path%>/index">回主页</a>
        </div>
    </body>
</html>