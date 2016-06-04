
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseInfoDao;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author 刘昱
 */
@Controller
public class GuestController {
    
    @RequestMapping("/guest")
    public String guestindex(HttpServletRequest request, HttpServletResponse response) {
       String sn=SecurityContextHolder.getContext().getAuthentication().getName();//anonymousUser
       if(sn.equals("anonymousUser")){
            List<String> l=CourseDao.findAllCourse2();
            StringBuffer sb=new StringBuffer();
            String at="";
             for (int i = 0; i < l.size()/2; i++) {
                 if(at.equals("")){at="guestcour?cid="+l.get((2*i)+1);}
                 sb.append("<li class=\"course-item\"><a href=\"guestcour?cid="+l.get((2*i)+1)+"\" target=\"content\">"+l.get(2*i)+"</a></li>");
             }
             request.setAttribute("Courselist",sb.toString());
             request.setAttribute("firstpage",at);
             request.setAttribute("logname",getCurrentUsername());
             return "/guest/Index";
       }else{
        return "redirect:/loginsuccess";
       }
       
    }
   @RequestMapping("/guest/GuesTour")
    public String guestcour(HttpServletRequest request, HttpServletResponse response) {
        String cid = request.getParameter("cid");
        int term=201601;

        request.setAttribute("syllabusspan2",TermCourseInfoDao.getCourseInfo(term, Integer.parseInt(cid), 1));
        request.setAttribute("CourseDescription2",TermCourseInfoDao.getCourseInfo(term, Integer.parseInt(cid), 0));
  
        return "guest/GuesTour";
    }
     public String getCurrentUsername() {
      return SecurityContextHolder.getContext().getAuthentication().getName();
   }
}
