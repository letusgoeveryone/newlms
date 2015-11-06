/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import java.util.Iterator;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Administrator
 */

public class TempStudentDao {
     static Session session = HibernateUtil.getSessionFactory().openSession();
     
    //保存临时教师
    public static void saveTempStudent(TempStudent tempStudent){
        
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            session.save(tempStudent);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
     
     
     //根据用户名查询正式学生对象
    public static QueryResult getTempStudentByUserName(String userName){
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            //操作
            Criteria criteria = null;
           if(userName.length() == 10){//十位即根据学号查询
            criteria = session.createCriteria(TempStudent.class);
            criteria.add(Restrictions.eq("studentSn", userName));
           }else if(userName.length() == 11){//十一位即根据手机号查询
            criteria = session.createCriteria(TempStudent.class);
            criteria.add(Restrictions.eq("studentTel", userName));
           }else{//其他则根据身份证查询
            criteria = session.createCriteria(TempStudent.class);
            criteria.add(Restrictions.eq("studentIdcard", userName));
           }
            QueryResult<TempStudent> queryResult = new QueryResult<TempStudent>();
            queryResult.setList((List<TempStudent>) criteria.list());//记录结果集合
            queryResult.setNumber(criteria.list().size());//记录条数
            if(queryResult.getNumber() == 1){//若结果唯一，则为结果中的对象赋值
                Iterator<TempStudent> iterator = criteria.list().iterator();
                queryResult.setE(iterator.next());
            }
            transaction.commit();//提交
            return queryResult;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
     
     
}
