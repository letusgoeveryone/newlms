<%-- 
    Document   : home
    Created on : 2016-5-14, 16:27:55
    Author     : dots
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String sessionid = session.getId();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css" />
        <!-- <link href="http://netdna.bootstrapcdn.com/font-awesome/3.0.2/css/font-awesome.css" rel="stylesheet"> -->
        <style media="screen">
            html, body {
                height: 100%;
                width: 100%;
                overflow:hidden;
                color:#FFF;
                padding:0 15px;
            }

        </style>
    </head>


    <body id="lms-home" class="height-control stage-image" style="background-image:url(<%=path%>/images/bg-gaoshi.jpg)">

        <header>

        </header>
        <div id="lms_guest_cview" class="container height-control">
            <div class="row height-control width-control card">
                
            </div>
        </div>
        <!--  主页 结束--> 
        <!--主页页尾 开始-->
        <footer class="ui-footer" id="tree-footer">
            <div class="container">
                <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
            </div>
        </footer>
        <!--  主页页尾 结束 --> 
        <!-- 背景 顶部 --> 
        <script src="<%=path%>/js/jquery.min.js"></script> 
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
    </body>
        <div class="content">

            <div class="content-header ui-content-header">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-6 col-md-8 ">
                            <h1 class="content-heading">我的主页</h1>
                            <div class="space-block"></div>
                        </div>
                    </div>
                </div>
            </div>

            <header class="header header-transparent header-waterfall ui-header navbar-wrapper" id="tree-header">
                <div class="container">
                    <div class="row" >
                        <!--            <a class="header-logo " href="#"><span class="icon icon-lg">home</span>学生页面</a>
                                <a class="header-logo" href=""><span class="text-white">导航 ①</span></a>
                                  <a class="header-logo" href=""><span class="text-white">导航 ②</span></a>-->

                        <nav class="tab-nav tab-nav-gold pull-right hidden-xx ui-tab" id="zdytab">
                            <ul class="nav nav-list">
                                <li  class="active"><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#ui_tab_example_pInfo"><span class="text-white">个人资料</span></a></li>
                                <li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#ui_tab_example_class"><span class="text-white">已选课程</span></a></li>
                                <li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#ui_tab_example_1"><span class="text-white">未批准课程</span></a></li>
                                <li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#ui_tab_example_2"><span class="text-white">加入新课程</span></a></li>
                                <li><a class="waves-attach waves-light waves-effect"  href="<%=path%>/logout"><span class="text-white">退出系统</span></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </header>

            <div class="container tab-content" >
                <div class="row tab-pane fade active in" id="ui_tab_example_pInfo">       
                    <div class="col-md-12">
                        <iframe src="<%=path%>/student/PersonalInfo" id="pInfoiframepage" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="pInfocontent"></iframe>
                    </div>
                </div>

                <div class="row tab-pane fade" id="ui_tab_example_class">       
                    <!--1/3 功能控制区-->
                    <div class="col-md-3 lms-control-list" style="border-right: whitesmoke solid 1px;">
                        <h4>已选课程</h4>
                        <span id="span1">
                            <ol type="1" class="" >${stucou}</ol> 
                        </span>
                    </div>
                    <!--2/3 功能展示区-->
                    <div class="col-md-9" >
                        <iframe src="" id="couiframepage" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="coucontent" onload=" startInit('couiframepage', 500);"></iframe>
                    </div>
                </div>

                <div class="row tab-pane fade" id="ui_tab_example_1">       
                    <!--1/3 功能控制区-->
                    <div class="col-md-3 lms-control-list" style="border-right: whitesmoke solid 1px;">

                        <h4>未批准课程</h4>
                        <span id="span2">
                            <ol type="1" class="" >${noreadycou}</ol>
                        </span>
                    </div>

                    <!--2/3 功能展示区-->
                    <div class="col-md-9"  style="margin-top: 20px;">
                        <iframe src="" id="noreadycoucontent" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="noreadycoucontent" onload=" startInit('noreadycoucontent', 500);"></iframe>
                    </div>
                </div>

                <div class="row tab-pane fade" id="ui_tab_example_2">       
                    <div class="col-md-12" style="margin-top: 20px;">
                        <iframe src="<%=path%>/student/JoinCourse" id="addcouocontent" frameborder="0" scrolling="no" marginheight="0" height="500px" width="100%" name="addcouocontent" onload=" startInit('addcouocontent', 500);"></iframe>
                    </div>
                </div>


            </div>
        </div>
