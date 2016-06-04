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
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Calendar;
import static java.util.Collections.list;
import java.util.Date;
import java.util.HashMap;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author liubingxu
 */
@Controller
@RequestMapping("/")
public class IndexController {
    //主页映射
    @RequestMapping("/index")
    public String index1() {
        return "redirect:/login";
    }
    

    //重定向到主页
    @RequestMapping("/reg/guest")
    public String index2() {
        return "redirect:/guest ";
    }

    //前台显示学院
    @RequestMapping("/reg/hq_xy")
    public @ResponseBody String[] xy(HttpServletRequest request){
       String str[] = {
       "软件学院",
       "文学院",
       "历史文化学院",
       "教育科学学院",
       "哲学与公共管理学院",
       "法学院",
       "新闻与传播学院",
       "外语学院",
       "经济学院",
       "商学院",
       "数学与统计学院",
       "物理与电子学院",
       "计算机与信息工程学院",
       "环境与规划学院",
       "生命科学学院",
       "化学化工学院",
       "土木建筑学院",
       "艺术学院",
       "体育学院",
       "医学院",
       "药学院",
       "护理学院",
       "淮河临床学院",
       "东京临床学院",
       "国际教育学院",
       "民生学院",
       "国际汉学院",
       "欧亚国际学院",
       "人民武装学院",
       "远程与继续教育学院",
       "马克思主义学院",
       "大学外语教学部",
       "公共体育部",
       "军事理论教研部"
       };
      
      return str;
    }
    
    //学期返回前台,下拉框显示
       @RequestMapping("/fhxq")
        public @ResponseBody String[] xq(HttpServletRequest request){
            Calendar now = Calendar.getInstance();  
            int year = now.get(Calendar.YEAR);
            String str[] = {
                year+"01",
                year+"02",
                year+"03",
                year-1+"01",
                year-1+"02",
                year-1+"03",
                year+1+"01" 
            };
           return str;
        }
         //年级返回前台,下拉框显示
       @RequestMapping("/reg/fhnj")
        public @ResponseBody String[] nj(HttpServletRequest request){
            Calendar now = Calendar.getInstance();  
            int year = now.get(Calendar.YEAR);
            String str[] = {
                year+"",
                year-1+"",
                year-2+"",
                year-3+"",
                year-4+"",
                year-5+"",
                year-6+""
            };
           return str;
        }
        //关于我们
        @RequestMapping("about_us")
        public String aboutus(){
            return "about_us";
        }
      
        
        
        public String getFileFolder(HttpServletRequest request) {
        String path = this.getClass().getClassLoader().getResource("/").getPath();
        System.out.println(path);
        path=path.replace("target/classes/", "web/file/");
        System.out.println(path);
        return path;        
    }  
}
