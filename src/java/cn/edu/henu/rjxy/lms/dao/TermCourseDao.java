/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import static cn.edu.henu.rjxy.lms.dao.TempTeacherDao.session;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TermCourse;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class TermCourseDao {
    static Session session;
    
    public  void saveTermCourse(TermCourse termCourse){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            session.save(termCourse);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    public  void deleteTermCourse(TermCourse termCourse){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            session.delete(termCourse);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    //根据id获取一个临时学生表
    public  TermCourse getTermCourseById(int id){
        session = HibernateUtil.getSessionFactory().openSession();
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
    public  void deleteTermCourseById(int id){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            TermCourse termCourse = (TermCourse) session.get(TermCourse.class, id);
            session.delete(termCourse);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
        
    }
     //add for set_all.jsp and term-class in 1.14

    public PageBean<TermCourse> findAll(int term, int pc, int ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List list = session.createQuery("FROM TermCourse WHERE term = " + term)
                    .setFirstResult((pc - 1) * ps)
                    .setMaxResults(ps)
                    .list();
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TermCourse WHERE term = " + term
            ).uniqueResult();
            PageBean<TermCourse> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            pageBean.setBeanList(list);//设置当前列表
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
