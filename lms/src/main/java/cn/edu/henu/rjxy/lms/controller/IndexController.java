/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;


import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.server.CurrentInfo;
import cn.edu.henu.rjxy.lms.server.AuthorityManage;
import java.util.Calendar;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
    public String login() {
        return "redirect:/login";
    }
    

    //重定向到主页
    @RequestMapping("/reg/guest")
    public String guest() {
        return "redirect:/guest ";
    }
    
    //重定向当前头像
    @RequestMapping("/getavatar.svg")
    public String getAvatar() {
        int imgid=-1;
        String sn=AuthorityManage.getCurrentUsername();
        boolean sex=true;
        Teacher tea;
        Student stu;
        try {
            tea=TeacherDao.getTeacherBySn(sn);
            imgid=tea.getTeacherImg();
            sex=tea.getTeacherSex();
        } catch (Exception e) {
        }
        if (imgid==-1) {
            try {
                stu=StudentDao.getStudentBySn(sn);
                imgid=stu.getStudentImg();
                sex = stu.getStudentSex();
            } catch (Exception e) {
            } 
        }
        if (imgid<=0) {//默认头像
            if (sex) {
                return "redirect:/images/avatar/male.svg";  //男
            }else{
                return "redirect:/images/avatar/female.svg";//女
            }
            
        }
        return "redirect:/images/avatar/"+imgid+".svg";
    }
    
    //前台显示学院
    @RequestMapping("/reg/hq_xy")
    public @ResponseBody List<String> xy(HttpServletRequest request){
      return CurrentInfo.getAllCollege();
    }
    
    //学期返回前台,下拉框显示
    @RequestMapping("/fhxq")
    public @ResponseBody List<String> xq(HttpServletRequest request){
        return CurrentInfo.getAllTerm();
    }
      //年级返回前台,下拉框显示
    @RequestMapping("/reg/fhnj")
    public @ResponseBody List<String> nj(HttpServletRequest request){
        return CurrentInfo.getAllGrade();
    }
     //关于我们
    @RequestMapping("us")
    public String aboutus(){
        return "redirect:/login";
        ///return "us";
    }
     
    public String getFileFolder(HttpServletRequest request) {
        String path = this.getClass().getClassLoader().getResource("/").getPath();
        System.out.println(path);
        path=path.replace("target/classes/", "web/file/");
        System.out.println(path);
        return path;        
    }  
}
