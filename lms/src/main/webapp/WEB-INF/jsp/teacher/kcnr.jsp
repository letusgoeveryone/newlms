
<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
    String sessionid = session.getId();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<h3 style="text-align: center;color: blue" id="kcdg_kcnr" ></h3>   
<div style="width: 20%;float: left;">
    <ul id="tt1"  class="easyui-tree" data-options="
        url:'<%=path%>/teacher/kcgs',
        method: 'get',
        animate: true,                          
        onContextMenu: function(e,node){
        e.preventDefault();
        $(this).tree('select',node.target);
        $('#menu').menu('show',{
        left: e.pageX,
        top: e.pageY
        });
        }
        "></ul>
</div>  
<div id="menu" class="easyui-menu" style="width: 200px;max-height: 10em;">
    <div  onclick="bj_dqjd()">编辑当前节点名称</div>
    <div class="menu-sep"></div>
    <div id="m-closeother" onclick="zj_zjds()">增加子节点</div>
    <div class="menu-sep"></div>
    <div id="m-closeother" onclick="re()">删除选中节点</div>
    <div id="m-close" onclick="save()">保存全部节点设置</div>
    <!--<div id="m-closeother" onclick="rm()">查看节点id</div>-->
    <div id="m-closeother" onclick="setcourse()">课程设置工具</div>
</div>
<!--模态框（Modal）--> 
<div class="modal fade" id="myModalkcnr" tabindex="-1" role="dialog" 
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" 
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    课程工具
                </h4>
            </div>
            <div class="modal-body" style="width: 100%">
                建设中～～～

            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-success" data-dismiss="modal">Close</a>
            </div>
        </div>
    </div>
</div>



<div id="kcnrdivone" style="float: left;width: 80%;height: auto;">
    <!--        <div id="ylkenr"  style="min-height: 50px;border:0px solid #b8dcff" > <iframe id="kcnrurl" frameborder="0" scrolling="no" height="700px" width="100%" name="content" ></iframe></div>-->
    <br>
    <span id="kcnr"></span>
    <!--<iframe src="" id="swfplayer" frameborder="0" scrolling="no" marginheight="0" height="400px" width="700px" name="swfplayer"></iframe>-->

    <hr>

    <div style="padding-left: 0%;" id="uploadkcnr">
        注意：上传的视频只有.mp4才能在线观看，上传word,PPT,XLS时文件名尽量不要有符号．<br><br>
        <input type="file" name="uploadify" id="multiple_file_upload" />
        <a class="btn btn-primary" onclick="kssc()">开始上传</a>
        <a class="btn btn-primary" href="javascript:$('#multiple_file_upload').uploadify('cancel','*')">取消上传</a>
        <a class="btn btn-primary" href="javascript:$('#multiple_file_upload').uploadify('stop','*')" hidden=true id="stopUpload">停止上传</a>
    </div>   
</div>

