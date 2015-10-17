<%-- 
    Document   : index-acount-3
    Created on : 2015-10-16, 10:57:34
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>注册</title>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/stylesheet-base.css" />
        <script src="<%=path%>/js/jquery.js"></script>
        <script src="<%=path%>/js/bootstrap.js"></script>
        <script  src="<%=path%>/js/md5.js"></script>
        <style media="screen">
            .btn-default{
                color: gray;
            }
        </style>
    </head>
    <body  class="hidden-x">
        <div class="container ">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6" >
                    <div class="" id="account-title">
                        <h1 class="page-header stage-box">
                            注册<span></span>
                        </h1>
                    </div>
                    <div class=""  id="account">
                        <form class="form-horizontal" method="post"  name="form1" action="student_register_message">
                            <!-- 学号 -->
                            <div class="input-group">
                                <span class="input-group-addon">学号：</span>
                                <input type="text" name="idCard" class="form-control" placeholder="请输入您的学号 " maxlength="16" onblur="verifyText('idcard', 'idcardMsg');">
                            </div>      
                            <span id="idcardMsg" class="fontTips"></span>


                            <!-- 姓名 -->
                            <div class="input-group">
                                <span class="input-group-addon">姓名：</span>
                                <input type="text" id="name" name="name"class="form-control" placeholder="请输入您的姓名" width="180px" height="30px" size="25" maxlength="16" onblur="verifyText('name', 'nameMsg');" onfocus="initMessage('nameMsg');">
                            </div>
                            <span id="nameMsg" class="fontTips"></span>

                            <!-- 身份证号 -->
                            <div class="input-group">
                                <span class="input-group-addon">身份证号：</span>
                                <input type="text" id="myIDNum" name="myIDNum" class="form-control" placeholder="请再次输入您常用的身份证号" me="pn" onblur="verifyText('myIDNum', 'myIDNumMsg');
                                       " >
                            </div>
                            <span id="myIDNumMsg" class="fontTips"></span>

                            <!-- 年级 -->
                            <div class="input-group">
                                <span class="input-group-addon">年级：</span>
                                <select class="form-control" required="required" name="niji" >
                                    <option value="2008" type='hide' >2008</option>
                                    <option value="2009" type='hide'>2009</option>
                                    <option value="2010" type='hide'>2010</option>
                                    <option value="2011" type='hide'>2011</option>
                                    <option value="2012" type='hide'>2012</option>

                                    <option value="2013" type='hide'>2013</option>
                                    <option value="2014" type='hide'>2014</option>
                                    <option value="2015" type='hide'>2015</option>
                                    <option value="2016" type='hide'>2016</option>
                                    <option value="2017" type='hide'>2017</option>
                                    <option value="2018" type='hide'>2018</option>
                                    <option value="2019" type='hide'>2019</option>
                                    <option value="2020" type='hide'>2020</option>
                                    <option value="2021" type='hide'>2021</option>
                                </select>
                            </div>
                            <span class="fontTips"></span>

                            <!-- 院系 -->
                            <div class="input-group">
                                <span class="input-group-addon">院系：</span>
                                <select class="form-control" name="xueyuan">
                                    <option value="文学院" type='hide'>文学院	</option>
                                    <option value="历史文化学院" type='hide'>历史文化学院</option>
                                    <option value="教育科学学院" type='hide'>教育科学学院</option>
                                    <option value="哲学与公共管理学院" type='hide'>哲学与公共管理学院</option>
                                    <option value="法学院" type='hide'>法学院</option>	
                                    <option value="新闻与传播学院" type='hide'>新闻与传播学院</option>
                                    <option value="外语学院" type='hide'>外语学院</option>
                                    <option value="经济学院" type='hide'>经济学院</option>
                                    <option value="商学院" type='hide'>商学院</option>
                                    <option value="数学与统计学院" type='hide'>数学与统计学院	</option>
                                    <option value="物理与电子学院" type='hide'>物理与电子学院	</option>
                                    <option value="计算机与信息工程学院" type='hide'>计算机与信息工程学院</option>
                                    <option value="环境与规划学院" type='hide'>环境与规划学院	</option>
                                    <option value="生命科学学院" type='hide'>生命科学学院	</option>
                                    <option value="化学化工学院" type='hide'>化学化工学院</option>
                                    <option value="土木建筑学院" type='hide'>土木建筑学院	</option>
                                    <option value="艺术学院" type='hide'>艺术学院</option>
                                    <option value="体育学院" type='hide'>体育学院</option>
                                    <option value="医学院" type='hide'>医学院	药学院	</option>
                                    <option value="护理学院" type='hide'>护理学院</option>
                                    <option value="淮河临床学院" type='hide'>淮河临床学院	</option>
                                    <option value="东京临床学院" type='hide'>东京临床学院	</option>
                                    <option value="国际教育学院" type='hide'>国际教育学院</option>
                                    <option selected="" value="软件学院" type='hide'>软件学院</option>
                                    <option value="民生学院" type='hide'>民生学院</option>
                                    <option value="国际汉学院" type='hide'>国际汉学院</option>
                                    <option value="欧亚国际学院" type='hide'>欧亚国际学院	</option>
                                    <option value="人民武装学院" type='hide'>人民武装学院	</option>
                                    <option value="远程与继续教育学院" type='hide'>远程与继续教育学院</option>
                                    <option value="马克思主义学院" type='hide'>马克思主义学院	</option>
                                    <option value="大学外语教学部" type='hide'>大学外语教学部	</option>
                                    <option  value="公共体育部" type='hide'>公共体育部</option>
                                    <option value="军事理论教研部" type='hide'>军事理论教研部	</option>
                                </select>
                            </div>
                            <span class="fontTips"></span>

                            <!-- 手机号码 -->
                            <div class="input-group">
                                <span class="input-group-addon">手机：</span>
                                <input type="text" id="myPhone" name="myPhone" class="form-control" placeholder="请输入您常用的手机号码" me="pn" onblur="verifyText('myPhone', 'myPhoneMsg');
                                       " >
                            </div>
                            <span id="myPhoneMsg" class="fontTips"></span>
                            <!-- QQ -->
                            <div class="input-group">
                                <span class="input-group-addon">扣扣：</span>
                                <input type="text" id="myQq" name="myQq" class="form-control" placeholder="请输入您的QQ号" me="qq" onblur="verifyText('myQq', 'myQqMsg');
                                       ">
                            </div>
                            <span id="myQqMsg" class="fontTips"></span>

                            <!-- 密码 -->
                            <div class="input-group">
                                <span class="input-group-addon">密码：</span>
                                <input type="password" name="password_plain" id="mima" class="form-control" placeholder="请输入密码" me="psw" onblur="verifyText('passwFrist', 'passwFristMsg');
                                       " onfocus="initMessage('passwFristMsg');">
                                <input type="hidden" name="password_md5">
                            </div>
                            <span id="passwFristMsg" class="fontTips"></span>


                            <!-- 验证码 -->
                            <div class="input-group">
                                <span class="input-group-addon"></span></span>
                                <input type="text" class="form-control"  id="checkcodeText" placeholder="请输入右侧的验证码" onblur="verifyText('checkcodeText', 'checkcodeMsg');" >
                                <span class="input-group-addon"><input type="button" id="checkcode" onclick="createCheckCode(5);" readonly="readonly"></span>
                            </div>
                            <span id="checkcodeMsg" class="fontTips"></span>
                            <br>
                            <div class="form-group">
                                <div class="col-md-12">
                                    <a  onclick="mysubmit()"><div class="btn-card btn-danger col-md-6"  >下一步</div></a>

                                    <a href="index-acount-0.html" class="btn-card btn-default col-md-3" >
                                        重新选择角色
                                    </a>
                                    <a href="index" class="btn-card btn-default col-md-3" >
                                        返回登陆界面
                                    </a>

                                </div>
                            </div>

                        </form>
                        <script>
                            //加密代码
                            function mysubmit()
                            {
                                document.form1.password_md5.value = hex_md5(document.getElementById('mima').value);
                                // alert(document.form1.password_md5.value);
                                // alert("密码已经加密");
                                document.form1.submit();
                            }
                            /**构造&&实例化*********************************************************************************************************/
                            /*验证和提示*/
                            function verifyObject(targetParm) { //targetParm为待验证的消息
                                this.target = targetParm;
                            }
                            verifyObject.prototype.trim = function () {
                                var pattern = /(^\s*)|(\s*$)/g;
                                this.target = this.target.replace(pattern, "");
                            }
                            verifyObject.prototype.isEqual = function (anyParm) {
                                if (this.target == anyParm) {
                                    return true;
                                } else {
                                    return false;
                                }
                            }
                            verifyObject.prototype.isPattern = function (patternParm) {
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
                                        document.getElementById(checkMessage).innerHTML = "用户名 错误";
                                    } else {
                                        document.getElementById(checkMessage).innerHTML = "";
                                    }
                                } else if (checkText == "idcard") {
                                    if (!(verifyObj.isPattern(/^[0-9 _]{6,18}$/))) {
                                        document.getElementById(checkMessage).innerHTML = "学号错误";
                                    } else {
                                        document.getElementById(checkMessage).innerHTML = "";
                                    }
                                } else if (checkText == "myIDNum") {
                                    if (!(verifyObj.isPattern(/^[0-9 x]{14}$/))) {
                                        document.getElementById(checkMessage).innerHTML = "身份证号有误";
                                    } else {
                                        document.getElementById(checkMessage).innerHTML = "";
                                    }
                                } else if (checkText == "myPhone") {
                                    if (!(verifyObj.isPattern(/^[0-9]{11}$/))) {
                                        document.getElementById(checkMessage).innerHTML = "手机号有误";
                                    } else {
                                        document.getElementById(checkMessage).innerHTML = "";
                                    }
                                } else if (checkText == "myQq") {
                                    if (!(verifyObj.isPattern(/^[0-9]{6,12}$/))) {
                                        document.getElementById(checkMessage).innerHTML = "Qq号有误";
                                    } else {
                                        document.getElementById(checkMessage).innerHTML = "";
                                    }
                                } else if (checkText == "passwFrist") {
                                    if (!(verifyObj.isPattern(/^[a-z A-Z 0-9 _]{6,18}$/))) {
                                        document.getElementById(checkMessage).innerHTML = "密码必须为6-18位";
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
                                    obj.innerHTML = "<span style='color:green'>用户名必须为2-16位的字母,数字或汉字构成</span>";
                                } else if (objId == "passwFristMsg") {
                                    obj.innerHTML = "<span style='color:green'>密码必须为6-18位的字母,数字或下划线构成</span>";
                                }
                            }

                        </script>

                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
        </div>
    </body>
</html>
