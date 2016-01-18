/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.Course1;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.server.CourseMethod;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Administrator
 */
@Controller
@RequestMapping("/")
public class CourseEdit {
    //添加课程

    /**
     *
     * @param request
     * @param params
     *
     * @return
     */
    @RequestMapping(value = "course_add", method = RequestMethod.POST)
    public @ResponseBody
    String pz2(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        String course_number = params[0];
        String course_name = params[1];
        String course_Ename =params[2];
        String  courseType = params[3];
        int faceTeacherHourse =Integer.parseInt(params[4]);
        int testTeacherHourse = Integer.parseInt(params[5]);
        int course_cridet = Integer.parseInt(params[6]);  
        System.out.println(courseType);
        new CourseMethod().addCourse(course_number, course_name, course_Ename, courseType, faceTeacherHourse, testTeacherHourse, course_cridet);
       
        return "success";
    }

    //课程显示
    @RequestMapping("course_fanhui")
    public @ResponseBody
    JSONObject course_fanhui(HttpServletRequest request, HttpServletResponse response) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        PageBean<Course> pb = new CourseMethod().findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }
    
    //课程delete
    @RequestMapping("sckc")
    public @ResponseBody
    String sckc(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        for(int i = 0;i < params.length;i++){
          new CourseMethod().deleteCourse(Integer.parseInt(params[i]));
        }
        return "批准删除成功";
    }
    
}
