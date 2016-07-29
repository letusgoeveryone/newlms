<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<sec:authorize access="hasRole('ROLE_STUDENT') or hasRole('ROLE_ADMIN')">
    <style>
        .content-wrapper{
            margin: 0 auto;
            background: #fff;
            width: 1100px;
        }
        .main-content{
            width: 790px;
            padding: 29px 29px 0;
            float: left;
            position: relative;
        }
        .side-content {
            position: relative;
            float: left;
            width: 270px;
            padding: 29px 29px 0;
        }
        .tile-position-fixed {
            position: fixed;
            width: 212px;
        }
        .tile-scroll{
            height: 400px;
            overflow-y: scroll;
            margin-right: -15px;
        }
    </style>
    
    <div class="content-wrapper">
    <!--课程 正文 O--> 
    <div id="tree-course-content" class="main-content">
        <div class="card sample-height">
            <div class=" card-main">
            <nav class="tab-nav tab-nav-brand margin-top-no">
                <ul class="nav nav-list nav-justified">
                    <li class="active">
                        <a data-toggle="tab" href="#selector"> 课程大纲 </a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#selector"> 课程介绍 </a>
                    </li>

                    <li>
                        <a data-toggle="tab" href="#selector"> 课程介绍 </a>
                    </li>
                    <li class="">
                        <a data-toggle="tab" href="#selector"> 作业区 </a>
                    </li>
                </ul>
            </nav>
            <div class="tab-content">
                
            </div>
            </div>
        </div>
    </div>
    <!--课程 正文 O-->


    <!--课程 列表 O--> 
    <nav id="tree-course-list" class="side-content">
        <div class="tile-wrap fix-tile-style card">
            <div class="tile tile-collapse active">
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
                        <div class="fix-tile-close"></div>
                    </nav>
                    <div class="tile-footer">

                        <div class="tile-footer-btn pull-left">
                            <a class="btn btn-flat waves-attach waves-effect" onclick="toggleCourseTileScroll()">
                                <span class="tile-toggle-unscroll"><span class="icon">fullscreen</span></span>
                                <span class="tile-toggle-scroll"  hidden=""><span class="icon">fullscreen_exit</span></span>
                            </a>
                        </div>
                        <div class="tile-footer-btn pull-right">
                            <a class="btn btn-flat waves-attach waves-effect" onclick="toggleCourseTileLocked()">
                                <span class="tile-toggle-lock"><span class="icon">lock</span>&nbsp;固定位置</span>
                                <span class="tile-toggle-unlock" hidden=""><span class="icon">lock_open</span>&nbsp;解除固定</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    <!--课程 列表 X-->
    </div>
</sec:authorize>