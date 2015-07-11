/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author wht
 */
@Controller()
@RequestMapping("/reg")
public class RegisterController {
    @RequestMapping("/register")
    public String register(){
        return "register/register";
    }
    
    @RequestMapping("/register_Student_step")
    public String registerSS(){
        return "register/registerStudentstep";
    }

    
    @RequestMapping("/register_Teacher_step")
    public String registerTS(){
        return "register/registerTeacherstep";
    }
    
    @RequestMapping("/registerOK")
    public String stuok(){
        System.out.println("register ok.");
        return "register/stuok";
    }
//    @RequestMapping("/createImage")
//    public String createImage(){
//        return "register/image_code";
//    }
    

}
