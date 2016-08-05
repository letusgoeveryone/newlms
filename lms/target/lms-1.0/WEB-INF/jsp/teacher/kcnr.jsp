
<%  
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
    String sessionid =  session.getId();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <h3 style="text-align: center;color: blue" id="kcdg_kcnr" ></h3>  
        <button onclick="tj()"  class="btn btn-default btn-xs">增加根节点</button>
        <button onclick="zjd()" class="btn btn-primary btn-xs">增加子节点</button>
        <button onclick="re()"  class="btn btn-success btn-xs">删除节点</button>
        <button onclick="bj_dqjd()" class="btn btn-info btn-xs">编辑节点</button>
        <button onclick="save(1)" class="btn btn-primary btn-xs">保存设置</button><br><br><br>
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
                              
                        
        
      <div id="kcnrdivone" style="float: left;width: 80%;height: auto;">
<!--        <div id="ylkenr"  style="min-height: 50px;border:0px solid #b8dcff" > <iframe id="kcnrurl" frameborder="0" scrolling="no" height="700px" width="100%" name="content" ></iframe></div>-->
        <br>
        <span id="kcnr"></span>
        <!--<iframe src="" id="swfplayer" frameborder="0" scrolling="no" marginheight="0" height="400px" width="700px" name="swfplayer"></iframe>-->
           
        <hr>
           
         <div style="padding-left: 0%;display: none" id="uploadkcnr" >
                注意：上传的视频只有.mp4才能在线观看，上传word,PPT,XLS时文件名尽量不要有符号．<br><br>
                <input type="file" name="uploadify" id="multiple_file_upload" />
		<a class="btn btn-primary" onclick="kssc()">开始上传</a>
		<a class="btn btn-primary" href="javascript:$('#multiple_file_upload').uploadify('cancel','*')">取消上传</a>
		<a class="btn btn-primary" href="javascript:$('#multiple_file_upload').uploadify('stop','*')" hidden=true id="stopUpload">停止上传</a>
	 </div>   
     </div>
        
        <script>
            
        function lookmu(){
            var term  = ${term}; 
            var courseName= "${courseName}";
             $.ajax({
                   type:"post",
                   url:'<%=path%>/teacher/lookMulu?term='+term+'&courseName='+courseName, 
                   success:function(data){
                         if(data==="1"){   
                               $('#tt1').tree({url:'<%=path%>/teacher/scTree?term='+term+'&courseName='+courseName});
                         }else{
                               $('#tt1').tree({url:'<%=path%>/teacher/kcgs'});
                         }
                    }
               });
         }
            
          function setcourse(){
              $('#myModalkcnr').modal('show');
          }
          function kssc(){
            var a1=null,a2="undefined",a3="undefined";
            var selected = $('#tt1').tree('getSelected'); 
            var term  = ${term}; 
            var coursename= "${courseName}";
            var a =selected.attributes+"";
            if(a==="1"){
                    a1 = selected.id;
                    a2 = null;
                    a3 = null;
                    $('#multiple_file_upload').uploadify("settings", "formData",{'term':term,'coursename':coursename,'a1':a1,'a2':a2,'a3':a3});
                    $('#multiple_file_upload').uploadify('upload','*');
            }else if(a==="2"){
                    parent=$('#tt1').tree('getParent',selected.target);
                    a1 = selected.id;
                    a2 = parent.id;
                    a3 = null;
                    $('#multiple_file_upload').uploadify("settings", "formData",{'term':term,'coursename':coursename,'a1':a2,'a2':a1,'a3':a3});
                    $('#multiple_file_upload').uploadify('upload','*');
            }else{
                    parent=$('#tt1').tree('getParent',selected.target);
                    root=$('#tt1').tree('getParent',parent.target);
                    a1 = root.id;
                    a2 = parent.id;
                    a3 = selected.id;
                    $('#multiple_file_upload').uploadify("settings", "formData",{'term':term,'coursename':coursename,'a1':a1,'a2':a2,'a3':a3});
                    $('#multiple_file_upload').uploadify('upload','*');
            }
          }
        
          function ckkcnr(){ 
               var term  = ${term}; 
               var courseName= "${courseName}";
               var node = $('#tt1').tree('getSelected');
                if(node.attributes==="1"){
                   node1=node.id; 
                   node2=null;
                   node3=null;
                }else if(node.attributes==="2"){
                    node2=node.id;
                    node1=$('#tt1').tree('getParent',node.target).id;
                    node3=null;
                }else{
                   node3=node.id; 
                   parent=$('#tt1').tree('getParent',node.target);
                   root=$('#tt1').tree('getParent',parent.target);
                   node2=parent.id;
                   node1=root.id;
                }
                $.ajax({
                    url:'<%=path%>/teacher/courdir?term='+term+'&courseName='+courseName+'&node1='+node1+'&node2='+node2+'&node3='+node3,
                    type:"post",
                        success:function(data){
                            document.getElementById("kcnr").innerHTML=data;
                          }
                });
               
          }
          
          function kcnrxz(path){
             window.location.href = "<%=path%>/teacher/downloadDG?temp="+ path;
          }
          $(function() {
		$("#multiple_file_upload").uploadify({
			'uploader' : '<%=path%>/teacher/upload100.do;jsessionid=<%=sessionid%>?Func=uploadwallpaper2Dfs',//************ action **************
			'height' : 30,//表示按钮的高度，默认30PX。若要改为50PX，如下设置：'height' : 50，
			'width' : 120,//表示按钮的宽度
			'buttonText' : '选择文件',//按钮上显示的文字，默认”SELECT FILES”
			'buttonCursor' : 'hand',//上传按钮Hover时的鼠标形状，默认值是’hand’
			'auto' : false, //是否自动开始   
			'multi' : true, //是否支持多文件上传，默认为true
			'method' : 'post',//默认是’post’,也可以设置为’get’
			'swf' : '<%=path%>/uploadify/uploadify.swf',//进度条显示文件
			'cancelImg' : '<%=path%>/uploadify/uploadify-cancel.png',//取消按钮的图片
			'fileTypeExts' : '*.wmv;*.asf;*.mp4;*.rmvb;*.avi;*.3gp;*.mkv;*.docx;*.doc;*.xls;*.xlsx;*.ppt ',//指定文件格式
			'fileSizeLimit' : '200MB',//上传文件大小限制，默认单位是KB，若需要限制大小在100KB以内，可设置该属性为：'100KB'
			'fileObjName' : 'myFile',//文件对象名称。用于在服务器端获取文件。
			'progressData' : 'speed', // 'percentage''speed''all'//队列中显示文件上传进度的方式：all-上传速度+百分比，percentage-百分比，speed-上传速度
			'preventCaching' : true,//若设置为true，一个随机数将被加载swf文件URL的后面，防止浏览器缓存。默认值为true
			'timeoutuploadLimit' : 1,//能同时上传的文件数目
			'removeCompleted' : true,//默认是True，即上传完成后就看不到上传文件进度条了。
			'removeTimeout' : 0,//上传完成后多久删除队列中的进度条，默认为3，即3秒。
			'requeueErrors' : true,//若设置为True，那么在上传过程中因为出错导致上传失败的文件将被重新加入队列。
			'successTimeout' : 30,//表示文件上传完成后等待服务器响应的时间。不超过该时间，那么将认为上传成功。默认是30，表示30秒。
			'uploadLimit' : 5,//最多上传文件数量，默认999
			'onUploadStart' : function(file) {
				$("#stopUpload").removeAttr("hidden");
			},
			'onUploadSuccess' : function(file, data, response) {
                                ckkcnr();
				alert(file.name + " upload success !");
				$("#stopUpload").attr("hidden",true);
			}

		});
	});
        function scjd(){//删除节点
              if(ckTree()===false){return false;}
              var node = $('#tt1').tree('getSelected');
              if(node.id!==0){
                  $('#tt1').tree('remove', node.target); 
              }
              save(0);
          } 
         function tj(){//增加根级节点
              var node1 = $('#tt1').tree('getRoots'),max=lookIdMax();
              if (node1){
                        $('#tt1').tree('insert', {
                                before: node1.target,
                                data: {
                                        id:max,
                                        attributes:'1',
                                        text: '第一级'
                                }
                        });
                }
              save(0);
          }  

          function zjd(){//增加子节点
              if(ckTree()===false){return false;}
              var selected = $('#tt1').tree('getSelected'),max=lookIdMax();
              if(selected.attributes==="1"){//第一级菜单
                  $('#tt1').tree('append', {
                    parent: selected.target,
                    data: [{
                            id:max,
                            attributes:'2',
                            text: '第二级'
                           }]
                   });  
               }  
               if(selected.attributes==="2"){//第二级菜单
                   $('#tt1').tree('append', {
                    parent: selected.target,
                    data: [{
                            id:max,
                            attributes:'3',
                            text: '第三级'
                           }]
                   }); 
               }
               var a =selected.attributes+"",b = "undefined";
               if(a==="3"||a===b){
                   alert("已经不能添加了");
               }
               save(0);
          }  
          
          function lookIdMax(){
              var roots=$('#tt1').tree('getRoots'),max=0;
              for(i=0;i<roots.length;i++){
                     if(roots[i].id>max){max=roots[i].id;}
                         if($('#tt1').tree('isLeaf',roots[i].target)){
                         }else{
                              children=$('#tt1').tree('getChildren',roots[i].target);
                              for(j=0;j<children.length;j++){
                                if(children[j].id>max){max=children[j].id;}
                              } 
                         }
              }
              max++;//找出最大id值
              return max;
          }
         function ckTree(){//检查是否选择节点
              var node = $('#tt1').tree('getSelected');
              if(node){
                  return true;
              }else{
                  alert("没有选择，请先选择节点!");
                  return false;
              }
          }
          function bj_dqjd(){ 
               if(ckTree()===false){return false;}
               var node = $('#tt1').tree('getSelected');
               $('#tt1').tree('beginEdit',node.target);
          }

          //节点删除
          function re(){
              var node = $('#tt1').tree('getSelected');
                if(node.attributes==="1"){
                   node1=node.id; 
                   node2=null;
                   node3=null;
                }else if(node.attributes==="2"){
                    node2=node.id;
                    node1=$('#tt1').tree('getParent',node.target).id;
                    node3=null;
                }else{
                   node3=node.id; 
                   parent=$('#tt1').tree('getParent',node.target);
                   root=$('#tt1').tree('getParent',parent.target);
                   node2=parent.id;
                   node1=root.id;
                }
              if(window.confirm('你确定要删除吗?如果有课件，课件也会被删除.')){  
               var term  = ${term}; 
               var courseName= "${courseName}";
                $.ajax({
                     url: '<%=path%>/teacher/kcnr_sc?term='+term+'&courseName='+courseName+'&node1='+node1+'&node2='+node2+'&node3='+node3,
                     type:"post",
                     success:function(data){
                         if(data==="1"){
                            var node = $('#tt1').tree('getSelected');
                            $('#tt1').tree('remove', node.target);
                            save(0);
                            $("#uploadkcnr").hide();
                            $("#kcnrdivone").hide();
                         }else{
                             alert("删除失败，原因未知！");
                         }
                     }
                });
              }
            }
          
       
  
          function zj_zjds(){
              var selected = $('#tt1').tree('getSelected');
              if(selected.attributes==="1"){//第一级菜单
                  $('#tt1').tree('append', {
                    parent: selected.target,
                    data: [{
                            attributes:'2',
                            text: '节点'
                           }]
                   });  
               }  
               if(selected.attributes==="2"){//第二级菜单
                   $('#tt1').tree('append', {
                    parent: selected.target,
                    data: [{
                            attributes:'3',
                            text: '节点'
                           }]
                   }); 
               }
               var a =selected.attributes+"",b = "undefined";
               if(a==="3"||a===b){
                   alert("已经不能添加了");
               }
               save(0); 
             }
          
          function save(temp){
                var term  = ${term}; 
                var courseName= "${courseName}";
                var saveDataAry=[];  
                var roots=$('#tt1').tree('getRoots'),i,j,m = 1, n = 1;
                for(i=0;i<roots.length;i++){
                    saveDataAry.push(roots[i]);  
                }
                 $.ajax({
                     type:"post",
                     url:'<%=path%>/teacher/saveTree?term='+term+'&courseName='+courseName,
                     dataType:"json",
                     contentType:"application/json", 
                     data:JSON.stringify(saveDataAry), 
                     success:function(){
                         if(temp===1){alert("保存成功!");}
                     },
                     error:function(){
                         alert("操作太快!"); 
                     }
                 });
         }            

    //课件删除
    function kcnrfj_sc(filename){
          var term  = ${term}; 
          alert(filename);
          var courseName= "${courseName}";
          var selected = $('#tt1').tree('getSelected'); 
          if(selected.id!==null){
                var node = $('#tt1').tree('getSelected');
                if(node.attributes==="1"){
                   node1=node.id; 
                   node2=null;
                   node3=null;
                }else if(node.attributes==="2"){
                    node2=node.id;
                    node1=$('#tt1').tree('getParent',node.target).id;
                    node3=null;
                }else{
                   node3=node.id; 
                   parent=$('#tt1').tree('getParent',node.target);
                   root=$('#tt1').tree('getParent',parent.target);
                   node2=parent.id;
                   node1=root.id;
                }
                    if(window.confirm('你确定要删除此课件吗？')){  
                               $.ajax({
                                    url:'<%=path%>/teacher/kcsc?term='+term+'&courseName='+courseName+'&node1='+node1+'&node2='+node2+'&node3='+node3+'&filename='+filename,
                                    type:"post",
                                    success:function(data){
                                              alert("删除成功，你可以重新上传!");
                                              document.getElementById("kcnr").innerHTML=data[0];
                                              ckkcnr();
                                    }
                                });
                    }  
                
            }else{alert("请选择节点!");}
    }
   
        
     $(function () {
           var node1,node2,node3;
           $('#tt1').tree({
           onClick: function(node){
               var term  = ${term}; 
               var courseName= "${courseName}";
               if($('#tt1').tree('isLeaf',node.target)){
                    $("#uploadkcnr").show();
                    $("#kcnrdivone").show();
               }else{
                    $("#uploadkcnr").hide();
                    $("#kcnrdivone").hide();
               }
                if(node.attributes==="1"){
                   node1=node.id; 
                   node2=null;
                   node3=null;
                }else if(node.attributes==="2"){
                    node2=node.id;
                    node1=$('#tt1').tree('getParent',node.target).id;
                    node3=null;
                }else{
                   node3=node.id; 
                   parent=$('#tt1').tree('getParent',node.target);
                   root=$('#tt1').tree('getParent',parent.target);
                   node2=parent.id;
                   node1=root.id;
                }
                    $("#uploadkcnr").show();
                    $("#kcnrdivone").show();

                     $.ajax({
                        url:'<%=path%>/teacher/courdir?term='+term+'&courseName='+courseName+'&node1='+node1+'&node2='+node2+'&node3='+node3,
                        type:"post",
                        success:function(data){
                            document.getElementById("kcnr").innerHTML=data[0];
                           }
                     });
             }   
           });
         });
</script>
