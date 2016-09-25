<%
    //将项目的根取出来，页面中不再使用相对路径
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
        <title>PersonalInfo</title>

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css"/>
        <!--JS-->
        <script src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/vue.js"></script>
        <style>
            body{
                overflow: hidden; 
                min-width: 960px;
            }
            #uinfo>.row{
                max-width: 960px;
                margin: auto;
            }
            #info-form{
                overflow-y: auto;
            }
            #info-slct{
                padding-left: 15vh;
            }
            .pd-top-lg{
                padding-top: 15vh;
            }
            
        </style>
    </head>
    <body id="lms_adt_info" >

        <!--个人信息-->
        <div class="container pd-top-lg" id="uinfo" >
            <div class="row" >
                <div class="tab-content col-sm-5 divider-right" id="info-form">
                    <!--基础资料-->
                    <div class="tab-pane fade in active" id="tab-personalInfo" >
                        <form>
                            <!-- 工号 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="sn">学号：</label>
                                        <input type="text" id="sn" name="sn" value="{{sn}}" disabled class="form-control" placeholder="请输入您的工号 " maxlength="16" onblur="verifyText('sn', 'snMsg');">
                                    </div>
                                </div>
                                <span id="snMsg" class="text-error"></span>   
                            </div>

                            <!-- 姓名 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="name">姓名：</label>
                                        <input type="text" id="name" name="name" value="{{name}}" disabled class="form-control" placeholder="请输入您的姓名" maxlength="16" onblur="verifyText('name', 'nameMsg');" onfocus="initMessage('nameMsg');" />
                                    </div>
                                </div>
                                <span id="nameMsg" class="text-error"></span>
                            </div>
                            
                            <!-- 身份证号 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="ID">身份证号：</label>
                                        <input type="text" id="ID" name="ID" value="{{ID}}" disabled class="form-control" placeholder="请再次输入您的身份证号" onblur="verifyText('ID', 'IDMsg');" >
                                    </div>
                                </div>
                                <span id="IDMsg" class="text-error"></span>
                            </div>
                            
                            <!--性别-->
                            <div class="form-group form-group-label">

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="male">
                                        <input class="access-hide form-control" id="male" name="sex" type="radio">先生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="female">
                                        <input class="access-hide form-control" id="female" name="sex" type="radio">女士
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>
                            </div>
                            
                            <!-- 院系 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="institute">院系：</label>
                                        <select class="form-control" name="institute" id="institute">
                                            
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 手机号码 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="tel">手机：</label>
                                        <input type="text" id="tel" name="tel" value="{{tel}}" class="form-control" placeholder="请输入您常用的手机号码" me="pn" onblur="verifyText('tel', 'telMsg');" >
                                    </div>
                                </div>
                                <span id="telMsg" class="text-error"></span>
                            </div>

                            <!-- QQ -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="qq">扣扣：</label>
                                        <input type="text" id="qq" name="qq" value="{{qq}}" class="form-control" placeholder="请输入您的QQ号" me="qq" onblur="verifyText('qq', 'qqMsg');">
                                    </div>
                                </div>
                                <span id="qqMsg" class="text-error"></span>
                            </div>
                            
                        </form>
                    </div>
                    <!--密码设置-->
                    <div class="tab-pane fade" id="tab-password">
                        <form>
                            <!-- 旧密码 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="pw">密码</label>
                                        <input type="password" class="form-control" id="pw" name="pw" placeholder="请输入密码" onblur="verifyText('pw', 'pwMsg');">
                                    </div>
                                </div>
                                <span id="pwMsg" class="text-error"></span>
                            </div>
                            
                            <!-- 新密码-0 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="passwFrist">密码：</label>
                                        <input type="password" name="passwFrist" id="passwFrist" class="form-control" placeholder="请输入密码" me="psw" onblur="verifyText('passwFrist', 'passwFristMsg');
                                               " onfocus="initMessage('passwFristMsg');">
                                        <input type="hidden" name="password_md5"> 
                                    </div>
                                </div>
                                <span id="passwFristMsg" class="text-error"></span>
                            </div>
                            
                            <!-- 新密码-1 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="passwLast">密码：</label>
                                        <input type="password" id="passwLast" class="form-control" name="passwLast" placeholder="请再次输入您的密码" me="psw" onblur="verifyText('passwLast', 'passwLastMsg');">
                                    </div>
                                </div>
                                <span id="passwLastMsg" class="text-error"></span>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-sm-7" id="info-slct">
                    <div class="card">
                        <div class="uinfo-blur"></div>
                        <div class="card-main">
                            <div class="card-inner">
                                <img alt="" class="img-circle img-rounded img-pinfo" id="img-pinfo" src="<%=path%>/images/avatar.jpg" height="230" width="230">
                                <a class="btn btn-flat text-link">
                                    修改头像 <span class="icon icon-edit"></span>
                                </a>
                            </div>
                            <div class="card-action">
                                <div class="card-action-btn btn btn-block btn-flat btn-dashed disabled" id="submit-uinfo" data-submit="uinfo" >
                                    提交修改
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="card no-padding">
                        <div class="card-main">
                            <nav class="tab-nav tab-nav-brand no-margin">
                                <ul class="nav nav-list nav-justified">
                                    <li class="active">
                                        <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#tab-personalInfo">
                                            <span class="text-grey">个人信息</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="waves-attach waves-light waves-effect" data-toggle="tab" href="#tab-password">
                                            <span class="text-grey">密码设置</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        
        <!--单向信息传递 snackbar-->
        <div id="snackbar"></div>
        
        <!-- js -->
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/md5.js" type="text/javascript"></script>
        <script src="<%=path%>/js/api.adt.js"></script>
        <script>
            
            // 个人信息 监听器
            $('a[href="#tab-personalInfo"]').click(function(){
                $('#submit-uinfo').attr("data-submit","uinfo");
                console.log($('#submit-uinfo').attr('data-submit'));
                $('.form-control').blur(function(){
                    if(checkPersonalInfo()){
                        $('#submit-uinfo').removeClass('disabled');
                    }else{
                        $('#submit-uinfo').addClass('disabled');
                    };
                });

                $('#submit-uinfo').addClass('disabled');
            });
            // 个人密码 监听器
            $('a[href="#tab-password"]').click(function(){
                $("#op").val("");
                $("#np").val("");
                $("#nplast").val("");
                $('#submit-uinfo').attr("data-submit","upassword");
                console.log($('#submit-uinfo').attr('data-submit'));
                $('.form-control').blur(function () {
                    if (checkPassword()) {
                        $('#submit-uinfo').removeClass('disabled');
                    }else{
                        $('#submit-uinfo').addClass('disabled');
                    };
                });

                $('#submit-uinfo').addClass('disabled');
            });

            // submit 按钮 监听器
            $('#submit-uinfo').click(function(){
                var status = $(this).hasClass('disabled') === true ? false : true ;
                var method = $(this).attr('data-submit');

                console.log(status + " | " + method);
                if (status && (method === "uinfo")) {
                    updatePersonalInfo();
                } else if(status && (method === "upassword")){
                    console.log(status + " | " + method);
                    updatePassword();
                }

            });
            
            
            //  默认监听个人信息
            $('a[href="#tab-personalInfo"]').click();
            
            // 设置路径
            function getRootPath() {
                return '<%=path%>';
            }
        </script>
        <script src="<%=path%>/js/api.common.js"></script>
        <<script>
            CommonAPI.setDS.Institute('/reg/hq_xy');
            CommonAPI.setHS.Institute('institute');
            $('option[value="'+ AdtAPI.uInfo.college +'"]').attr('selected','');
        </script>
    </body>
</html>
