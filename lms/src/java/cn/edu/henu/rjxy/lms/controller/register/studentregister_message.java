/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.server.TempStudentAddMessagelmpl;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Administrator
 */
@Controller
@RequestMapping("/reg")
public class studentregister_message {

//    TempStudentAddMessagelmpl tempStudentAddMessagelmpl =  new TempStudentAddMessagelmpl();
    @RequestMapping("/student_register_message")
    public String student_sign_message1(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException, ParseException {
        request.setCharacterEncoding("UTF-8");//以免得到的姓名为乱码
        TempStudent stu = new TempStudent();

        Integer stu_sn = Integer.parseInt(request.getParameter("idCard"));
        String stu_college = request.getParameter("xueyuan");
        Integer stu_niji = Integer.parseInt(request.getParameter("niji"));
        String stuName = request.getParameter("name");
        String stuIdcard = request.getParameter("myIDNum");
        String stuTel = request.getParameter("myPhone");
        String stuQq = request.getParameter("myQq");
        String stuPwd = request.getParameter("password_md5");
        
        stu.setStuName(stuName);
        stu.setStuIdcard(stuIdcard);
        stu.setStuTel(stuTel);
        stu.setStuQq(stuQq);
        stu.setStuPwd(stuPwd);
        stu.setStuSn(stu_sn);
       // stu.setStuCollegeId(stuCollegeId);string 
        stu.setStuClassId(stu_niji);

        //测试数据
        System.out.println("学号" + stu_sn);
        System.out.println("身份证" + stuIdcard);
        System.out.println("电话" + stuTel);
        System.out.println("qq" + stuQq);
        System.out.println("密码" + stuPwd);
        System.out.println("姓名" + stuName);
        System.out.println("年级" + stu_niji);
        System.out.println("学院" + stu_college);
    
        return "register/success";
    }
}
