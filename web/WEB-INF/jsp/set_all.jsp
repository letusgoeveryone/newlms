<%-- 
    Document   : test
    Created on : 2015-11-22, 19:35:47
    Author     : Administrator
    add buttons.css in 12.11
--%>
<%
//  将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<%=path%>/css/buttons.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/easyui.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/icon.css">
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/easyuicss/demo.css">
        <script  type="text/javascript"  src="<%=path%>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%=path%>/js/easyuijs/jquery.easyui.min.js"></script>

    <body style="text-align: left">
        <br> <br> <br>
        <a href="#" style="width: 220px"  onclick="xs_course_sz()" class="button button-glow button-rounded button-raised button-primary">安排下学期课程</a>
        <a href="#"  style="width: 230px " onclick="xs_bj_sz()" class="button button-glow button-border button-rounded button-primar">安排下学期开课班级</a>
        <a href="#" style="width: 220px"   class="button button-glow button-rounded button-highlight">安排下学期课程表</a>
        <br> <br> <br>
        <!--//            add for add banji-->
        <div style="display: none" id="dg_add_bj_div">
          
            <div  id='xuehao_all' style="padding:5px;height:auto">
                学期<select  id="sz_xq" ></select>
            </div>
            <div style="float: left">
            <table id="dg_add_bj" style="width:320px;height:auto" class="easyui-datagrid" title="请设置学期要开的班级" 
                   data-options="singleSelect:false,collapsible:true,method:'get',fitColumns:true,pagination:true,toolbar:'#xuehao_all'
                   ">
                <thead>
                    <tr>
                        <th data-options="field:'ck',checkbox:true"></th>
                        <th data-options="field:'classId',hidden:'true',align:'left'">班序号</th>
                        <th data-options="field:'classGrade',editor:'numberbox'">年级</th>
                        <th data-options="field:'className',editor:'text'">班级</th>
                    </tr>
                </thead>
            </table>
            </div>
            
            <div  style="float: left;padding-top: 100px;padding-left: 5px;padding-right: 5px">
                 <a href="#" class="easyui-linkbutton"  onclick="ckbj_test()">---></a>  
            </div>
            
            
            <div style="float: left">
                <div  id='xuehao_all1' style="padding:5px;height:auto">
                 学期<select id="sz_xq1" class="test"></select>
                </div>
             <table id="dg_xq_bj" style="width: 320px;height:auto" class="easyui-datagrid" title="已添加班级信息" 
                   data-options="singleSelect:false,collapsible:true,method:'post',fitColumns:true,pagination:true,toolbar:'#xuehao_all1'
                   ">
                <thead>
                    <tr>
                        <th data-options="field:'ck',checkbox:true"></th>
                        <!--<th data-options="field:'classId',hidden:'true',align:'left'">班序号</th>-->
                        <th data-options="field:'classGrade',editor:'numberbox'">年级</th>
                        <th data-options="field:'className',editor:'text'">班级</th>
                    </tr>
                </thead>
             </table>
             </div>
            
        </div>
        
        
        <!--add for courese?-->
        <div style="display: none" id="dg_add_course_div">     
            <div  id='xuehao_curse' style="padding:5px;height:auto">
                学期<select id="szxq"></select>
            </div>
            <div style="float: left">
            <table id="dg_add_course" style="width:330px;height:auto" class="easyui-datagrid" title="课程信息" 
                   data-options="
                   iconCls: 'icon-edit',
                   singleSelect: false,
                   toolbar:'#xuehao_curse',
                   method: 'get',
                   pagination:true,
                   rownumbers:true,
                   fitColumns:true
               ">
                <thead>
                    <tr>	
                        <th data-options="field:'ck',checkbox:true"></th>
                        <th data-options="field:'courseId',width:80,align:'right',hidden:true">编号</th>      
                        <th data-options="field:'courseName',width:80,align:'right'">课程名称</th>  
                        <th width="80" data-options="field:'aa',formatter:go">课程负责人工号</th>
                    </tr>
                </thead>
            </table>
            </div>
            <div  style="float: left;padding-top: 100px;padding-left: 5px;padding-right: 5px">
                 <a href="#" class="easyui-linkbutton" onclick="ck_curse_test()">---></a>  
            </div>  
<!--            <div style="float: left">      
             <table id="dg_add_bj" style="width: 320px;height:auto" class="easyui-datagrid" title="已添加课程信息" 
                   data-options="singleSelect:false,collapsible:true,method:'get',fitColumns:true,pagination:true,toolbar:'#xuehao_all'
                   ">
                <thead>
                    <tr>
                        <th data-options="field:'ck',checkbox:true"></th>
                        <th data-options="field:'classId',hidden:'true',align:'left'">班序号</th>
                        <th data-options="field:'classGrade',editor:'numberbox'">年级</th>
                        <th data-options="field:'className',editor:'text'">班级</th>
                    </tr>
                </thead>
             </table>
             </div>
            -->
            </div>
         

        <script type="text/javascript">
            function term(val,row){     
                 var  a= "term"+row.classId;
                 return '<input style="width:80px" type="text" name="jihe" id="'+a+'" ">';
            }
            
            function go_term(val, row){
                 var  a= "term"+row.courseId;
                 return '<input style="width:80px" type="text" name="jihe" id="'+a+'" ">';
            }
            function  go(val, row) {
                var  a= "row"+row.courseId;
                return '<input style="width:100px" type="text" name="jihe" id="'+a+'" ">';
              //  return '<a href="#" onclick="constructionManager(\'' + row.courseId+ '\')">查看</a>  ';
            }
