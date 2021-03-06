/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import cn.edu.henu.rjxy.lms.dao.StudentDao;
import cn.edu.henu.rjxy.lms.dao.TeacherDao;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.model.ManageResult;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import java.io.File;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Administrator
 */
@Controller
public class AdminController {

    @RequestMapping("/admin")
    public String personal_InfInformation(HttpServletRequest request, HttpServletResponse response) {
	request.setAttribute("username",SecurityContextHolder.getContext().getAuthentication().getName());
        return "admin/Index";
    }

    @RequestMapping("/admin/FunctionManage")
    public String functionManage(HttpServletRequest request, HttpServletResponse response) {
        return "admin/FunctionManage";
    }

    @RequestMapping("admin/PersonManage")
    public String PersonManage(HttpServletRequest request, HttpServletResponse response) {
        return "admin/PersonManage";
    }

    @RequestMapping("/admin/UserSituation")
    public String UserSituation(HttpServletRequest request, HttpServletResponse response) {
        Integer t = TeacherDao.getAllTeacher().size();
        Integer tt = TempTeacherDao.getAllTempTeacher().size();
        Integer s = StudentDao.getAllStudent().size();
        Integer ts = TempStudentDao.getAllTempStudent().size();
        request.setAttribute("t", t);
        request.setAttribute("tt", tt);
        request.setAttribute("s", s);
        request.setAttribute("ts", ts);

        return "admin/UserSituation";
    }

