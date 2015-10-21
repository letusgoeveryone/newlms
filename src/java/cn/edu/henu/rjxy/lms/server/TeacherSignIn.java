/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;

/**
 *
 * @author Administrator
 */
public class TeacherSignIn {
    public static boolean teacherSignIn(int teacherSn, String teacherPwd){
         //操作数据库，进行登录认证，认证成功返回1，失败返回0
        if(HibernateUtil.teacherGetBysn(teacherSn) == null){
            return false;
        }
            return teacherPwd.compareTo(HibernateUtil.teacherGetBysn(teacherSn).getTeacherPwd()) == 0;
    }
}
