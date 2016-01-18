/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Administrator
 */
@Controller
@RequestMapping("/reg")
public class Student_teacher_registercontroller {

    @RequestMapping("/student_teacher")
    public String student_register1() {

        return "register/student_teacher";
    }

    @RequestMapping("/teacher_register")
    public String teacherRegister1() {

        return "register/teacher_register";
    }

    @RequestMapping("/student_register")
    public String studet_sign1() {
        return "register/student_register";
    }

}
