/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.CollegeDao;
import cn.edu.henu.rjxy.lms.dao.QueryResult;
import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;
import cn.edu.henu.rjxy.lms.hibernateutil.HibernateUtil;
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
    
    public static List<TempTeacher> getTempTeacherBySn(int MinSn,int MaxSn){
        QueryResult<TempTeacher> queryResult = new QueryResult<TempTeacher>();
        queryResult.setList(new LinkedList());
        QueryResult<TempTeacher> tempQueryResult;
        for(;MinSn <= MaxSn;MinSn++){
            tempQueryResult = TempTeacherDao.getTempTeacherByUserName(""+MinSn);
           if( tempQueryResult.getList() != null){
            queryResult.getList().addAll(tempQueryResult.getList());
           }
        }
        return queryResult.getList();
        
    }
  //  根据　学院查询

        public static List getTempTeacherByCollegeName(String collegeName){
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        try {

            //操作
            SQLQuery sQLQuery = session.createSQLQuery("select * from temp_teacher where teacher_college_id ="+CollegeDao.getIdByCollegeName(collegeName));
            sQLQuery.addEntity(TempTeacher.class);
            List<TempTeacherWithoutPwd> list = new LinkedList<TempTeacherWithoutPwd>();
            TempTeacher tempTeacher;
            TempTeacherWithoutPwd teacherWithoutPwd;
            Iterator<TempTeacher> iterator = sQLQuery.iterate();
            int i = 0;
            for(; i < sQLQuery.list().size(); i++){
                tempTeacher = iterator.next();
                teacherWithoutPwd = new TempTeacherWithoutPwd();
                teacherWithoutPwd.setTeacherSn(tempTeacher.getTeacherSn());
                teacherWithoutPwd.setTeacherName(tempTeacher.getTeacherName());
                teacherWithoutPwd.setTeacherIdcard(tempTeacher.getTeacherIdcard());
                teacherWithoutPwd.setTeacherCollegeId(tempTeacher.getTeacherCollegeId());
                teacherWithoutPwd.setTeacherTel(tempTeacher.getTeacherTel());
                teacherWithoutPwd.setTeacherCollegeId(tempTeacher.getTeacherCollegeId());
                teacherWithoutPwd.setTeacherQq(tempTeacher.getTeacherQq());
                teacherWithoutPwd.setTeacherPositionId(tempTeacher.getTeacherPositionId());
                teacherWithoutPwd.setTeacherEnrolling(tempTeacher.getTeacherEnrolling());
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
    
    public static void main(String[] args) {      
        List list = getTempTeacherByCollegeName("文学院");
        System.out.println(list.size());
        Iterator<TempTeacher> iterator = list.iterator();
        while(iterator.hasNext()){
            System.out.println((iterator.next().getTeacherName()));
        }

    }
    
    public static boolean addTempTeacherMessage(String teacherSn, String teacherName, String teacherIdcard, String teacherCollegeName, String teacherTel, String teacherQq, String teacherPwd, String teacherSex, int teacherPositionId, Date teacherEnrolling){
        if(teacherSex.compareTo("男") != 0 && teacherSex.compareTo("女") != 0 ){
            return false;
        }
        TempTeacher tempTeacher = new TempTeacher(teacherSn, teacherName, teacherIdcard, CollegeDao.getIdByCollegeName(teacherCollegeName), teacherTel, teacherQq, teacherPwd, teacherSex.compareTo("男")==0, teacherPositionId, teacherEnrolling);
        TempTeacherDao.saveTempTeacher(tempTeacher);
//        System.err.println("成功");
        return true;
    }
    
}
