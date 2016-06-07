<%-- 
    Document   : stu_listwpzcourse
    Created on : 2016-3-19, 23:33:22
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

<script  src="<%=path%>/js/md5.js"></script>
<script src="<%=path%>/js/ie-emulation-modes-warning.js"></script><style type="text/css"></style>
<script src="<%=path%>/js/ie10-viewport-bug-workaround.js"></script>

<table class="table table-responsive">
    <thead>
        <tr><th>课程</th><th>教师</th><th>班级</th><th>操作</th></tr>
    </thead>
    <tbody>

        ${wpzCourse}
    </tbody>
</table>
