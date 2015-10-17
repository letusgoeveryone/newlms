/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;

import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.server.TempTeacherAddMessagelmpl;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Administrator
 */
@Controller
@RequestMapping("/reg")
public class teacherregister_message {

    TempTeacherAddMessagelmpl tempTeacherAddMessagelmpl = new TempTeacherAddMessagelmpl();

    @RequestMapping("/teacher_register_message")
    public String teacher_register_message1(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ParseException {
        request.setCharacterEncoding("utf-8");
        TempTeacher teacher = new TempTeacher();

        Integer teacher_id = Integer.parseInt(request.getParameter("idCard"));
        String teacher_name = request.getParameter("name");
        String teacher_idcard = request.getParameter("myIDNum");
        Integer teacher_college_id = Integer.parseInt(request.getParameter("niji"));
        String teacher_tel = request.getParameter("myPhone");
        String teacher_qq = request.getParameter("myQq");
         String teacher_pwd = request.getParameter("password_md5");
        String xueyuan = request.getParameter("xueyuan");     
//        Integer teacher_id = Integer.parseInt(request.getParameter("teacher_id"));
//        Integer teacher_sn = Integer.parseInt(request.getParameter("teacher_sn"));
//        Integer teacher_postion_id = Integer.parseInt(request.getParameter("teacher_postion_id"));
//        Integer teacher_college_id = Integer.parseInt(request.getParameter("teacher_college_id"));
//        //Integer teacher_depart_id = Integer.parseInt(request.getParameter("teacher_depart_id"));
//        Long teacher_depart_id = Long.parseLong(request.getParameter("teacher_depart_id"));
//        SimpleDateFormat zh = new SimpleDateFormat("yyyyMMdd");//生日格式
//        Date teacher_birthday = zh.parse(request.getParameter("teacher_birthday"));
//        Date teacher_enrolling = zh.parse(request.getParameter("teacher_enrolling"));
////        
//        teacher.setTeacherBirthday(teacher_birthday);
//        teacher.setTeacherCollegeId(teacher_college_id);
//        teacher.setTeacherDepartId(teacher_id);
//        teacher.setTeacherEmail(teacher_email);
//        teacher.setTeacherEnrolling(teacher_enrolling);
//        teacher.setTeacherId(teacher_id);
//        teacher.setTeacherIdcard(teacher_idcard);
//        teacher.setTeacherName(teacher_name);
//        teacher.setTeacherPositionId(teacher_postion_id);
//        teacher.setTeacherPwd(teacher_pwd);
//        teacher.setTeacherQq(teacher_qq);
//      //  teacher.set(teacher_depart_id);//数据库没这选项
//        teacher.setTeacherSex(true);//注意的地方
//        teacher.setTeacherSn(teacher_sn);
//        teacher.setTeacherTel(teacher_tel);
//        
//       

        System.out.println(teacher_id);
        System.out.println(teacher_name);
        System.out.println(teacher_idcard);
        System.out.println(teacher_college_id);
        System.out.println(teacher_tel);
        System.out.println(teacher_qq);
        System.out.println(teacher_pwd);
        System.out.println(xueyuan);
        
        return "register/success";
    }
}
