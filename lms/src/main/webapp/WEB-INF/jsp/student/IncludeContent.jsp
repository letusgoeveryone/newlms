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
        
    </style>
    
    <div class="content-wrapper">
        
        <!--课程 正文 O--> 
        <div id="tree-course-content" class="main-content">
            <div class="card sample-height">
                <div class=" card-main">
                    
                    <nav class="tab-nav tab-nav-brand margin-top-no" id="thiscou-nav">
                        <ul class="nav nav-brand">
                            <li class="active">
                                <a data-toggle="tab" href="#content-CourseOutline"> 课程纲要 </a>
                            </li>

                            <li>
                                <a data-toggle="tab" href="#content-CourseResource" ondblclick="updataResourceArea()"> 课程资源 </a>
                            </li>
                            
                            <li>
                                <a data-toggle="tab" href="#content-Homework" > 课程作业 </a>
                            </li>
                        </ul>
                    </nav>
                    
                    <div class="tab-content">
                        
                        <article id="content-CourseOutline" class=" tab-pane fade in active lms-loading">
                            <h1>课程简介</h1><hr>
                            <section>
                                {{{introduction}}}
                            </section>
                            <h1>课程大纲</h1><hr>
                            <section>
                                {{{syllabus}}}
                            </section>
                        </article>
                        
                        <div id="content-CourseResource" class=" tab-pane fade">
                           {{{resource}}}
                        </div>
                        
                        <div id="content-Homework" class=" tab-pane fade">
                            <jsp:include page="../student/IncludeHomework.jsp" />
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
        <!--课程 正文 O-->

        <!--课程 列表 O--> 
        <nav id="tree-course-list" class="side-content">
            <div class="tile-wrap card">
                <div class="tile tile-brand tile-collapse active">

                    <div class="tile-footer">

                        <div class="tile-footer-btn pull-left">
                            <a class="btn btn-flat" data-toggle="tab" href="#lms_main">
                                <span class="icon">arrow_back</span> 
                            </a>
                        </div>
                        <div class="tile-footer-btn pull-right">
                            <a class="btn btn-flat" onclick="toggleCourseTileLocked()">
                                <span class="tile-toggle-lock"><span class="icon">lock</span>&nbsp;固定位置</span>
                                <span class="tile-toggle-unlock" hidden=""><span class="icon">lock_open</span>&nbsp;解除固定</span>
                            </a>
                        </div>
                        
                    </div>
                    
                    <div data-target="#tile-course-list" data-toggle="tile">
                        <div class="tile-inner">
                            <div class="text-overflow">课程列表</div>
                        </div>
                    </div>
                    <div class="collapse in" >
                        <nav class="tile-sub tab-nav tabs-right tab-nav-brand collapse in" id="tile-course-list">
                            <ul class="nav nav-brand  lms-loading">{{{courseliset}}}</ul>
                        </nav>
                    </div>
                </div>
            </div>
        </nav>
        <!--课程 列表 X-->

    </div>
</sec:authorize>