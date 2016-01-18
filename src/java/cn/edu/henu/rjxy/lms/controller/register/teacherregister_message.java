/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.server.TempTeacherMethod;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Administrator
 */
@Controller
@RequestMapping("/reg")
public class teacherregister_message {

    @RequestMapping("/teacher_register_message")
    public String teacher_register_message1(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ParseException, ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        TempTeacher teacher = new TempTeacher();

        HttpSession session = request.getSession();
        String ccd = (String) session.getAttribute("hccd");
        String ccd1 = request.getParameter("ccd");
        ccd = ccd.toLowerCase();
        ccd1 = ccd1.toLowerCase();
        if (!ccd.equals(ccd1)) {
            request.setAttribute("Errors", "你输入的验证码错误，请重新注册!");
            request.getRequestDispatcher("teacher_register").forward(request, response);
        }

        Integer teacher_id = Integer.parseInt(request.getParameter("idCard"));//工号
        String teacher_name = request.getParameter("name1");//姓名
        String teacher_idcard = request.getParameter("myIDNum");//身份证 
        String teacher_Vname = request.getParameter("Vname");//职称
        String teacher_sex = request.getParameter("xingbie");//性别
        //   Integer teacher_college_id = Integer.parseInt(request.getParameter("Grade"));//年级 
        String xueyuan = request.getParameter("Institute");  // xueyuan
        String teacher_tel = request.getParameter("myPhone");//手机号 
        String teacher_qq = request.getParameter("myQq");//qq 
        String teacher_pwd = request.getParameter("password_md5");//密码 
        //职称有问题，，类型不符
        TempTeacherMethod.addTempTeacherMessage(teacher_id.toString(), teacher_name, teacher_idcard, xueyuan,  teacher_tel, teacher_qq, teacher_pwd, teacher_sex, teacher_Vname, new Date());
        return "register/success";
    }
  
    //检查工号是否重复
     @RequestMapping("/cj_gh")
       public @ResponseBody
       String pz(HttpServletRequest request, @RequestParam("jssz") String params) {
       if(TeacherDao.getTeacherNameBySn(params)){
           System.out.println("存在");
            return "1";
       }else{
            System.out.println("不存在");
            return "0";
       }  
    }
    
     public static void main(String[] args) {
      for(int i = 0; i<200;i++){
        TempTeacherMethod.addTempTeacherMessage("1445203130"+i,"刘冰许"+i,"411121199412454587","软件学院","1313","127464454","2315454","男","教师",new Date());
      }
    }
            
}
