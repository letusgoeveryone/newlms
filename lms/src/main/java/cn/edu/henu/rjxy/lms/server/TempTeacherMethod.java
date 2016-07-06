/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;



import cn.edu.henu.rjxy.lms.dao.TempTeacherDao;

import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TempTeacher;
import cn.edu.henu.rjxy.lms.model.TempTeacherWithoutPwd;
import java.util.Date;
import java.util.List;



public class TempTeacherMethod {//根据学号范围　
    
    /**
     *获取指定范围内工号的教师
     * @param minSn 工号最小值
     * @param maxSn 工号最大值
     * @return 返回指定范围内临时教师列表
     */
    public static List<TempTeacherWithoutPwd> getTempTeacherBySn(Integer minSn,Integer maxSn){
        return TempTeacherDao.getTempTeacherBySn(minSn, maxSn);
    }
    
    /**
     *获取指定学院的所有临时教师
     * @param collegeName  学院名
     * @return 返回临时教师列表
     */
    public static List getTempTeacherByCollegeName(String collegeName) {
        return TempTeacherDao.getTempTeacherByCollegeName(collegeName);
    }
    
    /**
     *获取全体临时教师对象
     * @return 全体临时教师对象
     */
    public static List getAllTempTeacher() {
        return TempTeacherDao.getAllTempTeacher();
    }

    /**
     *根据工号获取临时教师密码
     * @param userName 工号
     * @return 返回指定教师密码
     */
    public static String teacherLoginGetPasswordByUserName(String userName) {
        TempTeacher tempTeacher = TempTeacherDao.getTempTeacherBySn(userName);
        if (tempTeacher != null) {//结果惟一

            return tempTeacher.getTeacherPwd();
        } else {
            return "";
        }
    }
    
    /**
     *临时教师注册
     * @param teacherSn 工号
     * @param teacherName 教师姓名
     * @param teacherIdcard 教师身份证
     * @param teacherCollegeName 教师院系
     * @param teacherTel 手机号
     * @param teacherQq 教师QQ
     * @param teacherPwd 密码
     * @param teacherSex 性别
     * @param teacherPosition 教师角色值
     * @param teacherEnrolling 注册时间
     * @return
     */
    public static boolean addTempTeacherMessage(String teacherSn, String teacherName, String teacherIdcard, String teacherCollegeName, String teacherTel, String teacherQq, String teacherPwd, String teacherSex, String teacherPosition, Date teacherEnrolling){
        if(teacherSex.compareTo("男") != 0 && teacherSex.compareTo("女") != 0 ){
            return false;
        }
        TempTeacher tempTeacher = new TempTeacher(teacherSn, teacherName, teacherIdcard, teacherCollegeName, teacherTel, teacherQq, teacherPwd, teacherSex.compareTo("男")==0, teacherPosition, teacherEnrolling);
        
        TempTeacherDao.saveTempTeacher(tempTeacher);
//        System.err.println("成功");
        return true;
    }
    
    /**
     *为全体教师分页
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 一个分页bean对象
     */
    public PageBean<TempTeacher>  findAll(Integer pc, Integer ps){
        return TempTeacherDao.findAll(pc, ps);
    }

    /**
     *根据id删除指定临时教师
     * @param id 临时教师id
     */
    public static void deleteTempTeacherById(Integer id){
        TempTeacherDao.deleteTempTeacherById(id);
    }

}
