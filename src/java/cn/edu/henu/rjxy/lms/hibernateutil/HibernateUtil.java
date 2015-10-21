/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.hibernateutil;

import java.util.Date;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.criterion.Restrictions;
import cn.edu.henu.rjxy.lms.server.StudentSignIn;
import cn.edu.henu.rjxy.lms.server.TeacherSignIn;
import cn.edu.henu.rjxy.lms.server.TempStudentAddMessagelmpl;
import cn.edu.henu.rjxy.lms.server.TempTeacherAddMessagelmpl;


/**
 * Hibernate Utility class with a convenient method to get Session Factory
 * object.
 *
 * @author Administrator
 */
public class HibernateUtil {

    private static final SessionFactory sessionFactory;
    
    static {
         Configuration configuration = new Configuration().configure();
         StandardServiceRegistry serviceRegistry =  new StandardServiceRegistryBuilder()
                .applySettings(configuration.getProperties())
                .build();
         //生成session工厂,全局只需要一个就可以了
         sessionFactory = configuration.buildSessionFactory((org.hibernate.service.ServiceRegistry) serviceRegistry);
         
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
    
    //从全局惟一的工厂中打开一个session
    public static Session openSessionFactory(){
        return sessionFactory.openSession();
    }
    
   
    public static void saveTempStudent(TempStudent tempStudent){
        
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            
            session.save(tempStudent);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
        
    }
    
    public static void saveTempTeacher(TempTeacher tempTeacher){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            session.save(tempTeacher);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    //根据学号查询对象
    public static TempStudent stuGetBysn(int sn){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = session.createCriteria(TempStudent.class);
            criteria.add(Restrictions.eq("stuSn", sn));
            TempStudent tempStudent = (TempStudent) criteria.uniqueResult();
            
            transaction.commit();//提交
            return tempStudent;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    public static TempTeacher teacherGetBysn(int teacherSn){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = session.createCriteria(TempTeacher.class);
            criteria.add(Restrictions.eq("teacherSn", teacherSn));
            TempTeacher tempTeacher = (TempTeacher) criteria.uniqueResult();
            
            transaction.commit();//提交
            return tempTeacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }             
}
