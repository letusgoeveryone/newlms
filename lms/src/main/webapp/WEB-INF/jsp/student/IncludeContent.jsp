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
        }
        .tab-content{
            padding: 29px 29px 0;
            word-wrap: break-word;
        }
        
        #fix-thiscou-nav{
            position: absolute;
            right: 2px;
            width: 2em;
            z-index: 20;
            box-shadow: none;
        }
        #fix-thiscou-nav .nav > li > a::after {
            border-right: 2px solid #f50057;
            border-bottom: none  !important;
            height:  100%;
        }
        #fix-thiscou-nav .tab-nav-indicator{
            display: none;
        }
        #fix-thiscou-nav>ul{
            padding: 0;
        }
        #fix-thiscou-nav > ul >li{
            left: 2px;
        }
        #fix-thiscou-nav > ul > .active{
            box-shadow:1px 0 2px rgba(0,0,0,.25);
        }
        
        #fix-thiscou-nav > ul > .active> a{
            background-color: rgb(255, 255, 255) !important;
            box-shadow: none !important;
            width: 2.1em;
            left: -.1em;
            z-index: 30;
        }
        #fix-thiscou-nav > ul > li > a {
            padding: .5em !important;
            background-color: rgba(255,255,255,.5);
            box-shadow: 1px 0 2px rgba(0,0,0,.5);
            margin-bottom: .5em;
        }
        #fix-thiscou-nav > ul > li > a:hover{

            background-color: rgba(255,255,255,.9);
            box-shadow: 1px 0 2.5px rgba(0,0,0,.5);
        }
        
        #tile-course-list{
            margin: 0 auto;
            padding: 0;
        }
        #tile-course-list .nav > li > a::after {
            border: none  !important;
            height:  100%;
        }
        #tile-course-list .tab-nav-indicator{
            display: none;
        }
        #tile-course-list>ul{
        }
        #tile-course-list a{
            padding: 0  1em !important;
            height: 3em;
        }
        #tile-course-list .btn::after {
            background-color: rgba(179, 194, 245, 0.1);
            box-shadow: none;
        }
        #fix-thiscou-nav .nav > li > a:hover::after,
        #tile-course-list .nav > li > a:hover::after {
            opacity: 1;
        }
        .btn::after, .card, .fbtn-text {
            border-radius: 0;
        }
    </style>

    <div class="content-wrapper">
        
        <!--课程 正文 O--> 
        <div id="tree-course-content" class="main-content">
            <div class="card sample-height">
                <div class=" card-main">
                    <nav class="tab-nav tab-nav-brand margin-top-no" id="fix-thiscou-nav">
                        <ul class="nav nav-brand">
                            <li class="active">
                                <a data-toggle="tab" href="#content-CourseOutline"> 课程纲要 </a>
                            </li>

                            <li>
                                <a data-toggle="tab" href="#content-CourseResource"> 课程资源 </a>
                            </li>
                            <li class="">
                                <a data-toggle="tab" href="#content-Homework"> 作业区 </a>
                            </li>
<!--                            <li>
                                <a data-toggle="tab" href="#"> 课程列表 </a>
                                <nav class="tile-sub tab-nav tabs-right tab-nav-brand collapse in" id="tile-course-list">
                                    <ul class="nav nav-brand">
                                        <li><a href="#" data-toggle="tab" class="btn btn-flat ">C语言程序与设计</a></li>
                                        <li><a href="#" data-toggle="tab" class="btn btn-flat ">计算机导论</a></li>
                                        <li><a href="#" data-toggle="tab" class="btn btn-flat ">读写译(一)</a></li>
                                        <li><a href="#" data-toggle="tab" class="btn btn-flat ">视听说(一)</a></li>
                                    </ul>
                                    <div class="fix-tile-close"></div>
                                </nav>
                            </li>-->
                        </ul>
                        
                    </nav>
                    <div class="tab-content">
                        
                        <article id="content-CourseOutline" class=" tab-pane fade in active">
                            <h1>
                                课程简介
                            </h1>
                            <hr>
                            <section>
                                {{{introduction}}}
                            </section>
                            <h1>
                                课程大纲
                            </h1>
                            <hr>
                            <section>
                                {{{syllabus}}}
                            </section>
                        </article>
                        <div id="content-CourseResource" class=" tab-pane fade">
                            
                        </div>
                        <div id="content-Homework" class=" tab-pane fade">
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--课程 正文 O-->

        <!--课程 列表 O--> 
        <nav id="tree-course-list" class="side-content">
            <div class="tile-wrap fix-tile-style card">
                <div class="tile tile-brand tile-collapse active">
                    <div data-target="#tile-course-list" data-toggle="tile">
                        <div class="tile-inner">
                            <div class="text-overflow">课程列表</div>
                        </div>
                    </div>
                    <div class="collapse in" >
                        <nav class="tile-sub tab-nav tabs-right tab-nav-brand collapse in" id="tile-course-list">
                            <ul class="nav nav-brand">{{{courseliset}}}</ul>
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