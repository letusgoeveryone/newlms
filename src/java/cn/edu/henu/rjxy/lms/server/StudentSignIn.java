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
public class StudentSignIn {
    public static boolean studentSignIn(int stuSn, String stuPwd){
         //操作数据库，进行登录认证，认证成功返回1，失败返回0
        if(HibernateUtil.stuGetBysn(stuSn) == null){
            return false;
        }
            return stuPwd.compareTo(HibernateUtil.stuGetBysn(stuSn).getStuPwd()) == 0;
    }
}
