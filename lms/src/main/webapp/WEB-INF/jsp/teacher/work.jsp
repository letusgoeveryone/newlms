<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    String sessionid = session.getId();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html class="bg-content">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            ol, ul {
                padding: 0 0 0 33px;
            }
            #iswork{
                color: #0052A3 !important;
                font-weight: bold;
                padding:0 15px;
            }
        </style>
    </head>
    <body>     
        
        <div style="border:0px solid #b8dcff"><span id="iswork" style="color: blue"></span><span id="zjtime" style="float: right"></span><hr>
            <ol id="myul"></ol>     
        </div>
        
        <hr>
        
        <div class="row" style="padding:0 15px;">
            <div class="col-md-4">
                <div class="box-small">
                    <p>作业名称:&nbsp;&nbsp;</p><input class="easyui-textbox"  id="zyms" style="width: 268px"/>
                </div>
                <div class="box-small">
                    开始时间:&nbsp;&nbsp;<input id="onexgtjzyksdd" class="easyui-datetimebox" style="width: 200px" /><br>
                    截止时间:&nbsp;&nbsp;<input id="dd" class="easyui-datetimebox" style="width: 200px" />
                </div>
            </div>
            <div class="col-md-8 box-small">
                <p>作业要求:</p>
                <script type="text/plain" id="homework" style="width: 600%;height:50px;"></script>
            </div>
        </div>
        <div style="padding:0 15px;">
            <button  class="btn btn-primary" onclick="uploadWork()">添加</button>&nbsp;
            <button onclick="ck()" class="btn btn-success">查看作业</button>
        </div>
        
        <script>

            $(function () {

                $('#dd').datebox().datebox('calendar').calendar({
                    validator: function (date) {
                        var now = new Date();
                        var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                        var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate() + 100);
                        return d1 <= date && date <= d2;
                    }
                });
            });

            //下载
            function hqxzlj() {
                var term = ${term};
                var courseName = "${courseName}";
                window.location.href = "<%=path%>/teacher/download?term=" + term + "&courseName=" + courseName + "&workid=" + workid;

            }
            // 下载当前班级的提交作业
            function hqdqzy() {
                var term = ${term};
                var courseName = "${courseName}";
                window.location.href = "<%=path%>/teacher/downloadclas?term=" + term + "&courseName=" + courseName + "&workid=" + workid + "&classname=" + classname;
            }
            //清楚临时生成的压缩文件
            function clear() {
                var term = ${term};
                $.ajax({
                    url: "<%=path%>/teacher/clear?term=" + term,
                    type: "POST",
                    success: function (returndata) {

                    },
                    error: function () {

                    }
                });
            }

            $(function () {
                $("#zymultiple_file_upload").uploadify({
                    'uploader': '<%=path%>/teacher/zyupload100.do;jsessionid=<%=sessionid%>?Func=uploadwallpaper2Dfs', //************ action **************
                    'height': 30,
                    'width': 120,
                    'buttonText': '选择文件',
                    'buttonCursor': 'hand',
                    'auto': false,
                    'multi': false,
                    'method': 'post ',
                    'swf': '<%=path%>/uploadify/uploadify.swf ',
                    'cancelImg': '<%=path%>/uploadify/uploadify-cancel.png',
                    'fileTypeExts': '*.docx;*.doc;*.xls;*.xlsx;*.ppt ', //指定文件格式
                    'fileSizeLimit': '10MB',
                    'fileObjName': 'myFile',
                    'progressData': 'speed',
                    'preventCaching': true,
                    'timeoutuploadLimit': 1,
                    'removeCompleted': true,
                    'removeTimeout': 1,
                    'requeueErrors': true,
                    'successTimeout': 30,
                    'uploadLimit': 1,
                    'onUploadStart': function (file) {
                        $("#stopUpload").removeAttr("hidden");
                    },
                    'onUploadSuccess': function (file, data, response) {
                        $("#fj").show();
                        alert(file.name + " upload success !重新点击作业可以查看哦!");
                        $("#stopUpload").attr("hidden", true);
                        cklastc();
                    }

                });
            });

            function uploadWork() {
                var miaoshu = $("#zyms").val();
                if (miaoshu === " " || miaoshu === "") {
                    alert("作业描述没有添加!");
                    return true;
                }
                var term = ${term};
                var courseName = "${courseName}";
                var time = $('#dd').datebox('getValue');
                var onetime = $('#onexgtjzyksdd').datebox('getValue');
                if (time === "" || onetime === "") {
                    alert("未设置学生作业时间!");
                    return true;
                }
                var arred = [];
                arred.push(UM.getEditor('homework').getContent());
                arred = arred + "";
                if (UM.getEditor('homework').hasContents() === false) {
                    alert("作业要求需要编辑哦!");
                    return true;
                }
                $.ajax({
                    url: "<%=path%>/teacher/work",
                    type: "POST",
                    data: {term: term, courseName: courseName, arred: arred, time: time, miaoshu: miaoshu, onetime: onetime},
                    success: function (returndata) {
                        if (returndata === "1") {
                            alert("成功!");
                            ck();
                        } else {
                            alert("成功!");
                            ck();
                        }
                    },
                    error: function () {
                        alert("上传失败!");
                    }
                });
            }


            //显示作业列表
            function ck() {
                var term = ${term};
                var courseName = "${courseName}";
                $.ajax({
                    url: "<%=path%>/teacher/ckcourselist",
                    type: "post",
                    data: {term: term, courseName: courseName},
                    success: function (data) {
                        if (data[0] === "0") {
                            document.getElementById("iswork").innerHTML = "还没有设置作业";
                            $("#myul").children("li").remove();
                        } else {
                            document.getElementById("iswork").innerHTML = "已经设置" + data[0] + "次作业,如下：";
                            document.getElementById("zjtime").innerHTML = "学生提交作业截至时间";
                            creatlist(data);
                        }
                    }
                });
            }
            function creatlist(n) {
                var term = ${term};
                var courseName = "${courseName}";
                var ul = document.getElementById("myul");
                $("#myul").children("li").remove();
                for (var i = 0; i < n[0]; i++) {
                    var li = document.createElement("li");
                    li.setAttribute("id", i + 1 + "");
                    li.setAttribute("width", "20px");
                    var myA = document.createElement("a");
                    myA.appendChild(document.createTextNode(n[i + 1]));//添加a标签内的文本   
                    var mySpan = document.createElement("span");
                    mySpan.setAttribute("style", "float:right");
                    mySpan.appendChild(document.createTextNode(n[i + 1 + parseInt(n[0])]));
                    li.appendChild(mySpan);
                    li.appendChild(myA);
                    ul.appendChild(li);
                    //查看作业信息
                    li.onclick = function () {
                        $("#zyfj").hide();
                        var id = this.id;
                        var name = n[id];
                        $.ajax({
                            url: "<%=path%>/teacher/worknewwindow",
                            type: "post",
                            data: {term: term, courseName: courseName, id: id},
                            success: function (data) {
                                workid = id;
                                $("#worklk").show();
                                $("#stuwork").hide();
                                document.getElementById("newwork").innerHTML = data[0];
                                document.getElementById("xghomework").innerHTML = data[0];
                                document.getElementById("jzsj").innerHTML = data[1];
                                document.getElementById("jzzyks").innerHTML = data[2];
                                $("#xgzyms").textbox('setValue', name);//赋值
                                $('#xgtjzyksdd').datetimebox('setValue', data[2]);
                                $('#xgdd').datetimebox('setValue', data[1]);
                                $("#mywork").show();
                                $("#coall").hide();
                                if (data[3] === "2") {
                                    $("#fj").show();
                                } else {
                                    $("#fj").hide();
                                    $("#zyfj").show();
                                    document.getElementById("zyfj").innerHTML = data[3];
                                }
                            }
                        });
                    };
                }

            }
            var workid; //全局变量　为作业序号     
            function zysc() {
                var term = ${term};
                var coursename = "${courseName}";
                $('#zymultiple_file_upload').uploadify("settings", "formData", {'term': term, 'coursename': coursename, 'workid': workid});
                $('#zymultiple_file_upload').uploadify('upload', '*');
            }

            function tjzygg() {
                var id = workid;
                var miaoshu = $("#xgzyms").val();
                if (miaoshu === " " || miaoshu === "") {
                    alert("作业描述没有添加!");
                    return true;
                }
                var term = ${term};
                var courseName = "${courseName}";
                var time = $('#xgdd').datebox('getValue');
                var starttime = $('#xgtjzyksdd').datebox('getValue');
                if (time === "" || starttime === "") {
                    alert("未设置学生提交作业截至时间!");
                    return true;
                }
                var arred = [];
                arred.push(UM.getEditor('xghomework').getContent());
                arred = arred + "";
                if (UM.getEditor('xghomework').hasContents() === false) {
                    alert("作业要求需要编辑哦!");
                    return true;
                }
                $.ajax({
                    url: "<%=path%>/teacher/xgwork",
                    type: "POST",
                    data: {term: term, courseName: courseName, arred: arred, time: time, miaoshu: miaoshu, id: id, starttime: starttime},
                    success: function (returndata) {
                        cklastc();
                        ck();
                        alert("修改成功！");
                    },
                    error: function () {
                        alert("上传失败!");
                    }
                });
            }
            function sczyfj() {
                var id = workid;
                var term = ${term};
                var courseName = "${courseName}";
                if (window.confirm('你确定要删除吗？')) {
                    $.ajax({
                        url: "<%=path%>/teacher/dlworkfj",
                        type: "POST",
                        data: {term: term, courseName: courseName, id: id},
                        success: function (returndata) {
                            if (returndata === "1") {
                                alert("删除成功！");
                            }
                            ck();
                            cklastc();
                        },
                        error: function () {

                        }
                    });
                }
            }
            function ckallclass() {
                var id = workid;//作业id
                var term = ${term};
                var courseName = "${courseName}";
                $.ajax({
                    url: "<%=path%>/teacher/lkworkbj",
                    type: "POST",
                    data: {term: term, courseName: courseName, id: id},
                    success: function (data) {
                        clear();
                        if (data.length === 1 && data[0] === "0") {
                            document.getElementById("bjalllk").innerHTML = "暂时没有学生交作业";
                        } else {
                            document.getElementById("bjalllk").innerHTML = data[0];
                        }
                    },
                    error: function () {

                    }
                });
            }
            var classname;
            function czxs(n) {
                classname = n;
                var a = n;
                var id = workid;//作业id
                var term = ${term};
                var courseName = "${courseName}";
                $.ajax({
                    url: "<%=path%>/teacher/lkworkxs",
                    type: "POST",
                    data: {term: term, courseName: courseName, id: id, a: a},
                    success: function (data) {
                        if (data[0] !== "0") {
                            $("#stuwork").show();
                            document.getElementById("stutable").innerHTML = data[0];
                            document.getElementById("bgbt").innerHTML = "共有" + data[data.length - 1] + "位同学已经交作业";
                        } else {
                            document.getElementById("stutable").innerHTML = "";
                            document.getElementById("bgbt").innerHTML = "";
                        }
                    },
                    error: function () {

                    }
                });
            }
        </script>
    </body>
</html>
