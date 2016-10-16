/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;
//该包封装了对student表的各种操作

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Student;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;


/**
 *
 * @author 鸿运
 * 
 */
public class StudentDao {



    /**
     * 保存传入的学生对象
     * @param student 传入一个学生对象
     *@throw 如果传入的学生学号和已有正式某学生重复，则抛出异常，并提示重复学号
     */
    public static void saveStudent(Student student) {
        String sn = student.getStudentSn();
        if (TeacherDao.getTeacherBySn(sn) != null) {
            throw new RuntimeException("该注册学生学号与已注册教师工号重复，重复学号为:"+sn);
        }
        
        
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List list = session.createQuery(//学号重复检查
                    "FROM Student s WHERE s.studentSn = :sn")
                    .setString("sn", student.getStudentSn())
                    .list();
            
            if (!list.isEmpty()) {//重复判断  重复则抛异常
                throw new RuntimeException("学号重复！ 重复学号为："+ student.getStudentSn());
            }
            
            session.save(student);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    public static void updateStudent(Student student) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.update(student);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    
    
    /**
     *为所有学生分页
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个分页bean对象
     */
    public static PageBean<Student>  findAll(Integer pc, Integer ps){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List list = session.createQuery("FROM Student")
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long count = (Long)  session.createQuery(
                    "SELECT COUNT(*) FROM Student"
            ).uniqueResult();
            PageBean<Student> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            pageBean.setBeanList(list);//设置当前列表
            
            transaction.commit();//提交
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    /**
     * 根据学院和年级，为正式学生分页
     * @param studentCollege 学生学院
     * @param studentGrade   学生年级
     * @param pc  当前页
     * @param ps  每页最大数
     * @return 返回pageBean
     */
    public static PageBean<Student> findAllStudentByCollegeGrade(String studentCollege, Integer studentGrade, Integer pc, Integer ps) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            Long x = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM Student s WHERE s.studentGrade = :grade and s.studentCollege = :college")
                    .setString("college", studentCollege)
                    .setInteger("grade", studentGrade)
                    .uniqueResult();
            List list = session.createQuery(
                    "FROM Student s WHERE s.studentGrade = :grade and s.studentCollege = :college")
                    .setString("college", studentCollege)
                    .setInteger("grade", studentGrade)
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            PageBean<Student> pageBean = new PageBean<>();
            pageBean.setPc(pc);
            pageBean.setPs(ps);
            pageBean.setTr(x.intValue());
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

    /**
     * 获取全部正式学生
     * @return 返回全体正式学生的集合（不含密码）
     */
    public static List<StudentWithoutPwd> getAllStudent() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List<StudentWithoutPwd> list = new LinkedList();
            Iterator<Student> it = session.createQuery("FROM Student").list().iterator();
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

    /**
     * 将一个临时学生加入到正式学生中
     * @param tempStudent 临时学生对象
     */
    public static void addStudentFromtempStudent(TempStudent tempStudent) {
            //操作
            Student student = new Student();
            student.copy(tempStudent);
            saveStudent(student);
    }

    /**
     *根据学生id删除学生
     * @param id 学生id
     */
    public static boolean deleteStudentById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List list = session.createQuery("FROM StudentSelectCourse a, Student b   Where a.student.studentId = b.studentId AND b.studentId = :id")
                    .setInteger("id", id)
                    .list();
            if(list.isEmpty()){
                 session.delete(session.get(Student.class, id));
                 transaction.commit();//提交
                 return true;
            }else{
                transaction.commit();//提交
                return false;
            }
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    public static void main(String[] args) {
         deleteStudentById(1);
        
    }
    

    /**
     *获取学号在指定范围内的学生
     * @param minSn 学号最小值
     * @param maxSn 学号最大值
     * @return  返回全体学生集合
     */
    public static List<Student> getStudentBySn(Integer minSn, Integer maxSn) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            List<Student> list = session.createQuery(
                    "FROM Student s WHERE s.studentSn BETWEEN :min AND :max ")
                    .setString("min", minSn.toString())
                    .setString("max", maxSn.toString())
                    .list();
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
     *根据学生学号获取学生
     * @param studentSn 学生学号
     * @return 返回指定学生
     */
    public static Student getStudentBySn(String studentSn) {
         Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            Student student = (Student) session.createQuery(
                    "FROM Student s WHERE s.studentSn = ?")
                    .setString(0, studentSn)
                    .uniqueResult();
            transaction.commit();//提交
            return student;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    public static Student getStudentById(Integer id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            Student student = (Student) session.get(Student.class, id);
            transaction.commit();//提交
            return student;
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
    public static PageBean<Student> findAllStudentBySn(Integer min, Integer max, Integer pc, Integer ps) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            
            List<Student> list = session.createQuery(
                    "FROM Student s WHERE s.studentSn BETWEEN  :min AND :max")
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .setInteger("min", min)
                    .setInteger("max", max)
                    .list();
            Long x = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM Student s WHERE s.studentSn BETWEEN  :min AND :max")
                    .setInteger("min", min)
                    .setInteger("max", max)
                    .uniqueResult();
            PageBean<Student> pageBean = new PageBean<>();
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
     *全体学生分页
     * @param pc 当前页
     * @param ps 每页记录最大数
     * @return 返回一个分页bean对象
     */
    public PageBean<Student>  findAllStudent(Integer pc, Integer ps){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List list = session.createQuery("FROM Student")
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long count = (Long)  session.createQuery(
                    "SELECT COUNT(*) FROM Student"
            ).uniqueResult();
            PageBean<Student> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            pageBean.setBeanList(list);//设置当前列表
            
            transaction.commit();//提交
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        }finally{
            session.close();
        }
    }
    
    /**
     *根据学院，年级为学生分页
     * @param studentCollege 学生学院
     * @param studentGrade   学生年级
     * @param pc  当前页
     * @param ps  每页记录最大数
     * @return  返回一个分页bean对象
     */
    public static PageBean<Student> findAllStudentByCollegeSn(String studentCollege, Integer studentGrade, Integer pc, Integer ps) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {


            List list = session.createQuery(
                    "FROM Student s WHERE s.studentGrade = :grade and s.studentCollege = :college")
                    .setInteger("grade", studentGrade)
                    .setString("college", studentCollege)
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            Long l = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM Student s WHERE s.studentGrade = :grade and s.studentCollege = :college")
                    .setInteger("grade", studentGrade)
                    .setString("college", studentCollege)
                    .uniqueResult();
            PageBean<Student> pageBean = new PageBean<>();
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