//        add for add banji
            function xs_bj_sz() {
                var nf= new Date().getFullYear();
                var dqnf1 = nf+"01";
                var dqmf2 = nf+"02";
                var xn1 = nf+1+"01";
                var xn2 = nf+1+"02";
                document.getElementById("sz_xq").options.length=0;
                document.getElementById("sz_xq").options.add(new Option(dqnf1,dqnf1));
                document.getElementById("sz_xq").options.add(new Option(dqmf2,dqmf2));
                document.getElementById("sz_xq").options.add(new Option(xn1,xn1));
                document.getElementById("sz_xq").options.add(new Option(xn2,xn2));
                document.getElementById("sz_xq1").options.length=0;
                document.getElementById("sz_xq1").options.add(new Option(dqnf1,dqnf1));
                document.getElementById("sz_xq1").options.add(new Option(dqmf2,dqmf2));
                document.getElementById("sz_xq1").options.add(new Option(xn1,xn1));
                document.getElementById("sz_xq1").options.add(new Option(xn2,xn2));
                $("#dg_add_bj_div").show();
                $("#dg_add_course_div").hide();
                $('#dg_add_bj').datagrid({
                    url: 'ckbj_xx',
                    loadMsg: '数据加载中请稍后……'
                });
            }
            //下学期班级的添加
            function ckbj_test() {
                var rows = $('#dg_add_bj').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                var term = new Array();
                var term = [];
                for (var n = 0; n < rows.length; n++) {
                    jssz[n] = rows[n].classId; 
                }
                term[0]=  document.getElementById("sz_xq").value;
                $.ajax({
                    type: "post", //提交方式
                    url: "tj_next_bj", //提交的页面，方法名
                    data: {jssz: jssz,term:term}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("添加成功");
                        xs_bj_sz();// 重新载入当前页面数据  
                    },
                    error: function () {
                        alert("error!！");
                    }
                });  
                term[0] =   document.getElementById("sz_xq1").value;
                $('#dg_xq_bj').datagrid({
                 url: 'next_bj?term=' + term[0],
                 loadMsg: '加载中请稍后……'
                }); 
            }
            // add for add banji   
            function xs_course_sz() {
                $("#dg_add_bj_div").hide();
                $("#dg_add_course_div").show();
                $('#dg_add_course').datagrid({
                    url: 'course_fanhui',
                    loadMsg: '课程数据加载中请稍后……'
                });
                var nf= new Date().getFullYear();
                var dqnf1 = nf+"01";
                var dqmf2 = nf+"02";
                var sn1 = nf-1+"01";
                var sn2 = nf-1+"02";
                var xn1 = nf+1+"01";
                var xn2 = nf+1+"02";
                document.getElementById("szxq").options.length=0;
              //添加SELECT 这个地方我们可以自己调用数据里面的数据
                document.getElementById("szxq").options.add(new Option(dqnf1,dqnf1));
                document.getElementById("szxq").options.add(new Option(dqmf2,dqmf2));
                document.getElementById("szxq").options.add(new Option(xn1,xn1));
                document.getElementById("szxq").options.add(new Option(xn2,xn2));
                document.getElementById("szxq").options.add(new Option(sn1,sn1));
                document.getElementById("szxq").options.add(new Option(sn2,sn2));

            }
//add for add course
            function ck_curse_test() {
                var rows = $('#dg_add_course').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                var tecgh = new Array();
                var tecgh = [];
                var term = new Array();
                var term = [];
                for (var n = 0; n < rows.length; n++) {
                    jssz[n] = rows[n].courseId;
                    tecgh[n] = document.getElementById("row"+jssz[n]).value;  
                }
                 term[0] = document.getElementById("szxq").value;
                 $.ajax({
                    type: "post", //提交方式
                    url: "tj_next_course", //提交的页面，方法名
                    data: {jssz: jssz,tecgh:tecgh,term:term}, //参数，如果没有，可以为null
                    success: function (data) {
                        alert("添加成功");
                    },
                    error: function () {
                        alert("error!！");
                    }
                });
            }
           //下拉框判断有没有触发下拉框
            $(function(){
                $('.test').change(function(){   
                $('#dg_xq_bj').datagrid({
                 url: 'next_bj?term=' + document.getElementById("sz_xq1").value,
                 loadMsg: '加载中请稍后……'
                }); 
                });
            });
        </script>
    </body>
</html>
