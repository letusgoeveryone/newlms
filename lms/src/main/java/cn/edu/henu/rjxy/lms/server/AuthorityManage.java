/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.Teacher;
import java.io.UnsupportedEncodingException;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 *
 * @author Yu
 */
public class AuthorityManage {
        public static List<String> getCurrentAuthoritiest(String sn) {
        String str[] = {"ROLE_ACDEMIC","ROLE_DEAN","ROLE_TEACHER"};//"ROLE_ADMIN"
        List list = new LinkedList();
        try {
            Student std = StudentDao.getStudentBySn(sn);
            System.out.println("找到学生" + std.getStudentName());
            list.add("ROLE_STUDENT");
            return list;
        } catch (Exception e) {
        }
        try {
            Teacher tea = TeacherDao.getTeacherBySn(sn);
            char[] ch = Integer.toBinaryString(Integer.valueOf(tea.getTeacherRoleValue())).toCharArray();
            int j = -1;
            for (int i = ch.length - 1; i >= 0; i--) {
                j++;
                if (String.valueOf(ch[i]).equals("1")) {
                    list.add(str[j]);
                }
            }
            return list;
        } catch (Exception e) {
        }
        try {
                if (sn.equalsIgnoreCase(CurrentInfo.getOtherConfigure("AdminUser"))) {
                   list.add("ROLE_ADMIN");
                }
                return list; 
            } catch (Exception e) {
        }
        return list;
    }
        
    public static String getCurrentUsername() {
      return SecurityContextHolder.getContext().getAuthentication().getName();
   }
    
    //判断个sn是否具有对应的ROLE值
    public static boolean checkCurrentAuthorities(String sn, String role) {
        String str[] =  {"ROLE_ACDEMIC","ROLE_DEAN","ROLE_TEACHER"};//

        try {
            Student std = StudentDao.getStudentBySn(sn);
            System.out.println("找到学生" + std.getStudentName());
            if (role.equals("ROLE_STUDENT")) {
                return true;
            }

        } catch (Exception e) {
        }
        
        try {
            Teacher tea = TeacherDao.getTeacherBySn(sn);
            char[] ch = Integer.toBinaryString(Integer.valueOf(tea.getTeacherRoleValue())).toCharArray();
            int j = -1;
            for (int i = ch.length - 1; i >= 0; i--) {
                j++;
                if (str[j].equals(role)) {
                    return true;
                }

            }

        } catch (Exception e) {
        }
        try {
                if (sn.equalsIgnoreCase(CurrentInfo.getOtherConfigure("AdminUser"))&&(role.equals("ROLE_ADMIN")||role.equals("ROLE_ACDEMIC"))) {
                    return true;
                }
                 
            } catch (Exception e) {
        }
        return false;
    }
    
    public static Teacher GetTecPersonalInfo() {
            String sn=getCurrentUsername();
            Teacher teacher = TeacherDao.getTeacherBySn(sn);
            teacher.setTeacherPwd("");
            teacher.setTeacherRoleValue(0);
            teacher.setTeacherEnrolling(null);
            teacher.setTermCourse(null);
            return teacher;
    }
     public static String UpdateTecPersonlInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        String sn=getCurrentUsername();
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
        String name=request.getParameter("name");
//        String idcard=request.getParameter("idcard");
        String college=request.getParameter("college");
        String sex=request.getParameter("sex");
        String telnum=request.getParameter("telnum");
        String qqnum=request.getParameter("qqnum");
        if (!name.matches("[\u4e00-\u9fa5]{2,4}")) {
            return "姓名校验未通过！";
        }
        teacher.setTeacherName(name);
//        if (!idcard.matches("([0-9]{17}([0-9]|X))|([0-9]{15})") ){
//            return "身份证校验未通过！";
//        }       
//        teacher.setTeacherIdcard(idcard);
        teacher.setTeacherCollege(college);
        teacher.setTeacherSex(sex.equals("男"));
        if (!telnum.matches("\\d{11}") ){
            return "电话号码校验未通过！";
        } 
        teacher.setTeacherTel(telnum);
        if (!qqnum.matches("\\d{5,10}") ){
            return "QQ号码校验未通过！";
        } 
        teacher.setTeacherQq(qqnum);
        TeacherDao.updateTeacherById(teacher);
        return "1";
    }   
     public static String UpdateTecPassword(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
        String pw=request.getParameter("pw");
        String repw=request.getParameter("repw");
        if (repw.matches("\\w{6,18}")) {
             return "0";}
        if (!pw.equals(teacher.getTeacherPwd().toLowerCase())) {
             return "1";}
        if (pw.equals(repw.toLowerCase())) {
             return "2";}
        teacher.setTeacherPwd(repw);
        TeacherDao.updateTeacherById(teacher);
        return "3";
    }  

    public static String updateTecImgId(HttpServletRequest request, HttpServletResponse response) {
        String sn=getCurrentUsername();
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
        Integer imgid=Integer.valueOf(request.getParameter("imgid"));
        teacher.setTeacherImg(imgid);
        TeacherDao.updateTeacherById(teacher);
        return "1"; 
    }
}
