/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import static cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil.getIdByCollegeName;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.server.TempTeacherAddMessagelmpl;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
        if (!ccd.equals(ccd1)) {
            request.setAttribute("Errors", "验证码错误，请重新注册!");
            request.getRequestDispatcher("teacher_register").forward(request, response);
        }

        Integer teacher_id = Integer.parseInt(request.getParameter("idCard"));//工号
        String teacher_name = request.getParameter("name1");//姓名
        String teacher_idcard = request.getParameter("myIDNum");//身份证 
        String teacher_Vname = request.getParameter("Vname");//职称
        String teacher_sex = request.getParameter("xingbie");//性别
     //   Integer teacher_college_id = Integer.parseInt(request.getParameter("Grade"));//年级 
        String xueyuan = request.getParameter("Institute");  // 系
        String teacher_tel = request.getParameter("myPhone");//手机号 
        String teacher_qq = request.getParameter("myQq");//qq 
        String teacher_pwd = request.getParameter("password_md5");//密码 
       
        System.out.println(teacher_id);
        System.out.println(teacher_name);
        System.out.println(teacher_idcard);
        System.out.println(teacher_tel);
        System.out.println(teacher_qq);
        System.out.println(teacher_pwd);
        System.out.println(xueyuan);
        System.out.println(teacher_sex);
        System.out.println(teacher_Vname);
        
        //职称有问题，，类型不符
        TempTeacherAddMessagelmpl.addTempTeacherMessage(teacher_id, teacher_name, teacher_idcard, xueyuan, 0, teacher_tel, teacher_qq, teacher_pwd, teacher_sex, 2, new Date());
        return "register/success";
    }
}
