/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.server.StudentSignIn;
import cn.edu.henu.rjxy.lms.server.TeacherSignIn;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
@Controller
public class Login {

    @RequestMapping("reg/login")
    public String login(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        String user = request.getParameter("username");
        String password = request.getParameter("password_md5");
        System.out.println("user:" + user + "password" + password);

        //do check mysql 
        if (StudentSignIn.studentSignInBySn(user, password) == true) {
            //登陆成功,跳转到学生页面
            return "register/success";

        } else {
            if (TeacherSignIn.teacherSignInBySn(user, password) == true) {
                //登陆成功,跳转到老师页面
                return "register/success";
            }
        }
        System.out.print("11");
        //执行到此失败，重定向登陆页面
        return "redirect:/index";
    }
}
