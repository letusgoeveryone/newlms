<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>

<!DOCTYPE html>
<html>
    <head>
        <title>注册</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/cupertino/easyui.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/lms.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/jquery-ui.min.css">

        <script  src="<%=path%>/js/easyui/jquery.min.js"></script>
        <script  src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>


        <style>
            html,body{
                font: 62.5% "Trebuchet MS", sans-serif;

                text-align:center;
            }
            .required,.flag{
                color: #ff0000;
            }
            .tdLabel{
                text-align: right;
            }
            .data{
                text-align: left;
            }

        </style>



    </head>
    <body>

        <div class="center" id="step1">


            <fieldset class="ui-widget ui-widget-content ui-corner-all center">


                <legend class="ui-widget ui-widget-header ui-corner-all flag " style="text-align:center">请正确填写信息，*部分为必填项</legend>
                <form id="registerForm1" name="registerForm" action="#" method="post" class="cmxform center">
                    <table class="cmxform center">
                        <tr>
                            <td class="tdLabel"><label for="sno" class="label"><span class="required">*</span>工号:</label></td>
                            <td
                                ><input type="text" name="sno" value="" id="sno" class="ui-widget-content easyui-validatebox" data-options="required:true,validType:'number',missingMessage:'请输入数字'"/></td>
                        </tr>


                        <tr>
                            <td class="tdLabel"><label for="name" class="label"><span class="required">*</span>姓名:</label></td>
                            <td
                                ><input type="text" name="name" value="" id="name" class="ui-widget-content  easyui-validatebox " data-options="required:true,validType:['minLength[2]','stl_name'],missingMessage:'请输入至少两个文字'"/></td>
                        </tr>



                        <tr>
                            <td class="tdLabel"><label for="idcard" class="label"><span class="required">*</span>身份证号:</label></td>
                            <td
                                ><input type="text" name="idcard" value="" id="idcard" class="ui-widget-content  easyui-validatebox" data-options="required:true,validType:'IdCard',missingMessage:'请输入正确格式的身份证号码'"/></td>
                        </tr>


                        <tr>
                            <td class="tdLabel"><label for="pwd" class="label"><span class="required">*</span>密码:</label></td>
                            <td
                                ><input type="password" name="pwd" value="" id="pwd" class="ui-widget-content  easyui-validatebox" data-options="required:true,validType:'minLength[6]',missingMessage:'请输入密码，长度不少于6位'"/></td>
                        </tr>


                        <tr>
                            <td  class="tdLabel" rowspan="3">请选择院系：</td>
                        </tr>
                        <tr>
                            <td class="data" ><label for="college">&nbsp;&nbsp;院：</label>
                                <select id="college" name="college"   class="ui-widget-content" required="required">
                                    <option value="0"  selected> 请选择学院 </option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="data">
                                <label for="department">&nbsp;&nbsp;系：</label>
                                <select id="department" name="department" class="ui-widget-content" required="required">
                                    <option value="0"  selected> 请选择系 </option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="tdLabel"><label for="registerForm_sex" class="label">性別:</label></td>
                            <td
                                ><input type="radio" name="sex" id="registerForm_sex男" checked="checked" value="男" class="ui-widget-content" class="ui-widget-content"/><label for="registerForm_sex男" class="ui-widget-content">男&nbsp;</label>
                                <input type="radio" name="sex" id="registerForm_sex女" value="女" class="ui-widget-content" class="ui-widget-content"/><label for="registerForm_sex女" class="ui-widget-content">女</label>
                            </td>
                        </tr>



                        <tr>
                            <td class="tdLabel"><label for="position" class="label">职称:</label></td>
                            <td
                                ><select name="position" id="position" class="ui-widget-content">
                                    <option value="0">助教</option>
                                    <option value="1">讲师</option>
                                    <option value="2">副教授</option>
                                    <option value="3">教授</option>


                                </select>

                            </td>
                        </tr>


                        <tr>
                            <td class="tdLabel"><label for="birthday" class="label">生日:</label></td>
                            <td
                                ><input type="date" name="birthday" value="1980-01-01" id="birthday" class="ui-widget-content"/></td>
                        </tr>



                        <tr>
                            <td class="tdLabel"><label for="mobile" class="label">手机号:</label></td>
                            <td
                                ><input type="tel" name="mobile" value="" id="mobile" class="ui-widget-content easyui-validatebox" data-options="validType:'mobile'"/></td>
                        </tr>


                        <tr>
                            <td class="tdLabel"><label for="qq" class="label">QQ:</label></td>
                            <td
                                ><input type="text" name="qq" value="" id="qq" class="ui-widget-content easyui-validatebox" data-options="validType:'QQ'"/></td>
                        </tr>


                        <tr>
                            <td class="tdLabel"><label for="email" class="label">E-Mail:</label></td>
                            <td
                                ><input type="text" name="email" value="" id="email" class="ui-widget-content easyui-validatebox" data-options="validType:'email',invalidMessage:'请输入正确邮箱'"/></td>
                        </tr>




                        <tr>
                            <td colspan="2">   
                                <p style="text-align:center">
                                    <input type="submit" id="next" value="下一步"/>

                                    <input type="reset" value="重置"/>

                                    <input type="button" name="" value="取消" id="cancel"/>
                                </p>
                            </td>
                        </tr>
                    </table></form>
            </fieldset>
        </div>

        <div class="center" id="step2">
            <fieldset class="ui-widget ui-widget-content ui-corner-all center">


                <legend class="ui-widget ui-widget-header ui-corner-all flag" style="text-align:center">请再次填写重要信息，以保证您的信息的正确</legend>
                <form id="registerForm2" name="signupForm" action="signup_teacher_2.jsp" method="post" class="cmxform center" >
                    <table class="cmxform center" >

                        <tr>
                            <td class="tdLabel"><label for="sno" class="label"><span class="required">*</span>工号:</label></td>
                            <td
                                ><input type="text" name="sno" value="" id="sno2" class="ui-widget-content easyui-validatebox" data-options="required:true,validType:'tch_sno',missingMessage:'请输入与前页相同的工号数字'"/></td>
                        </tr>


                        <tr>
                            <td class="tdLabel"><label for="name" class="label"><span class="required">*</span>姓名:</label></td>
                            <td
                                ><input type="text" name="name" value="" id="name2" class="ui-widget-content  easyui-validatebox " data-options="required:true,validType:'chk_name',missingMessage:'请输入与前页相同的姓名'"/></td>
                        </tr>


                        <tr>
                            <td class="tdLabel"><label for="idcard" class="label"><span class="required">*</span>身份证号:</label></td>
                            <td
                                ><input type="text" name="idcard" value="" id="idcard2" class="ui-widget-content  easyui-validatebox" data-options="required:true,validType:'chk_idcard',missingMessage:'请输入与前页相同的身份证号码'"/></td>
                        </tr>


                        <tr>
                            <td class="tdLabel"><label for="pwd" class="label"><span class="required">*</span>密码:</label></td>
                            <td
                                ><input type="password" name="pwd" value="" id="pwd2" class="ui-widget-content  easyui-validatebox" data-options="required:true,validType:'chk_pwd',missingMessage:'请输入与前页相同的密码'"/></td>
                        </tr>


                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>

                        </tr>
                        <tr>
                            <td class="tdLabel">验证码：</td>
                            <td class="content">
                                <input id="ccd" name="ccd" class="ui-widget-content easyui-validatebox" type="text" maxlength="4"  
                                       data-options="required:true,validType:'chk_code',missingMessage:'请输入验证码',tipPosition:'left' "
                                       title="验证码不区分大小写，看不清楚请单击图片" >
                                <img id="ccdImage" style="border:0"  title="看不清楚请单击图片" >
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <hr>
                            </td>

                        </tr>
                        <tr>
                            <td colspan="2">   
                                <p style="text-align:center">
                                    <input type="button" name="" value="上一步" id="previous"/>
                                    <input type="submit" id="next" value="下一步"/>

                                    <input type="reset" value="重置"/>

                                    <input type="button" name="" value="取消" id="cancel2"/>
                                </p>
                            </td>
                        </tr>
                    </table>
                </form>
            </fieldset>
        </div>

        <script src='<%=path%>/js/validate.js'></script>
        <script>
            $(function () {
//                $('#registerForm').submit(function(){
//                    $("#registerInfo").load("<%=path%>/reg/register_Teacher_step2"); 
//                    return false;
//                });
                $('#step2').hide();
                $('#cancel').click(function () {
                    location.href = '<%=path%>/index';
                });

                $('#registerForm1').form({
                    //url: '<%=path%>/reg/register_Teacher_step2',
                    onSubmit: function () {
                        return $(this).form('validate');
                    },
                    success: function (data) {
//                        $("#registerForm").submit();
                        // $("#registerInfo").load("<%=path%>/reg/register_Teacher_step2");
                        $('#step1').hide();
                        $('#step2').show();
                        $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random());

                    }
                });

                $('#previous').click(function () {
                    //$("#registerInfo").load("<%=path%>/reg/register_Teacher_step1");
                    $('#step2').hide();
                    $('#step1').show();
                });
                $('#cancel2').click(function () {
                    location.href = '<%=path%>/index';
                });
                $('#ccdImage').click(function () {
                    $('#ccdImage').attr("src", "<%=path%>/reg/createImage?dt=" + Math.random());

                });
                $('#registerForm2').form({
                    //url: '<%=path%>/reg/registerOK',
                    onSubmit: function () {
                        return $(this).form('validate');
                    },
                    success: function (data) {
//                        $("#registerInfo").submit();
                        $("#registerInfo").load("<%=path%>/reg/registerOK");
//                        $("#registerInfo").submit();
                    }
                });

            });
        </script>
    </body>
</html>
