/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TermCourse;
import cn.edu.henu.rjxy.lms.model.TermCourseResult;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *学期课程，用以记录课程在每学期学期开课
 * @author Administrator
 */
public class TermCourseDao {

    
    /**
     *保存一个学期课程
     * @param termCourse 学期课程对象
     */
   public static void saveTermCourse(TermCourse termCourse){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            Integer term = termCourse.getTerm();
            Integer lid = termCourse.getClasses().getClassId();
            Integer cid = termCourse.getCourse().getCourseId();
            Integer tid = termCourse.getTeacher().getTeacherId();
            List list = session.createQuery(
                    "FROM TermCourse t WHERE t.term = :term AND t.course.courseId = :cid AND t.classes.classId = :lid AND t.teacher.teacherId = :tid")
                    .setInteger("term", term)
                    .setInteger("cid", cid)
                    .setInteger("lid", lid)
                    .setInteger("tid", tid)
                    .list();
            if (list.isEmpty()) {
                session.save(termCourse);
            }else{
                throw new RuntimeException("添加课程表重复");
            }
            
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
   
   
   public static Integer getTermCourseId(Integer term, Integer courseId, Integer classId, Integer teacherId){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            Integer x = (Integer) session.createQuery("SELECT t.id FROM TermCourse t WHERE t.term = :term AND t.course.courseId = :courseId AND t.classes.classId = :classId AND  t.teacher.teacherId = :teacherId")
                    .setInteger("term", term)
                    .setInteger("courseId", courseId)
                    .setInteger("classId", classId)
                    .setInteger("teacherId", teacherId)
                    .uniqueResult();
            transaction.commit();//提交
            return x;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }

   
//根据课程id查询教师id 
 public static Integer getTecsnByCourseId(String courseId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            TermCourse tc = (TermCourse) session.createQuery("FROM TermCourse s WHERE s.id = :id")
                    .setString("id", courseId)
                    .uniqueResult();
            Integer id = tc.getTeacher().getTeacherId();
            transaction.commit();//提交
            return id;
            
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
 //根据选课id查询课程id
 public static Integer getCourseidByCourseId(String courseId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            TermCourse tc = (TermCourse) session.createQuery("FROM TermCourse s WHERE s.id = :id")
                    .setString("id", courseId)
                    .uniqueResult();

            Integer id = tc.getCourse().getCourseId();
                transaction.commit();//提交
               
            return  id;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
  //根据选课id查询学期
 public static Integer getxueqiBySCId(String courseId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            TermCourse tc = (TermCourse) session.createQuery("FROM TermCourse s WHERE s.id = :id")
                    .setString("id", courseId)
                    .uniqueResult();

            Integer id = tc.getTerm();
                transaction.commit();//提交
               
            return  id;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
 //根据选课id查询课程名称
 public static String getCourseNameByCourseId(String courseId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            TermCourse tc = (TermCourse) session.createQuery("FROM TermCourse s WHERE s.id = :id")
                    .setString("id", courseId)
                    .uniqueResult();
            String s = tc.getCourse().getCourseName();
                transaction.commit();//提交
                return  s;
            
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }   
//根据选课id查询class名称
 public static String getclassNameByCourseId(String courseId) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {            
            TermCourse tc = (TermCourse) session.createQuery("FROM TermCourse s WHERE s.id = :id")
                    .setString("id", courseId)
                    .uniqueResult();
            String s = tc.getClasses().getClassName();
                transaction.commit();//提交
                return  s;
            
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }      
   
    public static void main(String[] args) {
        //System.out.println(getTermCourseId(201601, 1,1, 1));
    }
   

    
    
    /**
     *删除一个学期课程
     * @param termCourse  学期课程对象
     */
    public static void deleteTermCourse(TermCourse termCourse){
        
        deleteTermCourseById(termCourse.getId());
    }
    
    /**
     *根据班级id获取一个学期课程
     * @param id 学期课程id
     * @return 返回指定学期课程
     */
    public static TermCourse getTermCourseById(Integer id){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            TermCourse termCourse = (TermCourse) session.get(TermCourse.class, id);
            transaction.commit();//提交
            return termCourse;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
        
    }
    
    /**
     *根据id删除一个学期课程
     * @param id 学期课程id
     */
    public static void deleteTermCourseById(Integer id){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            TermCourse termCourse = (TermCourse) session.get(TermCourse.class, id);
            String x = System.getProperty("file.separator");
            File f = new File("D:"+x+"My.ini");
            Properties p = new Properties();
            p.load(new FileReader(f));
            Integer term = new Integer(p.getProperty("term"));

            if(termCourse.getTerm()>term){
            session.delete(termCourse);
            }else{
                throw new RuntimeException("旧学期内容不可删除");
            }
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } catch (FileNotFoundException ex) {
            Logger.getLogger(TermCourseDao.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(TermCourseDao.class.getName()).log(Level.SEVERE, null, ex);
        }finally{
            session.close();
        }
        
    }
     //add for set_all.jsp and term-class in 1.14

    
    
    
    /**
     *根据学期为学期课程分页
     * @param term 学期
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个分页bean对象
     */
    public static PageBean<TermCourseResult> findAll(Integer term, Integer pc, Integer ps) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List<TermCourse> list = session.createQuery("FROM TermCourse t WHERE t.term = :term")
                    .setInteger("term", term)
                    .setFirstResult((pc - 1) * ps)
                    .setMaxResults(ps)
                    .list();
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TermCourse t WHERE t.term =  :term")
                    .setInteger("term", term)
                    .uniqueResult();
            List<TermCourseResult> lists = new LinkedList();
            for (TermCourse list1 : list) {
                TermCourseResult tcr = new TermCourseResult();
                tcr.setTeacherSn(list1.getTeacher().getTeacherSn());
                tcr.setClassName(list1.getClasses().getClassName());
                tcr.setCourseName(list1.getCourse().getCourseName());
                tcr.setTeacherName(list1.getTeacher().getTeacherName());
                lists.add(tcr);
            }
            
            PageBean<TermCourseResult> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            pageBean.setBeanList(lists);//设置当前列表
            transaction.commit();//提交
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    
}
