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
        <title></title>

    </head>
    <body>
        <div class="container stage-box">
          <div  id='js_xy' style="padding:5px;height:auto">
             选择学院:<select  id="xs_js_xy" class="zs_js" style="width: 100px"></select>
                From: <input class="easyui-textbox" style="width:80px" id="min_zs_js">
                To: <input class="easyui-textbox" style="width:80px" id = "max_zs_js">
                <a class="easyui-linkbutton" iconCls="icon-search" onclick="xh_zsjs_search()">Search</a>    
         </div>
        <table id="dg_zs_tec" title="正式教师信息" style="width:1000px;height:auto"
               data-options="rownumbers:true,singleSelect:false,pagination:true,toolbar:'#js_xy',fitColumns:true,method:'get'">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'teacherSn',width:90,align:'left'">工号</th>
                    <th data-options="field:'teacherName',width:60,align:'left'">姓名</th>
                     <th data-options="field:'teacherSex',width:50,align:'left',formatter:zs_js_sex">性别</th>
                    <th data-options="field:'teacherIdcard',width:150,align:'left'">身份证号</th>
                    <th data-options="field:'teacherCollege',width:150,align:'left'">学院</th>
                    <th data-options="field:'teacherPosition',width:40,align:'left'">职称</th>
                    <th data-options="field:'teacherTel',width:100,align:'left'">手机号</th>
                    <th data-options="field:'teacherQq',width:100,align:'left'">qq</th>
                    <th data-options="field:'teacherId',hidden:'true',width:30,align:'left'" >序号</th>
                    <th width="80" data-options="field:'aa',formatter:go_by">操作</th>
                </tr>
            </thead>
        </table>
        <br>
        <a  class="easyui-linkbutton" onclick="getSelected_zs_js()">查看选中的信息</a>
        <a  class="easyui-linkbutton" onclick="getSelections_zs_js()">查看选中的多个信息</a>
        <a  class="easyui-linkbutton" onclick="ck_zs_jsxx()">加载所有学院教师信息</a>
        <a  class="easyui-linkbutton" onclick="sc_zs_js()">删除选中的教师</a>
        <a href="daochualltoxlsa=正式教师信息" class="easyui-linkbutton">下载已批准的教师</a>
    </div>
        <script type="text/javascript">
            function zs_js_sex(val,row){     
                 if(row.teacherSex){
                    return '<span> 男</span>';
                 }else{
                    return '<span> 女</span>';   
                 } 
            }
             function  go_by(val, row) {
              return '<a href="#" onclick="sc_js_by(\'' + row.teacherId+ '\')">删除</a>  ';
            }
            
            $(function () {
                var pager = $('#dg_zs_tec').datagrid().datagrid('getPager'); 
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
            function ck_zs_jsxx() {
                $('#dg_zs_tec').datagrid({
                    url: 'fh_zs_jsme',
                    loadMsg:'数据加载中请稍后……'
                });
                looktea();
            }
            function newzsjs(){
                ck_zs_jsxx();
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
                    type: "post", 
                    url: "pzsc_zs_jsxx", 
                    data: {jssz: jssz}, 
                    success: function (data) {
                        if(data==="1"){
                            alert("删除正式表教师出错，已经存在依赖关系");
                        }else{
                            alert("删除成功"); 
                        }               
                        $('#dg_zs_tec').datagrid('reload');
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
                    type: "post", 
                    url: "pzsc_zs_jsxx", 
                    data: {jssz: jssz}, 
                    success: function (data) {
                        if(data==="1"){
                            alert("删除正式表教师出错，已经存在依赖关系");
                        }else{
                            alert("删除成功"); 
                        }               
                        $('#dg_zs_tec').datagrid('reload');
                    },
                     error:function(){
                      alert("未选择，请重新选择！");
                        }
                });   
            }
             $(function () {
                        $.ajax({
                            type: "get",
                            url: "reg/hq_xy",
                            success: function (data) {
                                document.getElementById("xs_js_xy").options.length = 0;
                                for (var i = 0; i < data.length; i++) {
                                 document.getElementById("xs_js_xy").options.add(new Option(data[i], data[i]));
                                }
                            },
                            error: function () {
                                alert("error!！");
                            }
                        });
                    });
                    
             $(function(){
                $('.zs_js').change(function(){
                   $('#dg_zs_tec').datagrid({
                    url: 'zs_js_xy_search?min=' + $('#xs_js_xy').val(),
                    loadMsg: '加载中请稍后……'
                  });    
                });
             });
            function xh_zsjs_search(){
                $('#dg_zs_tec').datagrid({
                    url: 'zs_js_search?min=' + $('#min_zs_js').val() + "&max=" + $('#max_zs_js').val(),
                    loadMsg: '加载中请稍后……'
                }); 
            }
            
            function looktea(){
                 $.ajax({
                            type: "get",
                            url: "reg/hq_xy",
                            success: function (data) {
                                document.getElementById("xs_js_xy").options.length = 0;
                                for (var i = 0; i < data.length; i++) {
                                 document.getElementById("xs_js_xy").options.add(new Option(data[i], data[i]));
                                }
                            },
                            error: function () {
                                alert("error!！");
                            }
                        });
                        $("#min_zs_js").textbox('setValue','');
                        $("#max_zs_js").textbox('setValue','');
            }
        </script>
    </body>
</html>