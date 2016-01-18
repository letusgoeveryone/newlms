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
    static Session session;
    
    
    public  void addClass(Classes classes){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            
            session.save(classes);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    public  Classes getClassById(int id){
        session = HibernateUtil.getSessionFactory().openSession();
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
    
    
    public  void deleteClass(Classes classes){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            session.delete(classes);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
        public PageBean<Classes>  findAll(int pc, int ps){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            List list = session.createQuery("FROM Classes order by classGrade desc")
                    
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long count = (Long)  session.createQuery(
                    "SELECT COUNT(*) FROM Classes"
            ).uniqueResult();
            PageBean<Classes> pageBean = new PageBean<Classes>();
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
        
        
        
//        public static void main(String[] args) {
//        ClassesDao classesDao = new ClassesDao();
        //添加数据
//        for(i = 0; i < 30; i++){
//            classesDao.addClass(new Classes(2014+i, "软工x班"));
//            if(i == 10){
//                classesDao.addClass(new Classes(i, 2015, "网工x班"));
//            }
//        }
//        PageBean<Classes> pageBean = classesDao.findAll(1, 10);
//        Iterator<Classes> it = pageBean.getBeanList().iterator();
//            while (it.hasNext()) {
//                Classes classes = it.next();
//                System.out.println(""+classes.getClassId()+"  "+classes.getClassGrade()+"  "+classes.getClassName()); 
//            }       
//    }

    
    
    
}
