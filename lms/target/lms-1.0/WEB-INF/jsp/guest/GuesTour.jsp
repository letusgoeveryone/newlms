<%-- 
    Document   : guestcour
    Created on : 2016-4-8, 20:52:32
    Author     : 刘昱
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title></title>
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
            function giveupnoreadycou(scid) {
                $.post("<%=path%>/student/cancelcourse", {scid: scid},
                        function (data) {
                            if (data == "1") {
                                alert("\n\nok,您的选课信息已被系统取消。\n\n");
                                window.parent.refleshspan();
                            } else {
                                alert("\n\n未知错误\n\n");
                            }
                            ;
                        });
            }
        </script>
        <style type="text/css">
            html,body{background-color:white; padding-right: 15px;}
            .tab-pane{
                padding: 2em;
            }
        </style>
    </head>  
    <body>
        <!--<span id="yz" >${noreadycou}</span>-->
        <div id="lms-course-tab">
            <nav class="tab-nav tab-nav-brand">
                <ul class="nav nav-list ">
                    <li class="active"><a data-toggle="tab"  href="#panel-1">课程介绍</a></li>
                    <li><a data-toggle="tab" href="#panel-2" >课程大纲</a></li>
                    <!--onclick="setheight()"-->
                </ul>
            </nav>
            <div class="tab-content ">
                <div class="tab-pane fade active in" id="panel-1">${syllabusspan2}</div>
                <div class="tab-pane fade" id="panel-2">${CourseDescription2}</div>
            </div>
        </div>
        <script src="<%=path%>/js/jquery.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
    </body>
</html>