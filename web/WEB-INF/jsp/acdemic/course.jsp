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
   
    </head>
    <body>
        <h2>设置课程</h2>
        <p>查看说明进行添加，删除.</p>
        <div style="margin:20px 0;"></div>
        <table id="dg_couse" class="easyui-datagrid" title="已添加课程信息" style="width:700px;height:auto"
               data-options="
               iconCls: 'icon-edit',
               singleSelect: false,
               toolbar: '#tb1',
               method: 'get',
               pagination:true,
               rownumbers:true,
               fitColumns:true,
               onClickRow: onClickRow
               ">
            <thead>
                <tr>	
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'courseId',width:80,align:'right',hidden:true,editor:'numberbox'">编号</th>
                    <th data-options="field:'courseNumber',width:80,align:'right',editor:'textbox'">课程编号</th>
                    <th data-options="field:'courseName',width:80,align:'right',editor:'textbox'">课程名称</th>
                    <th data-options="field:'courseEname',width:100,editor:'textbox'">英文名称</th>
                    <th data-options="field:'courseType',width:60,align:'left',editor:'textbox'">课程类型</th>
                    <th data-options="field:'faceTeacherHourse',width:80,align:'right',editor:'numberbox'">面授学时</th>
                    <th data-options="field:'testTeacherHourse',width:80,align:'right',editor:'numberbox'">实验学时</th>
                    <th data-options="field:'courseCredit',width:80,align:'right',editor:'numberbox'">课程学分</th>
                    <!--<th data-options="field:'coursePrincipal',width:80,align:'right',editor:'textbox'">课程负责人</th>-->                                
                </tr>
            </thead>
        </table>
            <br>
        <div id="tb1" style="height:auto">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="ckkcxx()">查看课程</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit_course()">批量删除</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges_course()">查看更改</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="append_course()">添加</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept_course()">添加课程</a>	
        </div>
        <script type="text/javascript">

            var editIndex = undefined;

            function endEditing() {
                if (editIndex === undefined) {
                    return true;
                }
                if ($('#dg_couse').datagrid('validateRow', editIndex)) {
                    $('#dg_couse').datagrid('endEdit', editIndex);
                    editIndex = undefined;
                    return true;
                } else {
                    return false;
                }
            }
            function onClickRow(index) {
                if (editIndex !== index) {
                    if (endEditing()) {
                        $('#dg_couse').datagrid('selectRow', index)
                                .datagrid('beginEdit', index);
                        editIndex = index;
                    } else {
                        $('#dg_couse').datagrid('selectRow', editIndex);
                    }
                }
            }
            function append_course() {
                if (endEditing()) {
                    $('#dg_couse').datagrid('appendRow', {status: 'P'});
                    editIndex = $('#dg_couse').datagrid('getRows').length - 1;
                    $('#dg_couse').datagrid('selectRow', editIndex)
                            .datagrid('beginEdit', editIndex);
                }
            }
            //批量删除班级
            function removeit_course() {
                var rows = $('#dg_couse').datagrid('getChecked');
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
                if ($('#dg_couse').datagrid('validateRow', editIndex)) {
                    var ed0 = $('#dg_couse').datagrid('getEditor', {index: editIndex, field: 'courseNumber'});
                    var ed1 = $('#dg_couse').datagrid('getEditor', {index: editIndex, field: 'courseName'});
                    var ed2 = $('#dg_couse').datagrid('getEditor', {index: editIndex, field: 'courseEname'});
                    var ed3 = $('#dg_couse').datagrid('getEditor', {index: editIndex, field: 'courseType'});
                    var ed4 = $('#dg_couse').datagrid('getEditor', {index: editIndex, field: 'faceTeacherHourse'});
                    var ed5 = $('#dg_couse').datagrid('getEditor', {index: editIndex, field: 'testTeacherHourse'});
                    var ed6 = $('#dg_couse').datagrid('getEditor', {index: editIndex, field: 'courseCredit'});
                    var jssz = new Array();
                    var jssz = [];
                    jssz[0] = $(ed0.target).combobox('getText');
                    jssz[1] = $(ed1.target).combobox('getText');
                    jssz[2] = $(ed2.target).combobox('getText');
                    jssz[3] = $(ed3.target).combobox('getText');
                    jssz[4] = $(ed4.target).combobox('getText');
                    jssz[5] = $(ed5.target).combobox('getText');
                    jssz[6] = $(ed6.target).combobox('getText');
                    tijiakecheng(jssz);
                }
                if (endEditing()) {
                    $('#dg_couse').datagrid('acceptChanges');
                    return true;
                }

            }
            function getChanges_course() {
                var rows = $('#dg_couse').datagrid('getChanges');
                alert(rows.length + ' rows are changed!');
            }

            function ckkcxx() {
                $('#dg_couse').datagrid({
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
                $('#dg_couse').datagrid({
                    url: 'course_fanhui',
                    loadMsg: '课程数据加载中请稍后……'
                });
            }
            
              //批量删除curse
            function removeit_course() {
                var rows = $('#dg_couse').datagrid('getChecked');
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