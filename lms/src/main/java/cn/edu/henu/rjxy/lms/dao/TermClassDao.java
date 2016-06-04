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
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *学期班级用于保存班级开课学期情况
 * @author Administrator
 */
public class TermClassDao {
    
    public static void main(String[] args) {
        deleteTermClassByid(2);
        
    }

    
    static Session session;

    /**
     *保存一个学期班级
     * @param termClass 学期班级对象
     */
    public static void saveTermClass(TermClass termClass) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            Integer term = termClass.getTerm();
            Integer id = termClass.getClasses().getClassId();

            List list = session.createQuery("FROM TermClass t WHERE t.term = :term AND t.classes.classId = :id")
                    .setInteger("term", term)
                    .setInteger("id", id)
                    .list();
            if (list.isEmpty()) {
                session.save(termClass);

            }else{
                throw new RuntimeException("学期班级重复，重复学期为："+term+"重复班级id为:"+id);
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
     *删除一个学期班级
     * @param termClass 学期班级对象
     */
    public static void deleteTermClass(TermClass termClass) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
             String x = System.getProperty("file.separator");
            File f = new File("D:"+x+"My.ini");
            Properties p = new Properties();
            p.load(new FileReader(f));
            Integer term = new Integer(p.getProperty("term"));

            if(termClass.getTerm()>term){
            session.delete(termClass);
            }else{
                throw new RuntimeException("旧学期内容不可删除");
            }
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } catch (IOException ex) {
            Logger.getLogger(TermClassDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            session.close();
        }
    }

    /**
     *根据班级获取一个学期班级
     * @param id 学期班级id
     * @return 返回一个学期班级
     */
    public static TermClass getTermClass(Integer id) {
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

    /**
     *根据id删除一个学期班级
     * @param id 学期班级id
     */
    public static void deleteTermClassByid(Integer id) {
        TermClass termClass = getTermClass(id);
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            String x = System.getProperty("file.separator");
            File f = new File("D:"+x+"My.ini");

            
            Properties p = new Properties();
            p.load(new FileReader(f));
            Integer term = new Integer(p.getProperty("term"));

            if(termClass.getTerm()>term){
            session.delete(termClass);
            }else{
                throw new RuntimeException("旧学期内容不可删除");
            }
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } catch (IOException ex) {
            Logger.getLogger(TermClassDao.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            session.close();
        }
    }

    /**
     *获取全体学期班级
     * @return 全体学期班级列表
     */
    public static List getAllTermClass() {
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

    /**
     *根据学期为学期班级分页
     * @param term 学期
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个分页bean对象
     */
    public static PageBean<Classes1> findAll(Integer term, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            List tempList = session.createQuery("FROM TermClass WHERE term = :term")
                    .setInteger("term", term)
                    .setFirstResult((pc - 1) * ps)
                    .setMaxResults(ps)
                    .list();
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TermClass WHERE term = :term")
                    .setInteger("term", term)
                    .uniqueResult();
            PageBean<Classes1> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            List list = new LinkedList();
            Iterator it = tempList.iterator();
            while (it.hasNext()) {
                TermClass next = (TermClass) it.next();
                Classes1 m = new Classes1();
                Classes c = next.getClasses();
                m.setClassId(c.getClassId());
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
