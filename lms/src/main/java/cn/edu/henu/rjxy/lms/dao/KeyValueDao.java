/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import static cn.edu.henu.rjxy.lms.dao.CourseDao.session;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.KeyValue;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class KeyValueDao {
    
    public static void main(String[] args) {
        KeyValue kv = new KeyValue("key", "value");
        KeyValue kv1 = new KeyValue("mykey", "value");
        add(kv);
        kv.setMyvalue("mykey");
        add(kv);
        delete(kv1);
        
        
    }
    
    public static void add(KeyValue keyValue) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
           KeyValue kv = (KeyValue) session.createQuery("FROM key_Value k WHERE k.mykey = :aaa")
                   .setString("aaa", keyValue.getMykey()).uniqueResult();
            if (kv == null) {
                session.save(keyValue);
            }else{
                kv.setMyvalue(keyValue.getMyvalue());
                session.update(kv);
            }
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }      
    }
    
    public static void delete(KeyValue keyValue) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
           KeyValue kv = (KeyValue) session.createQuery("FROM key_Value k WHERE k.mykey = :key")
                   .setString("key", keyValue.getMykey()).uniqueResult();
            if (kv != null) {
                session.delete(kv);
            }
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }      
    }
    
    
}
