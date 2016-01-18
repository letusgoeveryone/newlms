/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.Course;
import cn.edu.henu.rjxy.lms.model.Course1;
import cn.edu.henu.rjxy.lms.model.MasterCourseResult;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.Teacher;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class CourseDao {

    static Session session;

    public void addCourse(Course course) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作

            session.save(course);

            transaction.commit();//提交

        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    public Course getCourseById(int id) {
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

    public PageBean<Course> findAll(int pc, int ps) {
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
            PageBean<Course> pageBean = new PageBean<Course>();
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

    public PageBean<MasterCourseResult> findAllCourseMaster(int term, int pc, int ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
//操作
            List list = session.createQuery("SELECT new cn.edu.henu.rjxy.lms.model.MasterCourseResult(b.courseName, a.teacher.teacherName, a.teacher.teacherId, a.teacher.teacherSn) FROM CourseMaster a JOIN a.course b ")
                    .setFirstResult((pc - 1) * ps)
                    .setMaxResults(ps)
                    .list();
            Long count = (Long) session.createQuery(
                    "SELECT COUNT(*)FROM CourseMaster a JOIN a.course b"
            ).uniqueResult();
            PageBean<MasterCourseResult> pageBean = new PageBean<>();
            pageBean.setPc(pc);//设置当前页码
            pageBean.setPs(ps);//设置每页记录数
            pageBean.setTr(count.intValue());//设置总页数
            pageBean.setBeanList(list);//设置当前列表
            transaction.commit();//提交
            return pageBean;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
//保存课程负责人

    public void saveCourseMaster(Integer term, Teacher teacher, Course course) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            List list = session.createSQLQuery("select * from course_master where teacher_id = " + teacher.getTeacherId() + " and term = " + term).list();
            if (list.isEmpty()) {//如果没有这个老师这个学期的课程负责人，
//              //  CourseMaster cm = new CourseMaster();
//                cm.setTerm(term);//添加学期
//                cm.setTeacher(teacher);//添加教师
//                cm.setCourse(new HashSet());
//                cm.getCourse().add(course);//添加课程
//                session.save(cm);
            } else {
//                CourseMaster cm = (CourseMaster) list.iterator().next();
//                cm.getCourse().add(course);
//                session.update(cm);
            }
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
//这是我测试学的代码 你看看就可以删了

    public static void main(String[] args) {
// Teacher teacher = new Teacher("1445200000", "周润发", "412332312312312311", "软件学院", "13113131321", "313123123", "123", true, "院长", new Date(), 0);
// TeacherDao.saveTeacher(teacher);
        CourseDao cd = new CourseDao();
// cd.saveCourseMaster(2015, teacher, new CourseDao().getCourseById(636));
        MasterCourseResult cmr = (MasterCourseResult) cd.findAllCourseMaster(2015, 0, 1).getBeanList().iterator().next();
        System.out.print(cmr.getCourseName());
    }
}
