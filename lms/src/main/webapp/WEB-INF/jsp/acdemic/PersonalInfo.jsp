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
    <body>

        <!--个人信息-->
        <div class="container pd-top-lg" id="uinfo" >
            <div class="row" >
                <div class="tab-content col-sm-5 divider-right" id="info-form">
                    <!--基础资料-->
                    <div class="tab-pane fade in active" id="tab-personalInfo" >
                        <form>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="sn"> 工号 </label>
                                <input class="form-control" id="sn" type="text" value="{{sn}}" disabled="">
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="name"> 姓名 </label>
                                <input class="form-control" id="name" type="text" value="{{name}}">
                                <div id="validMsg-name" hidden>请输入至少两个汉字</div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="ID"> 身份证 </label>
                                <input class="form-control" id="ID" type="text" value="{{ID}}">
                                <div id="validMsg-ID" hidden>您输入的身份证格式不正确</div>
                            </div>
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
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="college"> 学院 </label>
                                <select class="form-control" id="college" value="">
                                    <option value="{{college}}"> {{college}} </option>
                                    {{{schoolCollegeList}}}
                                </select>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="tel"> 联系方式 </label>
                                <input class="form-control" id="tel" type="text" value="{{tel}}">
                                <div id="validMsg-tel" hidden>请输入正确的手机号</div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="qq"> QQ </label>
                                <input class="form-control" id="qq" type="text" value="{{qq}}">
                                <div id="validMsg-qq" hidden>请输入正确QQ号</div>
                            </div>
                        </form>
                    </div>
                    <!--密码设置-->
                    <div class="tab-pane fade" id="tab-password">
                        <form>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="op"> 原始密码 </label>
                                <input class="form-control" id="op" type="password">
                                <div id="msg-op" hidden></div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="np"> 新密码 </label>
                                <input class="form-control" id="np" type="password" placeholder="密码最短为6位">
                                <div id="msg-np" hidden></div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="nplast"> 确认密码  </label>
                                <input class="form-control" id="nplast" type="password">
                                <div id="msg-nplast" hidden></div>
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
        <script src="<%=path%>/js/api.json.adt.js"></script>
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
        </script>
    </body>
</html>
