/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.server;

import cn.edu.henu.rjxy.lms.dao.ClassesDao;
import cn.edu.henu.rjxy.lms.dao.TermClassDao;
import cn.edu.henu.rjxy.lms.model.PageBean;
import cn.edu.henu.rjxy.lms.model.TermClass;

/**
 *
 * @author Administrator
 */
public class TermClassMethod {

    public void saveTermClass(int classId, int term) {
        TermClassDao termClassDao = new TermClassDao();

        termClassDao.saveTermClass(new TermClass(term, new ClassesDao().getClassById(classId)));
    }

    public void deleteTermClass(int id) {
        new TermClassDao().deleteTermClassByid(id);
    }

    public PageBean<TermClass> findAll(int term, int pc, int ps) {
        return new TermClassDao().findAll(term, pc, ps);
    }
}
