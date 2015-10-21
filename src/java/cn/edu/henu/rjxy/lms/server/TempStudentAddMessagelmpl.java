/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import java.util.Date;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;


/**
 *
 * @author Administrator
 */
public class TempStudentAddMessagelmpl {
    public static final SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
    
    public static boolean addTempStudentMessage(TempStudent stu){
        if(HibernateUtil.stuGetBysn(stu.getStuSn())  != null){
            return false;
        }
        HibernateUtil.saveTempStudent(stu);
//        System.err.println("成功");
        return true;
    }
}
