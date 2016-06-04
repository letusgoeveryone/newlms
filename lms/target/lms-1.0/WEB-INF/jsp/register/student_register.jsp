<%-- 
    Document   : index-acount
    Created on : 2015-10-16, 10:57:34
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    //request.setAttribute("Error", "密码错误"); 
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>注册</title>
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css" />
        <style media="screen"></style>
    </head>
    <body  class="hidden-x stage-image" id="lms_stu_reg"  style="background-image:url(<%=path%>/images/bg-for-role.jpg)">
        <div class="container ">
            <div class="row">
                <div class="col-md-3 stage-box">
                    <div class="pull-left">

                        <a href="<%=path%>/login" class="btn-arrow">
                            <i class="fbtn waves-attach waves-circle waves-effect">←</i> 
                            <span> 返回登陆界面 </span> 
                        </a>
                    </div>
                </div>
                            
                <div class="col-md-6 card">
                    <form class="form-horizontal tab-content width-control stage-side" method="post" name="form_login" action="student_register_message" >
                        <div class="" id="account-title">
                            <h1 class="page-header">
                                注册
                            </h1>
                            <p id="yc">${requestScope.Error}</p> 
                        </div>
                        <div  class="tab-pane fade in active" id="login-0">
                            <div>

                                <!-- 学号 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="idCard">学号：</label>
                                            <input type="text" id="idcard" name="idCard" class="form-control" placeholder="请输入您的学号 " maxlength="16" onblur="verifyText('idcard', 'idcardMsg');">
                                        </div>
                                    </div>
                                    <span id="idcardMsg" class="text-error"></span>   
                                </div> 

                                <!--<br>-->
                                <!-- 姓名 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="name1">姓名：</label>
                                            <input type="text" id="name" name="name1" class="form-control" placeholder="请输入您的姓名" maxlength="16" onblur="verifyText('name', 'nameMsg');" onfocus="initMessage('nameMsg');" />
                                        </div>
                                    </div>
                                    <span id="nameMsg" class="text-error"></span>
                                </div>
                                <!--<br>-->
                                
                                <!-- 身份证号 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="myIDNum">身份证号：</label>
                                            <input type="text" id="myIDNum" name="myIDNum" class="form-control" placeholder="请再次输入您的身份证号" onblur="verifyText('myIDNum', 'myIDNumMsg');" >
                                        </div>
                                    </div>
                                    <span id="myIDNumMsg" class="text-error"></span>
                                </div>
                                <!--<br>-->
                                
                                <!--性别-->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="xingbie">性别：</label>
                                            <select class="form-control" required="required" name="xingbie" >                                       
                                                <option value="女" type='hide'>女</option>
                                                <option value="男" type='hide' selected="">男</option>                                     
                                            </select></div>
                                    </div>
                                </div>
                                <span class="text-error"></span>
                                <!--<br>-->
                                
                                <!-- 年级 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="myIDNum">年级：</label>
                                            <select class="form-control" required="required" name="niji" id="fhnj">
                                                <option value="2014">
                                                    2014
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!--<br>-->
                                
                                <!-- 院系 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="myIDNum">院系：</label>
                                            <select class="form-control" name="Institute" id="szxy">
                                                <option value="软件学院">
                                                    软件学院
                                                </option>
                                            </select></div>
                                    </div>
                                </div>
                                <span class="text-error"></span>
                                <!--<br>-->
                                
                                <!-- 手机号码 -->

                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="myPhone">手机：</label>
                                            <input type="text" id="myPhone" name="myPhone" class="form-control" placeholder="请输入您常用的手机号码" me="pn" onblur="verifyText('myPhone', 'myPhoneMsg');" >
                                        </div>
                                    </div>
                                    <span id="myPhoneMsg" class="text-error"></span>
                                </div>
                                <!--<br>-->
                                
                                <!-- QQ -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="myQq">扣扣：</label>
                                            <input type="text" id="myQq" name="myQq" class="form-control" placeholder="请输入您的QQ号" me="qq" onblur="verifyText('myQq', 'myQqMsg');">
                                        </div>
                                    </div>
                                    <span id="myQqMsg" class="text-error"></span>
                                </div>
                                <!--<br>-->
                                
                                <!-- 密码 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="password_plain">密码：</label>
                                            <input type="password" name="password_plain" id="passwFrist" class="form-control" placeholder="请输入密码" me="psw" onblur="verifyText('passwFrist', 'passwFristMsg');
                                                   " onfocus="initMessage('passwFristMsg');">
                                            <input type="hidden" name="password_md5"> 
                                        </div>
                                    </div>
                                    <span id="passwFristMsg" class="text-error"></span>
                                </div>
                                
                                <!--下一步按钮-->
                                <div class="box-small"></div>
                                <div class="form-group">
                                    <a id="fornext" onclick="fornext()" data-toggle="tab" href="#"><div class="btn btn-brand btn-block">最后一步</div></a>
                                </div>
                                <div class="stage-box"></div>
                                
                            </div>
                        </div>
                        
                        <!--下一步 内容验证-->
                        <div class="tab-pane fade" id="login-1">
                            
                            <!-- 学号 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="idcardCheck">学号：</label>
                                        <input type="text" id="idcardCheck" class="form-control" name="idcardCheck" placeholder="请再次输入您的学号 " maxlength="16" onblur="verifyText('idcardCheck', 'idcardCheckMsg');">
                                    </div>
                                </div>
                                <span id="idcardCheckMsg" class="text-error"></span>
                            </div>
                            
                            <!-- 姓名 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="nameCheck">姓名：</label>
                                        <input type="text" id="nameCheck" class="form-control" name="nameCheck" placeholder="请再次输入您的姓名" width="180px" height="30px" size="25" maxlength="16" onblur="verifyText('nameCheck', 'nameCheckMsg');">
                                    </div>
                                </div>
                                <span id="nameCheckMsg" class="text-error"></span>
                            </div>
                            <!--<br>-->

                            <!-- 手机号码 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="myIDNumCheck">身份证号：</label>
                                        <input type="text" id="myIDNumCheck" class="form-control" name="myIDNumCheck" placeholder="请再次输入您的身份证号" me="pn" onblur="verifyText('myIDNumCheck', 'myIDNumCheckMsg');">
                                    </div>
                                </div>
                                <span id="myIDNumCheckMsg" class="text-error"></span>
                            </div>

                            <!-- 密码 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="passwLast">密码：</label>
                                        <input type="password" id="passwLast" class="form-control" name="passwLast" placeholder="请再次输入您的密码" me="psw" onblur="verifyText('passwLast', 'passwLastMsg');">
                                    </div>
                                </div>
                                <span id="passwLastMsg" class="text-error"></span>
                            </div>

                            <!-- 验证码 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="ccd">验证码：</label>

                                        <input id="ccd" name="ccd" class="form-control ui-widget-content easyui-validatebox" type="text" maxlength="4"  
                                               data-options="required:true,validType:'chk_code',missingMessage:'请输入验证码',tipPosition:'left' "
                                               title="验证码区分不大小写，看不清楚请单击图片" >
                                        <span class="pull-right" style="position: relative;bottom: 25px; z-index: 1000; cursor:pointer;"> <img id="ccdImage" style="border:0" title="看不清楚请单击图片" onclick="reload()" ></span>
                                        <!-- <div class="input-group">
                                            <span class="floating-label"></span>
                                            <input type="text" class="form-control"  id="checkcodeText" placeholder="请输入右侧的验证码" onblur="verifyText('checkcodeText','checkcodeMsg');" >
                                            <span class="floating-label"><input type="button" id="checkcode" onclick="createCheckCode(5);" readonly="readonly"></span>
                                        </div>-->
                                    </div>
                                </div>
                                <span id="checkcodeMsg" class="text-error"></span>
                            </div>

                            <div class="box-small"></div>
                            <div class="form-group">

                                <div onclick="mysubmit()" type="submit" class="btn btn-brand-accent btn-block">注册</div>
                                <br />
                                <a href="#login-0" data-toggle="tab"><div class="btn btn-brand btn-block">上一步</div></a>
                            </div>
                            <div class="stage-box"></div>         


                        </div>
                    </form>
                </div>

                <div class="col-md-3 stage-box">

                    <div class="pull-right">
                        <a href="student_teacher" class="btn-arrow">
                            <span> 重新选择角色 </span>
                            <i class="fbtn waves-attach waves-circle waves-effect">→</i>
                        </a>
                    </div>
                </div>
            </div>
        </div>


        <script src="<%=path%>/js/jquery.min.js"></script> 
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script  src="<%=path%>/js/md5.js"></script>                            
        <script>
        $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random()); //随机生成验证码

        function reload() {
            $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random()); //随机生成验证码
        }

        var statusBase = [0, 0, 0, 0, 0, 0];
        var statusCheck = [0, 0, 0, 0, 0];
        function checknull() {
            var s = 0;
            for (var t in statusCheck) {
                if (statusCheck[t] === 1) {
                    s++;
                }
            }
            if (s === 4)
                return true;
            else
                return false;
        }
        //加密代码
        function fornext()
        {
            var k = 0;
            for (var i in statusBase) {
                if (statusBase[i] === 1) {
                    k++;
                }
            }
            if (k === 6) {
                $('#fornext').attr("href", "#login-1");
            } else {
                $('#fornext').attr("href", "#");
                alert("请填写完成并且检查无误后再行下一步");
            }

        }
        function mysubmit()
        {

            if (checknull()) {
                document.form_login.password_md5.value = hex_md5(document.getElementById('passwLast').value);
                var jssz = document.getElementById("idcard").value;
                $.ajax({
                    type: "get", //提交方式
                    url: "cjxh", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        if (parseInt(data) === 1) {
                            if (window.confirm("你是否要注册? 注册后带着你的注册信息找教务员!!!")) {
                                document.form_login.submit();
                            }
                        } else {
                            document.form_login.submit();
                        }
                    },
                    error: function () {
                        alert("error!！");
                    }
                });

            } else {
                alert("请填写完成并且检查无误后再行提交");
            }

        }
        /**构造&&实例化*********************************************************************************************************/
        /*验证和提示*/
        function verifyObject(targetParm) { //targetParm为待验证的消息
            this.target = targetParm;
        }
        ;
        verifyObject.prototype.trim = function () {
            var pattern = /(^\s*)|(\s*$)/g;
            this.target = this.target.replace(pattern, "");
        };
        verifyObject.prototype.isEqual = function (anyParm) {
            if (this.target === anyParm) {
                return true;
            } else {
                return false;
            }
        };
        verifyObject.prototype.isPattern = function (patternParm) {
            var pattern = new RegExp(patternParm);
            var flag = pattern.test(this.target);
            if (flag) {
                return true;
            } else {
                return false;
            }
        };

        function verifyText(checkText, checkMessage) {
            var text = document.getElementById(checkText).value;
            var verifyObj = new verifyObject(text); //实例化对象
            verifyObj.trim();
            if (checkText === "name") {
                $('#yc').hide();//jQuery 代码该方法隐藏所有 <p> 元素
                if (!(verifyObj.isPattern(/^[a-z A-Z 0-9 \u4e00-\u9fa5]{2,16}$/))) {
                    document.getElementById(checkMessage).innerHTML = "用户名有误";
                    statusBase[0] = 0;
                } else {
                    statusBase[0] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "nameCheck") {
                if (!(verifyObj.isEqual(document.getElementById("name").value))) {
                    document.getElementById(checkMessage).innerHTML = "用户名前后不一致";
                } else {
                    statusCheck[0] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "idcard") {
                if (!(verifyObj.isPattern(/^[0-9 _]{6,18}$/))) {
                    document.getElementById(checkMessage).innerHTML = "学号有误";
                    statusBase[1] = 0;
                } else {
                    statusBase[1] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "idcardCheck") {
                if (!(verifyObj.isEqual(document.getElementById("idcard").value))) {
                    document.getElementById(checkMessage).innerHTML = "学号前后不一致";
                } else {
                    statusCheck[1] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "myIDNum") {
                if (!(verifyObj.isPattern(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/g))) {
                    document.getElementById(checkMessage).innerHTML = "身份证号有误";
                    statusBase[2] = 0;
                } else {
                    statusBase[2] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "myIDNumCheck") {
                if (!(verifyObj.isEqual(document.getElementById("myIDNum").value))) {
                    document.getElementById(checkMessage).innerHTML = "身份证号前后不一致";
                } else {
                    statusCheck[2] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "passwFrist") {
                if (!(verifyObj.isPattern(/^[a-z A-Z 0-9 _]{6,18}$/))) {
                    document.getElementById(checkMessage).innerHTML = "密码有误";
                    statusBase[3] = 0;
                } else {
                    statusBase[3] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "passwLast") {
                if (!(verifyObj.isEqual(document.getElementById("passwFrist").value))) {
                    document.getElementById(checkMessage).innerHTML = "密码前后不一致";
                } else {
                    statusCheck[3] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "myPhone") {
                if (!(verifyObj.isPattern(/^1\d{10}$/g))) {
                    document.getElementById(checkMessage).innerHTML = "手机号有误";
                    statusBase[4] = 0;
                } else {
                    statusBase[4] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "myQq") {
                if (!(verifyObj.isPattern(/^[0-9]{6,12}$/))) {
                    document.getElementById(checkMessage).innerHTML = "Qq号有误";
                    statusBase[5] = 0;
                } else {
                    statusBase[5] = 1;
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "email") {
                if (!(verifyObj.isPattern(/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$/))) {
                    document.getElementById(checkMessage).innerHTML = "邮箱格式不对";
                } else {
                    document.getElementById(checkMessage).innerHTML = "";
                }
            } else if (checkText === "checkcodeText") {
                if (!(verifyObj.isEqual(document.getElementById("checkcode").value))) {
                    document.getElementById(checkMessage).innerHTML = "验证码输入错误";
                } else {
                    statusCheck[4] = 1;
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
        $(function () {
            $.ajax({
                type: "get", //提交方式
                url: "hq_xy", //提交的页面，方法名
                success: function (data) {
                    document.getElementById("szxy").options.length = 0;
                    for (var i = 0; i < data.length; i++) {
                        document.getElementById("szxy").options.add(new Option(data[i], data[i]));
                    }
                },
                error: function () {
                    alert("error!！");
                }
            });
            $.ajax({
                type: "get", //提交方式
                url: "fhnj", //提交的页面，方法名
                success: function (data) {
                    document.getElementById("fhnj").options.length = 0;
                    for (var i = 0; i < data.length; i++) {
                        document.getElementById("fhnj").options.add(new Option(data[i], data[i]));
                    }
                },
                error: function () {
                    alert("error!！");
                }
            });
        });
        </script>
    </body>
</html>