<script>

    function lookmu() {
        var term = ${term};
        var courseName = "${courseName}";
        $.ajax({
            type: "post",
            url: '<%=path%>/teacher/lookMulu?term=' + term + '&courseName=' + courseName,
            success: function (data) {
                if (data === "1") {
                    $('#tt1').tree({url: '<%=path%>/teacher/scTree?term=' + term + '&courseName=' + courseName});
                } else {
                    $('#tt1').tree({url: '<%=path%>/teacher/kcgs'});
                }
            }
        });
    }

    function setcourse() {
        $('#myModalkcnr').modal('show');
    }
    function kssc() {
        var a1 = null, a2 = "undefined", a3 = "undefined";
        var selected = $('#tt1').tree('getSelected');
        var term = ${term};
        var coursename = "${courseName}";
        if (selected.id !== null) {
            var a = selected.attributes + "", b = "undefined";
            if (a === "" || a === "3" || a === b) {
                parent = $('#tt1').tree('getParent', selected.target);
                root = $('#tt1').tree('getParent', parent.target);
                a1 = root.id;
                a2 = parent.id;
                a3 = selected.id;
                $('#multiple_file_upload').uploadify("settings", "formData", {'term': term, 'coursename': coursename, 'a1': a1, 'a2': a2, 'a3': a3});
                $('#multiple_file_upload').uploadify('upload', '*');
            } else if (a === "2") {
                alert("上传请选择第3节点");
            } else if (a === "1") {
                alert("上传请选择第3节点");
            }
        }
    }

    function ckkcnr() {
        var term = ${term};
        var courseName = "${courseName}";
        var node = $('#tt1').tree('getSelected');
        if (node.attributes === "2" || node.attributes === "1") {
            document.getElementById("kcnr").innerHTML = "";
            return true;
        }
        var node2 = $('#tt1').tree('getParent', node.target);//2
        if (node2.attributes === "2") {
            var node1 = $('#tt1').tree('getParent', node2.target);//1
            var node3 = $('#tt1').tree('getSelected');//3
            $.ajax({
                url: '<%=path%>/teacher/courdir?term=' + term + '&courseName=' + courseName + '&node1=' + node1.id + '&node2=' + node2.id + '&node3=' + node3.id,
                type: "post",
                success: function (data) {
                    document.getElementById("kcnr").innerHTML = data;
                }
            });
        }
    }
    $(function () {
                $("#multiple_file_upload").uploadify({
            'uploader': '<%=path%>/teacher/upload100.do;jsessionid=<%=sessionid%>?Func=uploadwallpaper2Dfs', //************ action **************
            'height': 30, //表示按钮的高度，默认30PX。若要改为50PX，如下设置：'height' : 50，
            'width': 120, //表示按钮的宽度
            'buttonText': '选择文件', //按钮上显示的文字，默认”SELECT FILES”
            'buttonCursor': 'hand', //上传按钮Hover时的鼠标形状，默认值是’hand’
            'auto': false, //是否自动开始   
            'multi': true, //是否支持多文件上传，默认为true
                    'method': 'post', //默认是’post’,也可以设置为’get’
                    'swf': '<%=path%>/uploadify/uploadify.swf', //进度条显示文件
            'cancelImg': '<%=path%>/uploadify/uploadify-cancel.png', //取消按钮的图片
            'fileTypeExts': '*.wmv;*.asf;*.mp4;*.rmvb;*.avi;*.3gp;*.mkv;*.docx;*.doc;*.xls;*.xlsx;*.ppt ', //指定文件格式
            'fileSizeLimit': '200MB', //上传文件大小限制，默认单位是KB，若需要限制大小在100KB以内，可设置该属性为：'100KB'
            'fileObjName': 'myFile', //文件对象名称。用于在服务器端获取文件。
            'progressData': 'speed', // 'percentage''speed''all'//队列中显示文件上传进度的方式：all-上传速度+百分比，percentage-百分比，speed-上传速度
            'preventCaching': true, //若设置为true，一个随机数将被加载swf文件URL的后面，防止浏览器缓存。默认值为true
            'timeoutuploadLimit': 1, //能同时上传的文件数目
            'removeCompleted': true, //默认是True，即上传完成后就看不到上传文件进度条了。
            'removeTimeout': 0, //上传完成后多久删除队列中的进度条，默认为3，即3秒。
            'requeueErrors': true, //若设置为True，那么在上传过程中因为出错导致上传失败的文件将被重新加入队列。
            'successTimeout': 30, //表示文件上传完成后等待服务器响应的时间。不超过该时间，那么将认为上传成功。默认是30，表示30秒。
            'uploadLimit': 5, //最多上传文件数量，默认999
            'onUploadStart': function (file) {
                $("#stopUpload").removeAttr("hidden");
            },
            'onUploadSuccess': function (file, data, response) {
                ckkcnr();
                alert(file.name + " upload success !");
                $("#stopUpload").attr("hidden", true);
            }

        });
    });


    function bj_dqjd() {
        $.messager.prompt('自定义界面', '输入课程的自定义章节', function (r) {
            var node = $('#tt1').tree('getSelected');
            if (node) {
                $('#tt1').tree('update', {
                    target: node.target,
                    text: r
                });
            }
        });
    }
    //节点删除
    function re() {
        var a, b, c;
        var node = $('#tt1').tree('getSelected');
        if (node.attributes === "1") {
            alert("此级节点不能删除");
            return true;
        }//1
        if (node.attributes === "2") {
            if (node.id === 1 || node.id === 2 || node.id === 3 || node.id === 4) {
                alert("此特殊节点不能删除");
                return true;
            }
        }//2
        if (node.id === 1000 || node.id === 2000 || node.id === 3000 || node.id === 4000 || node.id === 5000 || node.id === 6000 || node.id === 7000 || node.id === 8000) {
            alert("此特殊节点不能删除");
            return false;
        }
        if (node.attributes === "2") {
            root = $('#tt1').tree('getParent', node.target);
            a = root.id;
            b = node.id;
            c = "null";
        }
        if (node.attributes === "3") {
            parent = $('#tt1').tree('getParent', node.target);
            root = $('#tt1').tree('getParent', parent.target);
            a = root.id;
            b = parent.id;
            c = node.id;
        }
        if (window.confirm('你确定要删除吗?如果有课件，课件也会被删除.')) {
            var term = ${term};
            var courseName = "${courseName}";
            $.ajax({
                url: '<%=path%>/teacher/kcnr_sc?term=' + term + '&courseName=' + courseName + '&node1=' + a + '&node2=' + b + '&node3=' + c,
                type: "post",
                success: function (data) {
                    if (data === "1") {
                        var node = $('#tt1').tree('getSelected');
                        $('#tt1').tree('remove', node.target);
                        save();
                    } else {
                        alert("删除失败，原因未知！");
                    }
                }
            });
        }
    }



    function zj_zjds() {
        var selected = $('#tt1').tree('getSelected');
        if (selected.attributes === "1") {//第一级菜单
            $('#tt1').tree('append', {
                parent: selected.target,
                data: [{
                        attributes: '2',
                        text: '节点'
                    }]
            });
        }
        if (selected.attributes === "2") {//第二级菜单
            $('#tt1').tree('append', {
                parent: selected.target,
                data: [{
                        attributes: '3',
                        text: '节点'
                    }]
            });
        }
        var a = selected.attributes + "", b = "undefined";
        if (a === "3" || a === b) {
            alert("已经不能添加了");
        }
    }

    function save() {
        var term = ${term};
        var courseName = "${courseName}";
        var saveDataAry = [];
        var roots = $('#tt1').tree('getRoots'), children, i, j, m = 1, n = 1;
        for (i = 0; i < roots.length; i++) {
            roots[i].id = i;//最外层id定义 
            saveDataAry.push(roots[i]);
        }
        for (i = 0; i < roots.length; i++) {
            children = $('#tt1').tree('getChildren', roots[i].target);
            for (j = 0; j < children.length; j++) {
                var a = children[j].id + "", b = "undefined";
                if (a === b) {
                    children[j].id = children[j - 1].id + 1;
                }
            }
        }
        $.ajax({
            type: "post",
            url: '<%=path%>/teacher/saveTree?term=' + term + '&courseName=' + courseName,
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify(saveDataAry),
            success: function () {
                alert("保存成功!");
            },
            error: function () {
                alert("ERROR!");
            }
        });
    }

    //课件删除
    function kcdg_sc(filename) {
        var term = ${term};
        var courseName = "${courseName}";
        var a1 = null, a2 = "undefined", a3 = "undefined";
        var selected = $('#tt1').tree('getSelected');
        if (selected.id !== null) {
            var a = selected.attributes + "", b = "undefined";
            if (a === "" || a === "3" || a === b) {
                parent = $('#tt1').tree('getParent', selected.target);
                root = $('#tt1').tree('getParent', parent.target);
                a1 = root.id;
                a2 = parent.id;
                a3 = selected.id;
                if (window.confirm('你确定要删除此课件吗？')) {
                    $.ajax({
                        url: '<%=path%>/teacher/kcsc?term=' + term + '&courseName=' + courseName + '&node1=' + a1 + '&node2=' + a2 + '&node3=' + a3 + '&filename=' + filename,
                        type: "post",
                        success: function (data) {
                            alert("删除成功，你可以重新上传!");
                            document.getElementById("kcnr").innerHTML = data[0];
                            ckkcnr();
                        }
                    });
                }
            } else {
                alert("选择节点错误，请选择最低节点!");
            }
        }
    }


    $(function () {
        $('#tt1').tree({
            onClick: function (node) {
                var term = ${term};
                var courseName = "${courseName}";
                $("#uploadkcnr").hide();
                $("#ylkenr").hide();
                if (node.attributes === "2" || node.attributes === "1") {
                    document.getElementById("kcnr").innerHTML = "";
                    return true;
                }
                var node2 = $('#tt1').tree('getParent', node.target);//2
                if (node2.attributes === "2") {
                    $("#uploadkcnr").show();
                    $("#kcnrdivone").show();
                    var node1 = $('#tt1').tree('getParent', node2.target);//1
                    var node3 = $('#tt1').tree('getSelected');//3
                    $.ajax({
                                url: '<%=path%>/teacher/courdir?term=' + term + '&courseName=' + courseName + '&node1=' + node1.id + '&node2=' + node2.id + '&node3=' + node3.id,
                        type: "post",
                        success: function (data) {
                            document.getElementById("kcnr").innerHTML = data[0];
                        }
                    });
                }
            }
        });
    });
</script>
