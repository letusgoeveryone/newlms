<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<sec:authorize access="hasRole('ROLE_ACDEMIC') or hasRole('ROLE_DEAN')  or hasRole('ROLE_TEACHER') or hasRole('ROLE_ADMIN')">
    
    <style>
        #uinfo>modal-dialog{
            max-width: 960px;
        }
    </style>

    <div class="modal fade" id="uinfo" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content tab-content" >

                <div class="tab-content divider-right">
                    <!--基础资料-->
                    <div class="tab-pane fade in" id="tab-personalInfo" >
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
                                    <label for="boy">
                                        <input class="access-hide form-control" id="boy" name="sex" type="radio">男生
                                        <span class="radiobtn-circle" ></span><span class="radiobtn-circle-check" ></span>
                                    </label>
                                </div>

                                <div class="radiobtn radiobtn-adv radio-inline">
                                    <label for="girl">
                                        <input class="access-hide form-control" id="girl" name="sex" type="radio">女生
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
                                <label class="floating-label" for="grade"> 职称 </label>
                                <select class="form-control" id="grade" value="">
                                    <option value="{{grade}}"> {{grade}} </option>
                                    {{{schoolYearsList}}}
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
                                <label class="floating-label" for="oldPassword"> 原始密码 </label>
                                <input class="form-control" id="oldPassword" type="password">
                                <div id="validMsg-opw" hidden></div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="newPassword"> 新密码 </label>
                                <input class="form-control" id="newPassword" type="password" placeholder="密码最短为6位">
                                <div id="validMsg-npw" hidden></div>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="newPasswordConfirm"> 确认密码  </label>
                                <input class="form-control" id="newPasswordConfirm" type="password">
                                <div id="validMsg-npwconfirm" hidden></div>
                            </div>
                        </form>
                    </div>
                </div>
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

    <script>

        //基本信息 合法性检验
        function CheckValidation() {
            var status = true;

            //若值为空 复位
            if ($.trim($("#name").val()) === "") {
                $('#name').val(UInfo.$data.name);
            }
            if ($.trim($("#ID").val()) === "") {
                $('#ID').val(UInfo.$data.ID);
            }
            if ($.trim($("#tel").val()) === "") {
                $('#tel').val(UInfo.$data.tel);
            }
            if ($.trim($("#qq").val()) === "") {
                $('#qq').val(UInfo.$data.qq);
            }

            //合法性检验 并提示
            var r = /(^\d{15}$)|(^\d{17}([0-9]|X)$)/g;
            var flag = r.test($.trim($("#ID").val()));
            if (!flag) {
                $("#validMsg-ID").fadeIn();
                status = false;
            } else
                $("#validMsg-ID").fadeOut();

            r = /^1\d{10}$/g;
            flag = r.test($.trim($("#tel").val()));
            if (!flag) {
                $("#validMsg-tel").fadeIn();
                status = false;
            } else
                $("#validMsg-tel").fadeOut();

            r = /^[0-9]{6,10}$/;
            flag = r.test($.trim($("#qq").val()));
            if (!flag) {
                $("#validMsg-qq").fadeIn();
                status = false;
            } else
                $("#validMsg-qq").fadeOut();

            return status;
        }
        
        //密码合法性检验
        function checkPassword() {
            var status = true;
            if ($("#oldPassword").val() === '') {
                console.log($("#oldPassword").val());
                $("#validMsg-opw").html("请输入原始密码！");
                $("#validMsg-opw").fadeIn();
                status = false;
            } else
                $("#validMsg-opw").fadeOut();

            if ($("#newPasswordConfirm").val() !== $("#newPassword").val()) {
                $("#validMsg-npwconfirm").html("两次输入的密码不一致！");
                $("#newPasswordConfirm").val("");
                $("#validMsg-npwconfirm").fadeIn();
                status = false;
            } else
                $("#validMsg-npwconfirm").fadeOut();


            var r = /^[a-z A-Z 0-9 _]{6,18}$/;
            var flag = r.test($("#newPassword").val());
            if (!flag && ($("#oldPassword").val() !== '')) {
                $("#validMsg-npw").html("新密码不符合要求（6到18位），是不是太简单了?");
                $("#validMsg-npw").fadeIn();
                status = false;
            } else
                $("#validMsg-npw").fadeOut();

            if (status === false)
                return false;
            else {
                $("#validMsg-opw").fadeOut();
                $("#validMsg-npw").fadeOut();
                $("#validMsg-npwconfirm").fadeOut();
            }
            return true;
        }

        //更新个人密码
        function updataPassword() {}
        ;

        //更新个人信息
        function updataPersonalInfo() {}
        ;
    </script>

</sec:authorize>  