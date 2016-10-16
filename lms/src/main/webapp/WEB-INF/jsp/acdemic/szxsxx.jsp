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
             选择学院:<select  id="xs_xs_xy" class="selectpicker" style="width: 100px"></select>
             选择年级:<select  id="xs_xs_xy_3" class="zs_xs_nj1" style="width: 100px"></select>
                From: <input class="easyui-textbox" style="width:80px" id="min_ls_stu">
                To: <input class="easyui-textbox" style="width:80px" id = "max_ls_stu">
                <a  class="easyui-linkbutton" iconCls="icon-search" onclick="xh_lsxs_search()">Search</a>  
         </div>
      
        <table id="dg_stu" title="临时学生信息" style="width:1000px;height:auto"
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

        <a  onclick="go_ls_stu()">go</a> <input type="text" id="go_ls_xs" style="width: 50px">
        <a class="easyui-linkbutton" onclick="getSelected()_xs">查看选中的信息</a>
        <a class="easyui-linkbutton" onclick="getSelections()_xs">查看选中的多个信息</a>
        <a class="easyui-linkbutton" onclick="sj_stu()">加载所有学院学生信息</a>
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
                    type: "post", //提交方式
                    url: "acdemic/pzstu", //提交的页面，方法名
                    data: {jssz: jssz}, //参数，如果没有，可以为null
                    success: function (data) {
                       alert("批准成功");
                       $('#dg_stu').datagrid('reload'); // 重新载入当前页面数据  
                       go_ls_stu();
                    },
                    error:function(){
                      alert("正師学生表已經存在此学號，批准失敗！");
                    }
                });
                
            }
            function sc_ls_xs_by(studentId){
                 var jssz = new Array();
                 var jssz = [];
                 jssz[0]=studentId;
                  $.ajax({
                    type: "post", //提交方式
                    url: "acdemic/scstu", //提交的页面，方法名
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
               function newlsxs(){
                   sj_stu();
               }
                function sj_stu() {
                    $('#dg_stu').datagrid({
                    url: 'acdemic/fhstume',
                            loadMsg:'临时学生数据加载中请稍后……'
                      });
                      looktempstu();
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
                        url: "acdemic/pzstu", //提交的页面，方法名
                        data: {jssz: jssz}, //参数，如果没有，可以为null
                        success: function (data) {
                        alert("批准成功");
                        sj_stu();// 重新载入当前页面数据  
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
                        type: "post", //提交方式
                        url: "acdemic/scstu", //提交的页面，方法名
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
            function xh_lsxs_search(){
              //alert( $('#min_ls_stu').val()+"="+ $('#max_ls_stu').val())
                $('#dg_stu').datagrid({
                    url: 'acdemic/ls_xs_search?min=' + $('#min_ls_stu').val() + "&max=" + $('#max_ls_stu').val(),
                    loadMsg: '加载中请稍后……'
                });  
            }

            function go_ls_stu(){
                $('#dg_stu').datagrid('options').pageNumber=$('#go_ls_xs').val();
                $('#dg_stu').datagrid({
                url: 'acdemic/fhstume',
                loadMsg:'临时学生数据加载中请稍后……'
                }); 
            }
            
            $(function () {
                        $.ajax({
                            type: "get", //提交方式
                            url: "reg/hq_xy", //提交的页面，方法名
                            success: function (data) {
                                document.getElementById("xs_xs_xy").options.length = 0;
                                for (var i = 0; i < data.length; i++) {
                                    document.getElementById("xs_xs_xy").options.add(new Option(data[i], data[i]));
                                }
                            },
                            error: function () {
                                alert("error!！");
                            }
                        });
                        $.ajax({
                              type: "get", //提交方式
                              url: "reg/fhnj", //提交的页面，方法名
                              success: function (data) {
                                  document.getElementById("xs_xs_xy_3").options.length = 0;
                                  for (var i = 0; i < data.length; i++) {
                                      document.getElementById("xs_xs_xy_3").options.add(new Option(data[i], data[i]));
                                  }
                              },
                              error: function () {
                                  alert("error!！");
                              }
                          });
                    });
                    
             $(function(){
                $('.selectpicker').change(function(){
                   $('#dg_stu').datagrid({
                    url: 'acdemic/ls_xs_xy_ni__search?xueyuan=' + document.getElementById("xs_xs_xy").value + "&nianji=" + document.getElementById("xs_xs_xy_3").value,
                  });    
                });
                $('.zs_xs_nj1').change(function(){
                   $('#dg_stu').datagrid({
                    url: 'acdemic/ls_xs_xy_ni__search?xueyuan=' +  document.getElementById("xs_xs_xy").value + "&nianji=" + document.getElementById("xs_xs_xy_3").value, 
                    loadMsg: '加载中请稍后……'
                  });   
                });
             });
             function looktempstu(){
                   $.ajax({
                            type: "get", //提交方式
                            url: "reg/hq_xy", //提交的页面，方法名
                            success: function (data) {
                                document.getElementById("xs_xs_xy").options.length = 0;
                                for (var i = 0; i < data.length; i++) {
                                    document.getElementById("xs_xs_xy").options.add(new Option(data[i], data[i]));
                                }
                            },
                            error: function () {
                                alert("error!！");
                            }
                        });
                        $.ajax({
                              type: "get", //提交方式
                              url: "reg/fhnj", //提交的页面，方法名
                              success: function (data) {
                                  document.getElementById("xs_xs_xy_3").options.length = 0;
                                  for (var i = 0; i < data.length; i++) {
                                      document.getElementById("xs_xs_xy_3").options.add(new Option(data[i], data[i]));
                                  }
                              },
                              error: function () {
                                  alert("error!！");
                              }
                          });
                  $("#min_ls_stu").textbox('setValue','');
                  $("#max_ls_stu").textbox('setValue','');
             }
        </script>
    </body>
</html>