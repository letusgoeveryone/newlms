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
                            <!-- 原名 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="name">原名：</label>
                                        <input type="text" id="name" name="name" class="form-control"  maxlength="16">
                                    </div>
                                </div>
                                <span id="nameMsg" class="text-error"></span>   
                            </div>

                            <!-- 新名 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="rename">新名：</label>
                                        <input type="text" id="rename" name="rename" class="form-control" maxlength="16"/>
                                    </div>
                                </div>
                                <span id="renameMsg" class="text-error"></span>
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
                                        <label class="floating-label" for="pw">原始密码</label>
                                        <input type="password" class="form-control" id="pw" name="pw" placeholder="请输入密码" onblur="verifyText('pw', 'pwMsg');">
                                    </div>
                                </div>
                                <span id="pwMsg" class="text-error"></span>
                            </div>
                            
                            <!-- 新密码-0 -->
                            <div class="form-group form-group-label">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="floating-label" for="passwFrist">新密码：</label>
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
                                        <label class="floating-label" for="passwLast">确认密码：</label>
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
                                <img alt="" class="img-circle img-rounded img-pinfo" id="img-pinfo" src="<%=path%>/images/avatar.svg" height="230" width="230">
                                <span class="btn btn-flat text-link">
                                    暂无头像 <span class="icon icon-edit"></span>
                                </span>
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
            
            function checkName(id, msgid){
                var ele = document.getElementById(id);
                var msg = document.getElementById(msgid);
                
                if(ele.value === ''){
                    msg.innerHTML = '不能为空';
                    return false;
                }else{
                    msg.innerHTML = '';
                    return true;
                }
            }
            
            function updateName(on, nn){
                var status=0;
                if(checkName('name', 'nameMsg')&&checkName('rename', 'renameMsg')){
                    $.ajax({
                        url: PATH + '/admin/updateadminname?name=' + on + '&rename=' + nn,
                        type: 'post',
                        async: false,
                        dataType: 'json',
                        success: function(data) {
                                status = data;
                                console.log(data);
                        },
                        error: function() {
                            alert("数据传输失败 ！");
                        }
                    });
                }
                
                if (status === 0) {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '户名并未更新 原因:新户名不规范 <a data-dismiss="snackbar">我知道了</a>'
                    });
                    $("#msg-op").fadeIn();
                } else if (status === 1) {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '户名并未更新 原因:户名并未更新 原户名有误 <a data-dismiss="snackbar">我知道了</a>'
                    });
                }else if (status === 2) {
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '户名并未更新 原因:新户名与旧户名相同 <a data-dismiss="snackbar">我知道了</a>'
                    });
                } else if (status === 3) {
                    
                    $('#snackbar').snackbar({
                        alive: 10000,
                        content: '户名修改成功～ <a data-dismiss="snackbar" >我知道了</a>'
                    });
                } else if (status === -1){
                    alert("数据传输失败 ！");
                }
            }
            
            // 个人信息 监听器
            $('a[href="#tab-personalInfo"]').click(function(){
                $('#submit-uinfo').attr("data-submit","uinfo");
                console.log($('#submit-uinfo').attr('data-submit'));
                $('.form-control').blur(function(){
                    if(checkName('name', 'nameMsg')&&checkName('rename', 'renameMsg')){
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
                    updateName($('#name').val(), $('#rename').val());
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
    </body>
</html>
