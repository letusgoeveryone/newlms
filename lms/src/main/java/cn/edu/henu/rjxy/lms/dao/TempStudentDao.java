/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class TempStudentDao {

    static Session session;

    /**
     * 保存传入的学生对象
     * @param tempStudent
     *@throw 如果传入的学生学号和已有正式某学生重复，则抛出异常，“学号重复”和重复学号
     */
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
   
    /**
     *根据id删除临时学生
     * @param id 临时学生id
     */
    public static void deleteTempStudentById(Integer id) {
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
    
    /**
     *根据id获取一个临时学生
     * @param id 临时学生id
     * @return 返回指定临时学生
     */
    public static TempStudent getTempStudentById(Integer id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            TempStudent tempStudent = (TempStudent) session.get(TempStudent.class, id);
            transaction.commit();//提交
            return tempStudent;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     *根据学号获取指定临时学生对象
     * @param studentSn 学生学号
     * @return 返回一个临时学生对象
     */
    public static TempStudent getTempStudentBySn(String studentSn){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            TempStudent tempStudent = (TempStudent) session.createQuery("FROM TempStudent s WHERE s.studentSn = :sn")
                    .setString("sn", studentSn)
                    .uniqueResult();

            transaction.commit();//提交
            return tempStudent;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    
    /**
     *根据学号范围为临时学生分页
     * @param minSn 学号最小值
     * @param maxSn 学号最大值
     * @return 返回范围内学生列表
     */
    public static List<StudentWithoutPwd> getTempStudentsBySn(Integer minSn,Integer maxSn){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List lists = session.createQuery("FROM Student s WHERE s.studentSn BETWEEN :min AND :max")
                    .setInteger("min", minSn)
                    .setInteger("max", maxSn)
                    .list();
            TempStudent tempStudent;
            StudentWithoutPwd tempStudentWithoutPwd;
            List<StudentWithoutPwd> list = new LinkedList<>();
            Iterator<TempStudent> it = lists.iterator();
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

    /**
     *获取全体临时学生对象
     * @return 全体临时学生列表
     */
    public static List<StudentWithoutPwd> getAllTempStudent() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List<StudentWithoutPwd> list = new LinkedList();
            Iterator<TempStudent> it = session.createQuery("FROM TempStudent").list().iterator();
            TempStudent tempStudent;
            StudentWithoutPwd StudentWithoutPwd;
            while (it.hasNext()) {
                tempStudent = it.next();
                StudentWithoutPwd = new StudentWithoutPwd();
                StudentWithoutPwd.copy(tempStudent);
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
    
    /**
     *为学号在指定范围内的学生分页
     * @param min 学号最小值
     * @param max 学号最大值
     * @param pc  当前页
     * @param ps  每页记录最大数
     * @return  返回一个分页bean对象
     */
    public static PageBean<TempStudent> findAllTempStudentBySn(Integer min, Integer max, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            
            List<TempStudent> list = session.createQuery(
                    "FROM TempStudent s WHERE s.studentSn BETWEEN  :min AND :max")
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .setInteger("min", min)
                    .setInteger("max", max)
                    .list();
            Long x = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TempStudent s WHERE s.studentSn BETWEEN  :min AND :max")
                    .setInteger("min", min)
                    .setInteger("max", max)
                    .uniqueResult();
            PageBean<TempStudent> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(x.intValue());//设置总页数
            pageBean.setBeanList(list);
            transaction.commit();//提交
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     * 根据学院和年级，为临时学生分页
     * @param studentCollege 学生学院
     * @param studentGrade   学生年级
     * @param pc  当前页
     * @param ps  每页最大数
     * @return 返回pageBean
     */
    public static PageBean<TempStudent> findAllTempStudentByCollegeGrade(String studentCollege, Integer studentGrade, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List list = session.createQuery(
                    "FROM TempStudent s WHERE s.studentGrade = :grade and s.studentCollege = :college")
                    .setInteger("grade", studentGrade)
                    .setString("college", studentCollege)
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            Long l = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TempStudent s WHERE s.studentGrade = :grade and s.studentCollege = :college")
                    .setInteger("grade", studentGrade)
                    .setString("college", studentCollege)
                    .uniqueResult();
            PageBean<TempStudent> pageBean = new PageBean<>();
            pageBean.setPc(pc);
            pageBean.setPs(ps);
            pageBean.setTr(l.intValue());
            pageBean.setBeanList(list);
            transaction.commit();
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
    }

}
