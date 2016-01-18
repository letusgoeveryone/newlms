/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import static cn.edu.henu.rjxy.lms.dao.TempTeacherDao.session;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class TempStudentDao {

    static Session session;

    //保存临时教师
    public static void saveTempStudent(TempStudent tempStudent) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            session.save(tempStudent);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
//测试用来添加学生注册信息
    public static void main(String[] args) {
        for (int i = 1; i < 250; i++) {
            saveTempStudent(new TempStudent("1445200001", "刘炳旭" + i, "1443231313", 2015, "软件学院", "1123123123", "43434343", "213123", true, new Date()));
        }
    }

    public static void deleteTempStudentById(int id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            session.delete(session.get(TempStudent.class, id));
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    //根据用户名查询正式学生对象
    public static QueryResult getTempStudentByUserName(String userName) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            //Criteria criteria;
            SQLQuery sqlq;
            if (userName.length() == 10) {//十位即根据学号查询
                //criteria = session.createCriteria(TempTeacher.class);
                //criteria.add(Restrictions.eq("teacherSn", userName));
                sqlq = session.createSQLQuery("select * from temp_student where student_sn = " + userName);

            } else if (userName.length() == 11) {//十一位即根据手机号查询
                //criteria = session.createCriteria(TempTeacher.class);
                //criteria.add(Restrictions.eq("teacherTel", userName));
                sqlq = session.createSQLQuery("select * from temp_student where student_tel = " + userName);
            } else {//其他则根据身份证查询
//            criteria = session.createCriteria(TempTeacher.class);
//            criteria.add(Restrictions.eq("teacherIdcard", userName));
                sqlq = session.createSQLQuery("select * from temp_student where student_idcard = " + userName);
            }
            sqlq.addEntity(TempStudent.class);
            QueryResult queryResult = new QueryResult();
            //queryResult.setList(criteria.list());//记录结果集合
            queryResult.setList(sqlq.list());
            queryResult.setNumber(sqlq.list().size());//记录条数

            Iterator<TempStudent> iterator = sqlq.list().iterator();
            queryResult.setE(iterator.next());

            transaction.commit();//提交
            return queryResult;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static List getAllTempStudent() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            //Criteria criteria;
            SQLQuery sqlq = session.createSQLQuery("select * from temp_student");
            sqlq.addEntity(TempStudent.class);
            QueryResult queryResult = new QueryResult();
            queryResult.setList(sqlq.list());
            queryResult.setNumber(sqlq.list().size());//记录条数

            if (queryResult.getNumber() == 1) {//若结果唯一，则为结果中的对象赋值
                Iterator<TempStudent> iterator = sqlq.list().iterator();
                queryResult.setE(iterator.next());
            }
            List list = new LinkedList();
            Iterator<TempStudent> it = queryResult.getList().iterator();
            TempStudent tempStudent;
            StudentWithoutPwd tempStudentWithoutPwd;
            while (it.hasNext()) {
                tempStudent = it.next();
                tempStudentWithoutPwd = new StudentWithoutPwd();
                tempStudentWithoutPwd.copy(tempStudent);
                list.add(tempStudentWithoutPwd);
            }
            transaction.commit();//提交
            return list;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

}
