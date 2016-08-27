package cn.edu.henu.rjxy.lms.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import cn.edu.henu.rjxy.lms.server.DocConverter;
import java.io.File;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 *
 * @author 刘昱
 */
@Controller
public class FileController {
    
    @RequestMapping("/file")
    public String FileString(HttpServletRequest request, HttpServletResponse response) {
        String uri = request.getParameter("uri");
        uri = uri.replaceAll("\\\\", "/");
        uri = uri.replaceAll("//", "/");
        System.out.println(uri);
        request.setAttribute("uri", "file/" + uri);
        return "/file"+uri;
    }
    
    @RequestMapping("/getswf")
    public String Filegetswf(HttpServletRequest request, HttpServletResponse response) {
        String uri=request.getParameter("uri");
        uri=uri.replaceAll("\\\\", "/");
        uri=uri.replaceAll("//", "/");
        System.out.println(uri);
	request.setAttribute("uri","file/"+uri);
	return "getswf"; 
    }
    
    @RequestMapping("/getvideo")
    public String Filegetvideo(HttpServletRequest request, HttpServletResponse response) {
        String uri=request.getParameter("uri");
        uri=uri.replaceAll("\\\\", "/");
        uri=uri.replaceAll("//", "/");
        System.out.println(uri);
	request.setAttribute("uri","file/"+uri);
	return "getvideo"; 
    }
    
    @RequestMapping("/officedocconverter")
    public @ResponseBody String officedocconverter(HttpServletRequest request, HttpServletResponse response) {
        String uri=request.getClass().getResource("/").getFile().toString()+request.getParameter("uri");
        uri=uri.replace("lms/target/lms-1.0/WEB-INF/classes/", "lms/target/lms-1.0/file/");
        uri=uri.replaceAll("\\\\", "/");
        File f = new File(uri.substring(0,uri.lastIndexOf("."))+".swf");  // 输入要删除的文件位置
        if(f.exists())
        f.delete();
        DocConverter dc=new DocConverter(uri);
	boolean res=dc.conver();
        if (res) {
            try {
               // response.sendRedirect("/getswf?uri=");
                System.out.println(uri.substring(uri.lastIndexOf("\\")+1,uri.lastIndexOf(".")));
                response.sendRedirect(request.getContextPath()+"/getswf?uri="+uri.substring(uri.lastIndexOf("\\")+1,uri.lastIndexOf("."))+".swf");
            } catch (IOException ex) {
               
            }
           return uri+ " 转换成功" ;
        } else {
          return uri+ " 转换失败";
        }
        
	
    }
}
