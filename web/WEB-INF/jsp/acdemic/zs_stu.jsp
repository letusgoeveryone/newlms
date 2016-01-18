<%-- 
    Document   : zs_stu
    Created on : 2015-11-30, 19:46:58
    Author     : Administrator
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>正式学生</title>
    </head>
    <body>
        <h2>已批准学生信息</h2>
        <p>你可以修改正式学生信息.</p>


        <table id="dg_zs_stu" title="已批准学生信息"   style="width:700px;height:auto"
               data-options="rownumbers:true,singleSelect:false,pagination:true,fitColumns:true,method:'get'">
            <thead>
                <tr>
                    <th data-options="field:'ck',checkbox:true"></th>
                    <th data-options="field:'studentSn',width:90,align:'left'">学号</th>
                    <th data-options="field:'studentName',width:60,align:'left'">姓名</th>
                    <th data-options="field:'studentIdcard',width:150,align:'left'">身份证号</th>
                    <th data-options="field:'studentCollege',align:'left'">学院</th>
                    <th data-options="field:'studentTel',width:100,align:'left'">手机号</th>
                    <th data-options="field:'studentId',hidden:'true',width:30,align:'left'" >序号</th>
                    <th width="80" data-options="field:'aa',formatter:go_xs_by">操作</th>
                </tr>
            </thead>
        </table>    
        <br>
        <a href="#" onclick="go_zs_stu()">go</a> <input type="text" id="go" style="width: 50px">

        <!--//add for 批量批准删除2015年11月26日 22:24:19-->
        <a href="#" class="easyui-linkbutton" onclick="getSelected_zs_xs()">查看选中的信息</a>
        <a href="#" class="easyui-linkbutton" onclick="getSelections_zs_xs()">查看选中的多个信息</a>
        <a href="#" class="easyui-linkbutton" onclick="sj_zs_stu()">加载学生信息</a>
        <a href="#" class="easyui-linkbutton" onclick="sc_zs_xs()">删除选中的学生</a>
        <a href="daochuxuesheng" class="easyui-linkbutton" >下载学生信息</a>
        <a href="#" class="easyui-linkbutton" onclick="search_zs_xs()"> 按照学号搜索</a>

        <br><br>
        <div style="display: none" id="student_search">
            <div  id='xuehao' title="按照学号搜索" style="padding:5px;height:auto">
                From: <input class="easyui-textbox" style="width:80px" id="min_stu">
                To: <input class="easyui-textbox" style="width:80px" id = "max_stu">
                <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="xh_search()">Search</a>     
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="removeit_xuehao()">批量删除</a>  
            </div>
            <table id="tb_stu_search" class="easyui-datagrid" title="学号搜索" style="width:700px;height:auto"
                   data-options="singleSelect:false,collapsible:true,method:'get',fitColumns:true,toolbar:'#xuehao'">
                <thead>
                    <tr>
                        <th data-options="field:'ck',checkbox:true"></th>
                        <th data-options="field:'studentSn',width:90,align:'left'">学号</th>
                        <th data-options="field:'studentName',width:60,align:'left'">姓名</th>
                        <th data-options="field:'studentIdcard',width:150,align:'left'">身份证号</th>
                        <th data-options="field:'studentCollege',align:'left'">学院</th>
                        <th data-options="field:'studentTel',width:100,align:'left'">手机号</th>
                        <th data-options="field:'studentId',hidden:'true',width:30,align:'left'" >序号</th>
                    </tr>
                </thead>
            </table>
        </div>

        <!--//add for 批量批准删除-->
        <script type="text/javascript">
            function go_xs_by(val, row){
                 return '<a href="#" onclick="sc_xs_by(\'' + row.studentId+ '\')">删除</a>  ';  
            }
            function sc_xs_by(studentId){
                var jssz = new Array();
                var jssz = [];
                jssz[0] = studentId;
                $.ajax({
                    type: "post", 
                    url: "sc_zs_xs", 
                    data: {jssz: jssz}, 
                    success: function (data) {
                      alert("删除成功");
                      $('#tb_stu_search').datagrid('reload'); // 重新载入当前页面数据 
                      sj_zs_stu();// 重新载入当前页面数据
                    },
                    error: function () {
                       alert("未选择，请重新选择！");
                    }
                });  
            }
        //各个功能添加，删除
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
              //                    < !--//add for 批量批准删除2015年11月26日 22:24:19-- >
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
//       <!--//add for 批量批准删除2015年11月26日 22:24:19-->
//2015年11月27日 11:20:16 add for load teacher message
        function sj_zs_stu() {
            $('#dg_zs_stu').datagrid({
                url: 'fh_zs_stume',
                loadMsg: '数据加载中请稍后……'
            });
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
                type: "post", //提交方式
                        url: "sc_zs_xs", //提交的页面，方法名
                        data: {jssz: jssz}, //参数，如果没有，可以为null
                        success: function (data) {
                alert("删除成功");
                          sj_zs_stu(); // 重新载入当前页面数据  
                    },
                    error: function () {
                    alert("未选择，请重新选择！");
                }
        });
}

function go_zs_stu(){
    $('#dg_zs_stu').datagrid('options').pageNumber=$('#go').val();
    $('#dg_zs_stu').datagrid({
    url: 'fh_zs_stume',
    loadMsg:'数据加载中请稍后……'
    });

}
  
  
        function  xh_search(){

            $('#tb_stu_search').datagrid('options').pageNumber=$('#min_stu').val();  
            $('#tb_stu_search').datagrid('options').pageSize=$('#max_stu').val();  
            $('#tb_stu_search').datagrid({
            url: 'xh_search',
            loadMsg:'加载中请稍后……'
            });  
        }
        function removeit_xuehao() {
            var rows = $('#tb_stu_search').datagrid('getChecked');
            var jssz = new Array();
            var jssz = [];
            for (var n = 0; n < rows.length; n++) {
               jssz[n] = rows[n].studentId;
            }
            $.ajax({
            type: "post", //提交方式
            url: "sc_zs_xs", //提交的页面，方法名
            data: {jssz: jssz}, //参数，如果没有，可以为null
            success: function (data) {
              alert("删除成功");
              $('#tb_stu_search').datagrid('reload');// 重新载入当前页面数据  
            },
            error: function () {
               alert("未选择，请重新选择！");
               }
            });
        }
        function  xh_search() {
            $('#tb_stu_search').datagrid({
            url: 'xh_search?min=' + $('#min_stu').val() + "&max=" + $('#max_stu').val(),
            loadMsg: '加载中请稍后……'
            });
        }
        function search_zs_xs(){
             $("#student_search").show();
             
        }
   
        </script>
    </body>
</html>