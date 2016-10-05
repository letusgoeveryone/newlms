/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;


import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Classes;
import cn.edu.henu.rjxy.lms.model.Classes1;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TermCourseInfo;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class TermCourseInfoDao {


    
    /**
     * 根据课程在数据库的id返回这个课程
     * @param id  课程id 
     * @param flag 0 info  1  outline
     * @return 返回一个课程对象
     */
    public static void addCourseInfo(Integer term, Integer courseId, String courseBInfo, Integer flag){
        Course course = CourseDao.getCourseById(courseId);
         Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            TermCourseInfo tci= (TermCourseInfo) session.createQuery("from TermCourseInfo t WHERE t.course.courseId = :id AND t.term = :term")
                    .setInteger("id", courseId)
                    .setInteger("term", term)
                    .uniqueResult();

            if(tci == null){
                tci = new TermCourseInfo();
                tci.setCourse(course);
                tci.setTerm(term);
                if(flag == 0){
                    tci.setCourseBInfo(courseBInfo);
                }else{
                    tci.setCourseOutline(courseBInfo);
                }
                session.save(tci);
            }else{
                if (flag == 0) {
                    tci.setCourseBInfo(courseBInfo);
                }else{
                    tci.setCourseOutline(courseBInfo);
                }
                session.update(tci);
            }
            transaction.commit();//提交


        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    public static String getCourseInfo(Integer term, Integer courseId,  Integer flag){
        Course course = CourseDao.getCourseById(courseId);
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            TermCourseInfo tci= (TermCourseInfo) session.createQuery("from TermCourseInfo t WHERE t.course.courseId = :id AND t.term = :term")
                    .setInteger("id", courseId)
                    .setInteger("term", term)
                    .uniqueResult();
            String s;
            if (tci == null) {
                s = null;

            } else {
                if (flag == 0) {
                    s = tci.getCourseBInfo();
                } else {
                    s = tci.getCourseOutline();
                }
            }
            
            transaction.commit();//提交
            return s;

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
  

}
