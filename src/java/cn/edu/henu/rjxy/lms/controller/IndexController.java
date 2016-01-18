/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.TempStudentDao;

import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import cn.edu.henu.rjxy.lms.server.StudentMethod;
import cn.edu.henu.rjxy.lms.server.TempStudentMethod;
import cn.edu.henu.rjxy.lms.server.TempTeacherMethod;
import static cn.edu.henu.rjxy.lms.server.TempTeacherMethod.getTempTeacherByCollegeName;
import static java.util.Collections.list;
import java.util.HashMap;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author liubingxu
 */
@Controller
@RequestMapping("/")
public class IndexController {//主页映射

    @RequestMapping("index")
    public String index1() {
        return "index";
    }

    @RequestMapping("reg/index1")//重定向到主页
    public String index2() {
        return "redirect:/index ";
    }

    //json_test
    //根据学院返回教师信息 
    @RequestMapping(value = "/json_test89", method = RequestMethod.GET)
    public @ResponseBody
    Iterator<TempTeacherWithoutPwd> json_test1() {
        List list = getTempTeacherByCollegeName("软件学院");
        Iterator<TempTeacherWithoutPwd> iterator = list.iterator();
        return iterator;
    }

    //所有老师信息返回
    @RequestMapping(value = "/json_test90", method = RequestMethod.GET)
    public @ResponseBody
    List json_test01() {
        return TempTeacherDao.getAllTempTeacher();
    }

    // 学生所有信息返回
    @RequestMapping("/json_test88")
    public @ResponseBody
    List json_test() {
        return TempStudentDao.getAllTempStudent();
    }

    //2015年11月26日 21:23:45   add for easyui 临时教师分页
    @RequestMapping(value = "/fhjsxx", method = RequestMethod.GET)
    public @ResponseBody
    JSONObject json_test2(HttpServletRequest request, HttpServletResponse response) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        System.out.println(pc);
        System.out.println(ps);
        TempTeacherMethod teacherMethod = new TempTeacherMethod();
        PageBean<TempTeacher> pb = teacherMethod.findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }
//
//    @RequestMapping("fhjsxx")//console_dean yemian
//    public ModelAndView json_test2(HttpServletRequest request, HttpServletResponse response) {
//        int pc = getpc(request);
//        int ps = 10;
//        TempTeacherMethod teacherMethod = new TempTeacherMethod();
//        PageBean<TempTeacher> pb = teacherMethod.findAll(pc, ps);
//        // request.setAttribute("pb", pb);
//        HashMap map = new HashMap();
//        map.put("pb", pb);
//        return new ModelAndView("newjsp",map);
//    }
//     @RequestMapping("fhjsxx/{pc}")//console_dean yemian
//    public ModelAndView json_test3(HttpServletRequest request, HttpServletResponse response,@PathVariable(value="pc") Integer pc) {
//       
//        int ps = 10;
//        TempTeacherMethod teacherMethod = new TempTeacherMethod();
//        PageBean<TempTeacher> pb = teacherMethod.findAll(pc, ps);
//        // request.setAttribute("pb", pb);
//        HashMap map = new HashMap();
//        map.put("pb", pb);
//        return new ModelAndView("newjsp",map);
//    }

    @RequestMapping("/fhstume")//临时学生分页
    public @ResponseBody
    JSONObject fhstume(HttpServletRequest request, HttpServletResponse response) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        System.out.println(pc);
        System.out.println(ps);
        PageBean<TempStudent> pb = TempStudentMethod.findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }

//    private int getpc(HttpServletRequest request) {
//        String value = request.getParameter("pc");
//        if (value == null || value.trim().isEmpty()) {
//            return 1;
//        }
//        return Integer.parseInt(value);
//    }

    //后台显示学院
    @RequestMapping("/hq_xy")
    public @ResponseBody String xy(HttpServletRequest request){
      String jssz[] ={
       "rjxy",
       "yxy"
      };
      request.setAttribute("jssz", jssz);
      return "success";
    }
}
