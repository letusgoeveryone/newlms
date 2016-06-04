<%
    //    ����Ŀ�ĸ�ȡ������ҳ���в���ʹ�����·��
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";
%>
<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*,java.lang.*" %>
<%
    /**
     * ******************************************************************
     * Title: JspEnv v Description : JSP����̽�� CopyRight:(c)	2005 www.soho.net.ru
     *
     * @author:	��Ӱ
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
        <title>JSP ̽��</title>
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312">

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
            a       { color: #000000; text-decoration: none}
            body,td,span { font-size: 9pt}
            .input  {BORDER: 1px solid;font-size: 9pt}
            .backc  { BORDER:1px solid;font-size: 9pt;color:white}
            .PicBar { background-color: #f58200; border: 1px solid #000000; height: 12px;}

            .divcenter {
                position:absolute;
                height:30px;
                z-index:1000;
                left: 101px;
                top: 993px;
            }
        </STYLE>
        <script language="javascript">
            function showsubmenu(sid)
            {
                whichEl = eval("submenu" + sid);
                if (whichEl.style.display == "none")
                {
                    eval("submenu" + sid + ".style.display=\"\";");
                    eval("txt" + sid + ".innerHTML=\"<a href='#' title='�رմ���'><font face='Wingdings' color=#FFFFFF>x</font></a>\";");
                } else
                {
                    eval("submenu" + sid + ".style.display=\"none\";");
                    eval("txt" + sid + ".innerHTML=\"<a href='#' title='�򿪴���'><font face='Wingdings' color=#FFFFFF>y</font></a>\";");
                }
            }
        </SCRIPT>
    </head>
    <body style="padding:1px;">

        <!--        <div class="navbar navbar-default" role="navigation">
                    <div class="navbar-header">
                        <a href="#" class="navbar-brand">������</a>
                    </div>
                    <ul class="nav navbar-nav">
                        <li><a class="btn btn-default"  href="#ServerInfo">��������ز���</a></li>
                        <li><a class="btn btn-default"  href="#JAVAInfo">JAVA��ز���</a></li>
                        <li><a class="btn btn-default"  href="#Paramter">������ѯ</a></li>
                        <li><a class="btn btn-default"  href="javascript:location.reload()">ˢ��</a></li>
                    </ul>
                </div>-->
        <div><a class="btn btn-default pull-right"  href="javascript:location.reload()">ˢ��</a></div>
        <br>
        <br>

        <form action="?action=query" method="post" name="queryform">
            <table border="0" cellpadding="0" cellspacing="1" class="table table-bordered">
                <thead>
                    <tr> 
                        <td   onclick="showsubmenu(1)"><strong>ϵͳ������ѯ</strong>
                        </td>
                    </tr>
                    
                <thead>
                <tfoot>
                    <tr > 
                        <td>
                            <div class="form-group">
                                <input type="text" placeholder="�������������" name="query" class="form-control" size="70">
                                <br>

                                <a type="submit" value="�ύ" class="btn btn-default" onClick="document.queryform.submit();$('#srv_qresult').fadeToggle()">��ѯ</a>
                                <a href="#"class="btn btn-default "onClick="document.queryform.submit()">ö�����в�����Ϣ</a>
                                <a type="reset" value="����" class="btn btn-default pull-right" onclick="$('#srv_qresult').fadeOut()">���</a>
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
                            out.println("<tr  >\n<td>&nbsp;��������</td>\n<td>&nbsp;������Ϣ</td>\n</tr>");
                        } else {
                            out.println("<tr >\n<td>&nbsp;<font color=red>������Ϣ��</font></td>\n<td>&nbsp;<font color=red>û���ҵ�������ѯ�����ݣ���������Ҫ��ѯ�Ĳ����������ȷ�ϣ����Խ��г����ѯ��������������ĸ��</font></td>\n</tr>");
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
                    <td  onclick="showsubmenu(0)"><strong>��������ز���</strong>
                    </td>
                </tr>
            </thead>
            <tbody>
                <tr > 
                    <td width="130">&nbsp;��������</td>
                    <td colspan="3" height="22">&nbsp;<%= request.getServerName()%>(<%=request.getRemoteAddr()%>)</td>
                </tr>
                <tr > 
                    <td>&nbsp;����������ϵͳ</td>
                    <td colspan="3">&nbsp;<%=env.queryHashtable("os.name")%> <%=env.queryHashtable("os.version")%> 
                        <%=env.queryHashtable("sun.os.patch.level")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;����������ϵͳ����</td>
                    <td>&nbsp;<%=env.queryHashtable("os.arch")%></td>
                    <td>&nbsp;����������ϵͳģʽ</td>
                    <td>&nbsp;<%=env.queryHashtable("sun.arch.data.model")%>λ</td>
                </tr>     
                <tr > 
                    <td>&nbsp;���������ڵ���</td>
                    <td>&nbsp;<%=env.queryHashtable("user.country")%></td>
                    <td>&nbsp;����������</td>
                    <td>&nbsp;<%=env.queryHashtable("user.language")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;������ʱ��</td>
                    <td>&nbsp;<%=env.queryHashtable("user.timezone")%></td>
                    <td>&nbsp;������ʱ��</td>
                    <td>&nbsp;<%=new java.util.Date()%> </td>
                </tr>
                <tr > 
                    <td>&nbsp;��������������</td>
                    <td width="170">&nbsp;<%= getServletContext().getServerInfo()%></td>
                    <td width="130">&nbsp;�������˿�</td>
                    <td width="170">&nbsp;<%= request.getServerPort()%></td>
                </tr>
                <tr > 
                    <td height="22">&nbsp;��ǰ�û�</td>
                    <td height="22" colspan="3">&nbsp;<%=env.queryHashtable("user.name")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;�û�Ŀ¼</td>
                    <td colspan="3">&nbsp;<%=env.queryHashtable("user.dir")%></td>
                </tr>
                <tr > 
                    <td align=left >&nbsp;���ļ�ʵ��·��</td>
                    <td height="8" colspan="3">&nbsp;<%=request.getRealPath(request.getServletPath())%></td>
                </tr>
            </tbody>
        </table>
        <a name="JAVAInfo" id="JAVAInfo"></a><br>
        <table border="0" cellpadding="0" cellspacing="1" class="tableBorder table table-bordered table-striped">
            <thead>
                <tr> 
                    <td   onclick="showsubmenu(1)"><strong>JAVA��ز���</strong>
                    </td>
                </tr>
            </thead>
            <tbody>
                <tr  height="22"> 
                    <td>&nbsp;����</td>
                    <td width="50%" height="22">&nbsp;Ӣ������</td>
                    <td width="20%" height="22">&nbsp;�汾</td>
                </tr>
                <tr > 
                    <td>&nbsp;JAVA���л�������</td>
                    <td width="50%" height="22">&nbsp;<%=env.queryHashtable("java.runtime.name")%></td>
                    <td width="20%" height="22">&nbsp;<%=env.queryHashtable("java.runtime.version")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;JAVA���л���˵��������</td>
                    <td width="50%" height="22">&nbsp;<%=env.queryHashtable("java.specification.name")%></td>
                    <td width="20%" height="22">&nbsp;<%=env.queryHashtable("java.specification.version")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;JAVA���������</td>
                    <td width="50%" height="22">&nbsp;<%=env.queryHashtable("java.vm.name")%></td>
                    <td width="20%" height="22">&nbsp;<%=env.queryHashtable("java.vm.version")%></td>
                </tr>
                <tr > 
                    <td>&nbsp;JAVA�����˵��������</td>
                    <td width="50%" height="22">&nbsp;<%=env.queryHashtable("java.vm.specification.name")%></td>
                    <td width="20%" height="22">&nbsp;<%=env.queryHashtable("java.vm.specification.version")%></td>
                </tr>
                <%
                    float fFreeMemory = (float) Runtime.getRuntime().freeMemory();
                    float fTotalMemory = (float) Runtime.getRuntime().totalMemory();
                    float fPercent = fFreeMemory / fTotalMemory * 100;
                %>
                <tr > 
                    <td height="22">&nbsp;JAVA�����ʣ���ڴ棺</td>
                    <td height="22" colspan="2">
                        <div class="progress">
                            <div class="progress-bar" style="width:<%=0.85 * fPercent%>%"><%=fFreeMemory / 1024 / 1024%>M 
                            </div>
                        </div> 
                    </td>
                </tr>
                <tr > 
                    <td height="22">&nbsp;JAVA����������ڴ�</td>
                    <td height="22" colspan="2">
                        <div class="progress">
                            <div class="progress-bar" style="width:85%"><%=fTotalMemory / 1024 / 1024%>M 
                            </div>
                        </div> 
                    </td>
                </tr>
                
                <tr height="22"> 
                    <td>&nbsp;��������</td>
                    <td colspan="2">&nbsp;����·��</td>
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