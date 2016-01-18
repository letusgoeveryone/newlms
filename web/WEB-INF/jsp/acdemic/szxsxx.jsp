<%-- 
    Document   : easyuify
    Created on : 2015-11-26, 16:00:58
    Author     : Administrator
--%>
<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Custom DataGrid Pager - jQuery EasyUI Demo</title>
<!--        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/easyui.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/icon.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/demo.css">
        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/easyuijs/jquery.easyui.min.js"></script>-->
    </head>
    <body>
        <h2>未批准的学生信息</h2>
        <p>你可以批准删除临时学生信息.</p>
      
        <table id="dg_stu" title="临时学生信息" style="width:700px;height:auto"
               data-options="rownumbers:true,singleSelect:true,pagination:true,fitColumns:true,method:'get'">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'studentSn',width:90,align:'left'">学号</th>
                    <th data-options="field:'studentName',width:60,align:'left'">姓名</th>
                    <th data-options="field:'studentIdcard',width:150,align:'left'">身份证号</th>
                    <th data-options="field:'studentCollege',width:200,align:'left'">学院</th>
                    <th data-options="field:'studentTel',width:100,align:'left'">手机号</th>
                    <th data-options="field:'studentId',hidden:'true',width:30,align:'left'" >序号</th>
                    <th width="80" data-options="field:'aa',formatter:go_ls_xs_by">操作</th>
                </tr>
            </thead>
        </table>
        <div style="margin:10px 0;">
            <span>Selection Mode: </span>
            <select onchange="$('#dg_stu').datagrid({singleSelect: (this.value === 0)})">
                <option value="0">单行</option>
                <option value="1">多行</option>
            </select>
            SelectOnCheck: <input type="checkbox" checked onchange="$('#dg_stu').datagrid({selectOnCheck: $(this).is(':checked')})">
            CheckOnSelect: <input type="checkbox" checked onchange="$('#dg_stu').datagrid({checkOnSelect: $(this).is(':checked')})">
        </div>
        <a href="#" onclick="go_ls_stu()">go</a> <input type="text" id="go_ls_xs" style="width: 50px">
        <!--//add for 批量批准删除2015年11月26日 22:24:19-->
        <a href="#" class="easyui-linkbutton" onclick="getSelected()_xs">查看选中的信息</a>
        <a href="#" class="easyui-linkbutton" onclick="getSelections()_xs">查看选中的多个信息</a>
        <a href="#" class="easyui-linkbutton" onclick="sj_stu()">加载学生信息</a>
        <a href="#" class="easyui-linkbutton" onclick="pzxs()">批准选中的学生</a>
        <a href="#" class="easyui-linkbutton" onclick="scxs()">删除选中的学生</a>
     
        <!--//add for 批量批准删除-->
        <script type="text/javascript">
            function go_ls_xs_by(val, row){
                  return '<a href="#" onclick="sc_ls_xs_by(\'' + row.studentId+ '\')">删除</a> ' +'<a href="#" onclick="pz_ls_xs_by(\'' + row.studentId+ '\')">批准</a>  ';    
            }
            function pz_ls_xs_by(studentId){
                 var jssz = new Array();
                 var jssz = [];
                 jssz[0]=studentId;
                  $.ajax({
                    type: "post", //提交方式
                    url: "pzstu", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                       alert("批准成功");
                       $('#dg_stu').datagrid('reload'); // 重新载入当前页面数据  
                       go_ls_stu();
                    },
                    error:function(){
                      alert("请重新刷新页面！");
                    }
                });
                
            }
            function sc_ls_xs_by(studentId){
                 var jssz = new Array();
                 var jssz = [];
                 jssz[0]=studentId;
                  $.ajax({
                    type: "post", //提交方式
                    url: "scstu", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("删除成功");
                        $('#dg_stu').datagrid('reload'); // 重新载入当前页面数据 
                    },
                    error:function(){
                        alert("请重新刷新页面！");
                    }
                 });   
                
            }
            
           //各个功能添加，删除
            $(function () {
               var pager = $('#dg_stu').datagrid().datagrid('getPager'); // get the pager of datagrid
                pager.pagination({
                buttons: [{iconCls: 'icon-search',
                handler: function () {
                    alert('search');
                        }     
                                
                     }, {
                                    iconCls: 'icon-add', handler: function () {
                                    alert('add');
                            }
                            }, {
                            iconCls: 'icon-edit', handler: function () {
                            alert('edit');
                            }
                            }]
                            });
                    });
                    //                    < !--//add for 批量批准删除2015年11月26日 22:24:19-- >
               function getSelected_xs() {
                    var row = $('#dg_stu').datagrid('getSelected');
                    if (row) {
                        $.messager.alert('Info', row.studentSn + ":" + row.studentName + ":" + row.studentCollege); }
                }
               function getSelections_xs() {
                     var ss = [];
                      var rows = $('#dg_stu').datagrid('getChecked');
                      for (var i = 0; i < rows.length; i++) {
                            var row = rows[i];
                            ss.push('<span>' + row.studentSn + ":" + row.studentName + ":" + row.studentCollege + '</span>');
                     }                     $.messager.alert('Info', ss.join('<br/>'));
               }
//       <!--//add for 批量批准删除2015年11月26日 22:24:19-->
//2015年11月27日 11:20:16 add for load teacher message
                function sj_stu() {
                $('#dg_stu').datagrid({
                url: 'fhstume',
                        loadMsg:'临时学生数据加载中请稍后……'
                  });
                }
//批量批学生信息 
    function pzxs(){
        var rows = $('#dg_stu').datagrid('getChecked');
        var jssz = new Array();
        var jssz = [];
        for (var n = 0; n <  rows.length; n++) {                 
        jssz[n] = rows[n].studentId;

    }
    $.ajax({
        type: "post", //提交方式
        url: "pzstu", //提交的页面，方法名
        data: {jssz: jssz}, //参数，如果没有，可以为null
        success: function (data) {
        alert("批准成功");
        sj_stu();// 重新载入当前页面数据  
        },
    error:function(){
        alert("未选择，请重新选择！");
        }
    });       
 }
//批量删除学生信息 
    function scxs(){
        var rows = $('#dg_stu').datagrid('getChecked');
        var jssz = new Array();
        var jssz = [];
        for (var n = 0; n <  rows.length; n++) {                 
             jssz[n] = rows[n].studentId;
        }
    $.ajax({
        type: "post", //提交方式
        url: "scstu", //提交的页面，方法名
        data: {jssz: jssz}, //参数，如果没有，可以为null
            success: function (data) {
            alert("删除成功");
            sj_stu();// 重新载入当前页面数据  
        },
        error:function(){
            alert("未选择，请重新选择！");
        }
    });   
    }

    function go_ls_stu(){
        $('#dg_stu').datagrid('options').pageNumber=$('#go_ls_xs').val();
        $('#dg_stu').datagrid({
        url: 'fhstume',
        loadMsg:'临时学生数据加载中请稍后……'
        }); 
    }
        </script>
    </body>
</html>