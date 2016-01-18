<%-- 
    Document   : tibj
    Created on : 2015-11-28, 14:22:45
    Author     : Administrator
--%>
<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Row Editing in DataGrid - jQuery EasyUI Demo</title>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/easyui.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/icon.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/demo.css">
        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/easyuijs/jquery.easyui.min.js"></script>
    </head>
    <body>
        <h2>设置课程</h2>
        <p>查看说明进行添加，删除.</p>
        <div style="margin:20px 0;"></div>
        <table id="dg1" class="easyui-datagrid" title="已添加课程信息" style="width:700px;height:auto"
               data-options="
               iconCls: 'icon-edit',
               singleSelect: true,
               toolbar: '#tb',
               method: 'get',
               pagination:true,
               rownumbers:true,
               onClickRow: onClickRow
               ">
            <thead>
                <tr>	
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'courseId',width:80,align:'right',hidden:true,editor:'numberbox'">编号</th>
                    <th data-options="field:'courseNumber',width:80,align:'right',editor:'numberbox'">课程编号</th>
                    <th data-options="field:'courseName',width:80,align:'right',editor:'textbox'">课程名称</th>
                    <th data-options="field:'courseEname',width:100,editor:'textbox'">英文名称</th>
                    <th data-options="field:'courseType',width:60,align:'center',editor:'textbox'">课程类型</th>
                    <th data-options="field:'faceTeacherHourse',width:80,align:'right',editor:'numberbox'">面授学时</th>
                    <th data-options="field:'testTeacherHourse',width:80,align:'right',editor:'numberbox'">实验学时</th>
                    <th data-options="field:'courseCredit',width:80,align:'right',editor:'numberbox'">课程学分</th>
                    <th data-options="field:'coursePrincipal',width:80,align:'right',editor:'textbox'">课程负责人</th>                                
                </tr>
            </thead>
        </table>

        <div id="tb" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="ckkcxx()">查看课程</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit_course()">批量删除</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges_course()">查看更改</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append_course()">添加</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept_course()">添加课程</a>	
        </div>
        <div style="margin:10px 0;">
            <span>Selection Mode: </span>
            <select onchange="$('#dg1').datagrid({singleSelect: (this.value === 0)})">
                <option value="0">单行</option>
                <option value="1">多行</option>
            </select><br/>
            SelectOnCheck: <input type="checkbox" checked onchange="$('#dg1').datagrid({selectOnCheck: $(this).is(':checked')})"><br/>
            CheckOnSelect: <input type="checkbox" checked onchange="$('#dg1').datagrid({checkOnSelect: $(this).is(':checked')})">
        </div>

        <script type="text/javascript">

            var editIndex = undefined;

            function endEditing() {
                if (editIndex === undefined) {
                    return true;
                }
                if ($('#dg1').datagrid('validateRow', editIndex)) {
                    $('#dg1').datagrid('endEdit', editIndex);
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            function onClickRow(index) {
                if (editIndex !== index) {
                    if (endEditing()) {
                        $('#dg1').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg1').datagrid('selectRow', editIndex);
                    }
                }
            }
            function append_course() {
                if (endEditing()) {
                    $('#dg1').datagrid('appendRow', {status: 'P'});
                    editIndex = $('#dg1').datagrid('getRows').length - 1;
                    $('#dg1').datagrid('selectRow', editIndex)
                            .datagrid('beginEdit', editIndex);
                }
            }
            //批量删除班级
            function removeit_course() {
                var rows = $('#dg1').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                for (var n = 0; n < rows.length; n++) {
                    jssz[n] = rows[n].classId;
                }
                $.ajax({
                    type: "post", //提交方式
                    url: "scbj", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("批准删除成功！");
                        ckbjxx();// 重新载入当前页面数据  
                    },
                    error: function () {
                        alert("请选择后再进行删除！");
                    }
                });
            }
            function accept_course() {
                if ($('#dg1').datagrid('validateRow', editIndex)) {
                    var ed0 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'courseNumber'});
                    var ed1 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'courseName'});
                    var ed2 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'courseEname'});
                    var ed3 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'courseType'});
                    var ed4 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'faceTeacherHourse'});
                    var ed5 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'testTeacherHourse'});
                    var ed6 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'courseCredit'});
                    var ed7 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'coursePrincipal'});
                    var jssz = new Array();
                    var jssz = [];
                    jssz[0] = $(ed0.target).combobox('getText');
                    jssz[1] = $(ed1.target).combobox('getText');
                    jssz[2] = $(ed2.target).combobox('getText');
                    jssz[3] = $(ed3.target).combobox('getText');
                    jssz[4] = $(ed4.target).combobox('getText');
                    jssz[5] = $(ed5.target).combobox('getText');
                    jssz[6] = $(ed6.target).combobox('getText');
                    jssz[7] = $(ed7.target).combobox('getText');
                    tijiakecheng(jssz);
                }
                if (endEditing()) {
                    $('#dg1').datagrid('acceptChanges');
                    return true;
                }

            }
            function getChanges_course() {
                var rows = $('#dg1').datagrid('getChanges');
                alert(rows.length + ' rows are changed!');
            }

            function ckkcxx() {
                $('#dg1').datagrid({
                    url: 'course_fanhui',
                    loadMsg: '课程数据加载中请稍后……'
                });
            }
            function tijiakecheng(jssz) {
                $.ajax({
                    type: "post", //提交方式
                    url: "course_add", //提交的页面，方法名
                    data: {jssz: jssz},
                    success: function (data) {
                        alert("sucess!");
                    },
                    error: function () {
                        alert("添加失败！");
                    }
                });
                $('#dg1').datagrid({
                    url: 'course_fanhui',
                    loadMsg: '课程数据加载中请稍后……'
                });
            }
            
              //批量删除curse
            function removeit_course() {
                var rows = $('#dg1').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                for (var n = 0; n <  rows.length; n++) {                 
                        jssz[n] = rows[n].courseId;              
                }
                 $.ajax({
                    type: "post", //提交方式
                    url: "sckc", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("批准删除成功！");
                        ckkcxx();// 重新载入当前页面数据  
                    },
                     error:function(){
                       alert("请选择后再进行删除！");
                     }
                });    
            }
        </script>
    </body>
</html>