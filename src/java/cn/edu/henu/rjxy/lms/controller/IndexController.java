/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.model.TempTeacher;
import java.util.Date;
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
    public  @ResponseBody TempTeacher json_test(){
      TempTeacher tempTeacher;
      tempTeacher = new TempTeacher("1445201112", "刘丙戌", "192929299292929292", 4, "12345678901","434353535", "123456", true, 0, new Date());
        
      return tempTeacher;
    }
    //测试json
      @RequestMapping(value = "/json_test12", method = RequestMethod.POST)
    public  @ResponseBody TempTeacher json_test(@RequestBody TempTeacher tempTeacher){
      
        
      return tempTeacher;
    }
}
