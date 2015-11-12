/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
//import java.util.List;
//import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
//import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Administrator
 */
public class TempTeacherDao {
    static Session session;
    
    //保存临时教师对象
    public static void saveTempTeacher(TempTeacher tempTeacher){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();//开启事务
        try {
            //操作
            session.save(tempTeacher);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
     //根据用户名查询临时教师对象
    public static QueryResult getTempTeacherByUserName(String userName){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        
        try {
            //操作
            //Criteria criteria;
            SQLQuery sqlq;
           if(userName.length() == 10){//十位即根据学号查询
            //criteria = session.createCriteria(TempTeacher.class);
            //criteria.add(Restrictions.eq("teacherSn", userName));
            sqlq = session.createSQLQuery("select * from temp_teacher where teacher_sn = "+userName);

           }else if(userName.length() == 11){//十一位即根据手机号查询
            //criteria = session.createCriteria(TempTeacher.class);
            //criteria.add(Restrictions.eq("teacherTel", userName));
               sqlq = session.createSQLQuery("select * from temp_teacher where teacher_tel = "+userName);
           }else{//其他则根据身份证查询
//            criteria = session.createCriteria(TempTeacher.class);
//            criteria.add(Restrictions.eq("teacherIdcard", userName));
               sqlq = session.createSQLQuery("select * from temp_teacher where teacher_idcard = "+userName);
           }
           sqlq.addEntity(TempTeacher.class);
            QueryResult queryResult = new QueryResult();
            //queryResult.setList(criteria.list());//记录结果集合
            queryResult.setList(sqlq.list());
            queryResult.setNumber(sqlq.list().size());//记录条数
            
            if(queryResult.getNumber() == 1){//若结果唯一，则为结果中的对象赋值
                Iterator<TempTeacher> iterator = sqlq.list().iterator();
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
    
    public static List getAllTempTeacher(){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
                        //Criteria criteria;
            SQLQuery sqlq;
            sqlq = session.createSQLQuery("select * from temp_teacher");
           sqlq.addEntity(TempTeacher.class);
            QueryResult queryResult = new QueryResult();
            queryResult.setList(sqlq.list());
            queryResult.setNumber(sqlq.list().size());//记录条数
            if(queryResult.getNumber() == 1){//若结果唯一，则为结果中的对象赋值
                Iterator<TempTeacher> iterator = sqlq.list().iterator();
                queryResult.setE(iterator.next());
            }
            TempTeacher tempTeacher;
            TempTeacherWithoutPwd teacherWithoutPwd;
            Iterator<TempTeacher> it = queryResult.getList().iterator();
            List list = new LinkedList();
            while(it.hasNext()){
                tempTeacher = it.next();
                teacherWithoutPwd = new TempTeacherWithoutPwd();
                teacherWithoutPwd.copy(tempTeacher);
                list.add(teacherWithoutPwd);
            }
            
            transaction.commit();//提交
            return list;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    
    
}
