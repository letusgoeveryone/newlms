/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.CourseDao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.PageBean;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;


/**
 *
 * @author Administrator
 */
public class CourseMethod {
    
    /**
     * 
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个PageBean对象  内有分页所需数据
     */
    public  PageBean<Course>  findAll(int pc, int ps){
        return new CourseDao().findAll(pc, ps);
    }
    
    /**
     * 
     * @param courseNumber 课程编号
     * @param courseName  课程中文名称
     * @param courseEname 课程英文名称
     * @param courseCredit 课程学分
     * @param faceTeacherHourse 面授学时
     * @param testTeacherHourse 实验学时
     * @param courseType 课程类型
     * 
     */
    public void addCourse(String courseNumber, String courseName, String courseEname, String courseType, Integer faceTeacherHourse, Integer testTeacherHourse, Integer courseCredit) {
        Course course = new Course(courseNumber, courseName, courseEname, courseType, faceTeacherHourse, testTeacherHourse, courseCredit);
        new CourseDao().addCourse(course);
    }
    
    public static void main(String[] args) {
        Course course = new Course("1","2","3","bi",5,5,7);
         new CourseDao().addCourse(course);
//        for(int i = 0; i < 210; i++){
//        new CourseDao().addCourse(new Course("数据结构"+i));
//        }
    }
    
    public void deleteCourse(int id){
       Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
               session.delete(session.get(Course.class,id));
               transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        }finally{
         session.close();
        }        
    }
}
