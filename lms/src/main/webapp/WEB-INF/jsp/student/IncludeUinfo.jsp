<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
    //将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<sec:authorize access="hasRole('ROLE_STUDENT') or hasRole('ROLE_ADMIN')">    
    <style>
        .lms-avatars {
            height: 64px;
            width: 64px;
            background-attachment: fixed;
            background-repeat: no-repeat;
            background-size: contain;
            display: inline-block;
        }
        .lms-avatars>img{
            border-radius: 50%;
            cursor: pointer;
        }
        #lms-uavatar{
            display: block;
        }
        #lms-uavatar>img{
            display: block;
            margin: 1.5em auto;
            border-radius: 50%;
            cursor: pointer;
        }
    </style>
    <!--个人信息-->
    <div id="uinfo-wrap" style="display: none;">
        <div id="uinfo" >
            <div class="modal-dialog" style="max-width: 960px;">
                <div class="row" style="padding: 30px;">
                    <div class="tab-content divider-right col-sm-5">
                        <!--基础资料-->
                        <div class="tab-pane fade in active" id="tab-personalInfo" >
                            <form>
                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="sn"> 学号 </label>
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
                                    <label class="floating-label" for="grade"> 年级 </label>
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
                        <!--头像设置-->
                        <div class="tab-pane fade" id="tab-avatars">
                            
                        </div>
                    </div>
                    <div class="col-sm-7"  style="padding-left: 45px;" >
                        <div class="card">
                            <div class="uinfo-blur"></div>
                            <div class="card-main">
                                <div class="card-inner">
                                    <img alt="" class="img-circle img-rounded img-pinfo" id="img-pinfo" src="<%=path%>/images/avatar.jpg" height="230" width="230">
                                    <a class="btn btn-flat text-link" id="modify-avatar" data-toggle="tab" href="#tab-avatars" onclick="setAvatars([7,5],640)">
                                        修改头像 <span class="icon icon-edit"></span>
                                    </a>
                                    <a class="btn btn-flat text-link" id="reset-avatar" onclick="setDefaultAvatar()">
                                        还原系统头像 <span class="icon icon-edit"></span>
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
        </div>
    </div>
    <script>
        var UavatarSrc = document.getElementById('img-pinfo').src;
        var Bimage = '';
        var tmpAid = 0;
        /* ==================================================================
        * 个人信息 监听器
        * ================================================================== */
        
        // 基本信息 监听器
        $('a[href="#tab-personalInfo"]').click(function(){
            resetUavatarStatus();

            $('#submit-uinfo').attr("data-submit","uinfo");
            console.log($('#submit-uinfo').attr('data-submit'));
            $('.form-control').blur(function(){
                if(CheckPersonalInfo()){
                    $('#submit-uinfo').removeClass('disabled');
                }else{
                    $('#submit-uinfo').addClass('disabled');
                };
            });

            $('#submit-uinfo').addClass('disabled');
        });

        // 个人密码 监听器
        $('a[href="#tab-password"]').click(function(){
            resetUavatarStatus();

            $("#oldPassword").val("");
            $("#newPassword").val("");
            $("#newPasswordConfirm").val("");
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

        // 个人头像 监听器
        $('#uavatar').click(function(){
            $('a[href="#uinfo-wrap"]').click();
            $('a[href="#tab-password"]').parent('li').removeClass('active');
            $('a[href="#tab-personalInfo"]').parent('li').removeClass('active');
        });
        
        $('a[href="#tab-avatars"]').click(function(){
            $('#modify-avatar').hide();
            $('#reset-avatar').fadeIn();
            $('a[href="#tab-password"]').parent('li').removeClass('active');
            $('a[href="#tab-personalInfo"]').parent('li').removeClass('active');

            $('#submit-uinfo').attr("data-submit","avatar");
            console.log($('#submit-uinfo').attr('data-submit'));

            $('.lms-avatars').click(function(){
                $('#submit-uinfo').removeClass('disabled');
            });

            $('#lms-uavatar').click(function(){
                $('#submit-uinfo').addClass('disabled');
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
            }else if(status && (method === "avatar")){
                console.log(status + " | " + method);
                updateAvatar();
            }

        });
        
        //  默认监听个人信息
        $('a[href="#tab-personalInfo"]').click();
        $('#modify-avatar').fadeIn();
        $('#reset-avatar').fadeOut();
        
        function updateAvatar(){
            console.log('new avatar\'s id is' +  tmpAid);
            UavatarSrc = document.getElementById('img-pinfo').src;
            console.log('new avatar\'s src is' +  UavatarSrc);
            $('#lms-uavatar>img').attr('src', UavatarSrc);
            $('#uavatar').attr('src', UavatarSrc);
            $('#uavatar-small').attr('src', UavatarSrc);
            resetUavatarStatus(0);
        }
        
        function setAvatars(pos,size){
            var ele = document.getElementById('tab-avatars');
            var img = document.createElement('img'); 
            var oavatar = document.createElement('div');
            ele.innerHTML = '';
            
            
            
            for(var i=1; i<=pos[0]; i++){
                for(var k=1; k<=pos[1]; k++){
                    ele.appendChild(structureAvatar((i-1)*pos[1] +k));
                }
            }
            
            oavatar.id = 'lms-uavatar';  
            
            img.src = UavatarSrc;
            img.height = 96;
            img.width = 96;  
            img.addEventListener('click', function(){
                resetUavatarStatus(0);
            });
            
            oavatar.appendChild(img); 
            ele.appendChild(oavatar); 
        }
        
        function structureAvatar(aid){
            var ele = document.createElement('div');
            var img = document.createElement('img');
            
            ele.className = 'lms-avatars';      
            
            img.src = PATH + '/images/avatar/'+ aid + '.svg';
            img.height = 64;
            img.width = 64;
            
            img.addEventListener('click', function(){
                previewAvatar(PATH + '/images/avatar/' + aid + '.svg');
                tmpAid = aid;
            });
            
            ele.appendChild(img);
            
            return ele;
        }
        
        function previewAvatar(src){
            document.getElementById('img-pinfo').src = src;
        }
        
        
        function resetUavatarStatus(sign){
            document.getElementById('img-pinfo').src = UavatarSrc;
            
            if(sign===undefined){
                $('#reset-avatar').hide();
                $('#modify-avatar').fadeIn();
            }
        }
        
        function setAvatar(src){
            $('#uavatar').attr('src', src);
            $('#uavatar-small').attr('src', src);
            $('#lms-uavatar>img').attr('src', src);
            $('#img-pinfo').attr('src', src);
        }
        
        function setDefaultAvatar(){
            var sex = getSex()===true?'male':'female';
            UavatarSrc = PATH + '/images/avatar/' + sex + '.svg';
            $('#uavatar').attr('src', UavatarSrc);
            $('#uavatar-small').attr('src', UavatarSrc);
            $('#lms-uavatar>img').attr('src', UavatarSrc);
            resetUavatarStatus();
        }
        
        function getSex(){
            return StudentAPI.sex;
        }
    </script>

</sec:authorize>