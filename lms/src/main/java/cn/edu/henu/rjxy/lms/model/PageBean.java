/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

import java.util.List;

/**
 *
 * @author Administrator
 * @param <T>
 */
public class PageBean<T> {
    private int pc;//当前页码
//    private int tp;//总页数
    private int tr;//总记录数
    private int ps;//每页记录数
    private List<T> beanList;//当前页的记录

    /**
     * @return the pc
     */
    public int getPc() {
        return pc;
    }

    /**
     * @param pc the pc to set
     */
    public void setPc(int pc) {
        this.pc = pc;
    }

    /**
     * @return the tp
     */
    public int getTp() {
        return tr%ps==0 ? tr/ps:tr/ps+1;
    }

    /**
     * @param tp the tp to set
     */
//    public void setTp(int tp) {
//        this.tp = tp;
//    }

    /**
     * @return the tr
     */
    public int getTr() {
        return tr;
    }

    /**
     * @param tr the tr to set
     */
    public void setTr(int tr) {
        this.tr = tr;
    }

    /**
     * @return the ps
     */
    public int getPs() {
        return ps;
    }

    /**
     * @param ps the ps to set
     */
    public void setPs(int ps) {
        this.ps = ps;
    }

    /**
     * @return the beanList
     */
    public List getBeanList() {
        return beanList;
    }

    /**
     * @param beanList the beanList to set
     */
    public void setBeanList(List beanList) {
        this.beanList = beanList;
    }
}
