/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.server.TempStudentAddMessagelmpl;
import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Administrator
 */
@Controller
public class studentregister_message {

    TempStudentAddMessagelmpl tempStudentAddMessagelmpl = new TempStudentAddMessagelmpl();

    @RequestMapping("/reg/student_register_message")
    public String student_sign_message1(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException, ParseException, ServletException {
        request.setCharacterEncoding("UTF-8");//以免得到的姓名为乱码
        TempStudent stu = new TempStudent();           
        HttpSession session = request.getSession();
        String ccd = (String) session.getAttribute("hccd");
        String ccd1 = request.getParameter("ccd");
        if (!ccd.equals(ccd1)) {
            request.setAttribute("Error", "验证码错误，请重新注册!"); 
            request.getRequestDispatcher("student_register").forward(request,response); 
        }

        
        Integer stu_sn = Integer.parseInt(request.getParameter("idCard"));//学号
        String stu_college = request.getParameter("xueyuan");//院系
        String stu_sex = request.getParameter("xingbie");//性别
        Integer stu_niji = Integer.parseInt(request.getParameter("niji"));// 年级
        String stuName = request.getParameter("name");//姓名
        String stuIdcard = request.getParameter("myIDNum");// 身份证 
        String stuTel = request.getParameter("myPhone");//手机号
        String stuQq = request.getParameter("myQq");//qq
        String stuPwd = request.getParameter("password_md5");//密码 
        //性别
        //注册时间

        stu.setStudentSn(stu_sn);
        stu.setStudentName(stuName);
        stu.setStudentGrade(HibernateUtil.getIdByCollegeName(stu_college));
        stu.setStudentGrade(stu_niji);
        stu.setStudentIdcard(stuIdcard);
        stu.setStudentTel(stuTel);
        stu.setStudentQq(stuQq);
        stu.setStudentPwd(stuPwd);
        stu.setStudentSex(true);
        stu.setStudentEnrolling(new Date());
     
        System.out.println("性别:" + stu_sex);
       
        TempStudentAddMessagelmpl.addTempStudentMessage(stu_sn, stuName, stuIdcard, stu_niji, stu_college, stuTel, stuQq, stuPwd, stu_sex, new Date());
        return "register/success";
    }
}
