
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseDao;
import cn.edu.henu.rjxy.lms.dao.TermCourseInfoDao;
import cn.edu.henu.rjxy.lms.server.AuthorityManage;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author 刘昱
 */
@Controller
public class GuestController {
    //游客首页
    @RequestMapping("/guest")
    public String guestindex(HttpServletRequest request, HttpServletResponse response) {
       String sn=AuthorityManage.getCurrentUsername();//anonymousUser
       if(sn.equals("anonymousUser")){
            return "/guest/Index";
       }else{
            return "redirect:/loginsuccess";
       }  
    }
    //所有课程列表
    @RequestMapping("/guest/getcoulist")
    public @ResponseBody Map[] getcoulist(HttpServletRequest request, HttpServletResponse response) {
        List<String> list=CourseDao.findAllCourse2();
        Map []a = new Map[list.size()/2];      
        for (int i = 0; i < list.size()/2; i++) {
            a[i]=new HashMap();
            a[i].put("course", list.get(2*i));
            a[i].put("cid", list.get(2*i+1));
        }
        return a;
    }
   //课程简介和大纲json
   @RequestMapping("/guest/coudetails")
    public  @ResponseBody String[]  guestcour(HttpServletRequest request, HttpServletResponse response) {
        int cid =Integer.valueOf(request.getParameter("cid"));
        int term=getCurrentTerm();
        String []a = new String[2];
        a[0]=TermCourseInfoDao.getCourseInfo(term, cid, 0);
        a[1]=TermCourseInfoDao.getCourseInfo(term, cid, 1);
        if(a[0].equals(""))a[0]="暂无";
        if(a[1].equals(""))a[1]="暂无";
        return a;
    }
    //当前学期
   public int getCurrentTerm() {
      return 201601;
   }
}
