/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;

import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
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
        session.removeAttribute("hccd");//使当前验证码失效，否则将导致一个验证码能成功注册多个账号。刘昱注        
        String teacher_sn = request.getParameter("tn");//工号
        String teacher_name = request.getParameter("name");//姓名
        String teacher_idcard = request.getParameter("ID");//身份证 
        String teacher_Vname = request.getParameter("Vname");//职称
        String teacher_sex = request.getParameter("sex");//性别
        String xueyuan = request.getParameter("institute");  // xueyuan
        String teacher_tel = request.getParameter("tel");//手机号 
        String teacher_qq = request.getParameter("qq");//qq 
        String teacher_pwd = request.getParameter("password_md5");//密码 
        //职称有问题，，类型不符
        System.out.println(teacher_Vname + "职称");
        TempTeacher tempTeacher = new TempTeacher();
        tempTeacher.setTeacherSn(teacher_sn);
        tempTeacher.setTeacherName(teacher_name);
        tempTeacher.setTeacherIdcard(teacher_idcard);
        tempTeacher.setTeacherSex(true);//teacher_sex.compareTo("男")==0
        tempTeacher.setTeacherCollege(xueyuan);
        tempTeacher.setTeacherTel(teacher_tel);
        tempTeacher.setTeacherQq(teacher_qq);
        tempTeacher.setTeacherPwd(teacher_pwd);
        tempTeacher.setTeacherPosition(teacher_Vname);
        switch (teacher_Vname) {
            case "教务员":
                tempTeacher.setTeacherRoleValue(5);
                break;
            case "院长":
                tempTeacher.setTeacherRoleValue(6);
                break;
            case "教师":
                tempTeacher.setTeacherRoleValue(4);
                break;
        }
        tempTeacher.setTeacherEnrolling(new Date());
        System.out.println(teacher_Vname);
        TempTeacherDao.saveTempTeacher(tempTeacher);
//        TempTeacherMethod.addTempTeacherMessage(teacher_id.toString(), teacher_name, teacher_idcard, xueyuan,  teacher_tel, teacher_qq, teacher_pwd, teacher_sex, teacher_Vname, new Date());
        return "register/success";
    }

    //检查工号是否重复
    @RequestMapping("/cj_gh")
    public @ResponseBody
    String pz(HttpServletRequest request, @RequestParam("jssz") String params) {
        if (TeacherDao.isExistBySn(params)) {
            System.out.println("存在");
            return "1";
        } else {
            System.out.println("不存在");
            return "0";
        }
    }

    public static void main(String[] args) {
        for (int i = 0; i < 10; i++) {
            TempTeacherMethod.addTempTeacherMessage(144520888 + i + "", "临时教师" + i, "411121199412454587", "软件学院", "1313", "127464454", "e10adc3949ba59abbe56e057f20f883e", "男", "教务员", new Date());

        }
//       for(int i = 3;i<=13;i++){
//       TeacherDao.addTeacherFromTempTeacherById(i);
//       }
    }

}
