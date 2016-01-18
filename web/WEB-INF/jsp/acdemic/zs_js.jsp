<%-- 
    Document   : easyuify
    Created on : 2015-11-26, 16:00:58
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Custom DataGrid Pager - jQuery EasyUI Demo</title>

    </head>
    <body>
        <h2>正式教师信息</h2>
        <p>你可以修改正式教师信息.</p>
        <!--//  <div style="margin:20px 0;"></div>-->
        <table id="dg_zs_tec" title="正式教师信息" style="width:700px;height:auto"
               data-options="rownumbers:true,singleSelect:false,pagination:true,fitColumns:true,method:'get'">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'teacherSn',width:90,align:'left'">工号</th>
                    <th data-options="field:'teacherName',width:60,align:'left'">姓名</th>
                    <th data-options="field:'teacherIdcard',width:150,align:'left'">身份证号</th>
                    <th data-options="field:'teacherCollege',width:150,align:'left'">学院</th>
                    <th data-options="field:'teacherPosition',width:40,align:'left'">职称</th>
                    <th data-options="field:'teacherTel',width:100,align:'left'">手机号</th>
                    <th data-options="field:'teacherId',hidden:'true',width:30,align:'left'" >序号</th>
                    <th width="80" data-options="field:'aa',formatter:go_by">操作</th>
                </tr>
            </thead>
        </table>

        <!--//add for 批量批准删除2015年11月26日 22:24:19-->
        <a href="#"  class="easyui-linkbutton" onclick="getSelected_zs_js()">查看选中的信息</a>
        <a href="#" class="easyui-linkbutton" onclick="getSelections_zs_js()">查看选中的多个信息</a>
        <a href="#" class="easyui-linkbutton" onclick="ck_zs_jsxx()">加载教师信息</a>
        <a href="#" class="easyui-linkbutton" onclick="sc_zs_js()">删除选中的教师</a>
        <a href="daochualltoxls" class="easyui-linkbutton">下载已批准的教师</a>
        <!--//add for 批量批准删除-->
        <script type="text/javascript">
             function  go_by(val, row) {
              return '<a href="#" onclick="sc_js_by(\'' + row.teacherId+ '\')">删除</a>  ';
            }
            
//各个功能添加，删除
            $(function () {
                var pager = $('#dg_zs_tec').datagrid().datagrid('getPager'); // get the pager of datagrid
                pager.pagination({
                    buttons: [{
                            iconCls: 'icon-search',
                            handler: function () {
                                alert('search');
                            }
                        }, {
                            iconCls: 'icon-add',
                            handler: function () {
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
            function getSelected_zs_js() {
                var row = $('#dg_zs_tec').datagrid('getSelected');
                if (row) {
                    $.messager.alert('Info', row.teacherSn + ":" + row.teacherName + ":" + row.teacherCollege);
                }
             }
            function getSelections_zs_js() {
                var ss = [];
                var rows = $('#dg_zs_tec').datagrid('getChecked');
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    ss.push('<span>' + row.teacherSn + ":" + row.teacherName + ":" + row.teacherCollege + '</span>');
                }
                $.messager.alert('Info', ss.join('<br/>'));
            }
//       <!--//add for 批量批准删除2015年11月26日 22:24:19-->
          //2015年11月27日 11:20:16 add for load teacher message
            function ck_zs_jsxx() {
                $('#dg_zs_tec').datagrid({
                    url: 'fh_zs_jsme',
                    loadMsg:'数据加载中请稍后……'
                });
            }
 
            //批量删除正式教师信息 
            function sc_zs_js(){
                var rows = $('#dg_zs_tec').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                for (var n = 0; n <  rows.length; n++) {                 
                        jssz[n] = rows[n].teacherId;
                }
                 $.ajax({
                    type: "post", //提交方式
                    url: "pzsc_zs_jsxx", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("删除成功");
                        ck_zs_jsxx();// 重新载入当前页面数据  
                    },
                     error:function(){
                      alert("未选择，请重新选择！");
                        }
                });   
                
            }
            
            function go_zs_tec(){
                 $('#dg_zs_tec').datagrid('options').pageNumber=$('#go_zs_tec').val();        
                $('#dg_zs_tec').datagrid({
                    url: 'fh_zs_jsme',
                    loadMsg:'数据加载中请稍后……'
                });
            }
            function sc_js_by(teacherId){
                var jssz = new Array();
                var jssz = [];
                jssz[0] = teacherId;
                 $.ajax({
                    type: "post", //提交方式
                    url: "pzsc_zs_jsxx", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("删除成功");
                        ck_zs_jsxx();// 重新载入当前页面数据  
                    },
                     error:function(){
                      alert("未选择，请重新选择！");
                        }
                });   
            }
            
            
        </script>
    </body>
</html>