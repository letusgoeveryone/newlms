<%-- 
    Document   : getvideo
    Created on : 2016-4-9, 17:32:03
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
<!doctype html>
<html>
<head>
    <title>VideoPlayer</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style type="text/css" media="screen">
        html, body { left:0px;top:0px; width: 99%;height: 99%;margin:0 auto;}
    </style>
<script type="text/javascript">
            $(function(){
//               alert( document.documentElement.scrollWidth+"*"+ document.documentElement.scrollHeight);
//               alert( document.getElementById("vp1").scrollWidth+"*"+ document.getElementById("vp1").scrollHeight);
                document.getElementById("vp1").scrollWidth=document.documentElement.scrollWidth;
                document.getElementById("vp1").scrollHeight=document.documentElement.scrollHeight;
            });
		</script>
</head>
<body>
    <div style="margin:0 auto;left:0px;top:0px;width: 100%;height: 100%">
<video  controls preload="auto" width="100%" height="100%" poster="images/video/poster.jpg" data-setup="{}" autoplay="autoplay" id="vp1" style="margin:0 auto">
<source src="<%=path%>/${uri}" type="video/mp4">
</video>
</div>
<script type="text/javascript">

</script>
</body>
</html>