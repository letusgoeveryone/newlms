<%-- 
    Document   : xlk
    Created on : 2016-1-17, 20:12:06
    Author     : Name : liubingxu Email : 2727826327qq.com
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//  将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript" src="<%=path%>/js/jquery-1.7.min.js"></script>
    </head>
    <body>
        <select name="district">
			<option value="">
				请选择
			</option>
			<c:forEach var="d1" items="${jssz }" >
			<option value=${d1.jssz}/>
			</c:forEach>
	</select>
                        <a onclick="reload()">message</a>
        <script type="text/javascript">
            function reload(){   
                alert(1);
                 $.ajax({
                    type: "get", //提交方式
                    url: "hq_xy", //提交的页面，方法名
                    success: function (data) {
                     alert(data);
                    },
                    error: function () {
                        alert("error!！");
                    }
                });  
            }
        </script>
    </body>
</html>
