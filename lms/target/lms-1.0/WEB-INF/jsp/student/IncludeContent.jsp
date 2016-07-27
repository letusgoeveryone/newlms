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
        #tree-course-list{
            
        }
    </style>
    
    
    <!--课程 正文 O--> 
    <div id="tree-course-content" class="col-md-10">
        
    </div>
    <!--课程 正文 O-->
    
</sec:authorize>