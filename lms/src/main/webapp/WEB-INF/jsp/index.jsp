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
<html lang="zh-CN"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/lms.css" />
    <script src="<%=path%>/js/jquery.min.js"></script>
    <script src="<%=path%>/js/bootstrap.js"></script>
    <script  src="<%=path%>/js/md5.js"></script>
    <script src="<%=path%>/js/ie-emulation-modes-warning.js"></script><style type="text/css"></style>
       <script>
         $(function () {
           ${window.location.href}                  
         });
     </script>
    </head>  
<body>
 <h2>Test Index Page</h2><br>
<sec:authorize ifNotGranted="ROLE_ACDEMIC,ROLE_COUNSELLOR,ROLE_DEAN,ROLE_STUDENT,ROLE_TEACHER,ROLE_TUTOR,ROLE_ADMIN">  
<a href="login" class="button button-3d button-primary button-rounded">登录</a>
</sec:authorize>  
<sec:authorize access="hasRole('ROLE_STUDENT') or hasRole('ROLE_ADMIN')"> <a href="student" class="button button-3d button-primary button-rounded">学生页面</a> </sec:authorize>
<sec:authorize access="hasRole('ROLE_TEACHER') or hasRole('ROLE_ADMIN') or hasRole('ROLE_ACDEMIC')"><a href="teacher" class="button button-3d button-primary button-rounded">教师页面</a></sec:authorize>
<sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_ADMIN')"> <a href="console_dean" class="button button-3d button-primary button-rounded">管理员页面</a> </sec:authorize>
<sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_COUNSELLOR') or hasRole('ROLE_DEAN') or hasRole('ROLE_STUDENT') or hasRole('ROLE_TEACHER') or hasRole('ROLE_TUTOR') or hasRole('ROLE_ADMIN')">  
<a href="logout"class="button button-3d button-primary button-rounded">登出</a>
</sec:authorize>  
</body>
</html>
