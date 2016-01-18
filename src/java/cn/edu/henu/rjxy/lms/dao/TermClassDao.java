/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Classes;
import cn.edu.henu.rjxy.lms.model.Classes1;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TermClass;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class TermClassDao {

    Session session;

    public void saveTermClass(TermClass termClass) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            session.save(termClass);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public void deleteTermClass(TermClass termClass) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            session.delete(termClass);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public TermClass getTermClass(int id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            TermClass termClass = (TermClass) session.get(TermClass.class, id);
            transaction.commit();//提交
            return termClass;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public void deleteTermClassByid(int id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作

            session.delete(getTermClass(id));
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public List getAllTermClass() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作

            List list = session.createSQLQuery("select *from term_class").addEntity(TermClass.class).list();
            transaction.commit();//提交
            return list;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

//    add for set_all.jsp in1.14
    public PageBean<TermClass> findAll(int term, int pc, int ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            List tempList = session.createQuery("FROM TermClass WHERE term = " + term)
                    .setFirstResult((pc - 1) * ps)
                    .setMaxResults(ps)
                    .list();
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TermClass WHERE term = " + term
            ).uniqueResult();
            PageBean<TermClass> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            List list = new LinkedList();
            Iterator it = tempList.iterator();
            while (it.hasNext()) {
                TermClass next = (TermClass) it.next();
                Classes1 m = new Classes1();
                Classes c = next.getClasses();
                m.setClassGrade(c.getClassGrade());
                m.setClassName(c.getClassName());
                list.add(m);
            }
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
