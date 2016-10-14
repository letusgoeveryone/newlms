<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    String sessionid = session.getId();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/css/buttons.css">
<style>
    #hfText{
        padding:2em 1em;
        background: whitesmoke;
        margin: 2em 0;
    }
    #hfText p{
        padding: 0 2em;
    }

    #DGText{
        padding:2em 1em;
        background: whitesmoke;
        margin: 2em 0;
    }
    #DGText p{
        padding: 0 2em;
    }
    .cca-preview .btn-edit{
        border-radius: 1px;
        border-bottom-left-radius: 20px;
        background: #333;
        position: absolute;
        top: 82px;
        right: -8px;
        color: #cfcfd0;
    }
    .cca-preview .btn-edit:hover{
        color: #0081C2;
    }
</style>
<div class="cca-preview">
    <a class="btn btn-edit" onclick="lookcourseJS()" href="#anchor-CourseIntro">编辑</a>
    <div id="hfText" style="border:0px solid #CCC;">
    
    </div>
        
</div>
<a id="anchor-CourseIntro"></a>
<script type="text/plain" id="myEditor" style="width: 100%;min-height:100px;"></script>
<br>

<button  class="btn btn-default " onclick="getContent()">预览</button>
<!--<button  class="btn btn-primary " onclick="QXJS()">撤销</button>-->
<button id="tj"  class="btn btn-success" onclick="update()">提交</button>

<script type="text/javascript">

    var ue = UE.getEditor('myEditor');

    function getContent() {
        var value = UE.getEditor('myEditor').getContent();
        UE.getEditor("myEditor").setContent(value);
        document.getElementById("hfText").innerHTML = value;
    }

    function update() {
        $.ajax({
            type: "post",
            data: {courseid:${courseid}, term:${term}},
            url: "lookisCourseMaster",
            success: function (data) {
                if (data !== "0") {
                    alert("你不是课程负责人，不能在此编辑课程大纲!");
                } else {
                    if (window.confirm('你确定要更新课程介绍吗？')) {
                        var arr = [];
                        arr.push(UE.getEditor('myEditor').getContent());
                        addcourseinfo(arr);
                        return true;
                    }
                }
            },
            error: function () {
                CourseMaster();
            }
        });
    }

    //更新课程介绍
    function addcourseinfo(arr) {
        var arrinfor;
        arrinfor = arr + "";
        $.ajax({
            type: "post",
            url: "addcourseinfo",
            data: {arrinfor: arrinfor, courseid:${courseid}, term:${term}},
            success: function (data) {
                if (data === "1") {
                    alert("更新成功!");
                    lookcourseJS();
                }
            },
            error: function () {
                alert("出错了，未知原因！");
            }
        });

    }
    //返回课程介绍
    function lookcourseJS() {
        $.ajax({
            type: "post",
            url: "lookcourseline",
            data: {courseid:${courseid}, term:${term}},
            success: function (data) {
                if (data[0] === "null") {
                    document.getElementById("hfText").innerHTML = "课程介绍暂未更新，等待课程负责人添加";
                } else {
                    document.getElementById("hfText").innerHTML = data[0];
                    setTimeout(function(){
                        UE.getEditor("myEditor").setContent(data[0]);
                    }, 500);
                }
            },
            error: function () {
                lookcourseJS();
            }
        });
    }

    function QXJS() {
        document.getElementById("hfText").innerHTML = "";
        lookcourseJS();
    }
</script>