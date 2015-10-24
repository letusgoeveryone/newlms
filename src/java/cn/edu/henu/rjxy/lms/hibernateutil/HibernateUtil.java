/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.hibernateutil;

import cn.edu.henu.rjxy.lms.model.Student;
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

    public static SessionFactory getSessionFactory(){
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
    public static Student stuGetBySn(int sn){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = session.createCriteria(Student.class);
            criteria.add(Restrictions.eq("studentSn", sn));
            Student student = (Student) criteria.uniqueResult();
            
            transaction.commit();//提交
            return student;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
        public static Student stuGetByTel(int tel){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = session.createCriteria(Student.class);
            criteria.add(Restrictions.eq("studentTel",tel));
            Student student = (Student) criteria.uniqueResult();
            
            transaction.commit();//提交
            return student;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
        public static Student stuGetByIdCard(String id){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = session.createCriteria(Student.class);
            criteria.add(Restrictions.eq("studentIdcard",id));
            Student student = (Student) criteria.uniqueResult();
            
            transaction.commit();//提交
            return student;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }   
        
    
    public static Teacher teacherGetBySn(int teacherSn){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = session.createCriteria(Teacher.class);
            criteria.add(Restrictions.eq("teacherSn", teacherSn));
            Teacher Teacher = (Teacher) criteria.uniqueResult();
            
            transaction.commit();//提交
            return Teacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }             
    public static Teacher teacherGetByTel(int teacherTel){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = session.createCriteria(Teacher.class);
            criteria.add(Restrictions.eq("teacherTel", teacherTel));
            Teacher Teacher = (Teacher) criteria.uniqueResult();
            
            transaction.commit();//提交
            return Teacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    } 
    
    public static int getIdByCollegeName(String collegeName){
        //该函数传入学院名称返回代号，名称根据官网设置，暂时按照从左到右，从上到下的顺序,不存在则返回负一
        //该函数暂时这样使用，后期会完善数据库college表内容，改为查college表返回代号
        if(collegeName.compareTo("文学院")==0){
            return 1;
        }else if(collegeName.compareTo("历史文化学院")==0){
            return 2;
        }else if(collegeName.compareTo("教育科学学院")==0){
            return 3;
        }else if(collegeName.compareTo("哲学与公共管理学院")==0){
            return 4;
        }else if(collegeName.compareTo("法学院")==0){
            return 5;
        }else if(collegeName.compareTo("新闻与传播学院")==0){
            return 6;
        }else if(collegeName.compareTo("外语学院")==0){
            return 7;
        }else if(collegeName.compareTo("经济学院")==0){
            return 8;
        }else if(collegeName.compareTo("商学院")==0){
            return 9;
        }else if(collegeName.compareTo("数学与统计学院")==0){
            return 10;
        }else if(collegeName.compareTo("物理与电子学院")==0){
            return 11;
        }else if(collegeName.compareTo("计算机与信息工程学院")==0){
            return 12;
        }else if(collegeName.compareTo("环境与规划学院")==0){
            return 13;
        }else if(collegeName.compareTo("生命科学学院")==0){
            return 14;
        }else if(collegeName.compareTo("化学化工学院")==0){
            return 15;
        }else if(collegeName.compareTo("土木建筑学院")==0){
            return 16;
        }else if(collegeName.compareTo("艺术学院")==0){
            return 17;
        }else if(collegeName.compareTo("体育学院")==0){
            return 18;
        }else if(collegeName.compareTo("医学院")==0){
            return 19;
        }else if(collegeName.compareTo("药学院")==0){
            return 20;
        }else if(collegeName.compareTo("护理学院")==0){
            return 21;
        }else if(collegeName.compareTo("淮河临床学院")==0){
            return 22;
        }else if(collegeName.compareTo("东京临床学院")==0){
            return 23;
        }else if(collegeName.compareTo("国际教育学院")==0){
            return 24;
        }else if(collegeName.compareTo("软件学院")==0){
            return 25;
        }else if(collegeName.compareTo("民生学院")==0){
            return 26;
        }else if(collegeName.compareTo("国际汉学院")==0){
            return 27;
        }else if(collegeName.compareTo("欧亚国际学院")==0){
            return 28;
        }else if(collegeName.compareTo("人民武装学院")==0){
            return 29;
        }else if(collegeName.compareTo("远程与继续教育学院")==0){
            return 30;
        }else if(collegeName.compareTo("马克思主义学院")==0){
            return 31;
        }else if(collegeName.compareTo("大学外语教学部")==0){
            return 32;
        }else if(collegeName.compareTo("公共体育部")==0){
            return 33;
        }else if(collegeName.compareTo("军事理论教研部")==0){
            return 34;
        }else{
            return -1;
        }

    }
    
    public static Teacher teacherGetByIdcard(String teacherIdcard){
        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = session.createCriteria(Teacher.class);
            criteria.add(Restrictions.eq("teacherIdcard", teacherIdcard));
            Teacher Teacher = (Teacher) criteria.uniqueResult();
            
            transaction.commit();//提交
            return Teacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    } 
    
}