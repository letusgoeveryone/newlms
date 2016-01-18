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
<!--        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/easyui.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/icon.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/demo.css">
        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/easyuijs/jquery.easyui.min.js"></script>-->
    </head>
    <body>
        <h2>设置班级</h2>
        <p>查看说明进行添加，删除.</p>
        <div style="margin:20px 0;"></div>
        <table id="dg1" class="easyui-datagrid" title="已添加班级信息" style="width:515px;height:auto"
               data-options="
               iconCls: 'icon-edit',
               singleSelect: false,
               toolbar: '#tb',
               method: 'get',
               pagination:true,
               rownumbers:true,
               fitColumns:true,
               onClickRow: onClickRow
               ">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'classId',hidden:'true',width:50,align:'left'">班序号</th>
                    <th data-options="field:'classGrade',width:80,align:'left',editor:'numberbox'">年级</th>
                    <th data-options="field:'className',width:290,editor:'textbox'">班级</th>
                </tr>
            </thead>
        </table>

        <div id="tb" style="height:auto">
          
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="ckbjxx()">查看班级</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit()">批量删除</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true" onclick="getChanges()">查看更改</a>
           
        </div>

        <br>
             <form action="tjbj" method="post" name="tibjle"> 
                    <th><input type="text"  name="tjnj" id="tjnj"  placeholder="添加年级/例如2014" ></th> 
                    <th><input type="text"  name="tjbj" id="tjbj" placeholder="添加班级/例如软工1班"></th>
                    <th> <a type="button" onclick="accept()" >添加班级</a><br>  </th>
                </form>
        <script type="text/javascript">

            var editIndex = undefined;

            function endEditing() {
                if (editIndex === undefined) {
                    return true;
                }

                if ($('#dg1').datagrid('validateRow', editIndex)) {
                    var ed = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'classGrade'});
                    var ed1 = $('#dg1').datagrid('getEditor', {index: editIndex, field: 'className'});
                    var productname = $(ed.target).combobox('getText');//年级
                    var productname1 = $(ed1.target).combobox('getText');//班级
                    document.getElementById("tjnj").value = productname;
                    document.getElementById("tjbj").value = productname1;
                    alert(document.getElementById("tjbj").value);
                    $('#dg1').datagrid('getRows')[editIndex]['productname'] = productname;
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
            function append() {
                if (endEditing()) {
                    $('#dg1').datagrid('appendRow', {status: 'P'});
                    editIndex = $('#dg1').datagrid('getRows').length - 1;
                    $('#dg1').datagrid('selectRow', editIndex)
                            .datagrid('beginEdit', editIndex);
                }
            }
            //批量删除班级
            function removeit() {
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
            function accept() {
                if (confirm("你确定添加班级吗？？")) {
                    tibj();
                }
                if (endEditing()) {
                    $('#dg1').datagrid('acceptChanges');
                    return true;
                }

            }
            function getChanges() {
                var rows = $('#dg1').datagrid('getChanges');
                alert(rows.length + ' rows are changed!');
            }

            function ckbjxx() {
                $('#dg1').datagrid({
                    url: 'ckbj_xx',
                    loadMsg: '班级数据加载中请稍后……'
                });
            }
            function tibj() {
                var jssz = new Array();
                var jssz = [];
                jssz[0] = document.getElementById("tjnj").value;
                jssz[1] = document.getElementById("tjbj").value;
                document.getElementById("tjnj").value = "";
                document.getElementById("tjbj").value = "";
                //alert(jssz[0]);
                //alert(jssz[1]);
                $.ajax({
                    type: "post", //提交方式
                    url: "tjbj", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("添加成功");
                        ckbjxx();// 重新载入当前页面数据  
                    },
                    error: function () {
                        alert("请输入班级，再进行添加！");
                    }
                });
            }
        </script>
    </body>
</html>