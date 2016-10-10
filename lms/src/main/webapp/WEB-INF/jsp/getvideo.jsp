<%-- 
    Document   : getvideo
    Created on : 2016-4-9, 17:32:03
    Author     : 刘昱
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> 
<%
//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<!doctype html>
<html>
    <head>
        <title>Video Player</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style>
            body{
                margin: 2em;
            }
            video{
                display: block;
                margin: auto;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.55);
            }
            #pslider{
                margin: 1em auto;
                display: block;
            }
        </style>
    </head>
    
    <body>
        
        <input type="range" id="pslider" min="1" max="11" value="6" onmouseup="setPlayerHeight()"/>
        
        <div style="margin:0 auto;height: 600px" id="pwin">
            <video  controls preload="auto" height="100%" poster="<%=path%>/images/video-poster.png" data-setup="{}" autoplay="autoplay" style="margin:0 auto">
                <source src="<%=path%>/${uri}" type="video/mp4">
            </video>
        </div>
        <script>
            
            var win = document.getElementById('pwin');
            var oheight = 100;
            
            function setPlayerHeight(){
                var slider = document.getElementById('pslider');
                var x = slider.value;
                var height = x * oheight;
                
                win.style.height = height + 'px';
                console.log(slider.value);
                console.log(height);
                
                
            }
        </script>
            
    </body>
</html>