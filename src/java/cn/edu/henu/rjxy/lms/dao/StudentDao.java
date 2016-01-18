/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;
//该包封装了对student表的各种操作

import static cn.edu.henu.rjxy.lms.dao.TempStudentDao.session;
import static cn.edu.henu.rjxy.lms.dao.TempTeacherDao.session;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author Administrator
 */
public class StudentDao {

    static Session session;

    //根据用户名查询正式学生对象
    public static QueryResult getStudentByUserName(String userName) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Criteria criteria;
            if (userName.length() == 10) {//十位即根据学号查询
                criteria = session.createCriteria(Student.class);
                criteria.add(Restrictions.eq("studentSn", userName));
            } else if (userName.length() == 11) {//十一位即根据手机号查询
                criteria = session.createCriteria(Student.class);
                criteria.add(Restrictions.eq("studentTel", userName));
            } else {//其他则根据身份证查询
                criteria = session.createCriteria(Student.class);
                criteria.add(Restrictions.eq("studentIdcard", userName));
            }
            QueryResult<Student> queryResult = new QueryResult<Student>();
            queryResult.setList((List<Student>) criteria.list());//记录结果集合
            queryResult.setNumber(criteria.list().size());//记录条数
            if (queryResult.getNumber() == 1) {//若结果唯一，则为结果中的对象赋值
                Iterator<Student> iterator = criteria.list().iterator();
                queryResult.setE(iterator.next());
            }
            transaction.commit();//提交
            return queryResult;
        } catch (RuntimeException e) {
            if (e == null) {
                System.out.print("这里有错");
            }
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    //随后补充上增删改查
    /**
     * 保存传入的学生对象
     *
     * @param student 传入一个学生对象
     *
     */
    public static void saveStudent(Student student) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            session.save(student);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            //session.close();
        }
    }

    /**
     * @param userName 根据传入的用户名删除对象
     * @return 返回QueryResult对象，只有查询结果惟一时才真正删除
     */
    public static QueryResult<Student> deleteStudent(String userName) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            QueryResult queryResult = getStudentByUserName(userName);
            if (queryResult.getNumber() == 1) {
                session.delete(queryResult.getE());
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

    public static List getAllStudent() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            //Criteria criteria;
            SQLQuery sqlq = session.createSQLQuery("select * from student");
            sqlq.addEntity(Student.class);
            QueryResult queryResult = new QueryResult();
            queryResult.setList(sqlq.list());
            queryResult.setNumber(sqlq.list().size());//记录条数

            if (queryResult.getNumber() == 1) {//若结果唯一，则为结果中的对象赋值
                Iterator<Student> iterator = sqlq.list().iterator();
                queryResult.setE(iterator.next());
            }
            List list = new LinkedList();
            Iterator<Student> it = queryResult.getList().iterator();
            Student Student;
            StudentWithoutPwd StudentWithoutPwd;
            while (it.hasNext()) {
                Student = it.next();
                StudentWithoutPwd = new StudentWithoutPwd();
                StudentWithoutPwd.copy(Student);
                list.add(StudentWithoutPwd);
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

    public static void addTeacherFromtempStudent(TempStudent tempStudent) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Student student = new Student();
            student.copy(tempStudent);
            session.save(student);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static void deleteStudentById(int id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            session.delete(session.get(Student.class, id));
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public static void addstudentFromtempStudent(TempStudent tempStudent) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            Student student = new Student();
            student.copy(tempStudent);
            session.save(student);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public List getStudentBySn(int minSn, int maxSn) {
//        List<StudentWithoutPwd> lists = new LinkedList();
        List<Student> list = new LinkedList();
        List<Student> templist;
//        StudentWithoutPwd studentWithoutPwd;
//        Student student;
        for (; minSn <= maxSn; minSn++) {
            templist = StudentDao.getStudentByUserName("" + minSn).getList();
            list.addAll(templist);
        }

        System.out.println(list.size() + "list");

        return list;

    }

    public static boolean getStudentNameBySn(String studentSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            SQLQuery sqlq = session.createSQLQuery("select * from student where student_sn = " + studentSn);
            sqlq.addEntity(Student.class);
            transaction.commit();//提交
            if (sqlq.list().isEmpty()) {
                return false;
            } else {
                return true;
              //  return ((Student) sqlq.uniqueResult()).getStudentName();
            }
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

}
