<%-- 
    Document   : index-login
    Created on : 2015-7-20, 8:44:51
    Author     : llgt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head lang="zh-CN">
        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, inintal-scale=1.0">
        <title>登录</title>
        <link rel="stylesheet" href="css/reset.css">
        <link rel="stylesheet" href="css/bootstrap.css" />
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body onload="createCheckCode(5)">
        <div class="container accountPage" id="login">
            <table class="accountPageTable form-group">
                <form action="#" method="get">
                    <tr>
                        <td>用户名:</td>
                        <td>
                            <input type="text" id="name" class="form-control" placeholder="请输入姓名 !" width="180px" height="30px" size="25" maxlength="16" />
                        </td>
                    </tr>
                    <tr>
                        <td>密码:</td>
                        <td>
                            <input type="password" id="passwFrist" class="form-control" placeholder="请输入密码 !" me="psw" width="180px" height="30px" size="25" />
                            <!--autocomplete="on" autofocus="(1-9){4}"-->
                        </td>
                    </tr>
                    <tr>
                        <td>验证码:
                            <input type="button" id="checkcode" class="form-inline btn-o fontWheat code checkcod-btn" onclick="createCheckCode(5);" readonly="readonly" class="code" />

                        </td>
                        <td>
                            <input type="text" id="checkcodeText" class="form-control form-inline" placeholder="请输入验证码 !" width="180px" height="30px" onblur="verifyText('checkcodeText','checkcodeMsg');" />

                        </td>
                    </tr>
                    <tr>
                        <td><span id="checkcodeMsg" class="fontWheat form-inline ">>>停留以查看验证码</span>
                        </td>

                    </tr>
                    <div class="opt">

                        <input type="radio" name="btn-o" value="visiter">游客</input>
                        <br />
                        <input type="radio" name="btn-o" value="teacher">教师</input>
                        <br />
                        <input type="radio" name="btn-o" value="student">学生</input>
                        <br />
                        <input type="radio" name="btn-o" value="school">校务</input>
                        <br />
                        <input type="radio" name="btn-o" value="root">管理员</input>
                        <br />
                    </div>
                </form>
            </table>
        </div>
        <div class="bg-dym" id="introPage">
            <div class="intro">
                <h1>Henu Software University </h1>
                <p>欢迎来到河南大学软件学院</p>
                <a href="#login" class="btn-o" onclick="">登录</a> <a href="#accont" class="btn-o">注册</a>
            </div>
        </div>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript">
                 /*验证和提示*/
                function verifyObject(targetParm) { //targetParm为待验证的消息
                        this.target = targetParm;
                }
                verifyObject.prototype.trim = function() {
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
                                codeObject.prototype.creatCode = function (objParam) {
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
                                //			var modlogin = 0;
                                //			var modintro = 1
                                //
                                //			function showLogin() {
                                //				var show = document.getElementById('loginPage');
                                //				show.removeAttribute("hidden");
                                //			}
                                //
                                //			function hiddenLogin() {
                                //				var hidden = document.getElementById('loginPage');
                                //				hidden.setAttribute("hidden", " ");
                                //			}
                                //
                                //			function showIntro() {
                                //				var show = document.getElementById('introPage');
                                //				show.removeAttribute("hidden");
                                //			}
                                //
                                //			function hiddenIntro() {
                                //				var hidden = document.getElementById('introPage');
                                //				hidden.setAttribute("hidden", " ");
                                //			}
                                //
                                //			function changePage() {
                                //				var method = modintro;
                                //				if (method == 0) {
                                //					showIntro();
                                //					hiddenLogin();
                                //					modintro = 1;
                                //				} else {
                                //					hiddenIntro();
                                //					showLogin();
                                //					modintro = 0;
                                //				}
                                //			}
        </script>
    </body>
</html>
