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
        <title></title>
    </head>
    <body>
       <div class="container ">
         <div  id='xs_ls_xy' style="padding:5px;height:auto">
                From: <input class="easyui-textbox" style="width:80px" id="min_ls_stu">
                To: <input class="easyui-textbox" style="width:80px" id = "max_ls_stu">
                <a  class="easyui-linkbutton" iconCls="icon-search" onclick="xh_lsxs_search()">Search</a>  
         </div>
      
        <table id="dg_stu" title="临时学生信息" style="width:800px;height:auto"
               data-options="rownumbers:true,singleSelect:false,pagination:true,fitColumns:true,toolbar:'#xs_ls_xy',method:'get'">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'studentSn',width:110,align:'left'">学号</th>
                    <th data-options="field:'studentName',width:60,align:'left'">姓名</th>
                    <th data-options="field:'studentSex',width:50,align:'left',formatter:ls_xs_sex">性别</th>
                    <th data-options="field:'studentIdcard',width:160,align:'left'">身份证号</th>
                    <th data-options="field:'studentCollege',width:200,align:'left'">学院</th>
                    <th data-options="field:'studentTel',width:100,align:'left'">手机号</th>
                    <th data-options="field:'studentGrade',width:70,align:'left'">年级</th>
                    <th data-options="field:'studentTel',width:100,align:'left'">手机号</th>
                    <th data-options="field:'studentQq',width:100,align:'left'">qq</th>
                    <th data-options="field:'studentId',hidden:'true',width:30,align:'left'" >序号</th>
                    <th width="100" data-options="field:'aa',formatter:go_ls_xs_by">操作</th>
                </tr>
            </thead>
        </table>
        <a  class="easyui-linkbutton" onclick="pzxs()">批准选中的学生</a>
        <a  class="easyui-linkbutton" onclick="scxs()">删除选中的学生</a>
       </div>
     
        <script type="text/javascript">
            function ls_xs_sex(val,row){     
                 if(row.studentSex){
                    return '<span> 男</span>';
                 }else{
                    return '<span> 女</span>';   
                 } 
            }
            function go_ls_xs_by(val, row){
                  return '<a href="#" onclick="sc_ls_xs_by(\'' + row.studentId+ '\')">删除</a> ' +'<a href="#" onclick="pz_ls_xs_by(\'' + row.studentId+ '\')">批准</a>  ';    
            }
            function pz_ls_xs_by(studentId){
                 var jssz = new Array();
                 var jssz = [];
                 jssz[0]=studentId;
                  $.ajax({
                    type: "post",
                    url: "teacher/pzstu", 
                    data: {jssz: jssz}, 
                    success: function (data) {
                       alert("批准成功");
                       xh_lsxs_search();
                    },
                    error:function(){
                      alert("正式学生表已经存在此学号，批准失败！");
                    }
                });
                
            }
            function sc_ls_xs_by(studentId){
                 var jssz = new Array();
                 var jssz = [];
                 jssz[0]=studentId;
                 $.ajax({
                    type: "post", //提交方式
                    url: "teacher/scstu", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("删除成功");
                        xh_lsxs_search();
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
              
              
                //批量批学生信息 
                function pzxs(){
                    var rows = $('#dg_stu').datagrid('getChecked');
                    var jssz = new Array();
                    var jssz = [];
                    for (var n = 0; n <  rows.length; n++) {                 
                    jssz[n] = rows[n].studentId;

                }
                    $.ajax({
                        type: "post", 
                        url: "teacher/pzstu", 
                        data: {jssz: jssz}, 
                        success: function (data) {
                            alert("批准成功");
                            xh_lsxs_search();
                        },
                         error:function(){
                           alert("失败，已经存在！");
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
                        type: "post", 
                        url: "teacher/scstu", 
                        data: {jssz: jssz}, 
                        success: function (data) {
                            xh_lsxs_search();
                            alert("删除成功");
                        },
                        error:function(){
                            alert("未选择，请重新选择！");
                        }
                    });   
                }
            function xh_lsxs_search(){
                var min_sn =$('#min_ls_stu').val();
                var max_sn =  $('#max_ls_stu').val();
                if(min_sn>max_sn||min_sn.length<0||max_sn.length>12){
                    alert("学号范围输入错误！");
                    return false;
                }
                $('#dg_stu').datagrid({
                    url: 'teacher/ls_xs_search?min=' +  min_sn + "&max=" +max_sn,
                    loadMsg: '加载中请稍后……'
                });  
            }
                            
           
        </script>
    </body>
</html>