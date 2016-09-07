/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller.register;


import cn.edu.henu.rjxy.lms.dao.StudentDao;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.server.TempStudentMethod;
import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import javax.servlet.ServletException;
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
public class studentregister_message {



    @RequestMapping("/student_register_message")
    public String student_sign_message1(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, IOException, ParseException, ServletException {
        request.setCharacterEncoding("UTF-8");//以免得到的姓名为乱码
        TempStudent stu = new TempStudent();
        HttpSession session = request.getSession();
        String ccd = (String) session.getAttribute("hccd");
        String ccd1 = request.getParameter("ccd");
        ccd = ccd.toLowerCase();
        ccd1 = ccd1.toLowerCase();
        if (!ccd.equals(ccd1)) {
            request.setAttribute("Error", "你输入的验证码错误，请重新注册!");
            request.getRequestDispatcher("student_register").forward(request, response);
        }
        session.removeAttribute("hccd");//使当前验证码失效，否则将导致一个验证码能成功注册多个账号。刘昱注
        Integer stu_sn = Integer.parseInt(request.getParameter("idCard"));//学号
        String stu_college = request.getParameter("Institute");//院系
        String stu_sex = request.getParameter("xingbie");//性别
        Integer stu_niji = Integer.parseInt(request.getParameter("niji"));// 年级
        String stuName = request.getParameter("name");//姓名
        String stuIdcard = request.getParameter("myIDNum");// 身份证 
        String stuTel = request.getParameter("myPhone");//手机号
        String stuQq = request.getParameter("myQq");//qq
        String stuPwd = request.getParameter("password_md5");//密码 
        stu.setStudentSn(stu_sn.toString());
        stu.setStudentName(stuName);
        stu.setStudentGrade(stu_niji);
        stu.setStudentIdcard(stuIdcard);
        stu.setStudentTel(stuTel);
        stu.setStudentQq(stuQq);
        stu.setStudentPwd(stuPwd);
        stu.setStudentSex(true);
        stu.setStudentEnrolling(new Date());
        TempStudentMethod.addTempStudentMessage(stu_sn.toString(), stuName, stuIdcard, stu_niji, stu_college, stuTel, stuQq, stuPwd, stu_sex, new Date());
        return "register/success";
    }
     public static void main(String[] args) {
        for(int i= 0; i < 26;i++){
            TempStudentMethod.addTempStudentMessage(1445204004+"","临时学生"+i,"4111111111",2014,"软件学院","13733969717","1274604226","e10adc3949ba59abbe56e057f20f883e","true",new Date());
        }
    }
    //检查学号是否重复
     @RequestMapping("cjxh")
       public @ResponseBody
       String jc(HttpServletRequest request, @RequestParam("jssz") String params) {
       if(StudentDao.getStudentBySn(params)!=null){
            System.out.println("存在");
            return "1"; 
       }else{
            System.out.println("不存在");
            return "0";
       }  
    }
}
