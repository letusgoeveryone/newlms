/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import static cn.edu.henu.rjxy.lms.dao.TempTeacherDao.session;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 * 对正式老师的基本操作
 *
 * @author Administrator
 */
public class TeacherDao {

    static Session session;

    //根据用户名查询正式教师对象
    /**
     * 根据用户名返回相关信息，并将信息用QueryResult封装并返回<br>
     *
     * @param userName 传入用户名
     * @return 返回一个QueryResult对象
     */
    public static QueryResult getTeacherByUserName(String userName) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Criteria criteria;
            if (userName.length() == 10) {//十位即根据学号查询
                criteria = session.createCriteria(Teacher.class);
                criteria.add(Restrictions.eq("teacherSn", userName));
            } else if (userName.length() == 11) {//十一位即根据手机号查询
                criteria = session.createCriteria(Teacher.class);
                criteria.add(Restrictions.eq("teacherTel", userName));
            } else {//其他则根据身份证查询
                criteria = session.createCriteria(Teacher.class);
                criteria.add(Restrictions.eq("teacherIdcard", userName));
            }
            QueryResult<Teacher> queryResult = new QueryResult<Teacher>();
            queryResult.setList((List<Teacher>) criteria.list());//记录结果集合
            queryResult.setNumber(criteria.list().size());//记录条数
            if (queryResult.getNumber() == 1) {//若结果唯一，则为结果中的对象赋值
                Iterator<Teacher> iterator = criteria.list().iterator();
                queryResult.setE(iterator.next());
            }
            transaction.commit();//提交
            return queryResult;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static Teacher getTeacherById(int id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Teacher teacher = (Teacher) session.get(Teacher.class, id);
            transaction.commit();//提交
            return teacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static void addTeacherFromtempTeacher(TempTeacher tempTeacher) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Teacher teacher = new Teacher();
            teacher.copy(tempTeacher);
            session.save(teacher);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

//    public static void saveTeacher(Teacher teacher) {
//        session = HibernateUtil.getSessionFactory().openSession();
//        Transaction transaction = session.beginTransaction();
//        try {
//            //操作
//            session.save(teacher);
//            transaction.commit();//提交
//        } catch (RuntimeException e) {
//            transaction.rollback();//滚回事务
//            throw e;
//        } finally {
//            session.close();
//        }
//    }
    public static void saveTeacher(Teacher teacher) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            SQLQuery sqlq = session.createSQLQuery("select * from teacher where teacher_sn = " + teacher.getTeacherSn());
            sqlq.addEntity(Teacher.class);
            if (sqlq.list().isEmpty()) {
                session.save(teacher);
            }
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static void deleteTeacherById(int id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            session.delete(session.get(Teacher.class, id));

            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static void addTeacherFromTempTeacherById(int id) {//批准临时表教师的方法
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            TempTeacher tempTeacher = (TempTeacher) session.get(TempTeacher.class, id);
            Teacher teacher = new Teacher();
            teacher.copy(tempTeacher);
            session.save(teacher);

            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static List getAllTeacher() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            //Criteria criteria;
            SQLQuery sqlq;
            sqlq = session.createSQLQuery("select * from teacher");
            sqlq.addEntity(Teacher.class);
            QueryResult queryResult = new QueryResult();
            queryResult.setList(sqlq.list());
            queryResult.setNumber(sqlq.list().size());//记录条数
            if (queryResult.getNumber() == 1) {//若结果唯一，则为结果中的对象赋值
                Iterator<Teacher> iterator = sqlq.list().iterator();
                queryResult.setE(iterator.next());
            }
            Teacher Teacher;
            TempTeacherWithoutPwd teacherWithoutPwd;
            Iterator<Teacher> it = queryResult.getList().iterator();
            List list = new LinkedList();
            while (it.hasNext()) {
                Teacher = it.next();
                teacherWithoutPwd = new TempTeacherWithoutPwd();
                teacherWithoutPwd.copy(Teacher);
                list.add(teacherWithoutPwd);
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

    public static boolean getTeacherNameBySn(String teacherSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            SQLQuery sqlq = session.createSQLQuery("select * from teacher where teacher_sn = " + teacherSn);
            sqlq.addEntity(Teacher.class);
            transaction.commit();//提交
            if (sqlq.list().isEmpty()) {
                return false;
            } else {
                return true;
                //  return ((Teacher) sqlq.uniqueResult()).getTeacherName();
            }
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

}
