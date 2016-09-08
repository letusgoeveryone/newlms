/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.Course1;
import cn.edu.henu.rjxy.lms.model.CourseMaster;
import cn.edu.henu.rjxy.lms.model.MasterCourseResult;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Teacher;
import cn.edu.henu.rjxy.lms.model.TermCourse;
import cn.edu.henu.rjxy.lms.model.TermOpenCourse;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class CourseDao {

    static Session session;
    
    public static void main(String[] args) {
        getCourseById(1);
    }
    
    /**
     * 添加指定课程到数据库
     * @param course 课程对象
     */
    public static void addCourse(Course course) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            List list = session.createQuery(//学号课程名检查
                    "FROM Course s WHERE s.courseName = :name")
                    .setString("name", course.getCourseName())
                    .list();
            
            if (!list.isEmpty()) {
                throw new RuntimeException("课程重复！ 重复课程为："+ course.getCourseName());
            }
            session.save(course);
            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     * 根据课程id删除课程
     * @param id  课程id
     */
    public static boolean deleteCourse(Integer id){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            
            List list = session.createQuery("FROM Course c , TermOpenCourse t WHERE c.courseId = :id AND t.course.courseId = :id")
                    .setInteger("id", id)
                    .list();
            list.addAll(session.createQuery("FROM Course c , CourseMaster m WHERE c.courseId = :id AND m.course.courseId =:id")
                    .setInteger("id", id)
                    .list());
            if (list.isEmpty()) {
                session.delete(session.get(Course.class,id));
               transaction.commit();
               return true;
            }else{
                transaction.commit();
                return false;
            }
               
        } catch (Exception e) {
            transaction.rollback();
            throw e;
        }finally{
         session.close();
        }        
    }
    

    
   
    /**
     * 根据课程id获取课程对象
     * @param id  课程id
     * @return 返回指定课程对象
     */
    public static Course getCourseById(Integer id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作

            Course course = (Course) session.get(Course.class, id);
            transaction.commit();//提交
            return course;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     * 为所有课程分页
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个分页bean对象
     */
    public static PageBean<Course> findAllCourse(Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            List list = session.createQuery("FROM Course")
                    .setFirstResult((pc - 1) * ps)
                    .setMaxResults(ps)
                    .list();

            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM Course"
            ).uniqueResult();
            PageBean<Course> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数

            Course1 course1;
            Course next;
            List list1 = new LinkedList();
            Iterator<Course> it = list.iterator();
            while (it.hasNext()) {
                next = it.next();
                course1 = new Course1();
                course1.copy(next);
                list1.add(course1);
            }

            pageBean.setBeanList(list1);//设置当前列表

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
     * 返回所有课程名称，id
     * @return 返回包含所有课程的List
     */
    public static List findAllCourse2() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        List fList = new LinkedList();
        try {
            //操作
            List<Course> list = session.createQuery("FROM Course").list();
            for (Course list1 : list) {
                fList.add(list1.getCourseName());
                fList.add(list1.getCourseId().toString());
            }
            transaction.commit();//提交
            return fList;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     * 根据学期为课程负责人分页
     * @param term
     * @param pc
     * @param ps
     * @return 返回一个分页bean对象，返回列包括课程名，教师id，教师学号，教师姓名
     */
    public static PageBean<MasterCourseResult> findAllCourseMaster(Integer term, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
       //操作
            List<CourseMaster> list = session.createQuery("FROM CourseMaster c  Where c.term = :term")
                    .setInteger("term", term)
                    .setFirstResult((pc-1) * ps)
                    .setMaxResults(ps)
                    .list();

            
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*)FROM CourseMaster c  Where c.term = :term")
                    .setInteger("term", term)
                    .uniqueResult();
            PageBean<MasterCourseResult> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            List<MasterCourseResult> list1 = new LinkedList();//存放结果
            Set<Course> courseslSet;
            MasterCourseResult mcr;
            for (CourseMaster cm : list) {//老师
                    mcr = new MasterCourseResult();
                    mcr.setCourseName(cm.getCourse().getCourseName());
                    mcr.setTeacherId(cm.getTeacher().getTeacherId());
                    mcr.setTeacherName(cm.getTeacher().getTeacherName());
                    mcr.setTeacherSn(cm.getTeacher().getTeacherSn());
                    list1.add(mcr);
                
            }
            pageBean.setBeanList(list1);//设置当前列表
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
     * 根据课程名返回一个课程对象
     * @param courseName  课程名
     * @return 返回指定课程对象
     */
    
     public static Course getCourseByName(String courseName) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            Course course = (Course) session.createQuery("FROM Course c WHERE c.courseName = :name")
                    .setString("name", courseName)
                    .uniqueResult();
            transaction.commit();
            return course;
        } catch (RuntimeException e) {
            transaction.rollback();
            throw e;
        } finally {
            session.close();
        }
     }
     
     /**
     * 保存一个课程负责人
     * @param term  学期
     * @param teacherSn  教师工号
     * @param courseName  课程名
     */
     public static void saveCourseMaster(Integer term, String teacherSn, String courseName) {
         Teacher teacher = TeacherDao.getTeacherBySn(teacherSn);
         Course course = getCourseByName(courseName);
         session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            
                CourseMaster cm = new CourseMaster();
                cm.setCourse(course);
                cm.setTeacher(teacher);
                cm.setTerm(term);
                session.save(cm);
            transaction.commit();
        } catch (RuntimeException e) {
            transaction.rollback();
            throw e;
        } finally {
                 session.close();
        }
    }

     
     public static void deleteCourseMaster(Integer id) {

         session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.delete(session.get(CourseMaster.class, id));
            transaction.commit();
        } catch (RuntimeException e) {
            transaction.rollback();
            throw e;
        } finally {
                 session.close();
        }
    }
     
        /**
     * 列举出 某学期 所开的课程代码 返回CourseId List
     * @param term  学期
     */
