<%-- 
    Document   : index
    Created on : 2014-7-31, 13:51:43
    Author     : wht
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>   
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>--%>  
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>--%> 
<%String path = request.getContextPath();
    System.out.println(path);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>河南大学软件学院教务教学系统</title>
        <!-- 引入 Bootstrap -->
        <link href="<%=path%>/css/bootstrap.min.css" rel="stylesheet">

        <!-- HTML5 Shim 和 Respond.js 用于让 IE8 支持 HTML5元素和媒体查询 -->
        <!-- 注意： 如果通过 file://  引入 Respond.js 文件，则该文件无法起效果 -->
        <!--[if lt IE 9]>
           <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
           <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->

        <link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/cupertino/easyui.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/js/easyui/themes/icon.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/lms.css"/>

        <script  src="<%=path%>/js/easyui/jquery.min.js"></script>
        <script  src="<%=path%>/js/easyui/jquery.easyui.min.js"></script>
        <script src="<%=path%>/js/bootstrap.min.js"></script>

        <script>
            $(function () {
                $(window).resize(function () {
                    //alert(10);
                    $("#inlogin").panel().doLayout();
                });
            });
        </script>
    </head>
    <!--easyui-layout的布局为东南西北中的布局方式-->
    <body class="easyui-layout">
        <!--头部放在北部-->
        <div id="header" data-options="region:'north'" ></div>

        <!--主要内容放在中部-->
        <div  data-options="region:'center'" style="padding:4%">

            <div class="container" style="min-width: 580px;min-height:200px">
                <div class="row">
                    <div  class="col-md-6 col-xs-6" >
                        <img src="<%=path%>/images/welcome.png" style="display:table-cell;vertical-align:middle;width:100%;min-height: 100%"/>
                    </div>
                    <div  class="col-md-4  col-md-offset-1 col-xs-4 col-xs-offset-1" >
                        <div style="margin-bottom:20px"></div>
                        <div id="inlogin" class="easyui-panel " title="登录">
                            <div style="margin-bottom:20px">
                                <%--<s:set var="role" value="#{'teacher':'教工','student':'学生'}" />--%>
                                <!--radio的value设置radio的默认选择项，如果value的值为数值时，可以这样写如："1"，但是如果value的值为字符串，则必须在字符串的左右加上单引号，再加上双引号方可-->
                                <!--<s:radio name="role" list="" value="'student'" />-->
                                <input type="radio" name="role" id="roleteacher" value="teacher"/><label for="roleteacher">教工</label>
                                <input type="radio" name="role" id="rolestudent" checked="checked" value="student"/><label for="rolestudent">学生</label>
                            </div>
                            <div style="margin-bottom:10px">
                                <input type="text" name="" class="easyui-textbox" style="width:100%;height:25px;padding:5px" data-options="prompt:'学号/工号/身份证号/手机号',iconCls:'icon-man',iconWidth:30, iconAlign:'left'"/>
                                <!--<s:textfield cssClass="easyui-textbox" cssStyle="width:100%;height:25px;padding:5px" data-options="prompt:'学号/工号/身份证号/手机号',iconCls:'icon-man',iconWidth:30, iconAlign:'left'"  />-->
                            </div>
                            <div style="margin-bottom:20px">
                                <input type="password" name="" class="easyui-textbox" style="width:100%;height:25px;padding:5px" data-options="iconCls:'icon-lock',iconWidth:30, iconAlign:'left'"/>
                                <!--<s:textfield cssClass="easyui-textbox" type="password" cssStyle="width:100%;height:25px;padding:5px" data-options="iconCls:'icon-lock',iconWidth:30, iconAlign:'left'" />-->
                            </div>

                            <div>
                                <!--<s:a href="course/course_list.jsp" cssClass="easyui-linkbutton" data-options="iconCls:'icon-man1'" cssStyle="padding:5px 0px;width:40%;">-->
                                <a href="course/course_list.jsp" class="easyui-linkbutton" style="padding:5px 0px;width:40%;" data-options="iconCls:'icon-man1'">
                                    <span style="font-size:14px;">访客</span>
                                </a>
                                <!--</s:a>-->
                                <a href="#" class="easyui-linkbutton" style="padding:5px 0px;width:40%;" data-options="iconCls:'icon-ok'" >
                                    <!--<s:a href="#" cssClass="easyui-linkbutton" data-options="iconCls:'icon-ok'" cssStyle="padding:5px 0px;width:40%;">-->

                                    <span style="font-size:14px;">登录</span>
                                </a>
                                <!--</s:a>-->

                            </div>
                            <div style="margin-bottom:20px"></div>
                            <!--<s:a href="reg/register">注册</s:a>-->
                            <a href="reg/register">注册</a>

                        </div>
                    </div>

                    <!--</div>-->
                </div>
            </div>
            <div >
                <hr/>
            </div>

            <div id="copyright">&copy; 河南大学软件学院 版权所有</div>
        </div>


    </body>
</html>
