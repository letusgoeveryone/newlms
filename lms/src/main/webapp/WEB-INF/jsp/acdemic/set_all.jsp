<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            #lms-am-timetables [id^="panel"]{
                height:  350px;
            }
            #lms-am-timetables .nav-tabs li{
                display: inline-block;
                list-style: none;
            }
            #lms-am-timetables .nav-tabs>ul{
                padding: 0;
            }
            #lms-am-timetables .active>a{
                background: linear-gradient(to bottom,rgba(255, 255, 255, 0.73) 0,rgba(63, 81, 181, 0.43) 100%);
                color: #313131;
            }
        </style>
    </head>
    <body>
        <div class="container " id="lms-am-timetables">

            <nav class="nav-tabs">
                <ul>
                    <li>
                        <a data-toggle="tab" href="#panel-setCourses" style="width: 120px" class="easyui-linkbutton">安排下学期课程</a>
                    </li>
                    <li>
                        <a data-toggle="tab" href="#panel-setClasses" style="width:120px " class="easyui-linkbutton">安排下学期班级</a> 
                    </li>
                    <li>
                        <a data-toggle="tab" href="#panel-setTimeTables" style="width: 120px" class="easyui-linkbutton">安排下学期课程表</a>
                    </li>
                    <li class="active">
                        <a data-toggle="tab" href="#panel-getTimeTables" style="width:100px" class="easyui-linkbutton active">查看课程表</a>
                    </li>
                    
                </ul>
            </nav>

            <div style="padding: 1.5em"></div>

            <div class="tab-pane fade" id="panel-setClasses">
                <div style="float: left">
                    <div  id='xuehao_all' style="padding:5px;height:auto">
                        请设置学期:<select  id="sz_xq" ></select>
                    </div>
                    <div >
                        <table id="dg_add_bj" style="width:320px;height:auto" class="easyui-datagrid" title="请设置学期要开的班级" 
                               data-options="singleSelect:false,collapsible:false,method:'get',fitColumns:true,pagination:true,toolbar:'#xuehao_all'
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
                </div> 

                <div  style="float: left;padding:5em;">
                    <a class="easyui-linkbutton"  onclick="ckbj_test()"><span class="icon">all_inclusive</span></a>  
                </div>

                <div  id='xuehao_all1' style="padding:5px;height:auto">
                    学期
                    <select id="sz_xq1" class="test"></select>
                </div>
                <table id="dg_xq_bj" style="width: 320px;" class="easyui-datagrid" title="已添加班级信息" 
                       data-options="singleSelect:false,method:'post',pagination:true,toolbar:'#xuehao_all1'
                       ">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
                            <th data-options="field:'classGrade',editor:'numberbox'">年级</th>
                            <th data-options="field:'className',editor:'text'">班级</th>
                        </tr>
                    </thead>
                </table>


            </div>

            <div  class="tab-pane fade"  id="panel-setCourses">     
                <div style="float: left">
                    <div  id='xuehao_curse' style="padding:5px;height:auto">
                        请设置学期:<select id="szxq"></select>
                    </div>

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
                                <th data-options="field:'courseName',width:80,align:'left'">课程名称</th>  
                                <th width="90" data-options="field:'aa',align:'left',formatter:go">课程负责人工号</th>
                                <th width="80" data-options="field:'ago1',align:'left',formatter:go1">课程负责人</th>
                            </tr>
                        </thead>
                    </table>
                </div> 

                <div  style="float: left;padding:5em;">
                    <a class="easyui-linkbutton"  onclick="ck_curse_test()"><span class="icon">all_inclusive</span></a>  
                </div>

                <div  id='xuehao_course' style="padding:5px;height:auto">
                    学期<select id="sz_xq_course" class="test1"></select>
                </div>

                <table id="dg_xq_cs" style="float: left;width: 320px;height:auto" class="easyui-datagrid" title="已开课学期课程信息" 
                       data-options="singleSelect:false,collapsible:true,method:'get',fitColumns:true,pagination:true,toolbar:'#xuehao_course'
                       ">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
                            <th data-options="field:'courseName',width:80,align:'left'">课程名称</th>  
                            <th width="80" data-options="field:'teacherName',align:'left'">课程负责人</th>
                            <th width="80" data-options="field:'teacherSn',align:'left'">课程负责人工号 </th>
                        </tr>
                    </thead>
                </table>

            </div>

            <div  class="tab-pane fade"  id="panel-setTimeTables">
                <div class="pull-left">
                    <table id="all" style="width:330px;height:auto" class="easyui-datagrid" title="课程信息" 
                           data-options="
                           iconCls: 'icon-edit',
                           singleSelect: false,
                           toolbar:'#xuehao_curse',
                           method: 'get',
                           pagination:true,
                           rownumbers:true,
                           fitColumns:true,
                           singleSelect:true,
                           ">
                        <thead>
                            <tr>	
                                <th data-options="field:'ck',checkbox:true"></th>
                                <th data-options="field:'courseId',align:'right',hidden:true">编号</th>      
                                <th data-options="field:'courseName',width:200,align:'left'">课程名称</th>  
                            </tr>
                        </thead>
                    </table>
                    <div style="margin:10px 0;display: none">
                        <span>选择方法: </span>
                        <select onchange="$('#all').datagrid({singleSelect: (this.value === 0)})">
                            <option value="0">单行</option>
                        </select>
                    </div>
                </div>
                <div  style="float: left;padding:5em;">
                    
                    <a  class="easyui-linkbutton"  onclick="tijiao()">提交</a>  
                </div>

                <div style="width:350px;height:auto;float: left;">
                    <div  id='all_bj_xq' style="padding:5px;height:auto">
                        学期:<select id="szall_xq" class="allbj_ck"></select>
                    </div>
                    <table id="all_bj" style="width:350px;height:auto" class="easyui-datagrid" title="请选择课程所需的班级" 
                           data-options="rownumbers:true,singleSelect:false,collapsible:true,method:'post',fitColumns:true,pagination:true,toolbar:'#all_bj_xq'
                           ">
                        <thead>
                            <tr>
                                <th data-options="field:'ck',checkbox:true"></th>
                                <th data-options="field:'classId',hidden:true,align:'left'">班序号</th>
                                <th data-options="field:'classGrade',editor:'numberbox'">年级</th>
                                <th data-options="field:'className',editor:'text'">班级</th>
                                <th width="100" data-options="field:'ab',formatter:rkjs">任课教师教工号</th>
                                <th width="80" data-options="field:'rkjs',formatter:rkjsxm">任课教师</th>
                            </tr>
                        </thead>
                    </table>

                    <div>
                        一个课程对应多个班级,
                        <br>
                        选择好课程班级后,输入相应的任课老师
                    </div>
                </div>
                
            </div>

            <div  id='courselist_xq' style="padding:5px;height:auto">
                学期:<select id="courselist_xq1" class="courselist_xq1"></select>
            </div>

            <div  class="tab-pane fade in active"  id="panel-getTimeTables">
                <table id="course_list" style="width:800px;height:auto" class="easyui-datagrid" title="课程表" 
                       data-options="rownumbers:true,singleSelect:false,collapsible:true,method:'get',fitColumns:true,pagination:true,toolbar:'#courselist_xq'
                       ">
                    <thead>
                        <tr>
                            <th data-options="field:'ck',checkbox:true"></th>
                            <!--<th data-options="field:'classId',hidden:true,align:'left'">班序号</th>-->
                            <th data-options="field:'teacherName',width:200,editor:'numberbox'">任课教师</th>
                            <th data-options="field:'teacherSn',width:200,editor:'numberbox'">任课教师工号</th>
                            <th data-options="field:'className',width:200,editor:'text'">班级</th>
                            <th data-options="field:'courseName',width:200,editor:'text'">课程名称</th>
                        </tr>
                    </thead>
                </table>
                
            </div>

        </div>
        <script type="text/javascript">
            function term(val, row) {
                var a = "term" + row.classId;
                return '<input style="width:80px" type="text" name="jihe" id="' + a + '" ">';
            }

            function go_term(val, row) {
                var a = "term" + row.courseId;
                return '<input style="width:80px" type="text" name="jihe" id="' + a + '" ">';
            }
            function  go(val, row) {
                var a = "row" + row.courseId;
                return '<input style="width:80px" type="text"  onkeyup="findName(' + row.courseId + ');" type="text" name="jihe" id="' + a + '" ">';
            }
            function  go1(val, row) {
                var a = "span" + row.courseId;
                return ' <span id="' + a + '"> </span>  ';

            }
            function  rkjsxm(val, row) {
                var a = "span1" + row.classId;
                ;
                return ' <span id="' + a + '"> </span>  ';
            }
            function  rkjs(val, row) {
                var a = "spanrk" + row.classId;
                return '<input style="width:85px" onkeyup="findName1(' + row.classId + ');" type="text" name="jihe" id="' + a + '" ">';
            }

            function findName1(a) {
                var b = document.getElementById("spanrk" + a).value;
                $.ajax({
                    type: "post",
                    url: "acdemic/ppjsxx",
                    data: {value: b},
                    success: function (data) {
                        document.getElementById("span1" + a).innerHTML = data;
                    },
                    error: function () {
                        document.getElementById("span1" + a).innerHTML = "不存在";
                    }
                });
            }

            function findName(a) {
                var b = document.getElementById("row" + a).value;
                $.ajax({
                    type: "post",
                    url: "acdemic/ppjsxx",
                    data: {value: b},
                    success: function (data) {
                        document.getElementById("span" + a).innerHTML = data;
                    },
                    error: function () {
                        document.getElementById("span" + a).innerHTML = "不存在";
                    }
                });
            }

            function xs_bj_sz() {
                $('#dg_add_bj').datagrid({
                    url: 'acdemic/ckbj_xx',
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
                term[0] = document.getElementById("sz_xq").value;
                $.ajax({
                    type: "post",
                    url: "acdemic/tj_next_bj",
                    data: {jssz: jssz, term: term},
                    success: function (data) {
                        alert("添加成功");
                        xs_bj_sz();
                    },
                    error: function () {
                        alert("重复添加！失败！");
                    }
                });
                term[0] = document.getElementById("sz_xq1").value;
                $('#dg_xq_bj').datagrid({
                    url: 'acdemic/next_bj?term=' + term[0],
                    loadMsg: '加载中请稍后……'
                });
            }

            function xs_course_sz() {
                $('#dg_add_course').datagrid({
                    url: 'acdemic/course_fanhui',
                    loadMsg: '课程数据加载中请稍后……'
                });
            }

            function ck_curse_test() {
                var rows = $('#dg_add_course').datagrid('getChecked');
                var jssz = new Array();
                var jssz = [];
                var tecgh = new Array();
                var tecgh = [];
                var tecgh1 = new Array();
                var tecgh1 = [];
                var term = new Array();
                var term = [];
                var courseName = new Array();
                var courseName = [];
                for (var n = 0; n < rows.length; n++) {
                    jssz[n] = rows[n].courseId;
                    tecgh[n] = document.getElementById("row" + jssz[n]).value;
                    courseName[n] = rows[n].courseName;
                    if (tecgh[n] === "") {
                        alert("你遗漏了课程负责人的工号，请补添!!!");
                        return 0;
                    }
                }
                term[0] = document.getElementById("szxq").value;
                if (tecgh.length === 0) {
                    alert("你遗漏了something!!在左边的表格写入吧.");
                } else {
                    $.ajax({
                        type: "post",
                        url: "acdemic/tj_next_course",
                        data: {jssz: jssz, tecgh: tecgh, term: term, courseName: courseName},
                        success: function (data) {
                            alert("添加成功");
                            $('#dg_xq_cs').datagrid({
                                url: 'acdemic/next_cs_tr?term=' + document.getElementById("sz_xq_course").value,
                                loadMsg: '加载中请稍后……'
                            });
                        },
                        error: function () {
                            alert("你可能已经设置过此学期,课程的课程负责人!");
                        }
                    });
                }
            }
            $(function () {
                $.ajax({
                    type: "get",
                    url: "fhxq",
                    success: function (data) {
                        document.getElementById("szxq").options.length = 0;
                        document.getElementById("sz_xq_course").options.length = 0;
                        document.getElementById("sz_xq1").options.length = 0;
                        document.getElementById("sz_xq").options.length = 0;
                        document.getElementById("szall_xq").options.length = 0;
                        document.getElementById("courselist_xq1").options.length = 0;
                        for (var i = 0; i < data.length; i++) {
                            document.getElementById("szxq").options.add(new Option(data[i], data[i]));
                            document.getElementById("sz_xq_course").options.add(new Option(data[i], data[i]));
                            document.getElementById("sz_xq1").options.add(new Option(data[i], data[i]));
                            document.getElementById("sz_xq").options.add(new Option(data[i], data[i]));
                            document.getElementById("szall_xq").options.add(new Option(data[i], data[i]));
                            document.getElementById("courselist_xq1").options.add(new Option(data[i], data[i]));
                        }
                    },
                    error: function () {
                        alert("error!！");
                    }
                });
                $.ajax({
                    type: "get",
                    url: "reg/fhnj",
                    success: function (data) {
                        document.getElementById("cs_nj").options.length = 0;
                        for (var i = 0; i < data.length; i++) {
                            document.getElementById("cs_nj").options.add(new Option(data[i], data[i]));
                        }
                    },
                    error: function () {
                        alert("error!！");
                    }
                });
            });

//          下拉框判断有没有触发下拉框
            $(function () {
                $('.test').change(function () {
                    $('#dg_xq_bj').datagrid({
                        url: 'acdemic/next_bj?term=' + document.getElementById("sz_xq1").value,
                        loadMsg: '加载中请稍后……'
                    });
                });
            });
            $(function () {
                $('.test1').change(function () {
                    $('#dg_xq_cs').datagrid({
                        url: 'acdemic/next_cs_tr?term=' + document.getElementById("sz_xq_course").value,
                        loadMsg: '加载中请稍后……'
                    });
                });
            });
            $(function () {
                $('.allbj_ck').change(function () {
                    $('#all_bj').datagrid({
                        url: 'acdemic/next_bj?term=' + document.getElementById("szall_xq").value,
                        loadMsg: '加载中请稍后……'
                    });
                });
            });
            $(function () {

                $('.courselist_xq1').change(function () {
                    $('#course_list').datagrid({
                        url: 'acdemic/courselist_fanhui?term=' + document.getElementById("courselist_xq1").value,
                        loadMsg: '加载中请稍后……'
                    });
                });
            });
            function allinall() {
                $('#all').datagrid({
                    url: 'acdemic/course_fanhui',
                    loadMsg: '课程数据加载中请稍后……'
                });
                var term = document.getElementById("szall_xq").value;
                $('#all_bj').datagrid({
                    url: 'acdemic/next_bj?term=' + term,
                    loadMsg: '加载中请稍后……'
                });
            }
            function kechengbiao() {
                $('#course_list').datagrid({
                    url: 'acdemic/courselist_fanhui?term=' + document.getElementById("courselist_xq1").value,
                    loadMsg: '加载中请稍后……'
                });
            }
            function tijiao() {
                var rows = $('#all').datagrid('getChecked');
                var courseName;
                for (var n = 0; n < rows.length; n++) {
                    courseName = rows[n].courseName;
                }
                var row = $('#all_bj').datagrid('getChecked');
                var classId = new Array();
                var tec_gh = new Array();
                for (var n = 0; n < row.length; n++) {
                    classId[n] = row[n].classId;
                    tec_gh[n] = document.getElementById("spanrk" + row[n].classId).value;
                }
                var xueqi = document.getElementById("szxq").value;
                $.ajax({
                    type: "post",
                    url: "acdemic/courselist_add",
                    data: {xueqi: xueqi, tec_gh: tec_gh, courseName: courseName, classId: classId},
                    success: function (data) {
                        alert("success!");
                        $('#all_bj').datagrid('reload');
                        $('#all').datagrid('reload');
                    },
                    error: function () {
                        alert("添加重复！请不要重复添加！");
                    }
                });
            }
            

            $('[href="#panel-setCourses"]').click(function(){
                setTimeout(xs_course_sz,500);
            });
            $('[href="#panel-setClasses"]').click(function(){
                setTimeout(xs_bj_sz,500);
            });
            $('[href="#panel-setTimeTables"]').click(function(){
                setTimeout(allinall,500);
            });
            $('[href="#panel-getTimeTables"]').click(function(){
                setTimeout(kechengbiao,500);
            });
        </script>
    </body>
</html>
