/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.dao;

import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Administrator
 */
public class TempTeacherDao {

    static Session session;

    /**
     *保存一个临时教师对象
     * @param tempTeacher 临时教师对象
     */
    public static void saveTempTeacher(TempTeacher tempTeacher) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            
            session.save(tempTeacher);
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     *根据id获取教师
     * @param id 教师id
     * @return 返回指定教师
     */
    public static TempTeacher  getTempTeacherById(Integer id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            TempTeacher TempTeacher = (TempTeacher) session.get(TempTeacher.class, id);
            transaction.commit();//提交
            return TempTeacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }  
//        
    
    /**
     *获取指定范围内工号的教师
     * @param minSn 工号最小值
     * @param maxSn 工号最大值
     * @return 返回指定范围内临时教师列表
     */
    public static List<TempTeacherWithoutPwd> getTempTeacherBySn(Integer minSn, Integer maxSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try{
        List<TempTeacher> lists = session.createQuery("FROM TempTeacher t WHERE t.teacherSn  BETWEEN  :min AND  :max")
                .setInteger("min", minSn)
                .setInteger("max", minSn)
                .list();

        TempTeacher tempTeacher;
        Iterator<TempTeacher> it = lists.iterator();
        List<TempTeacherWithoutPwd> list = new LinkedList();
        while (it.hasNext()) {
            TempTeacherWithoutPwd teacherWithoutPwd = new TempTeacherWithoutPwd();
            tempTeacher = it.next();
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
    

    
    /**
     *获取指定学院的所有临时教师
     * @param collegeName  学院名
     * @return 返回临时教师列表
     */
    public static List getTempTeacherByCollegeName(String collegeName){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            List lists = session.createQuery("FROM TempTeacher t WHERE t.teacherCollege = :college")
                    .setString("college", collegeName)
                    .list();
            List<TempTeacherWithoutPwd> list = new LinkedList<>();
            TempTeacher tempTeacher;
            TempTeacherWithoutPwd teacherWithoutPwd;
            Iterator<TempTeacher> iterator = lists.iterator();
            while(iterator.hasNext()){
                tempTeacher = iterator.next();
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


    /**
     *为全体临时教师分页
     * @param pc 当前页
     * @param ps 每页记录最大数
     * @return 教师分页bean对象
     */
    public static PageBean<TempTeacher>  findAll(Integer pc, Integer ps){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            List list = session.createQuery("FROM TempTeacher")
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long count = (Long)  session.createQuery(
                    "SELECT COUNT(*) FROM TempTeacher"
            ).uniqueResult();
            PageBean<TempTeacher> pageBean;
            pageBean = new PageBean<>();
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
     *获取全体临时教师对象
     * @return 全体临时教师对象
     */
    public static List getAllTempTeacher() {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            List lists = session.createQuery("FROM TempTeacher").list();
            TempTeacher tempTeacher;
            TempTeacherWithoutPwd teacherWithoutPwd;
            Iterator<TempTeacher> it = lists.iterator();
            List list = new LinkedList();
            while (it.hasNext()) {
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
        } finally {
            session.close();
        }
    }
    
    /**
     *根据临时教师工号获取临时教师
     * @param userSn 临时教师工号
     * @return 返回一个临时教师对象
     */
    public static TempTeacher getTempTeacherBySn(String userSn) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            TempTeacher tempTeacher = (TempTeacher) session.createQuery("FROM TempTeacher t Where t.teacherSn = :sn")
                    .setString("sn", userSn)
                    .uniqueResult();
            transaction.commit();//提交
            return tempTeacher;
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }
    
    /**
     *删除指定临时教师对象
     * @param tempTeacher 临时教师对象
     */
    public static void deleteTempTeacher(TempTeacher tempTeacher) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            session.delete(tempTeacher);
            transaction.commit();//提交
            
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    /**
     *根据教师姓名删除临时教师，可能出现重名问题
     * @param userName
     * 
     */
    public static void deleteTempTeacherByUserName(String userName) {
        deleteTempTeacher(getTempTeacherBySn(userName));
    }

    /**
     *根据id删除临时教师
     * @param id 临时教师id
     */
    public static void deleteTempTeacherById(Integer id) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            //操作
            session.delete(session.get(TempTeacher.class, id));
            transaction.commit();//提交
        } catch (RuntimeException e) {
            transaction.rollback();//滚回事务
            throw e;
        } finally {
            session.close();
        }
    }

    /**
     *为工号在指定范围的临时教师分页
     * @param min 工号最小值
     * @param max 工号最大值
     * @param pc 当前页
     * @param ps 每页记录最大数
     * @return 返回一个分页bean对象
     */
    public static PageBean<TempTeacher> getTeachersBySn(Integer min, Integer max, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            List list = session.createQuery(
                    "FROM TempTeacher t WHERE t.teacherSn BETWEEN :min  AND :max")
                    .setInteger("min", min)
                    .setInteger("max", max)
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long x = (Long) session.createQuery(
                    "SELECT COUNT(*) FROM TempTeacher t WHERE t.teacherSn BETWEEN :min  AND :max")
                    .setInteger("min", min)
                    .setInteger("max", max)
                    .uniqueResult();
            PageBean<TempTeacher> pageBean = new PageBean<>();
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
    
    public static void main(String[] args) {
        List<TempTeacher> list = getTeachersBySn(0, 1445200090, 1, 10).getBeanList();
        for (TempTeacher list1 : list) {
            System.out.println(list1.getTeacherSn());
        }
    }
    

    /**
     *为在指定院系的教师分页
     * @param teacherCollege 教师院系
     * @param pc 当前页
     * @param ps 每页记录最大数
     * @return 分页bean对象
     */
    public static PageBean<TempTeacher> findAllTempTeacherByCollege(String teacherCollege, Integer pc, Integer ps) {
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {
            List<TempTeacher> list =  session.createQuery("FROM TempTeacher t WHERE t.teacherCollege =  :college")
                    .setString("college", teacherCollege)
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long x = (Long) session.createQuery("SELECT COUNT(*) FROM TempTeacher t WHERE t.teacherCollege =  :college")
                    .setString("college", teacherCollege)
                    .uniqueResult();


            PageBean<TempTeacher> pageBean = new PageBean<>();
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
 
}
