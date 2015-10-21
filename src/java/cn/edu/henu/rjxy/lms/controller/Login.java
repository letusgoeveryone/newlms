/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;

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
        return "register/success";
    }
}
