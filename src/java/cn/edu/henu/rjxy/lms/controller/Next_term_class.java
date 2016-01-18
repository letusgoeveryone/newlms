/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.model.Classes;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.TermClass;
import cn.edu.henu.rjxy.lms.server.ClassesMethod;
import cn.edu.henu.rjxy.lms.server.CourseMethod;
import cn.edu.henu.rjxy.lms.server.TermClassMethod;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/")
public class Next_term_class {
   //添加班级
    @RequestMapping(value = "/tj_next_bj", method = RequestMethod.POST)
    public @ResponseBody
    String tj_next_bj(HttpServletRequest request, @RequestParam("jssz[]") String[] params
            ,@RequestParam("term[]") String[] terms) {
        for(int i = 0;i < params.length;i++){
        new TermClassMethod().saveTermClass(Integer.parseInt(params[i]),Integer.parseInt(terms[0]));
        }
        return "sucess";
    }
    //显示学期班级
    
    @RequestMapping(value = "/next_bj",method = RequestMethod.POST)
    public @ResponseBody JSONObject next_bj(HttpServletRequest request){
       int term = Integer.parseInt(request.getParameter("term"));
       int pc = Integer.parseInt(request.getParameter("page"));
       int ps = Integer.parseInt(request.getParameter("rows"));
       PageBean<TermClass> pb =  new TermClassMethod().findAll(term, pc, ps);
       System.out.println(pb.getClass()+":"+pb.getPs());
       Map<String, Object> jsonMap = new HashMap<String, Object>();
       jsonMap.put("total", pb.getTr());
       jsonMap.put("rows",  pb.getBeanList());
       return JSONObject.fromObject(jsonMap);          
    }
}
