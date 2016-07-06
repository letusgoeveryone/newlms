<%-- 
    Document   : jsp1
    Created on : 2015-10-16, 10:54:59
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>

<html>
	<head>
		<meta charset="utf-8">
		<title>注册</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/lms.css" />
		<script src="<%=path%>/js/jquery.js"></script>
                <script src="<%=path%>/js/bootstrap.js"></script>
		<style media="screen">
			.btn-default{
				color: gray;
			}
			#role{
				margin-top:12%;
			}
                        #f_role{
                            padding-left: 50px;
                        }
			#f_role a{

				border: 3px solid rgba(255, 255, 255, 0.4);
				background-color: rgba(255, 255, 255, 0.9);
				height: 200px;
				width: 200px;
				margin: 20px 25px;
				display: inline-block;
				text-align: center;
				font-size: 20px;
				line-height: 175px;
				text-decoration: none;
				color: rgba(0, 0, 0, 0.6);
			}
			#role-teacher:hover,#role-student:hover{
				border: 3px dashed rgba(255, 255, 255, 0.9);
				background-color: rgba(255, 255, 255, 0.5);
				color: rgba(0,0,0,0.9);

				-webkit-transition: all 0.4s ;
				-moz-transition: all 0.4s ;
				-o-transition: all 0.4s ;
				transition: all 0.4s ;
			}
		</style>
	</head>
	<body  class="hidden-x stage-image" style="background-image:url(<%=path%>/images/bg-for-role.jpg)">
		<div class="container height-control">
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6" id="role">
						<h1>您是: </h1>
                                                <div id="f_role">
                                                    <a href="teacher_register" id="role-teacher" class="card">老师</a>
                                                    <a href="student_register" id="role-student">学生</a>
                                                </div>
				</div>
				<div class="col-md-3"></div>
			</div>
		</div>
	</body>
</html>
