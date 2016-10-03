

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>正式学生</title>
    </head>
    <body>
        <div  class="container ">
         <div  id='xs_zs_xy' style="padding:5px;height:auto">
             选择学院:<select  id="xs_xs_xy_1" class="zs_xs" style="width: 100px"></select>
             选择年级:<select  id="xs_xs_xy_2" class="zs_xs_nj" style="width: 100px"></select>
              From: <input class="easyui-textbox" style="width:80px" id="min_stu">
                To: <input class="easyui-textbox" style="width:80px" id = "max_stu">
                <a  class="easyui-linkbutton" iconCls="icon-search" onclick="xh_search()">Search</a>   
         </div>
        <table id="dg_zs_stu" title="已批准学生信息"   style="width:1000px;height:auto"
               data-options="rownumbers:true,singleSelect:false,pagination:true,toolbar:'#xs_zs_xy',fitColumns:true,method:'get'">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'studentSn',width:90,align:'left'">学号</th>
                    <th data-options="field:'studentName',width:60,align:'left'">姓名</th>
                    <th data-options="field:'studentSex',width:50,align:'left',formatter:zs_xs_sex">性别</th>
                    <th data-options="field:'studentIdcard',width:150,align:'left'">身份证号</th>
                    <th data-options="field:'studentCollege',align:'left'">学院</th>
                    <th data-options="field:'studentGrade',width:70,align:'left'">年级</th>
                    <th data-options="field:'studentTel',width:100,align:'left'">手机号</th>
                    <th data-options="field:'studentQq',width:100,align:'left'">qq</th>
                    <th data-options="field:'studentId',hidden:'true',width:30,align:'left'" >序号</th>
                    <th width="80" data-options="field:'aa',formatter:go_xs_by">操作</th>
                </tr>
            </thead>
        </table>    
        <br>
        <a  onclick="go_zs_stu()">go</a> <input type="text" id="go" style="width: 50px">
        <a class="easyui-linkbutton" onclick="getSelected_zs_xs()">查看选中的信息</a>
        <a  class="easyui-linkbutton" onclick="getSelections_zs_xs()">查看选中的多个信息</a>
        <a  class="easyui-linkbutton" onclick="sj_zs_stu()">加载所有学院学生信息</a>
        <a  class="easyui-linkbutton" onclick="sc_zs_xs()">删除选中的学生</a>
        <a href="acdemic/daochuxuesheng?a=正式学生信息" class="easyui-linkbutton" >下载学生信息</a>
        
    </div>
        <script type="text/javascript">
            function zs_xs_sex(val,row){     
                 if(row.studentSex){
                    return '<span> 男</span>';
                 }else{
                    return '<span> 女</span>';   
                 } 
            }
            function go_xs_by(val, row){
                 return '<a href="#" onclick="sc_xs_by(\'' + row.studentId+ '\')">删除</a>  ';  
            }
            function sc_xs_by(studentId){
                var jssz = new Array();
                var jssz = [];
                jssz[0] = studentId;
                $.ajax({
                    type: "post", 
                    url: "acdemic/sc_zs_xs", 
                    data: {jssz: jssz}, 
                    success: function (data){
                        if(data==="1"){
                           alert("删除正式表学生出错，已经存在依赖关系!"); 
                        }else{
                           alert("删除成功");  
                        }
                      $('#dg_zs_stu').datagrid('reload'); 
                    },
                    error: function () {
                       alert("未选择，请重新选择！");
                    }
                });  
            }
        $(function () {
            var pager = $('#dg_zs_stu').datagrid().datagrid('getPager'); 
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
                            }]                         });
                        });
            function getSelected_zs_xs() {
               var row = $('#dg_zs_stu').datagrid('getSelected');
                   if (row) {
                    $.messager.alert('Info', row.studentSn + ":" + row.studentName + ":" + row.studentCollege);
                   }  
            }
            function getSelections_zs_xs() {                        
                var ss = [];
                var rows = $('#dg_zs_stu').datagrid('getChecked');
                 for (var i = 0; i < rows.length; i++) {
                        var row = rows[i];
                        ss.push('<span>' + row.studentSn + ":" + row.studentName + ":" + row.studentCollege + '</span>');
                     }
                     $.messager.alert('Info', ss.join('<br/>'));
                  }
        function newzsxs(){
            sj_zs_stu() ;
        }
        function sj_zs_stu() {
            $('#dg_zs_stu').datagrid({
                url: 'acdemic/fh_zs_stume',
                loadMsg: '数据加载中请稍后……'
            });
            looknew();
        }

        //批量删除学生信息 
        function sc_zs_xs() {
        var rows = $('#dg_zs_stu').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                for (var n = 0; n < rows.length; n++) {
                 jssz[n] = rows[n].studentId;
                }
                $.ajax({
                type: "post", 
                    url: "acdemic/sc_zs_xs",
                    data: {jssz: jssz},
                     success: function (data) {
                        if(data==="1"){
                           alert("删除正式表学生出错，已经存在依赖关系!"); 
                         }else{
                           alert("删除成功");  
                         }
                          $('#dg_zs_stu').datagrid('reload');
                     },
                    error: function () {
                    alert("未选择，请重新选择！");
                }
               });
        }

        function go_zs_stu(){
            $('#dg_zs_stu').datagrid('options').pageNumber=$('#go').val();
            $('#dg_zs_stu').datagrid({
            url: 'acdemic/fh_zs_stume',
            loadMsg:'数据加载中请稍后……'
            });

        }
 
        function removeit_xuehao() {
            var rows = $('#dg_zs_stu').datagrid('getChecked');
            var jssz = new Array();
            var jssz = [];
            for (var n = 0; n < rows.length; n++) {
               jssz[n] = rows[n].studentId;
            }
            $.ajax({
            type: "post", 
            url: "acdemic/sc_zs_xs", 
            data: {jssz: jssz}, 
            success: function (data) {
               if(data==="1"){
                      alert("删除正式表学生出错，已经存在依赖关系!"); 
                    }else{
                      alert("删除成功");  
                    }
                $('#dg_zs_stu').datagrid('reload');
            },
            error: function () {
               alert("未选择，请重新选择！");
               }
            });
        }
        function  xh_search() {
            $('#dg_zs_stu').datagrid({
              url: 'acdemic/xh_search?min=' + $('#min_stu').val() + "&max=" + $('#max_stu').val(),
              loadMsg: '加载中请稍后……'
            });
        }
        function search_zs_xs(){
             $("#student_search").show();
             
        }
           $(function () {
                        $.ajax({
                            type: "get",
                            url: "reg/hq_xy",
                            success: function (data) {
                                document.getElementById("xs_xs_xy_1").options.length = 0;
                                for (var i = 0; i < data.length; i++) {
                                 document.getElementById("xs_xs_xy_1").options.add(new Option(data[i], data[i]));
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
                                  document.getElementById("xs_xs_xy_2").options.length = 0;
                                  for (var i = 0; i < data.length; i++) {
                                      document.getElementById("xs_xs_xy_2").options.add(new Option(data[i], data[i]));
                                  }
                              },
                              error: function () {
                                  alert("error!！");
                              }
                          });
                    });
                    
             $(function(){
                $('.zs_xs').change(function(){
                  $('#dg_zs_stu').datagrid({
                        url: 'acdemic/xh_nianji_search?nianji=' + document.getElementById("xs_xs_xy_2").value + "&xueyuan=" +  document.getElementById("xs_xs_xy_1").value,
                        loadMsg: '加载中请稍后……'
                     });   
                });
                 $('.zs_xs_nj').change(function(){
                     $('#dg_zs_stu').datagrid({
                        url: 'acdemic/xy_nianji_search?nianji=' + document.getElementById("xs_xs_xy_2").value + "&xueyuan=" + document.getElementById("xs_xs_xy_1").value,
                        loadMsg: '加载中请稍后……'
                     });
                
                });
             });
             
             function looknew(){
                  $.ajax({
                            type: "get",
                            url: "reg/hq_xy",
                            success: function (data) {
                                document.getElementById("xs_xs_xy_1").options.length = 0;
                                for (var i = 0; i < data.length; i++) {
                                 document.getElementById("xs_xs_xy_1").options.add(new Option(data[i], data[i]));
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
                                  document.getElementById("xs_xs_xy_2").options.length = 0;
                                  for (var i = 0; i < data.length; i++) {
                                      document.getElementById("xs_xs_xy_2").options.add(new Option(data[i], data[i]));
                                  }
                              },
                              error: function () {
                                  alert("error!！");
                              }
                          });
                          $("#min_stu").textbox('setValue','');
                          $("#max_stu").textbox('setValue','');
             }
        </script>
    </body>
</html>