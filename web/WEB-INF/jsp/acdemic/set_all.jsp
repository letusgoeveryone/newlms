<%-- 
    Document   : test
    Created on : 2015-11-22, 19:35:47
    Author     : Administrator
    add buttons.css in 12.11
--%>
<%
//  将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!--        <link rel="stylesheet" href="<%=path%>/css/buttons.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/easyui.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/icon.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/demo.css">
        <script  type="text/javascript"  src="<%=path%>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/easyuijs/jquery.easyui.min.js"></script>-->

    <body style="text-align: left">
         <br> <br> <br>
        <a href="#" style="width: 220px"  onclick="xs_course_sz()" class="button button-glow button-rounded button-raised button-primary">安排下学期课程</a>
        <a href="#"  style="width: 230px " onclick="xs_bj_sz()" class="button button-glow button-border button-rounded button-primar">安排下学期开课班级</a>
        <a href="#" style="width: 220px"   class="button button-glow button-rounded button-highlight">安排下学期课程表</a>
        <br> <br> <br>
<!--//            add for add banji-->
        <div style="display: none" id="dg_add_bj_div">
            <div  id='xuehao_all' style="padding:5px;height:auto">
                <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="ckbj_test()">添加</a>      
            </div>
            <table id="dg_add_bj" style="width:515px;height:auto" class="easyui-datagrid" title="已添加班级信息" 
                   data-options="singleSelect:false,collapsible:true,method:'get',fitColumns:true,pagination:true,toolbar:'#xuehao_all'
                   ">
                <thead>
                    <tr>
                        <th data-options="field:'ck',checkbox:true"></th>
                        <th data-options="field:'classId',hidden:'true',width:50,align:'left'">班序号</th>
                        <th data-options="field:'classGrade',width:80,hidden:'true',align:'left',editor:'numberbox'">年级</th>
                        <th data-options="field:'className',width:290,editor:'textbox'">班级</th>
                    </tr>
                </thead>
            </table>
        </div>
<!--          add for add banji?-->

         <!--add for courese?-->
         <div style="display: none" id="dg_add_course_div">     
            <div  id='xuehao_curse' style="padding:5px;height:auto">
                <a href="#" class="easyui-linkbutton" iconCls="icon-add" onclick="ck_curse_test()">添加</a>      
            </div>
            <table id="dg_add_course" style="width:515px;height:auto" class="easyui-datagrid" title="已添加课程信息" 
                   data-options="singleSelect:false,collapsible:true,method:'get',fitColumns:true,pagination:true,toolbar:'#xuehao_curse'
                   ">
                <thead>
                   <tr>	
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'courseId',width:80,align:'right',hidden:true,editor:'numberbox'">编号</th>
                    <th data-options="field:'courseNumber',width:80,hidden:'true',align:'right',editor:'numberbox'">课程编号</th>
                    <th data-options="field:'courseName',width:80,align:'right',editor:'textbox'">课程名称</th>                                
                     <th data-options="field:'courseType',width:60,align:'center',editor:'textbox'">课程类型</th>
                    <th data-options="field:'faceTeacherHourse',width:80,align:'right',editor:'numberbox'">面授学时</th>
                    <th data-options="field:'testTeacherHourse',width:80,align:'right',editor:'numberbox'">实验学时</th>
                    <th data-options="field:'courseCredit',width:80,align:'right',editor:'numberbox'">课程学分</th>
                    <th data-options="field:'coursePrincipal',width:80,align:'right',editor:'textbox'">课程负责人</th> 
                   </tr>
                </thead>
            </table>
        </div>
         
         
            <!--add for courese?-->
        <script type="text/javascript">
//            add for add banji
            function xs_bj_sz() {
                $("#dg_add_bj_div").show();
                 $("#dg_add_course_div").hide();
                $('#dg_add_bj').datagrid({
                    url: 'ckbj_xx',
                    loadMsg: '数据加载中请稍后……'
                });
            }
            function ckbj_test(){
                 var rows = $('#dg_add_bj').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                for (var n = 0; n < rows.length; n++) {
                    jssz[n] = rows[n].classId;
                  //  alert(jssz[n]);
                }
                
            }
//            add for add banji   
           function xs_course_sz(){
                $("#dg_add_bj_div").hide();
                $("#dg_add_course_div").show();
                $('#dg_add_course').datagrid({
                    url: 'course_fanhui',
                    loadMsg: '课程数据加载中请稍后……'
                });
               
           }
//add for add course
           function ck_curse_test(){
               var rows = $('#dg_add_course').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                for (var n = 0; n < rows.length; n++) {
                    jssz[n] = rows[n].courseId;
                 //   alert(jssz[n]);
                }              
           }

        </script>
    </body>
</html>
