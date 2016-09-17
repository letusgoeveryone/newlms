<%
    //    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
        + request.getServerName() + ":"
        + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*,java.lang.*" %>
<%
    /**
     * ******************************************************************
     * Title: JspEnv v Description : JSP环境探针 CopyRight:(c)	2005 www.soho.net.ru
     *
     * @author:	若影
     * @version:	1.0
     * @Data:	2005-1-1 12:00:00
     * *******************************************************************
     */
    long timePageStart = System.currentTimeMillis();
%>
<%
    class EnvServlet {

        public long timeUse = 0;
        public Hashtable htParam = new Hashtable();
        private Hashtable htShowMsg = new Hashtable();

        public void setHashtable() {
            Properties me = System.getProperties();
            Enumeration em = me.propertyNames();
            while (em.hasMoreElements()) {
                String strKey = (String) em.nextElement();
                String strValue = me.getProperty(strKey);
                htParam.put(strKey, strValue);
            }
        }

        public void getHashtable(String strQuery) {
            Enumeration em = htParam.keys();
            while (em.hasMoreElements()) {
                String strKey = (String) em.nextElement();
                String strValue = new String();
                if (strKey.indexOf(strQuery, 0) >= 0) {
                    strValue = (String) htParam.get(strKey);
                    htShowMsg.put(strKey, strValue);
                }
            }
        }

        public String queryHashtable(String strKey) {
            strKey = (String) htParam.get(strKey);
            return strKey;
        }

        public long test_int() {
            long timeStart = System.currentTimeMillis();
            int i = 0;
            while (i < 3000000) {
                i++;
            }
            long timeEnd = System.currentTimeMillis();
            long timeUse = timeEnd - timeStart;
            return timeUse;
        }

        public long test_sqrt() {
            long timeStart = System.currentTimeMillis();
            int i = 0;
            double db = (double) new Random().nextInt(1000);
            while (i < 200000) {
                db = Math.sqrt(db);
                i++;
            }
            long timeEnd = System.currentTimeMillis();
            long timeUse = timeEnd - timeStart;
            return timeUse;
        }
    }
%>
<%
    EnvServlet env = new EnvServlet();
    env.setHashtable();
    String action = new String(" ");
    String act = new String("action");
    if (request.getQueryString() != null && request.getQueryString().indexOf(act, 0) >= 0) {
        action = request.getParameter(act);
    }
