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
    public static boolean teacherSignInBySn(String userName, String stuPwd){
         //操作数据库，进行登录认证，认证成功返回1，失败返回0
        //用户名10位默认为学号登录，十一位默认用手机号登录，其他则默认用身份证登录
        int temp =Integer.parseInt(userName);
        if(userName.length() == 10){//十位，根据学号判断
            if(HibernateUtil.teacherGetBySn(temp) == null){
            return false;
        }
            return stuPwd.compareTo(HibernateUtil.teacherGetBySn(temp).getTeacherPwd()) == 0;
        }else if(userName.length() == 11){
            if(HibernateUtil.teacherGetByTel(temp) == null){
                return false;
            }
            return  stuPwd.compareTo(HibernateUtil.teacherGetByTel(temp).getTeacherPwd()) == 0;
        }else{
            if(HibernateUtil.teacherGetByIdcard(userName)==null){
                return false;
            }
            return stuPwd.compareTo(HibernateUtil.teacherGetByIdcard(userName).getTeacherIdcard())==0;
        }
    }
}
