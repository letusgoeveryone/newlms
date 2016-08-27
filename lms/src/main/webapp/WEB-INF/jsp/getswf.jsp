<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <title>FlexPaper</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="initial-scale=1,user-scalable=no,maximum-scale=1,width=device-width" />
        <style type="text/css" media="screen">
            html,body{ height:100%; padding: 0; margin: 0;}
            .viewer-wrapper{
                height: 100vh;
                width: 100%;
                margin: 0;
                padding: 0;
            }
        </style>

        <link href="<%=path%>/viewer/css/flexpaper.css" rel="stylesheet" type="text/css"/>
        <script src="<%=path%>/viewer/js/jquery.min.js"></script>
        <script src="<%=path%>/viewer/js/flexpaper.js"></script>
        <script src="<%=path%>/viewer/js/flexpaper_handlers.js"></script>
    </head>
    <body>
        <div class="viewer-wrapper">
            <div id="viewer" class="flexpaper_viewer"></div>
        </div>
        
        <script type="text/javascript">

            var startDocument = "Paper";            
            var url = window.location.href.toString();
            var path = '<%=path%>' + '/' + '${uri}';
            $('#viewer').FlexPaperViewer({
                config: 
                    {
                        SWFFile: path,
                        Scale: 1,
                        ZoomTransition: 'easeOut',
                        ZoomTime: 0.5,
                        ZoomInterval: 0.05,
                        FitPageOnLoad: false,
                        FitWidthOnLoad: true,
                        FullScreenAsMaxWindow: false,
                        ProgressiveLoading: true,
                        MinZoomSize: 0.2,
                        MaxZoomSize: 5,
                        SearchMatchAll: false,
                        InitViewMode: 'Portrait',
                        RenderingOrder: 'flash',
                        StartAtPage: '',
                        ViewModeToolsVisible: true,
                        ZoomToolsVisible: true,
                        NavToolsVisible: true,
                        CursorToolsVisible: true,
                        SearchToolsVisible: true,
                        WMode: 'window',
                        localeChain: 'zh_CN'
                    }
                }
            );
        </script>
    </body>
</html>