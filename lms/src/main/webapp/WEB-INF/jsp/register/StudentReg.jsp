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
        <title>注册 | 学生</title>
        <link href="<%=path%>/css/base.min.css" rel="stylesheet"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" />
        <style media="screen">html{height:100%}body{min-height: 100%;overflow: scroll;}</style>
    </head>
    <body  class="hidden-x stage-image" id="lms_stu_reg"  style="background-image:url(<%=path%>/images/bg-for-role.jpg)">
        <div class="container ">
            <div class="row">
                <div class="col-md-3 stage-box">
                    <div class="pull-left">

                        <a href="<%=path%>/login">
                            <span><i class="fbtn waves-attach waves-circle waves-effect icon">arrow_back</i>  返回登陆界面 </span> 
                        </a>
                    </div>
                </div>
                            
                <div class="col-md-6">
                    <div class="card login-form">
                        <form class="form-horizontal tab-content width-control stage-side" method="post" name="form_login" action="student_register_message" >
                            <div class="" id="account-title">
                                <h1 class="page-header">
                                    注册
                                </h1>
                            </div>
                            <div  class="tab-pane fade in active" id="login-start">
                                <div>

                                    <!-- 学号 -->
                                    <div class="form-group form-group-label">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label class="floating-label" for="sn">学号：</label>
                                                <input type="text" id="sn" name="sn" class="form-control" placeholder="请输入您的学号 " maxlength="16" onblur="verifyText('sn', 'snMsg');">
                                            </div>
                                        </div>
                                        <span id="snMsg" class="text-error"></span>   
                                    </div> 

                                    <!--<br>-->
                                    <!-- 姓名 -->
                                    <div class="form-group form-group-label">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label class="floating-label" for="name">姓名：</label>
                                                <input type="text" id="name" name="name" class="form-control" placeholder="请输入您的姓名" maxlength="16" onblur="verifyText('name', 'nameMsg');" onfocus="initMessage('nameMsg');" />
                                            </div>
                                        </div>
                                        <span id="nameMsg" class="text-error"></span>
                                    </div>
                                    <!--<br>-->

                                    <!-- 身份证号 -->
                                    <div class="form-group form-group-label">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label class="floating-label" for="ID">身份证号：</label>
                                                <input type="text" id="ID" name="ID" class="form-control" placeholder="请再次输入您的身份证号" onblur="verifyText('ID', 'IDMsg');" >
                                            </div>
                                        </div>
                                        <span id="IDMsg" class="text-error"></span>
                                    </div>
                                    <!--<br>-->

                                    <!--性别-->
                                    <div class="form-group form-group-label">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label class="floating-label" for="sex">性别：</label>
                                                <select class="form-control" required="required" name="sex" >                                       
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
                                                <label class="floating-label" for="grade">年级：</label>
                                                <select class="form-control" required="required" name="grade" id="fhnj">
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
                                                <label class="floating-label" for="institute">院系：</label>
                                                <select class="form-control" name="institute" id="szxy">
                                                    <option value="软件学院">
                                                        软件学院
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <span class="text-error"></span>
                                    <!--<br>-->

                                    <!-- 手机号码 -->

                                    <div class="form-group form-group-label">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label class="floating-label" for="tel">手机：</label>
                                                <input type="text" id="tel" name="tel" class="form-control" placeholder="请输入您常用的手机号码" me="pn" onblur="verifyText('tel', 'telMsg');" >
                                            </div>
                                        </div>
                                        <span id="telMsg" class="text-error"></span>
                                    </div>
                                    <!--<br>-->

                                    <!-- QQ -->
                                    <div class="form-group form-group-label">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <label class="floating-label" for="qq">扣扣：</label>
                                                <input type="text" id="qq" name="qq" class="form-control" placeholder="请输入您的QQ号" me="qq" onblur="verifyText('qq', 'qqMsg');">
                                            </div>
                                        </div>
                                        <span id="qqMsg" class="text-error"></span>
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
                                        <a id="fornext" onclick="isVaildOfInfo()" data-toggle="tab" href="#"><div class="btn btn-brand btn-block">下一步</div></a>
                                    </div>
                                    <div class="stage-box"></div>

                                </div>
                            </div>

                            <!--下一步 内容验证-->
                            <div class="tab-pane fade" id="login-next">

                                <!-- 学号 -->
                                <div class="form-group form-group-label">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="floating-label" for="snCheck">学号：</label>
                                            <input type="text" id="snCheck" class="form-control" name="snCheck" placeholder="请再次输入您的学号 " maxlength="16" onblur="verifyText('snCheck', 'snCheckMsg');">
                                        </div>
                                    </div>
                                    <span id="snCheckMsg" class="text-error"></span>
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
                                            <label class="floating-label" for="IDCheck">身份证号：</label>
                                            <input type="text" id="IDCheck" class="form-control" name="IDCheck" placeholder="请再次输入您的身份证号" me="pn" onblur="verifyText('IDCheck', 'IDCheckMsg');">
                                        </div>
                                    </div>
                                    <span id="IDCheckMsg" class="text-error"></span>
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
                                                   title="验证码区分不大小写，看不清楚请单击图片" onblur="verifyText('ccd', 'ccdMsg');">
                                            <span class="pull-right" style="position: relative;bottom: 25px; z-index: 1000; cursor:pointer;"> <img id="ccdImage" style="border:0" title="看不清楚请单击图片" onclick="updateCcdImage()" ></span>
                                            <!-- <div class="input-group">
                                                <span class="floating-label"></span>
                                                <input type="text" class="form-control"  id="checkcodeText" placeholder="请输入右侧的验证码" onblur="verifyText('checkcodeText','checkcodeMsg');" >
                                                <span class="floating-label"><input type="button" id="checkcode" onclick="createCheckCode(5);" readonly="readonly"></span>
                                            </div>-->
                                        </div>
                                    </div>
                                    <span id="ccdMsg" class="text-error"></span>
                                </div>

                                <div class="box-small"></div>
                                <div class="form-group">

                                    <div onclick="submitInfo()" type="submit" class="btn btn-brand-accent btn-block">注册</div>
                                    <br />
                                    <a href="#login-start" data-toggle="tab"><div class="btn btn-brand btn-block">上一步</div></a>
                                </div>
                                <div class="stage-box"></div>         


                            </div>
                        </form>
                    </div>
                </div>

                <div class="col-md-3 stage-box">

                    <div class="pull-right">
                        <a href="role">
                            <span><i class="fbtn waves-attach waves-circle waves-effect icon">arrow_forward</i> 重新选择角色 </span>
                        </a>
                    </div>
                </div>
            </div>
        </div>


        <script src="<%=path%>/js/jquery.min.js"></script> 
        <script src="<%=path%>/js/base.min.js"></script>
        <script src="<%=path%>/js/project.min.js"></script>
        <script  src="<%=path%>/js/md5.js"></script>                            
        <script>
        function getRootPath() {
            return '<%=path%>';
        }
        
        function isEqualOfInfo() {
            if(verifyText('snCheck', 'snCheckMsg')&&verifyText('nameCheck', 'nameCheckMsg')&&verifyText('IDCheck', 'IDCheckMsg')&&verifyText('passwLast', 'passwLastMsg')){
                return true;
            }else
                return false;
        }
        
        function isVaildOfInfo(){
            var status = false;
            if(verifyText('sn', 'snMsg')&&verifyText('name', 'nameMsg')&&verifyText('tel', 'telMsg')&&verifyText('qq', 'qqMsg')&&verifyText('passwFrist', 'passwFristMsg')){
                status = true;
            }else
                status = false;
            
            if (status === true) {
                $('#fornext').attr("href", "#login-next");
            } else {
                $('#fornext').attr("href", "#");
                alert("请填写完成并且检查无误后再行下一步");
            }

        }
        
        function submitInfo() {

            if (isEqualOfInfo()&&verifyText('ccd', 'ccdMsg')) {
                document.form_login.password_md5.value = hex_md5(document.getElementById('passwLast').value);
                var jssz = document.getElementById("sn").value;
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

        </script>
        <script src="<%=path%>/js/api.common.js"></script>
        <script>
            CommonAPI.setDS.Institute();
            CommonAPI.setDS.SchoolYear();
            CommonAPI.setHS.Institute('szxy');
            CommonAPI.setHS.SchoolYear('fhnj');
            updateCcdImage();
        </script>
    </body>
</html>
