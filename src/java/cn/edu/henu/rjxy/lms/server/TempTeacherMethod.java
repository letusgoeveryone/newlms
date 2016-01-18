/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;


import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;


public class TempTeacherMethod {//根据学号范围　
    
    public static List<TempTeacherWithoutPwd> getTempTeacherBySn(int MinSn,int MaxSn){
        QueryResult<TempTeacher> queryResult = new QueryResult<TempTeacher>();
        queryResult.setList(new LinkedList());
        QueryResult<TempTeacher> tempQueryResult;
        List<TempTeacherWithoutPwd> list = new LinkedList<TempTeacherWithoutPwd>();
        for(;MinSn <= MaxSn;MinSn++){
            tempQueryResult = TempTeacherDao.getTempTeacherByUserName(""+MinSn);
           if( tempQueryResult.getList() != null){
            queryResult.getList().addAll(tempQueryResult.getList());
           }
           TempTeacher tempTeacher;
           Iterator<TempTeacher> it = queryResult.getList().iterator();
           
           while(it.hasNext()){
               TempTeacherWithoutPwd teacherWithoutPwd = new TempTeacherWithoutPwd();
               tempTeacher = it.next();
               teacherWithoutPwd.copy(tempTeacher);
               list.add(teacherWithoutPwd);
           }
        }
        return list;
        
    }
  //  根据　学院查询

        public static List getTempTeacherByCollegeName(String collegeName){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            SQLQuery sQLQuery = session.createSQLQuery("select * from temp_teacher where teacher_college ="+collegeName);
            sQLQuery.addEntity(TempTeacher.class);
            List<TempTeacherWithoutPwd> list = new LinkedList<TempTeacherWithoutPwd>();
            TempTeacher tempTeacher;
            TempTeacherWithoutPwd teacherWithoutPwd;
            Iterator<TempTeacher> iterator = sQLQuery.iterate();
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
    public static List getAllTempTeacher(){
        return TempTeacherDao.getAllTempTeacher();
    }
    
    
    public static boolean addTempTeacherMessage(String teacherSn, String teacherName, String teacherIdcard, String teacherCollegeName, String teacherTel, String teacherQq, String teacherPwd, String teacherSex, String teacherPosition, Date teacherEnrolling){
        if(teacherSex.compareTo("男") != 0 && teacherSex.compareTo("女") != 0 ){
            return false;
        }
        TempTeacher tempTeacher = new TempTeacher(teacherSn, teacherName, teacherIdcard, teacherCollegeName, teacherTel, teacherQq, teacherPwd, teacherSex.compareTo("男")==0, teacherPosition, teacherEnrolling);
        TempTeacherDao.saveTempTeacher(tempTeacher);
//        System.err.println("成功");
        return true;
    }
    

    
//    public static void main(String[] args) {
//        TempTeacherDao.deleteTempTeacherById(1);
//
//    }
    public PageBean<TempTeacher>  findAll(int pc, int ps){
        Session session = HibernateUtil.getSessionFactory().openSession();
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
            PageBean<TempTeacher> pageBean = new PageBean<TempTeacher>();
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
    public static void deleteTempTeacherById(int id){
        TempTeacherDao.deleteTempTeacherById(id);
    }
    
    
//    public static void main(String[] args) {
//        
//        TempTeacherMethod teacherMethod = new TempTeacherMethod();
//        PageBean<TempTeacher> pageBean = teacherMethod.findAll(0, 10);
//        List list = pageBean.getBeanList();
//        Iterator<TempTeacher> iterator = list.iterator();
//        //request.setAttribute("iterator", iterator);
//       // System.out.println(iterator.next().getTeacherName());
////        System.out.println(pageBean.getPc());
////        System.out.println(pageBean.getPs());
////        System.out.println(pageBean.getTp());
////        System.out.println(pageBean.getTr());
//       
//        
//        
//
//    }
}
