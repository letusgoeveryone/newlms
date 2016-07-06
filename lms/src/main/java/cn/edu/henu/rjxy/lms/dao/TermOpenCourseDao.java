/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;


import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TermOpenCourse;
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
 *相当于课程表，由班级，课程，任课教师，学期组成
 * @author Administrator
 */
public class TermOpenCourseDao {
   static Session session;
    
    /**
     *保存一个学期开课课程
     * @param termOpenCourse
     */
    public static void saveTermOpenCourse(TermOpenCourse termOpenCourse) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Integer term = termOpenCourse.getTerm();
            Integer id = termOpenCourse.getCourse().getCourseId();
            List list = session.createQuery("FROM TermOpenCourse t WHERE t.term = :term AND t.course.courseId = :id")
                    .setInteger("term", term)
                    .setInteger("id", id)
                    .list();
            if(list.isEmpty()){
                session.save(termOpenCourse);
            }else{
                throw new RuntimeException("学期课程重复，重复的学期为："+term+"重复的课程id为:"+id);
            }
            
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    
    /**
     *删除一个学期开课课程
     * @param termOpenCourse 学期开课课程对象
     */
    public static void deleteTermOpenCourse(TermOpenCourse termOpenCourse) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            String x = System.getProperty("file.separator");
            File f = new File("D:"+x+"My.ini");
            Properties p = new Properties();
            p.load(new FileReader(f));
            Integer term = new Integer(p.getProperty("term"));

            if(termOpenCourse.getTerm()>term){
            session.delete(termOpenCourse);
            }else{
                throw new RuntimeException("旧学期内容不可删除");
            }
            
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } catch (FileNotFoundException ex) {
           Logger.getLogger(TermOpenCourseDao.class.getName()).log(Level.SEVERE, null, ex);
       } catch (IOException ex) {
           Logger.getLogger(TermOpenCourseDao.class.getName()).log(Level.SEVERE, null, ex);
       } finally {
            session.close();
        }
    }
    
    /**
     *根据id获取一个学期开课课程
     * @param id 学期开课课程id
     * @return 返回指定学期开课课程对象
     */
    public static TermOpenCourse  getTermOpenCourse(Integer id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            TermOpenCourse termOpenCourse = (TermOpenCourse) session.get(TermOpenCourse.class, id);
            transaction.commit();//提交
            return termOpenCourse;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     *根据id删除一个学期开课课程
     * @param id 学期开课课程id
     */
    public static void deleteTermOpenCourseById(Integer id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            TermOpenCourse termOpenCourse = (TermOpenCourse) session.get(TermOpenCourse.class, id);
            String x = System.getProperty("file.separator");
            File f = new File("D:"+x+"My.ini");
            Properties p = new Properties();
            p.load(new FileReader(f));
            Integer term = new Integer(p.getProperty("term"));

            if(termOpenCourse.getTerm()>term){
            session.delete(termOpenCourse);
            }else{
                throw new RuntimeException("旧学期内容不可删除");
            }
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } catch (IOException ex) {
           Logger.getLogger(TermOpenCourseDao.class.getName()).log(Level.SEVERE, null, ex);
       } finally {
            session.close();
        }
    }
    
    /**
     *根据学期为学期开课表分页，分页结果集合中有该学期开课课程的名字
     * @param term 学期
     * @param pc 当前页
     * @param ps 每页记录最大数
     * @return 返回一个分页bean对象
     */
    public static PageBean<String> findAll(Integer term, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List<TermOpenCourse> list = session.createQuery("FROM TermOpenCourse t WHERE t.term = :term")
                    .setInteger("term", term)
                    .setFirstResult((pc - 1) * ps)
                    .setMaxResults(ps)
                    .list();
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TermOpenCourse t WHERE t.term =  :term")
                    .setInteger("term", term)
                    .uniqueResult();
            List<String> lists = new LinkedList();
            for (TermOpenCourse list1 : list) {
                lists.add(list1.getCourse().getCourseName());
            }
            PageBean<String> pageBean = new PageBean<>();
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