public static List getCourseIdByTerm(Integer term) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List<TermOpenCourse> list = session.createQuery(" FROM TermOpenCourse t WHERE t.term = :term")
                    .setInteger("term", term)
                    .list();
            List<String> lists = new LinkedList();
            for (TermOpenCourse toc : list) {
                lists.add(toc.getCourse().getCourseId().toString());
            }
            
            transaction.commit();//提交
            return lists;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
   /**
     * 列举出 某学期 某个课程代码都有那些老师教,返回老师sn List
     * @param term  学期
     * @param courseId  课程
     */
public static List getTeacherSnByTermCourseId(Integer term,  Integer courseId) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List<TermCourse> list = session.createQuery(" FROM TermCourse t WHERE t.term = :term")
                    .setInteger("term", term)
                    .list();
            List<String> lists = new LinkedList();
            for (TermCourse toc : list) {
                if(toc.getCourse().getCourseId().equals(courseId))
                    if(!lists.contains(toc.getTeacher().getTeacherSn())){  
                         lists.add(toc.getTeacher().getTeacherSn());
        }  
                    
            }
            
            transaction.commit();//提交
            return lists;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
   /**
     * 列举出 某学期 某个课程代码 某老师教的班,返回ClassId List
     * @param term  学期
     * @param courseId  课程
     * @param teacherSn  某老师
     */
public static List getClassSnByTermCourseNumber(Integer term,  Integer courseId,String teacherSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List<TermCourse> list = session.createQuery(" FROM TermCourse t WHERE t.term = :term AND t.teacher.teacherSn = :sn AND t.course.courseId = :Id")
                    .setString("sn", teacherSn)
                    .setInteger("Id", courseId)
                    .setInteger("term", term)
                    .list();
            List<String> lists = new LinkedList();
            for (TermCourse toc : list) {
                if(toc.getCourse().getCourseId().equals(courseId))
                    lists.add(toc.getClasses().getClassId()+"");
            }
            
            transaction.commit();//提交
            return lists;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
     


}
