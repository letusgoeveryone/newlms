
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%-- 
    Document   : newjsp
    Created on : 2015-10-16, 11:12:25
    Author     : Administrator

<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String path = request.getContextPath();
    System.out.println(path);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>登陆</title>
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/stylesheet-base.css" />
		<script src="<%=path%>/js/jquery.js"></script>
		<script src="<%=path%>/js/bootstrap.js"></script>
		<style media="screen">
			#login-show h1, strong{
				text-shadow: black 5px 3px 3px;
			}
			.nav-tabs > li > a {border-top: 1px solid #ddd;}

		</style>
		<script type="text/javascript">
			$(document).ready(function(){

				var treeFrame = $(window).height();
				var treeHeader = $("#login-show").height();
				var treeBlank = $("#login-form").height();
				var treeContent = treeFrame - treeHeader;
				var treePosition = treeFrame - treeBlank;
				//685*535
				$("#login-form").css({
					'marginTop': 0.3*treePosition
				});
				$("#login-show").css({
					'bottom': 0.05*treeContent,
					'left':'2%'
				});


			})
		</script>
	</head>
	<body onload="createCheckCode(5) " class="hidden-x">
		<div class="container-fuild height-control">
			<div class="row-fuild height-control">
				<div  class="col-md-8 hidden-xs hidden-sm height-control stage-img" style="background-image:url(<%=path%>/images/bg-for-login.png);">
                                  
                                    <div class="box-small " id="login-show">
						<footer class="container-fluid box-small" id="tree-footer" >
							<h5>
								<span class="text-muted row-fuild stage-box">
									<strong>Copyright © 2015 ● 河南大学软件学院</strong>
								</span>
							</h5>

							<div class="row-fuild box-small placeholders">
								<div class="col-md-4 placeholder">
									<h4>关于我们</h4>
									<span class="text-muted">我们的主页:</span>
									<span class="text-muted">
									<a href="index-us.html">LongYeh</a>
								</span>
								</div>

								<div class="col-md-4 placeholder">
									<h4>Feedback</h4>
									<span class="text-muted">Email:
									<a href="mailto:llgtgx1@hotmail.com">llgtgx1@hotmail.com</a>
								</span>
									<br>
									<span class="text-muted">帮助:
									<a href="index-help.html">帮助文档</a>
								</span>
								</div>

								<div class="col-md-4 placeholder">
									<h4>地址</h4>
									<span class="text-muted">开封市 金明区金明大道</span>
									<br />
								</div>
							</div>
							<br />
						</footer>

					</div>
				</div>
				<div  class="col-md-4 height-control" id="form-frame" >
						<div class="row ">
							<div id="login-form" class="height-control">
								<div class="tabbable tabs-right"><!-- Only required for left/right tabs -->
								<ul id="myTab" class="nav nav-tabs ">
									<li class="active">
										<a href="#login" >登录 </a>
									</li>
									<li>
										<a href="reg/student_teacher" >注册</a>
									</li>
								</ul>
								<div >
									<div id="login">
										<form class="form-horizontal" role="form" action="index.html" method="post">

											<div class="input-group">
										         <span class="input-group-addon">名字:</span></span>
										         <input type="text" class="form-control" id="firstname" placeholder="请输入名字">
									        </div><br>
											<div class="input-group">
										         <span class="input-group-addon">密码:</span></span>
										         <input type="password" class="form-control" id="password" placeholder="请输入密码">
									        </div><br>
											<div class="input-group">
										         <span class="input-group-addon"></span></span>
										        <input type="text" class="form-control" id="checkcodeText" placeholder="请输入右侧的验证码" onblur="verifyText('checkcodeText','checkcodeMsg');" onfocus="initMessage('checkcodeMsg');">
												 <span class="input-group-addon"><input type="button" id="checkcode" onclick="createCheckCode(5);" readonly="readonly"></span>
									        </div>
											<span id="checkcodeMsg" class="fontTips"></span>
											<div class="form-group">
												<div class="col-md-12">
													<div class="checkbox">
														<label>
															<input type="checkbox" />请记住我
														</label>
														<label class="pull-right">
															<a class="btn-forget" href="#">忘记密码?</a>
														</label>
													</div>
												</div>
											</div>
											<div class="form-group">
												<div class=" col-md-12">
													<div type="submit" class="btn-card btn-success btn-block">登录 </div>
												</div>

											</div>
										</form>
									</div>
								</div>
								</div>
							</div>
						</div>
						<script>
							 /**构造&&实例化*********************************************************************************************************/
							/*验证和提示*/
							function verifyObject(targetParm) { //targetParm为待验证的消息
								this.target = targetParm;
							}
							verifyObject.prototype.trim = function() {
								var pattern = /(^\s*)|(\s*$)/g;
								this.target = this.target.replace(pattern, "");
							}
							verifyObject.prototype.isEqual = function(anyParm) {
								if (this.target == anyParm) {
									return true;
								} else {
									return false;
								}
							}
							verifyObject.prototype.isPattern = function(patternParm) {
								var pattern = new RegExp(patternParm);
								var flag = pattern.test(this.target);
								if (flag) {
									return true;
								} else {
									return false;
								}
							}

							function verifyText(checkText, checkMessage) {
								var text = document.getElementById(checkText).value;
								var verifyObj = new verifyObject(text); //实例化对象
								verifyObj.trim();
								if (checkText == "name") {
									if (!(verifyObj.isPattern(/^[a-z A-Z 0-9 \u4e00-\u9fa5]{2,16}$/))) {
										document.getElementById(checkMessage).innerHTML = "用户名必须为2-16位";
									} else {
										document.getElementById(checkMessage).innerHTML = "";
									}
								} else if (checkText == "passwFrist") {
									if (!(verifyObj.isPattern(/^[a-z A-Z 0-9 _]{6,18}$/))) {
										document.getElementById(checkMessage).innerHTML = "密码必须为6-18位";
									} else {
										document.getElementById(checkMessage).innerHTML = "";
									}
								} else if (checkText == "passwLast") {
									if (!(verifyObj.isEqual(document.getElementById("passwFrist").value))) {
										document.getElementById(checkMessage).innerHTML = "密码前后不一致";
									} else {
										document.getElementById(checkMessage).innerHTML = "";
									}
								} else if (checkText == "email") {
									if (!(verifyObj.isPattern(/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$/))) {
										document.getElementById(checkMessage).innerHTML = "邮箱格式不对";
									} else {
										document.getElementById(checkMessage).innerHTML = "";
									}
								} else if (checkText == "checkcodeText") {
									if (!(verifyObj.isEqual(document.getElementById("checkcode").value))) {
										document.getElementById(checkMessage).innerHTML = "验证码输入错误";
									} else {
										document.getElementById(checkMessage).innerHTML = "";
									}
								}
							}

							function initMessage(objId) {
									var obj = document.getElementById(objId); //实例化对象obj
									if (objId == "nameMsg") {
										obj.innerHTML = "用户名必须为2-16位的字母,数字或汉字构成";
									} else if (objId == "passwFristMsg") {
										obj.innerHTML = "密码必须为6-18位的字母,数字或下划线构成";
									} else if (objId == "passwLastMsg") {
										obj.innerHTML = "请再次输入密码";
									} else if (objId == "emailMsg") {
										obj.innerHTML = "请输入您常用的邮箱";
									} else if (objId == "checkcodeMsg") {
										obj.innerHTML = "请输入右侧的验证码";
									}
								}
								/*验证码*/

							function codeObject(lengthParam) {
								this.code = "";
								this.length = lengthParam;
							}
							codeObject.prototype.creatCode = function(objParam) {
								this.code = "";
								var selectChar = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p', 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'z', 'x', 'c', 'v', 'b', 'n', 'm');
								for (var i = 0; i < this.length; i++) {
									var charIndex = Math.floor(Math.random() * 36);
									this.code += selectChar[charIndex];
								}
								if (objParam != null) {
									objParam.value = this.code;
								}
								return this.code;
							}

							function createCheckCode(length) {
								var objCode = new codeObject(length); //实例化对象objCode
								var objPattern = document.getElementById("checkcode");
								objCode.creatCode(objPattern);
							}
						</script>
				</div>
			</div>
		</div>
	</body>
</html>