%>
<html>
    <head>
        <title>JSP 探针</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf8">

        <!-- css -->
        <link href="<%=path%>/css/base.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/project.min.css" rel="stylesheet" type="text/css"/>
        <link href="<%=path%>/css/lms.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/css/images/tree_icons.png"> 

        <!--JS-->
        <script type="text/javascript" src="<%=path%>/js/jquery.min.js"></script>
        <script src="<%=path%>/js/base.min.js" type="text/javascript"></script>
        <script src="<%=path%>/js/project.min.js" type="text/javascript"></script>

        <style>
            .input  {border: 1px solid;font-size: 9pt}
            .backc  { border: 1px solid;font-size: 9pt;color:white}
            .PicBar { background-color: #f58200; border: 1px solid #000000; height: 12px;}
            .divcenter {
                position:absolute;
                height:30px;
                z-index:1000;
                left: 101px;
                top: 993px;
            }
            #srv_qresult td{display: inline-block; width: 50%;word-break: break-all;}
        </style>
        <script>
            function showsubmenu(sid){
                whichEl = eval("submenu" + sid);
                if (whichEl.style.display === "none"){
                    eval("submenu" + sid + ".style.display=\"\";");
                    eval("txt" + sid + ".innerHTML=\"<a href='#' title='关闭此项'><font face='Wingdings' color=#FFFFFF>x</font></a>\";");
                } else {
                    eval("submenu" + sid + ".style.display=\"none\";");
                    eval("txt" + sid + ".innerHTML=\"<a href='#' title='打开此项'><font face='Wingdings' color=#FFFFFF>y</font></a>\";");
                }
            }
        </script>
    </head>
    <body class="container">

        <!--        
        <div class="navbar navbar-default" role="navigation">
            <div class="navbar-header">
                <a href="#" class="navbar-brand">服务器</a>
            </div>
            <ul class="nav navbar-nav">
                <li><a class="btn btn-default"  href="#ServerInfo">服务器相关参数</a></li>
                <li><a class="btn btn-default"  href="#JAVAInfo">JAVA相关参数</a></li>
                <li><a class="btn btn-default"  href="#Paramter">参数查询</a></li>
                <li><a class="btn btn-default"  href="javascript:location.reload()">刷新</a></li>
            </ul>
        </div>
        -->
        <div class="space-block"></div>
        <div class=" box-small">
            <a class="btn btn-default pull-right"  href="javascript:location.reload()">刷新</a>
        </div>
        
        <form class=" box-small" action="?action=query" method="post" name="queryform">
            
            <table border="0" cellpadding="0" cellspacing="1" class="table table-bordered">
                <thead>
                    <tr> 
                        <td   onclick="showsubmenu(1)"><strong>系统参数查询</strong>
                        </td>
                    </tr>

                <thead>
                <tfoot>
                    <tr > 
                        <td>
                            <div class="form-group">
                                <input type="text" placeholder="请输入所查参数" name="query" class="form-control" size="70">
                                <br>

                                <a type="submit" value="提交" class="btn btn-default" onClick="document.queryform.submit();$('#srv_qresult').fadeToggle()">查询</a>
                                <a href="#" class="btn btn-default" onClick="document.queryform.submit()">枚举所有参数信息</a>
                                <a type="reset" value="重置" class="btn btn-default pull-right" onclick="$('#srv_qresult').fadeOut()">清除</a>
                            </div>
                        </td>
                    </tr>
                <tfoot>
            </table>
            
            <table class='table  table-striped' border=0 width=100% cellspacing=1 cellpadding=3 bgcolor="#f58200" id="srv_qresult">		
                <%
                    if (action.equals("query")) {
                        String query = request.getParameter("query");
                        env.getHashtable(query);
                        out.println("<tbody>");
                        if (env.htShowMsg.size() > 0) {
                            out.println("<tr  >\n<td>&nbsp;参数名称</td>\n<td>&nbsp;参数信息</td>\n</tr>");
                        } else {
                            out.println("<tr >\n<td>&nbsp;<font color=red>出错信息：</font></td>\n<td>&nbsp;<font color=red>没有找到你所查询的内容，请输入所要查询的参数，如果不确认，可以进行抽象查询，输入所包含字母。</font></td>\n</tr>");
                        }
                        Enumeration em = env.htShowMsg.keys();
                        while (em.hasMoreElements()) {
                            String strParam = (String) em.nextElement();
                            String strParamValue = (String) env.htShowMsg.get(strParam);
                            if (strParam.indexOf(".path", 0) >= 0) {
                                strParamValue = strParamValue.replaceAll(env.queryHashtable("path.separator"), env.queryHashtable("path.separator") + "<br>&nbsp;");
                            }
                            out.println("<tr ><td >&nbsp;" + strParam + "</td><td>&nbsp;" + strParamValue + "</td></tr>");
                        }

                        out.println("</tbody>");
                    }
                %>
            </table> 
            
        </form>
            
        <table border="0" cellpadding="0" cellspacing="1" class="tableBorder table table-bordered table-striped">
            <thead>
                <tr> 
                    <td  onclick="showsubmenu(0)"><strong>服务器相关参数</strong>
                    </td>
                </tr>
            </thead>
            <tbody>
                <tr > 
                    <td width="130">&nbsp;服务器名</td>
                    <td colspan="3" height="22">&nbsp;<%= request.getServerName()%>(<%=request.getRemoteAddr()%>)</td>
                </tr>
                <tr > 
                    <td>&nbsp;服务器操作系统</td>
                    <td colspan="3">&nbsp;<%=env.queryHashtable("os.name")%> <%=env.queryHashtable("os.version")%> 
                        <%=env.queryHashtable("sun.os.patch.level")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;服务器操作系统类型</td>
                    <td>&nbsp;<%=env.queryHashtable("os.arch")%></td>
                    <td>&nbsp;服务器操作系统模式</td>
                    <td>&nbsp;<%=env.queryHashtable("sun.arch.data.model")%>位</td>
                </tr>     
                <tr > 
                    <td>&nbsp;服务器所在地区</td>
                    <td>&nbsp;<%=env.queryHashtable("user.country")%></td>
                    <td>&nbsp;服务器语言</td>
                    <td>&nbsp;<%=env.queryHashtable("user.language")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;服务器时区</td>
                    <td>&nbsp;<%=env.queryHashtable("user.timezone")%></td>
                    <td>&nbsp;服务器时间</td>
                    <td>&nbsp;<%=new java.util.Date()%> </td>
                </tr>
                <tr > 
                    <td>&nbsp;服务器解译引擎</td>
                    <td width="170">&nbsp;<%= getServletContext().getServerInfo()%></td>
                    <td width="130">&nbsp;服务器端口</td>
                    <td width="170">&nbsp;<%= request.getServerPort()%></td>
                </tr>
                <tr > 
                    <td height="22">&nbsp;当前用户</td>
                    <td height="22" colspan="3">&nbsp;<%=env.queryHashtable("user.name")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;用户目录</td>
                    <td colspan="3">&nbsp;<%=env.queryHashtable("user.dir")%></td>
                </tr>
                <tr > 
                    <td align=left >&nbsp;本文件实际路径</td>
                    <td height="8" colspan="3">&nbsp;<%=request.getRealPath(request.getServletPath())%></td>
                </tr>
            </tbody>
        </table>
                
        <a name="JAVAInfo" id="JAVAInfo"></a><br>
        
        <table border="0" cellpadding="0" cellspacing="1" class="tableBorder table table-bordered table-striped">
            <thead>
                <tr> 
                    <td   onclick="showsubmenu(1)"><strong>JAVA相关参数</strong>
                    </td>
                </tr>
            </thead>
            <tbody>
                <tr  height="22"> 
                    <td>&nbsp;名称</td>
                    <td width="50%" height="22">&nbsp;英文名称</td>
                    <td width="20%" height="22">&nbsp;版本</td>
                </tr>
                <tr > 
                    <td>&nbsp;JAVA运行环境名称</td>
                    <td width="50%" height="22">&nbsp;<%=env.queryHashtable("java.runtime.name")%></td>
                    <td width="20%" height="22">&nbsp;<%=env.queryHashtable("java.runtime.version")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;JAVA运行环境说明书名称</td>
                    <td width="50%" height="22">&nbsp;<%=env.queryHashtable("java.specification.name")%></td>
                    <td width="20%" height="22">&nbsp;<%=env.queryHashtable("java.specification.version")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;JAVA虚拟机名称</td>
                    <td width="50%" height="22">&nbsp;<%=env.queryHashtable("java.vm.name")%></td>
                    <td width="20%" height="22">&nbsp;<%=env.queryHashtable("java.vm.version")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;JAVA虚拟机说明书名称</td>
                    <td width="50%" height="22">&nbsp;<%=env.queryHashtable("java.vm.specification.name")%></td>
                    <td width="20%" height="22">&nbsp;<%=env.queryHashtable("java.vm.specification.version")%></td>
                </tr>
                <%
                    float fFreeMemory = (float) Runtime.getRuntime().freeMemory();
                    float fTotalMemory = (float) Runtime.getRuntime().totalMemory();
                    float fPercent = fFreeMemory / fTotalMemory * 100;
                %>
                <tr > 
                    <td height="22">&nbsp;JAVA虚拟机剩余内存：</td>
                    <td height="22" colspan="2">
                        <div class="progress">
                            <div class="progress-bar" style="width:<%=0.85 * fPercent%>%"><%=fFreeMemory / 1024 / 1024%>M 
                            </div>
                        </div> 
                    </td>
                </tr>
                <tr > 
                    <td height="22">&nbsp;JAVA虚拟机分配内存</td>
                    <td height="22" colspan="2">
                        <div class="progress">
                            <div class="progress-bar" style="width:85%"><%=fTotalMemory / 1024 / 1024%>M 
                            </div>
                        </div> 
                    </td>
                </tr>

                <tr height="22"> 
                    <td>&nbsp;参数名称</td>
                    <td colspan="2">&nbsp;参数路径</td>
                </tr>
                <tr > 
                    <td>&nbsp;java.class.path </td>
                    <td colspan="2">&nbsp;<%=env.queryHashtable("java.class.path").replaceAll(env.queryHashtable("path.separator"), env.queryHashtable("path.separator") + "<br>&nbsp;")%>		
                    </td>
                </tr>
                <tr > 
                    <td>&nbsp;java.home</td>
                    <td colspan="2">&nbsp;<%=env.queryHashtable("java.home")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;java.endorsed.dirs</td>
                    <td colspan="2">&nbsp;<%=env.queryHashtable("java.endorsed.dirs")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;java.library.path</td>
                    <td colspan="2">&nbsp;<%=env.queryHashtable("java.library.path").replaceAll(env.queryHashtable("path.separator"), env.queryHashtable("path.separator") + "<br>&nbsp;")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;java.io.tmpdir</td>
                    <td colspan="2">&nbsp;<%=env.queryHashtable("java.io.tmpdir")%></td>
                </tr>
            </tbody>
        </table>
        <a name="Paramter" id="Paramter"></a><br>
        
    </body>
</html>