    @RequestMapping("/admin/ServerInfo")
    public String ServerInformation(HttpServletRequest request, HttpServletResponse response) {
        return "admin/EnvInfo";
    }
    @RequestMapping("/admin/PersonalInfo")
    public String teacher12(HttpServletRequest request,HttpServletResponse response) {
         String sn=getCurrentUsername();
         Teacher teacher = TeacherDao.getTeacherBySn(sn);
         String name = teacher.getTeacherName();
         String idCard = teacher.getTeacherIdcard();
         String qq = teacher.getTeacherQq();
         String tel =teacher.getTeacherTel();
         request.setAttribute("sn", sn);
         request.setAttribute("name",name);
         request.setAttribute("idCard",idCard );
         request.setAttribute("qq", qq);
         request.setAttribute("tel", tel);
         request.setAttribute("college", teacher.getTeacherCollege());
         request.setAttribute("zc", teacher.getTeacherPosition());
        return "admin/PersonalInfo";
    } 
    @RequestMapping("admin/search")
    public @ResponseBody
    List<ManageResult> search(HttpServletRequest request, HttpServletResponse response) {
        String flag = (String) request.getParameter("flag");
        String text = (String) request.getParameter("text");

        List<ManageResult> lists = new LinkedList();
        List<ManageResult> l = new LinkedList();
        if ("0".equals(flag)) {//权限管理
            List list = TeacherDao.getAllTeacher();
            for (Object ob : list) {
                ManageResult mr = new ManageResult();
                mr.copy(ob);
                mr.setControl("<a herf=\"#\"  onclick=\"manage(" + mr.getSn() + "," + 0 + ")\">权限管理</a>");
                l.add(mr);
            }
        } else {//密码重置
            List list = StudentDao.getAllStudent();
            list.addAll(TeacherDao.getAllTeacher());
            for (Object ob : list) {//获取所有对象
                ManageResult mr = new ManageResult();
                mr.copy(ob);
                mr.setControl("<a herf=\"#\" class = \"m\" onclick=\"manage(" + mr.getSn() + "," + 1 + ")\">重置密码</a>");
                l.add(mr);
            }
        }

        for (ManageResult mr : l) {
            boolean b = false;

            String x;
            x = mr.getSn();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setSn("<div class=\"text-primary\">" + x + "</div>");

            }
            x = mr.getTel();
            if (x.matches(".*" + text + ".*")) {
                b = true;

                mr.setTel("<div class=\"text-primary\">" + x + "</div>");
            }
            x = mr.getQq();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setQq("<div class=\"text-primary\">" + x + "</div>");
            }
            x = mr.getPosition();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setPosition("<div class=\"text-primary\">" + x + "</div>");
            }
            x = mr.getName();
            if (x.matches(".*" + text + ".*")) {
                b = true;

                mr.setName("<div class=\"text-primary\">" + x + "</div>");

            }
            x = mr.getIdCard();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setIdCard("<div class=\"text-primary\">" + x + "</div>");
            }

            x = mr.getSex();
            if (x.matches(".*" + text + ".*")) {
                b = true;
                mr.setSex("<div class=\"text-primary\">" + x + "</div>");
            }
            if (b) {
                lists.add(mr);
            }
        }
        System.out.println("size"+lists.size());


        return lists;
    }

    @RequestMapping("admin/all")
    public @ResponseBody
    List<ManageResult> all(HttpServletRequest request, HttpServletResponse response) {
        List list = StudentDao.getAllStudent();
        list.addAll(TeacherDao.getAllTeacher());
        List<ManageResult> l = new LinkedList();
        for (Object ob : list) {
            ManageResult mr = new ManageResult();
            mr.copy(ob);
            mr.setControl("<a herf=\"#\" class = \"m\" onclick=\"manage(" + mr.getSn() + "," + 1 + ")\">重置密码</a>");
            l.add(mr);
        }
        return l;
    }

    @RequestMapping("admin/czmm")
    public @ResponseBody
    String czmm(HttpServletRequest request, HttpServletResponse response) {
        String sn = request.getParameter("sn");
        Teacher t = TeacherDao.getTeacherBySn(sn);

        if (t != null) {
            t.setTeacherPwd("e10adc3949ba59abbe56e057f20f883e");
            TeacherDao.updateTeacherById(t);
        } else {
            Student s = StudentDao.getStudentBySn(sn);
            s.setStudentPwd("e10adc3949ba59abbe56e057f20f883e");
            StudentDao.updateStudent(s);
        }

        return "0";
    }

    @RequestMapping("admin/teacher")
    public @ResponseBody
    List<ManageResult> All(HttpServletRequest request, HttpServletResponse response) {
        List list = TeacherDao.getAllTeacher();
        List<ManageResult> l = new LinkedList();
        String pw = request.getParameter("a");
        System.out.println(pw);
        for (Object ob : list) {
            ManageResult mr = new ManageResult();
            mr.copy(ob);
            mr.setControl("<a herf=\"#\"  onclick=\"manage(" + mr.getSn() + "," + 0 + ")\">权限管理</a>");
            l.add(mr);
        }
        return l;
    }

    public List<String> getCurrentAuthoritiest(String sn) {
        String str[] = {"ROLE_ACDEMIC", "ROLE_COUNSELLOR", "ROLE_DEAN", "ROLE_STUDENT", "ROLE_TEACHER", "ROLE_TUTOR", "ROLE_ADMIN"};
        List list = new LinkedList();
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
        } catch (Exception e) {
        }
        try {
            Student std = StudentDao.getStudentBySn(sn);
            System.out.println("找到学生" + std.getStudentName());
            list.add("ROLE_STUDENT");
        } catch (Exception e) {
        }
        return list;
    }

    //管理员页面Role编辑

    @RequestMapping("/admin/rolecheck")
    public @ResponseBody
    String[] rolecheck(HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("UTF-8");
        String p = request.getParameter("p");
        String[] a = new String[1];

        String sn = request.getParameter("sn");

        StringBuffer sb = new StringBuffer();
        sb.append("<form role=\"form\">已选择教师sn：" + sn + "<br><div class=\"checkbox\">");
        List<String> list = getCurrentAuthoritiest(sn);
        String str[] = {"ROLE_ACDEMIC", "ROLE_COUNSELLOR", "ROLE_DEAN", "ROLE_STUDENT", "ROLE_TEACHER", "ROLE_TUTOR", "ROLE_ADMIN"};
        String str2[] = {"教务员", "辅导员", "院长", "学生", "教工", "助教", "系统管理员"};
        String str3[] = {"1", "2", "4", "8", "16", "32", "64"};
        // System.out.println(list);
        for (int i = 0; i < str.length; i++) {

            if (list.contains(str[i])) {
                sb.append("<label><input name=\"rolevelue\" value=\"" + str3[i] + "\" type=\"checkbox\" checked = checked>" + str2[i] + "</label><br>");
            } else {
                sb.append("<label><input name=\"rolevelue\" value=\"" + str3[i] + "\"  type=\"checkbox\">" + str2[i] + "</label><br>");
            }

        }

        sb.append("</div></form>");

        a[0] = sb.toString();

        return a;
    }

    //管理员页面Role设置

    @RequestMapping("/admin/roleset")
    public @ResponseBody
    String roleset(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //System.out.println("logincheck");
        request.setCharacterEncoding("UTF-8");
        String sn = request.getParameter("sn");
        String rolesum = request.getParameter("rolesum");
        Teacher teacher = TeacherDao.getTeacherBySn(sn);
        teacher.setTeacherRoleValue(Integer.valueOf(rolesum));
        TeacherDao.updateTeacherById(teacher);
        return "ok";
    }
    public String getCurrentUsername() {
      return SecurityContextHolder.getContext().getAuthentication().getName();
   }
}
