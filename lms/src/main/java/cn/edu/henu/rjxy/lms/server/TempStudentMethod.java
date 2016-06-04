/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;



import cn.edu.henu.rjxy.lms.dao.TempStudentDao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TempStudent;
import cn.edu.henu.rjxy.lms.model.StudentWithoutPwd;
import java.util.Date;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.Transaction;


/**
 *
 * @author Administrator
 */
public class TempStudentMethod {
    
    /**
     *t保存一个正式学生
     * @param studentSn 学号
     * @param studentName 姓名
     * @param studentIdcard 身份证
     * @param studentGrade 年级
     * @param studentCollegeName 学院名
     * @param studentTel 手机号
     * @param studentQq qq号
     * @param studentPwd 密码
     * @param studentSex 性别
     * @param studentEnrolling 注册时间
     */
    public static void addTempStudentMessage(String studentSn, String studentName,
            String studentIdcard, Integer studentGrade, String studentCollegeName, String studentTel,
            String studentQq, String studentPwd, String studentSex, Date studentEnrolling) {
        TempStudent tempStudent = new TempStudent(studentSn, studentName, studentIdcard, studentGrade, studentCollegeName, studentTel, studentQq, studentPwd, studentSex.compareTo("男") == 0, studentEnrolling);
        TempStudentDao.saveTempStudent(tempStudent);
    }
    
    /**
     *根据工号获取密码
     * @param userName 学号
     * @return
     */
    public static String studentLoginGetPasswordByUserName(String userName){
       TempStudent tempStudent = TempStudentDao.getTempStudentBySn(userName);
       if(tempStudent != null){//查无此人
         return tempStudent.getStudentPwd();
       }else{
             return "";
        }      
      }
    
    /**
     *根据学号范围为临时学生分页
     * @param minSn 学号最小值
     * @param maxSn 学号最大值
     * @return 返回范围内学生列表
     */
    public static List<StudentWithoutPwd> getStudentsBySn(Integer minSn, Integer maxSn) {
        return TempStudentDao.getTempStudentsBySn(minSn, maxSn);

    }
    
    /**
     *获取全体临时学生对象
     * @return 全体临时学生列表
     */
    public static List getAllTempStudent() {
        return TempStudentDao.getAllTempStudent();
    }
        
    /**
     *为全体临时学生分页
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 返回一个分页bean对象
     */
    public static PageBean<TempStudent>  findAll(Integer pc, Integer ps){
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
            PageBean<TempStudent> pageBean;
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
     *根据id删除临时学生
     * @param id 临时学生id
     */
    public static void deleteTempStudentById(Integer id){
        TempStudentDao.deleteTempStudentById(id);
    }
   


    
}
