/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.model.TempTeacher;
import static cn.edu.henu.rjxy.lms.server.TempTeacherMethod.getTempTeacherByCollegeName;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author liubingxu
 */
@Controller
@RequestMapping("/")
public class IndexController {//主页映射
    @RequestMapping("index")
    public String index1(){
        return "index";
    }
    @RequestMapping("reg/index1")//重定向到主页
    public String index2(){
        return  "redirect:/index ";
    }
    //    测试json
   
    @RequestMapping(value = "/json_test88", method = RequestMethod.GET)
    public  @ResponseBody  Iterator<TempTeacher> json_test(){
       List list= getTempTeacherByCollegeName("软件学院");
       Iterator<TempTeacher> iterator = list.iterator();
      return iterator;
    }
    //测试json
      @RequestMapping(value = "/json_test12", method = RequestMethod.GET)
    public  @ResponseBody Iterator<TempTeacher> json_test1(){
       List list= getTempTeacherByCollegeName("软件学院");
       Iterator<TempTeacher> iterator = list.iterator();
        
      return iterator;
    }
}
