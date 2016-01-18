/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.server.TeacherMethod;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
@Controller
public class Login {

    @RequestMapping("login")
    public String login(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String user = request.getParameter("username");
        String password = request.getParameter("password_md5");
        System.out.println("user:" + user + "password" + password);

        //do check mysql 
//        if (StudentMethod.studentSignInByUserName(user, password) == true) {
//            //登陆成功,跳转到学生页面
//            return "register/success";
//
//        } else {
        HttpSession session = request.getSession();
        String ccd2 = (String) session.getAttribute("hccd");
        String ccd3 = request.getParameter("ccd");
        System.out.println(ccd2);
        System.out.println(ccd3);
        ccd2 = ccd2.toLowerCase();
        ccd3 = ccd3.toLowerCase();
        if (!ccd2.equals(ccd3)) {
            request.setAttribute("Error", "你输入的验证码错误，请重新登陆!");
            request.getRequestDispatcher("index").forward(request, response);
        }
        if (TeacherMethod.teacherSignInByUserName(user, password) == true) {
            //登陆成功,跳转到老师页面
            System.out.print("11");
            return "register/success";
        } 
        //执行到此失败，重定向登陆页面

        //return "register/success";  
        return "redirect:/index";
    }
}
