<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_COUNSELLOR') or hasRole('ROLE_DEAN') or hasRole('ROLE_STUDENT') or hasRole('ROLE_TEACHER') or hasRole('ROLE_TUTOR') or hasRole('ROLE_ADMIN')">

    <!--导航栏 o-->
    <header class="header header-waterfall ui-header" id="tree-header">
        <nav class="tab-nav ui-tab">
            <ul class="header-nav nav nav-list">

                <li class="nav-brand"><a>教务系统</a></li>
                <li  class="active"><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_pInfo"><span class="text-white">我的课程</span></a></li>
                <span class="divider"></span>
                <li  class="">
                    <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_pHomework">
                        <span class="text-white">作业</span>
                    </a>
                </li>
                <!--<li><a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#lms_stu_tnav_tLine"><span class="text-white">时光轴</span></a></li>-->

                <!--个人信息 下拉菜单 o-->
                <li class="dropdown fix-dd-usr" style="position:absolute;right: 0;"><a class="dropdown-toggle" data-toggle="dropdown"><span class="avatar ">{{ portrait }}</span></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a class="waves-attach waves-light waves-effect stage-card" href="#personalInfo">
                                <span class="icon mg-sm-right">account_circle</span> 查看/修改 个人信息
                            </a>
                        </li>
                        <li>
                            <a class="waves-attach waves-light waves-effect" href="<%=path%>/logout">
                                <span class="icon mg-sm-right">exit_to_app</span> 注销
                            </a>
                        </li>
                    </ul>
                </li>
                <!--个人信息 下拉菜单 x-->
            </ul>
        </nav>
    </header>
    <!--导航栏 x-->  
    
</sec:authorize>
