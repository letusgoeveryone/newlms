<%-- 
    Document   : dohomework
    Created on : 2016-3-27, 21:18:34
    Author     : 刘昱
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String sessionid = session.getId();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>


<script>
    $(function () {
        $("#uploadify").uploadify({
            'uploader': '<%=path%>/student/zyupload100.do;jsessionid=<%=sessionid%>?Func=uploadwallpaper2Dfs', //************ action **************
            'height': 30,
            'width': 120,
            'buttonText': '选择文件',
            'buttonCursor': 'hand',
            'auto': false,
            'multi': true,
            'method': 'post       ',
            'swf': '<%=path%>/uploadify/uploadify.swf       ',
            'cancelImg': '<%=path%>/uploadify/uploadify-cancel.png',
            'fileTypeExts': '*.docx;*.doc;*.xls;*.xlsx;*.ppt;*.pptx;*.zip;*.rar;*.7z;*.txt;', //指定文件格式
            'fileSizeLimit': '50MB',
            'fileObjName': 'myFile',
            'progressData': 'speed',
            'preventCaching': true,
            'timeoutuploadLimit': 1,
            'removeCompleted': true,
            'removeTimeout': 1,
            'requeueErrors': true,
            'successTimeout': 30,
            'uploadLimit': 5,
            'onUploadStart': function (file) {
                $("#stopUpload").removeAttr("hidden");
            },
            'onUploadSuccess': function (file, data, response) {
                $("#stopUpload").attr("hidden", true);
                stuhwrefresh();
            }

        });
        setheight();
    });
    function myModalshow() {
        $('#myModal').modal('show');
    }
    ;

    function hmsubmitht() {

        $.ajax({
            url: path + '?scid=${scid}&homeworkid=${homeworkid}',
            type: 'POST',
            data: {HwEitor: UM.getEditor('myEditor').getContent()},
            cache: false,
            success: function (returndata) {
                if (returndata === "1") {
                    alert("作业提交成功！");
                    updataHomeworkList(scid);
                } else {
                    alert("作业提交失败！ 可能原因：作业已过期不存在");
                }



            },
            error: function (returndata) {
                alert("\n\n作业提交失败！\n\n");
            }
        });
    }
    ;

    function fileupload() {
        $('#zymultiple_file_upload').uploadify("settings", "formData", {'scid':${scid}, 'homeworkid':${homeworkid}});
        $('#zymultiple_file_upload').uploadify('upload', '*');
    }
    ;

    function delmyattach(url) {

        $.ajax({
            type: "GET",
            url: "<%=path%>/student/" + url,
            success: function (data) {

                if (data === "ok") {
                    alert("作业附件删除成功！");
                    stuhwrefresh();
                } else {
                    alert("作业附件删除失败！ 可能原因：作业已过期或文件不存在");
                }

            },
            error: function () {
                alert("\n\n出错！\n\n");
            }
        });
        stuhwrefresh();
    }
    ;

    function stuhwrefresh() {
        $.post("<%=path%>/student/stuhwrefresh", {scid:${scid}, homeworkid:${homeworkid}},
                function (data) {
                    document.getElementById("attachspan").innerHTML = data;

                });
    }
    ;

</script>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" nobackdrop="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">编辑您的作业附件</h4>
            </div>
            <div class="modal-body" style="width: 100%">


                <div class="container" style="width:550px">
                    <div class="span12">
                        您已上传的附件：<br>

                        <span id="attachspan">
                            <ol class="breadcrumb" id="breadcour2">

                                ${Myattachment}

                            </ol></span>

                        您还可以添加附件：<br>
                        <div id="homeworkatid">
                            <input type="file" name="uploadify" id="zymultiple_file_upload" />
                            <a class="btn btn-primary" onclick="fileupload()">开始上传</a>
                            <a class="btn btn-primary" href="javascript:$('#zymultiple_file_upload').uploadify('cancel','*')">取消上传</a>
                            <a class="btn btn-primary" href="javascript:$('#zymultiple_file_upload').uploadify('stop','*')" hidden=true id="stopUpload">停止上传</a>
                            <a class="btn btn-primary" onclick="stuhwrefresh()">刷新附件</a></div>
                    </div>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>  
            </div>
        </div>
    </div>
</div>

<p>标题${Hwtitle}</p>
<p>提交时间${Hwtime}</p>
<p>截止时间${Hwendtime}</p>
<p>指导${Hwhelp}</p>


作业的附加资源

<ol class="breadcrumb" id="breadcour">${Hwattachment}</ol>

您可以在下面的编辑框里编辑作业内容，您所提交的作业内容将会被老师查看和批改。


<script id="myEditor" style="width: 780px;height:300px;">${HwtextWork}</script>
<script type="text/javascript">var ue = UM.getEditor('myEditor');</script>


<p>您还可以：<a class="btn btn-primary" onclick="myModalshow()">编辑附件</a></p>


如果您确认已经完成了作业的编辑，您可以选择

<a class="btn btn-primary"  onclick="hmsubmitht()"> 保存作业 </a> 
<a class="btn btn-primary" href="<%=path%>/student/Course?cou=${scid}#zy"> 不保存 </a>

