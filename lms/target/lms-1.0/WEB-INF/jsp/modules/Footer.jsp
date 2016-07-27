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

    <!--页脚 o-->
    <footer class="ui-footer" id="tree-footer">
        <div class="container">
            <strong>Copyright © 2015 河南大学软件学院  · 【教务系统】</strong>
        </div>
    </footer>
    <!--页脚 x-->
    
</sec:authorize>
