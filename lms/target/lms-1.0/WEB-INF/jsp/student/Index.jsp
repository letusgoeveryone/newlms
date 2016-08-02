<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">

    <head>
        <meta charset="UTF-8">
        <meta content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no, width=device-width" name="viewport">
        <title>教务系统</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" />
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />

        <script src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/vue.js"></script>
        <script src="<%=path%>/js/md5.js" type="text/javascript"></script>
        <script src="<%=path%>/js/bootstrap-treeview.js" type="text/javascript"></script>
        <style>
            
        </style>
    </head>
    <body class="page-brand container-full" id="lms_stu">

        <!--aside -->
        <aside id="ubox" class="menu menu-left nav-drawer nav-drawer-md" >
            <div class="menu-scroll">
                <div class="menu-content">
                    <a class="menu-logo" href="#">{{name}}</a>
                    <div class="vcard">

                        <a href="/account" alt="Change your avatar" class="vcard-avatar">
                            <img alt="" class=" img-rounded" src="<%=path%>/images/avatar.jpg" height="230" width="230">
                        </a>

                        <h1 class="vcard-names">
                            <!--<div class="vcard-fullname" >{{name}}</div>-->
                            <div class="vcard-id" >ID: {{sn}} ( {{grade}}级 )</div>
                        </h1>

                        <div class="user-profile-edit">
                            <a data-toggle="tab" href="#tab-personalInfo" onclick="toggleSettingContent()">编辑个人信息 <span class="icon">edit</span></a>

                        </div>

                        <ul class="vcard-details">
                            <li alt="Home location" class="vcard-detail" title="China">
                                <span class="icon">location_on</span> {{college}}
                            </li>
                            <li alt="Email" class="vcard-detail">
                                <span class="icon">chat</span> 扣扣: {{qq}}
                            </li>
                            <li alt="Member since" class="vcard-detail ">
                                <span class="icon">access_time</span>
                                加入时间: <span title="Jun 9, 2015, 2:36 PM GMT+8" class="join-date">Jun 9, 2015</span>
                            </li>
                        </ul>

                        <!--个人状态 O-->
                        <div class="vcard-stats">
                            <!--<h3 class="vcard-stat-heading">个人状态</h3>-->
                            <a class="vcard-stat" href="#">
                                <strong class="vcard-stat-count">63</strong>
                                <span class="text-muted">未完成作业</span>
                            </a>
                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-selected" onclick="toggleSettingContent()">
                                <strong class="vcard-stat-count">2</strong>
                                <span class="text-muted">已选课程</span>
                            </a>
                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-selectable" onclick="toggleSettingContent()">
                                <strong class="vcard-stat-count">10</strong>
                                <span class="text-muted">可选课程</span>
                            </a>
                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-permit" onclick="toggleSettingContent()">
                                <strong class="vcard-stat-count">10</strong>
                                <span class="text-muted">已批准课程</span>
                            </a>
                            <a class="vcard-stat" data-toggle="tab"  href="#tab-course-notpermit" onclick="toggleSettingContent()">
                                <strong class="vcard-stat-count">10</strong>
                                <span class="text-muted">未批准课程</span>
                            </a>
                        </div>
                        <!--个人状态 X-->

                    </div>
                </div>
            </div>
        </aside>

        <!--header-->
        <header class="header header-brand header-waterfall ui-header">
            <ul class="nav nav-list pull-left">
                <li>
                    <a href="#ubox" id="anchor-ubox" onclick="toggleUbox()">
                        <span class="icon icon-lg">menu</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | 学生页面</span>
            <ul class="nav nav-list pull-right">
                <li>
                    <a data-toggle="menu" href="#menu-settings" id="anchor-menu" onclick="toggleUserSettings()">
                        <span class="icon icon-lg">settings</span>
                    </a>
                </li>
            </ul>
        </header>

        <!--content-->
        <div class="content" id="ucontent" style="min-height:2000px">
            <div class=" space-block"></div>
            <jsp:include page="../student/IncludeContent.jsp" />
        </div>

        <!--footer-->
        <footer class="ui-footer footer">
            <div class="container">
                <p>河南大学</p>
            </div>
        </footer>
    
        <user-settings class="menu menu-left" id="menu-settings">
            <jsp:include page="../student/IncludeSetting.jsp" />
        </user-settings>
    
        <!--scrollUp-->
        <div class="fbtn-container" id="scrollUp" hidden>
            <div class="fbtn-inner">
                <a class="fbtn fbtn-brand waves-attach waves-circle">
                    <span class="fbtn-text fbtn-text-left">返回顶部</span>
                    <span class="fbtn-ori icon">keyboard_arrow_up</span>
                </a>
            </div>
        </div>



        <!-- js -->
        <script src="<%=path%>/js/api.json.student.js" type="text/javascript"></script>
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/tinymce/tinymce.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
        <!--<script src="http://open.iciba.com/huaci/huaci.js"></script>-->
        
    </body>
</html>