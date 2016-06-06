/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.ClassesDao;
import cn.edu.henu.rjxy.lms.dao.TermClassDao;
import cn.edu.henu.rjxy.lms.model.Classes1;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TermClass;

/**
 *
 * @author Administrator
 */
public class TermClassMethod {

    /**
     *保存学期班级
     * @param classId 班级id
     * @param term 学期
     */
    public static void saveTermClass(Integer classId, Integer term) {
        TermClassDao.saveTermClass(new TermClass(term, ClassesDao.getClassById(classId)));
    }
    public static void main(String[] args) {
        saveTermClass(2, 201501);
    }

    /**
     *根据id删除一个学期班级
     * @param id 学期班级id
     */
    public void deleteTermClass(Integer id) {
        TermClassDao.deleteTermClassByid(id);
    }

    /**
     *为所有学期班级分页
     * @param term 学期
     * @param pc 当前页
     * @param ps 每页记录数
     * @return 分页bean对象
     */
    public static PageBean<Classes1> findAll(Integer term, Integer pc, Integer ps) {
        return TermClassDao.findAll(term, pc, ps);
    }
}
