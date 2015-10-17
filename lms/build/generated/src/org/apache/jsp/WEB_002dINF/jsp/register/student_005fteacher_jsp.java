package org.apache.jsp.WEB_002dINF.jsp.register;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class student_005fteacher_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");

//    将项目的根取出来，页面中不再使用相对路径
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":"
            + request.getServerPort() + path + "/";

      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("\n");
      out.write("<html>\n");
      out.write("\t<head>\n");
      out.write("\t\t<meta charset=\"utf-8\">\n");
      out.write("\t\t<title>注册</title>\n");
      out.write("\t\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/css/bootstrap.css\" />\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/css/stylesheet.css\" />\n");
      out.write("\t\t<link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.print(path);
      out.write("/plugin/stage-self/stage.css\" />\n");
      out.write("\t\t<script src=\"");
      out.print(path);
      out.write("/js/jquery.js\"></script><script src=");
      out.print(path);
      out.write("/js/bootstrap.js\"></script>\n");
      out.write("\t\t<style media=\"screen\">\n");
      out.write("\t\t\t.btn-default{\n");
      out.write("\t\t\t\tcolor: gray;\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\t#role{\n");
      out.write("\t\t\t\tmargin-top:12%;\n");
      out.write("\t\t\t}\n");
      out.write("\n");
      out.write("\t\t\t#role-teacher, #role-student{\n");
      out.write("\n");
      out.write("\t\t\t\tborder: 3px solid rgba(255, 255, 255, 0.4);\n");
      out.write("\t\t\t\tbackground-color: rgba(255, 255, 255, 0.9);\n");
      out.write("\t\t\t\theight: 200px;\n");
      out.write("\t\t\t\twidth: 200px;\n");
      out.write("\t\t\t\tmargin-top: 20px;\n");
      out.write("\t\t\t\tmargin-right: 50px;\n");
      out.write("\t\t\t\tdisplay: inline-block;\n");
      out.write("\t\t\t\ttext-align: center;\n");
      out.write("\t\t\t\tfont-size: 20px;\n");
      out.write("\t\t\t\tline-height: 175px;\n");
      out.write("\t\t\t\ttext-decoration: none;\n");
      out.write("\t\t\t\tcolor: rgba(0, 0, 0, 0.6);\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\t#role-teacher:hover,#role-student:hover{\n");
      out.write("\t\t\t\tborder: 3px dashed rgba(255, 255, 255, 0.9);\n");
      out.write("\t\t\t\tbackground-color: rgba(255, 255, 255, 0.5);\n");
      out.write("\t\t\t\tcolor: rgba(0,0,0,0.9);\n");
      out.write("\n");
      out.write("\t\t\t\t-webkit-transition: all 0.4s ;\n");
      out.write("\t\t\t\t-moz-transition: all 0.4s ;\n");
      out.write("\t\t\t\t-o-transition: all 0.4s ;\n");
      out.write("\t\t\t\ttransition: all 0.4s ;\n");
      out.write("\t\t\t}\n");
      out.write("\t\t</style>\n");
      out.write("\t</head>\n");
      out.write("\t<body  class=\"hidden-x stage-image\"style=\"background-image:url(");
      out.print(path);
      out.write("/image/for-role.jpg)\">\n");
      out.write("\t\t<div class=\"container bg-trans height-control\">\n");
      out.write("\t\t\t<div class=\"row\">\n");
      out.write("\t\t\t\t<div class=\"col-md-3\"></div>\n");
      out.write("\t\t\t\t<div class=\"col-md-6\" id=\"role\">\n");
      out.write("\t\t\t\t\t\t<h1>您是: </h1>\n");
      out.write("\t\t\t\t\t\t<a href=\"teacher_register\" id=\"role-teacher\">老师</a>\n");
      out.write("\t\t\t\t\t\t<a href=\"student_register\" id=\"role-student\">学生</a>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t\t<div class=\"col-md-3\"></div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\t</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
