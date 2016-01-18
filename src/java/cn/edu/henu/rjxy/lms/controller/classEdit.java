/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.model.Classes;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.server.ClassesMethod;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
@Controller
@RequestMapping("/")
public class classEdit {

    //添加班级  2015年11月28日 18:51:49
    @RequestMapping(value = "/tjbj", method = RequestMethod.POST)
    public @ResponseBody
    String tjbj(HttpServletRequest request, @RequestParam("jssz[]") String[] params) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        ClassesMethod cla = new ClassesMethod();
        cla.addClass(Integer.parseInt(params[0]), params[1]);
        System.out.println(params[0] + ":" + params[1] + "\n" + "添加班级success");
        return "添加成功！";
    }
//查看班级add  in 2015年11月28日 14:50:52

    @RequestMapping(value = "/ckbj_xx", method = RequestMethod.GET)
    public @ResponseBody
    JSONObject fhtjbj(HttpServletRequest request) {
        int pc = Integer.parseInt(request.getParameter("page"));
        int ps = Integer.parseInt(request.getParameter("rows"));
        ClassesMethod cla = new ClassesMethod();
        PageBean<Classes> pb = cla.findAll(pc, ps);
        Map<String, Object> jsonMap = new HashMap<String, Object>();//定义map  
        jsonMap.put("total", pb.getTr());//total键 存放总记录数，必须的  
        jsonMap.put("rows", pb.getBeanList());//rows键 存放每页记录 list  
        //格式化result   一定要是JSONObject  
        return JSONObject.fromObject(jsonMap);
    }
//批准班级   暂时不写
//
//    @RequestMapping("pzbj")
//    public String pzbj(HttpServletRequest request) {
//        int temp = Integer.parseInt(request.getParameter("id"));
//        ClassesMethod cla = new ClassesMethod();
//
//        return "qx";
//    }
    
    
//删除班级
    @RequestMapping(value = "/scbj",method = RequestMethod.POST)
    public  @ResponseBody String scbj(HttpServletRequest request, @RequestParam("jssz[]") String[] params) {
        for (int i=0;i<params.length;i++) {
           new ClassesMethod().deleteClassById(Integer.parseInt(params[i]));
        }
        return "批量删除成功！";
    }
//    @RequestMapping("scbj")
//      public ModelAndView md(HttpServletRequest request){
//        int temp = Integer.parseInt(request.getParameter("id"));
//        ClassesMethod cla = new ClassesMethod();
//        cla.deleteClassById(temp);
//        HashMap map = new HashMap();
//        map.put(map, map);
//        return new ModelAndView("qx");
//      }

//    private int getpc(HttpServletRequest request) {
//        String value = request.getParameter("pc");
//        if (value == null || value.trim().isEmpty()) {
//            return 1;
//        }
//        return Integer.parseInt(value);
//    }
}
