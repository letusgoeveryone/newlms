/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;
import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import cn.edu.henu.rjxy.lms.server.AuthorityManage;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author 刘昱
 */
@Controller
public class Login {

    @Autowired
    private AuthenticationManager myAuthenticationManager; 

    @RequestMapping("/login")
    public String loginpage(HttpServletRequest request, HttpServletResponse response) {
//        for (int i = 10; i < 80; i++) {
//            TeacherDao.saveTeacher(new Teacher("14452030" + i, "正式教师" + i, "4104821900020212" + i, "软件学院", "130850012" + i, "1234567" + i, "21232f297a57a5a743894a0e4a801fc3", true, "系统管理员", new Date(), 15));  //15是所有权限
//            StudentDao.saveStudent(new Student("14452031" + i, "正式学生" + i, "4104821900020210" + i, 2014, "文学院", "130850010" + i, "1234567" + i, "21232f297a57a5a743894a0e4a801fc3", true));
//        }
        String sn = AuthorityManage.getCurrentUsername(); 
        if (sn.equals("anonymousUser")) {
            return "login";
        } else {
            String op = request.getParameter("op");

            if (op != null) {
                if (op.toLowerCase().equals("changeuser")) {
                    return "login";
                }
                return "login";
            } else {
                return "redirect:/loginsuccess";
            }

        }
    }
    @RequestMapping("/loginsuccess")
    public String loginSuccess(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ServletException, IOException {
        String sn = AuthorityManage.getCurrentUsername();
        List<String> list = AuthorityManage.getCurrentAuthoritiest(sn);
        String str[] = {"ROLE_ADMIN", "ROLE_DEAN", "ROLE_ACDEMIC", "ROLE_TEACHER", "ROLE_STUDENT"};
        String str2[] = {"redirect:/admin", "redirect:/dean", "redirect:/acdemic", "redirect:/teacher", "redirect:/student"};
        for (int j = 0; j < 5; j++) {
            if (list.contains(str[j])) {
                return str2[j];
            }
        }
        return "redirect:/login";
    }

    //验证码检验及登录过程

    @RequestMapping("/logincheck")
    public @ResponseBody
    String logincheck(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ServletException, IOException {
        System.out.println("logincheck");
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        String ccd2 = (String) session.getAttribute("hccd");
        String ccd3 = request.getParameter("ccd");
        if (!ccd2.equalsIgnoreCase(ccd3)) {
            return "CheckCodeError";
        }
        session.removeAttribute("hccd");
        username = username.trim();
        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, password);
        try {
            Authentication authentication = myAuthenticationManager.authenticate(authRequest);
            SecurityContextHolder.getContext().setAuthentication(authentication);
            session.setAttribute("SPRING_SECURITY_CONTEXT", SecurityContextHolder.getContext());
        } catch (AuthenticationException ex) {
            return "LoginError";
        }
        return "Loginok";
    }


    @RequestMapping("/tea_dat_up")
    public @ResponseBody String[] teacherRoleDataUpdate(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException, ServletException, IOException {
        int str[] = {1,0,2,0,4,0,8};
//       String str2[] = {"教务员","辅导员","院长","学生","教工","助教","系统管理员"};
        int sum=0,ok=0;
        List<TempTeacherWithoutPwd> tealist = TeacherDao.getAllTeacher();
            for (TempTeacherWithoutPwd tea : tealist) {
                Teacher teacher = TeacherDao.getTeacherBySn(tea.getTeacherSn());
                sum++;
                if(teacher.getTeacherRoleValue()>15){
                    char[] ch = Integer.toBinaryString(teacher.getTeacherRoleValue()).toCharArray();
                    int j = 0;
                    for (int i = ch.length - 1; i >= 0; i--) {
                        if (String.valueOf(ch[i]).equals("1")) {
                            j=j+str[i];
                        }
                    }
                    teacher.setTeacherRoleValue(j);
                    TeacherDao.updateTeacherById(teacher);
                    ok++;
                }
            } 
        String []a = new String[1];
        a[0]="教师权限数据已全部处理完成。共"+sum+ "条，更新成功"+ok+ "条";
        return a;
    }
}
