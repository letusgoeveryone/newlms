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
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class ClassesDao {
    
    
    /**
     * 添加课程
     * @param classes  参数为一个课程对象
    */

    public static void addClass(Classes classes){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            String name = classes.getClassName();
            Integer grade = classes.getClassGrade();
            List<Classes> list = session.createQuery("FROM Classes c WHERE c.className = :name AND c.classGrade = :grade")
                    .setString("name", name)
                    .setInteger("grade", grade)
                    .list();
            
            if (list.isEmpty()) {
                session.save(classes);
            }else{
                throw new RuntimeException("班级重复  重复班级名称为："+name);
            }

            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }

    
    /**
     * 根据课程在数据库的id返回这个课程
     * @param id  课程id 
     * @return 返回一个课程对象
     */
    public static Classes getClassById(Integer id){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Classes classes = (Classes) session.get(Classes.class, id);
            transaction.commit();//提交
            return classes;

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    /**
     * 删除指定课程对象
     * @param classes 课程对象
     */
    public static  boolean deleteClass(Classes classes){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Integer id = classes.getClassId();
            List list = session.createQuery("FROM TermClass t WHERE t.classes.classId = :id")
                    .setInteger("id", id)
                    .list();
            
            if (list.isEmpty()) {
                session.delete(classes);
                transaction.commit();//提交
                return true;
            }else{
                
                transaction.commit();//提交
                return false;
            }
            

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    

    
    /**
     * 对所有课程分页
     * @param pc  当前页数
     * @param ps  每页记录数
     * @return 返回一个分页bean对象
     */
    public static PageBean<Classes>  findAll(Integer pc, Integer ps){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            List list = session.createQuery("FROM Classes ORDER BY classGrade DESC")
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long count = (Long)  session.createQuery(
                    "SELECT COUNT(*) FROM Classes")
                    .uniqueResult();
            PageBean<Classes> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            
            //转换
            Classes1 classes1;
            Iterator<Classes> it = list.iterator();
            List list1 = new LinkedList();
            while (it.hasNext()) {
                Classes next = it.next();
                classes1 = new Classes1();
                classes1.copy(next);
                list1.add(classes1);
                
            }
            
            pageBean.setBeanList(list1);//设置当前列表
            
            transaction.commit();//提交
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }

}
