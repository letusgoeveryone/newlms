<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<%-- 
    Document   : ServerInformation
    Created on : 2016-3-13, 20:51:56
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ServerInformation</title>

        <!-- css -->
        <link rel="stylesheet"  href="<%=path%>/css/base.min.css"/>
        <link rel="stylesheet"  href="<%=path%>/css/project.min.css"/>
        <link rel="stylesheet"  href="<%=path%>/css/lms.css"/>

        <!--JS-->
        <script src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/base.min.js" ></script>
        <script src="<%=path%>/js/project.min.js" ></script>

    </head>
    <body class="container">
        <h2>服务器状态</h2>
        <form class="form-horizontal" role="form">
            <div class="form-group">
                <label for="inputEmail3" class="col-md-2 control-label">CPU型号</label>
                <div class="col-md-3">
                    <input type="email" class="form-control" id="inputEmail3" placeholder="请输入您的邮箱地址" value="默认型号">
                </div>
                <div class="col-md-7"></div>
            </div>
            <div class="form-group">
                <label for="inputEmail3" class="col-md-2 control-label">内存大小</label>
                <div class="col-md-3">
                    <input type="email" class="form-control" id="inputPassword3" placeholder="请输入您的邮箱密码" value="16GB">
                </div>
                <div class="col-md-7"></div>
            </div>
            <div class="form-group">
                <label for="inputEmail3" class="col-md-2 control-label">磁盘大小</label>
                <div class="col-md-3">
                    <input type="email" class="form-control" id="inputPassword3" placeholder="请输入您的邮箱密码" value="256TB">
                </div>
                <div class="col-md-7"></div>
            </div>
            <div class="form-group">
                <label for="inputEmail3" class="col-md-2 control-label">磁盘占用情况</label>
                <div class="col-md-3">
                    <input type="email" class="form-control" id="inputPassword3" placeholder="请输入您的邮箱密码" value="良好">
                </div>
                <div class="col-md-7"></div>
            </div>
        </form>
    </body>
</html>
