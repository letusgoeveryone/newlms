/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.server.TermOpenCourseMethod;
import java.util.Calendar;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/")
public class Next_term_course {
    @RequestMapping("tj_next_course")
    public @ResponseBody String tj_next_course(HttpServletRequest request, @RequestParam("jssz[]") String[] params,
            @RequestParam("tecgh[]") String[] tec_gh,@RequestParam("term[]") String[] term){
        List list = new LinkedList();
        for(int i = 0;i<tec_gh.length;i++){
            list.addAll(TeacherDao.getTeacherByUserName(tec_gh[i]).getList());
        }
        Iterator<Teacher> it = list.iterator();
        int  j= 0;
        while (it.hasNext()) {
            Teacher next = it.next();
           // System.out.print(next.getTeacherId());
            tec_gh[j] = next.getTeacherId()+"";
            j++;
        }
        for(int i = 0;i<tec_gh.length;i++){
             new TermOpenCourseMethod().saveOpenCourse(Integer.parseInt(term[0]), Integer.parseInt(tec_gh[i]),Integer.parseInt( params[i]));
        }
       return "添加成功";
    }
}
