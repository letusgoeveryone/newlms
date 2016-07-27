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
        <style>
            a {
                color: #8b95cb;
            }
            .header::after {
                box-shadow: 2px 1px 2px rgba(0,0,0,.5);
                content: "";
            }
            .content{
                display: block;
            }
            
            
            /*like github*/
            .vcard-avatar{
                padding: .5em 0;
            }
            .vcard-avatar img{
                border-radius: 3px;
            }
            .vcard-names {
                line-height: 1;
                color: #473E3E;
                font-weight: 500;
                margin-top: 12px !important;
                margin-bottom: 12px !important;
            }
            .vcard-fullname {
                font-size: 25px;
                line-height: 30px;
            }
            .vcard-id {
                font-size: 15px;
                font-style: normal;
                font-weight: 300;
                line-height: 24px;
                color: #666;
            }
            .user-profile-edit{
                color: lightgray;
            }
            .vcard-details {
                list-style: none;
                border-top: 1px solid whitesmoke;
                border-bottom:  1px solid whitesmoke;
                padding: 1em 0;
                margin: 1.2em auto;
            }
            .vcard-detail{
                margin: 0;
                padding: .3em 0;
                color: #473E3E;
                font-size: 14px;
                
            }
            .vcard-detail .icon{
                color: #8b95cb;
                margin-right: .8em;
            }
            .vcard-stats {
                text-align: center;
            }
            .vcard-stat-heading{
                margin-top: 1em;
                font-size: 20px;
                line-height: 30px;
            }
            .vcard-stat {
                float: left;
                width: 29%;
                margin: 2%;
                padding: 10px;
                font-size: 11px;
                text-transform: capitalize;
                position: relative;
                background: whitesmoke;
                height: 60px;
                border-radius: 1px;
            }
            .vcard-stat-count {
                font-size: 28px;
                font-weight: 600;
                line-height: 1;
            }
            .vcard-stat > .text-muted {
                color: #767676 !important;
                float: left;
                position: absolute;
                bottom: .5em;
                width: 100%;
                left: 0;
            }
            .header-logo, .header-text {
                line-height: 56px;
            }
            
            .collapsing {
            }
            .tile-wrap{
                min-height: 48px;
                max-height: 48px;
                overflow: hidden;
                background-color: whitesmoke;
                border: 2px dashed lightgrey;
                box-sizing: content-box;
                transition: all 0.3s;
                margin-top: 14px;
                margin-bottom: 14px;
            }
            .fix-tile-position > .active {
                width: 200px;
                position: fixed;
                left: 285px;
                bottom: -15px;
            }
            .fix-tile-position > .dock {
                left: 0 !important;
                width: 265px !important;
                top: 0px;
                margin: 0 !important;
                z-index: 100;
                bottom: 0 !important;
                background-color: #f5f5f5;
                color: #000;
            }
            .fix-tile-position > .dock > div:first-child{
                flex: none;
                height: 56px;
            }
            .fix-tile-position > .dock .tile-footer{
                position: absolute;
                bottom: 0px;
                right: 0px;
                left: 0px;
                margin: auto;
            }
            .fix-tile-bug{
                position: fixed;
                width: 265px;
                height: 56px;
                background-color: transparent;
                left: 0;
                top: 0;
                z-index: 100;
            }
            
            .fix-modal-align{
                margin-right: -15px;
            }
            .fix-tab-pullright{
                position: absolute !important;
                right: 0;
            }
            .menu-scroll {
                width: 95%;
            }
            .menu-content > .menu-logo:first-child {
                margin-top: -15px;
            }
            .nav-drawer.nav-drawer-md .menu-scroll {
                box-shadow: 0 0 2px rgba(0,0,0,.5);
                -webkit-transform: none;
                transform: none;
                width: 265px;
                background-color: rgb(252, 252, 252);
                background-size: cover;

            }
            .nav-drawer.nav-drawer-md {
                background-color: transparent;
                display: block !important;
                overflow: visible;
                width: 265px;
                z-index: 30;
            }
            .nav-drawer.nav-drawer-md.menu-left ~ .content,
            .nav-drawer.nav-drawer-md.menu-left ~ .footer,
            .nav-drawer.nav-drawer-md.menu-left ~ .header {
                margin-left: 265px;
            }
            .menu-top {
                background-color: #473E3E;
                color: #fff;
                position: relative;
                z-index: 1;
            }
            .menu-backdrop.in {
                opacity: 1;
            }
            .menu-backdrop {
                -webkit-backface-visibility: hidden;
                backface-visibility: hidden;
                background-color: #6D7ADA;
                opacity: 0;
                right: 0;
                bottom: 0;
                -webkit-transition: opacity .3s cubic-bezier(.4,0,.2,1);
                transition: opacity .3s cubic-bezier(.4,0,.2,1);
                z-index: 30;
            }
            .menu-content {
                margin-top: 0.5em;
                padding-bottom: 8px;
            }
            .menu-content .nav a:hover{
                background-color: transparent;
                color: #6C7AC5;
            }
            .menu-content .nav .a:focus, .menu-content .nav .a:hover, .menu-content .nav a:focus, .menu-content .nav a:hover {
                background-color: transparent;
            }
            .menu-collapse-toggle, .menu-collapse-toggle-close {
                background-color: rgba(221, 221, 221, 0.3);
            }
            .fix-menu-nav{
                border-right: 1px solid whitesmoke;
                min-height: 660px;
            }
            .fix-menu-nav>ul{
                background-color: transparent;
            }
            .fix-menu-nav>ul>li{
                padding: 0 0 1em 0;
            }
            .fix-menu-nav>ul>li>a,
            .fix-menu-nav>ul>li>a:hover{
                background-color: whitesmoke !important;
            }
        </style>
    </head>
    <body class="page-brand container-full" id="lms_stu">
        
        <!--aside -->
        <aside id="ubox" class="menu menu-left nav-drawer nav-drawer-md" >
            <div class="menu-scroll">
                <div class="menu-content">
                    <a class="menu-logo" href="#">个人面板</a>
                </div>
                <div class="container vcard">
                    <a href="/account" alt="Change your avatar" class="vcard-avatar">
                        <img alt="" class=" img-rounded" src="<%=path%>/images/avatar.jpg" height="230" width="230">
                    </a>



                    <h1 class="vcard-names">
                        <div class="vcard-fullname" >{{name}}</div>
                        <div class="vcard-id" >ID: {{sn}} ( {{grade}}级 )</div>
                    </h1>

                    <div class="user-profile-edit">
                        <a data-toggle="modal" href="#modal-personalInfo">编辑个人信息 <span class="icon">edit</span></a>
                            
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

                    <!--课程 列表 O--> 
                    <nav id="tree-course-list">
                        <div class="tile-wrap fix-tile-position">
                            <div class="tile tile-collapse tile-brand active">
                                <div data-target="#tile-course-list" data-toggle="tile">
                                    <div class="tile-inner">
                                        <div class="text-overflow">课程列表</div>
                                    </div>
                                </div>
                                <div class="collapse in" >
                                    <nav class="tile-sub collapse in" id="tile-course-list">
                                        <ul class="nav nav-brand">
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                            <li><a href="#" class="btn btn-flat waves-attach waves-effect">C语言</a></li>
                                        </ul>
                                        <div class="fix-tile-bug"></div>
                                    </nav>
                                    <div class="tile-footer">

                                        <div class="tile-footer-btn pull-left">
                                            <a class="btn btn-flat waves-attach waves-effect" onclick="makeCourseTileColse();toggleCourseTileLocked(true);">
                                                <span ><span class="icon">close</span>&nbsp;关闭</span>
                                            </a>
                                        </div>
                                        <div class="tile-footer-btn pull-right">
                                            <a class="btn btn-flat waves-attach waves-effect" onclick="toggleCourseTileLocked()">
                                                <span class="tile-toggle-lock"><span class="icon">lock</span>&nbsp;固定到侧栏</span>
                                                <span class="tile-toggle-unlock" hidden=""><span class="icon">lock</span>&nbsp;解除固定</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </nav>
                    <!--课程 列表 X-->
                    
                    <!--个人状态 O-->
                    <div class="vcard-stats">
                        <!--<h3 class="vcard-stat-heading">个人状态</h3>-->
                        <a class="vcard-stat" href="#">
                            <strong class="vcard-stat-count">63</strong>
                            <span class="text-muted">未完成作业</span>
                        </a>
                        <a class="vcard-stat" href="#">
                            <strong class="vcard-stat-count">2</strong>
                            <span class="text-muted">已选课程</span>
                        </a>
                        <a class="vcard-stat" href="#">
                            <strong class="vcard-stat-count">10</strong>
                            <span class="text-muted">可选课程</span>
                        </a>
                        <a class="vcard-stat" href="#">
                            <strong class="vcard-stat-count">10</strong>
                            <span class="text-muted">已批准课程</span>
                        </a>
                        <a class="vcard-stat" href="#">
                            <strong class="vcard-stat-count">10</strong>
                            <span class="text-muted">未批准课程</span>
                        </a>
                    </div>
                    <!--个人状态 X-->
                    
                </div>
            </div>
        </aside>
                  
        <!--header-->
        <header class="header header-brand header-waterfall ui-header affix-top">
            <ul class="nav nav-list pull-left">
                <li>
                    <a data-toggle="menu" href="#ui_menu">
                        <span class="icon icon-lg">menu</span>
                    </a>
                </li>
            </ul>
            <span class="header-logo" >教务系统 | 学生页面</span>
            <ul class="nav nav-list pull-right">
                <li>
                    <a data-toggle="menu" href="#ui_menu_settings">
                        <span class="icon icon-lg">settings</span>
                    </a>
                </li>
            </ul>
        </header>
                    
        <!--content-->
        <content class="content" id="ucontent" style="min-height:2000px">
            <div class="space-block"></div>
            <div class="container">
                <div class="row">
                    <!--col-lg-6 col-lg-offset-3 col-md-10 col-md-offset-1-->
                    <jsp:include page="../student/IncludeContent.jsp" />
                </div>
            </div>
        </content>
        
        <!--footer-->
        <footer class="ui-footer footer">
            <div class="container">
                <p>河南大学</p>
            </div>
        </footer>

        <!--ScrollUp 触发器-->
        <div class="fbtn-container" id="scrollUp" hidden>
            <div class="fbtn-inner">
                <a class="fbtn fbtn-brand waves-attach waves-circle">
                    <span class="fbtn-text fbtn-text-left">返回顶部</span>
                    <span class="fbtn-ori icon">keyboard_arrow_up</span>
                </a>
            </div>
        </div>
        
        <jsp:include page="../student/IncludeSetting.jsp" />

        <!-- js -->
        <script src="<%=path%>/js/api.json.student.js" type="text/javascript"></script>
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/configure.js" type="text/javascript"></script>
        <!--<script src="http://open.iciba.com/huaci/huaci.js"></script>-->
        
    </body>
</html>