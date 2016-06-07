<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    String sessionid = session.getId();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<div class="row-fluid" style="min-height: 600px" id="coall">
    <div class="span12">
        <div class="tab-nav">
            <ul class="nav  nav-list">
                <li class="active">
                    <a href="#panel-761012" data-toggle="tab">课程介绍</a>
                </li>
                <li>
                    <a href="#panel-587333" data-toggle="tab" onclick="lookcourseDG()">课程大纲</a>
                </li>
                <li>
                    <a href="#panel-587334" data-toggle="tab" onclick="lookmu()">课程内容</a>
                </li>
                <li>
                    <a href="#panel-587335" data-toggle="tab" onclick="ck()">作业区</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="panel-761012">
                    <p>
                        <jsp:include page="kcjs.jsp"  />
                    </p>
                </div>
                <div class="tab-pane fade in" id="panel-587333">
                    <p>
                        <jsp:include page="kcdg.jsp"  />
                    </p>
                </div>
                <div class="tab-pane fade in" id="panel-587334">
                    <p>
                        <jsp:include page="kcnr.jsp" /> 
                    </p>
                </div>
                <div class="tab-pane fade in" id="panel-587335">
                    <p>
                        <jsp:include page="work.jsp"  /> 
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal-body" style="width:1000px;display: none" id="mywork">

    <div class="container" style="width:1000px">
        <div class="row">
            <div class="span12">
                <div class="tab-nav" id="tabs-701766">
                    <ul class="nav nav-list">
                        <li>
                            <a href="#panel-HomeworkDetail" data-toggle="tab">作业详情</a>
                        </li>
                        <li class="active">
                            <a href="#panel-AlterHomework" data-toggle="tab">修改作业</a>
                        </li>
                        <li class="active1">
                            <a href="#panel-LookOverHomeWork" data-toggle="tab" onclick="ckallclass()">学生作业查看</a>
                        </li>
                        <li class="active2">
                            <a href="#panel-BackToCourse" data-toggle="tab" onclick="cklastc()">返回课程</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane" id="panel-HomeworkDetail">
                            <p>
                            <div id="worklk" style="border:0px solid #b8dcff;width: 800px;padding-left: 0%;display: none">
                                <span >作业要求:</span><br>
                                <span id = "newwork" style="width: 550px"></span><br>
                                <span > 学生提交作业截至时间:</span><br>
                                <span id="jzsj" > </span><br><br><br>
                                <span > 学生提交作业开始时间</span><br>
                                <span id="jzzyks" > </span><br><br><br>
                                <span id="zyfj" style="width: 800px"></span>
                                <div id="fj" style="display: none">
                                    <input type="file" name="uploadify" id="zymultiple_file_upload" />
                                    <a class="btn btn-primary" onclick="zysc()">开始上传</a>
                                    <a class="btn btn-primary" href="javascript:$('#zymultiple_file_upload').uploadify('cancel','*')">取消上传</a>
                                    <a class="btn btn-primary" href="javascript:$('#zymultiple_file_upload').uploadify('stop','*')" hidden=true id="stopUpload">停止上传</a>

                                </div>   

                            </div>
                            </p>
                        </div>
                        <div class="tab-pane active" id="panel-AlterHomework">
                            <p> 
                                <br>
                                学生提交作业开始时间<br>
                                <input id="xgtjzyksdd" class="easyui-datetimebox" style="width: 200px"></input><br><br>
                                学生提交作业截至时间:<br>
                                <input id="xgdd" class="easyui-datetimebox" style="width: 200px"></input><br><br>
                                作业名称:<br><input class="easyui-textbox"  id="xgzyms" style="width: 200px"></input><br><br>
                                作业要求:
                                <script type="text/plain" id="xghomework" style="width: 800px;height:100px;"></script><br>
                                <button type="button"  class="btn btn-primary"  onclick="tjzygg()">
                                    提交更改
                                </button>
                            </p>
                        </div>
                        <div class="tab-pane active1" id="panel-LookOverHomeWork">
                            <p><br>

                                <span id="bjalllk"></span>
                            <div style="display: none" id="stuwork"> 
                                <table class="table">
                                    <caption id="bgbt">上下文表格布局</caption>
                                    <thead>
                                        <tr >
                                            <th>学号</th>
                                            <th>姓名</th>
                                            <th>班级</th>
                                            <th>提交时间</th>
                                            <th style="width: 500px">作业</th>
                                        </tr>
                                    </thead>
                                    <tbody id="stutable">
                                    </tbody>
                                </table>
                                <button type="button" class="btn btn-primary" onclick="hqxzlj()">
                                    下载全部班级的提交作业
                                </button>
                                <button type="button" class="btn btn-primary" onclick="hqdqzy()">
                                    下载当前班级的提交作业
                                </button>
                            </div>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>                           
</div>

<script>
    var ue = UM.getEditor('homework');
    var ue = UM.getEditor('xghomework');
    function cklastc() {
        $("#mywork").hide();
        $("#coall").show();
    }
</script>     
