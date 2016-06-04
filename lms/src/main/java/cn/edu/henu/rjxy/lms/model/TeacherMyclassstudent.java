/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

import java.util.List;
import java.util.Objects;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
public class TeacherMyclassstudent {
    private int pc;//当前页码
    private int tr;//总记录数
    private int ps;//每页记录数
    private List<Mystudent> beanList;//当前页的记录

    public int getPc() {
        return pc;
    }

    public void setPc(int pc) {
        this.pc = pc;
    }

    public int getTr() {
        return tr;
    }

    public void setTr(int tr) {
        this.tr = tr;
    }

    public int getPs() {
        return ps;
    }

    public void setPs(int ps) {
        this.ps = ps;
    }

    public List<Mystudent> getBeanList() {
        return beanList;
    }

    public void setBeanList(List<Mystudent> beanList) {
        this.beanList = beanList;
    }
    
}
