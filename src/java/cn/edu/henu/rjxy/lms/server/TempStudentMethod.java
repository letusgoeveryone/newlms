/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;


import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;


/**
 *
 * @author Administrator
 */
public class TempStudentMethod {
    
    
    
    public static void addTempStudentMessage(String studentSn, String studentName,
            String studentIdcard, int studentGrade, String studentCollegeName, String studentTel,
            String studentQq, String studentPwd, String studentSex, Date studentEnrolling){
        TempStudent tempStudent = new TempStudent(studentSn, studentName, studentIdcard, studentGrade, studentCollegeName, studentTel, studentQq, studentPwd, studentSex.compareTo("男")==0, studentEnrolling);
        TempStudentDao.saveTempStudent(tempStudent);
    }
    
    public static List<StudentWithoutPwd> getStudentBySn(int MinSn,int MaxSn){
        QueryResult<TempStudent> queryResult = new QueryResult<TempStudent>();
        queryResult.setList(new LinkedList());
        QueryResult<TempStudent> tempQueryResult;
        for(;MinSn <= MaxSn;MinSn++){
            tempQueryResult = TempTeacherDao.getTempTeacherByUserName(""+MinSn);
           if( tempQueryResult.getList() != null){
            queryResult.getList().addAll(tempQueryResult.getList());
           }
        }
        TempStudent tempStudent;
        StudentWithoutPwd tempStudentWithoutPwd;
        List<StudentWithoutPwd> list = new LinkedList<StudentWithoutPwd>();
        Iterator<TempStudent> it = queryResult.getList().iterator();
        while(it.hasNext()){
            tempStudent = it.next();
            tempStudentWithoutPwd = new StudentWithoutPwd();
            tempStudentWithoutPwd.copy(tempStudent);
            list.add(tempStudentWithoutPwd);
        }
 
        return list;
        
    }
    
        public static List getAllTempStudent(){
        return TempStudentDao.getAllTempStudent();
    }
        
   public static PageBean<TempStudent>  findAll(int pc, int ps){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            List list = session.createQuery("FROM TempStudent")
                    .setFirstResult((pc-1)*ps)
                    .setMaxResults(ps)
                    .list();
            
            Long count = (Long)  session.createQuery(
                    "SELECT COUNT(*) FROM TempStudent"
            ).uniqueResult();
            PageBean<TempStudent> pageBean = new PageBean<TempStudent>();
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
   
   public static void deleteTempStudentById(int id){
        TempStudentDao.deleteTempStudentById(id);
    }
   
//    public static void main(String[] args) {
//        
//        
//        PageBean<TempStudent> pageBean = new TempStudentMethod().findAll(0, 10);
//        System.out.print(pageBean.getBeanList().size());
//    }
        

    
}
