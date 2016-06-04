<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%-- 
    Document   : UserSituation
    Created on : 2016-3-13, 20:45:46
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>UserSituation</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/images/tree_icons.png"> 
        
        <!--JS
        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        -->

    </head>
    <body  style="padding: 1px;" >
        
        <table class="table table-bordered table-responsive" data-search ="true"  data-striped = "true" data-pagination ="true" data-toggle="table" >
            <thead>
                <tr>
                    <td>正式教师总人数</td>
                    <td>临时教师总人数</td>
                    <td>正式学生总人数</td>
                    <td>临时学生总人数</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>${t}</td>
                    <td>${tt}</td>
                    <td>${s}</td>
                    <td>${ts}</td>
                </tr>
                
            </tbody>
        </table>


    </body>
</html>
