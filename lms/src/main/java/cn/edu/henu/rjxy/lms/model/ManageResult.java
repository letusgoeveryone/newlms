/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

/**
 *
 * @author Administrator
 */
public class ManageResult {
    private String sn;
    private String name;
    private String idCard;
    private String sex;
    private String position;
    private String tel;
    private String qq;
    private String control;

    
    
    
    public ManageResult copy(Object ob){
        if (ob instanceof TempTeacherWithoutPwd) {
            TempTeacherWithoutPwd ttwp = (TempTeacherWithoutPwd)ob;
            this.setSn(ttwp.getTeacherSn());
            this.setName(ttwp.getTeacherName());
            this.setIdCard(ttwp.getTeacherIdcard());
            String sexString = "";
            if (ttwp.getTeacherSex()) {
                sexString = "男";
            }else{
                sexString = "女";
            }
            this.setSex(sexString);
            this.setPosition(ttwp.getTeacherPosition());
            this.setTel(ttwp.getTeacherTel());
            this.setQq(ttwp.getTeacherQq());
        }else if(ob instanceof StudentWithoutPwd){
            StudentWithoutPwd swp = (StudentWithoutPwd)ob;
            this.setSn(swp.getStudentSn());
            this.setName(swp.getStudentName());
            this.setIdCard(swp.getStudentIdcard());
            String sexString = "";
            if (swp.isStudentSex()) {
                sexString = "男";
            }else{
                sexString = "女";
            }
            this.setSex(sexString);
            this.setPosition("学生");
            this.setTel(swp.getStudentTel());
            this.setQq(swp.getStudentQq());
        }else{
            throw new RuntimeException("传入对象类型不符合");
        }
       
        return this;
    }

    /**
     * @return the sn
     */
    public String getSn() {
        return sn;
    }

    /**
     * @param sn the sn to set
     */
    public void setSn(String sn) {
        this.sn = sn;
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the idCard
     */
    public String getIdCard() {
        return idCard;
    }

    /**
     * @param idCard the idCard to set
     */
    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    /**
     * @return the sex
     */
    public String getSex() {
        return sex;
    }

    /**
     * @param sex the sex to set
     */
    public void setSex(String sex) {
        this.sex = sex;
    }

    /**
     * @return the position
     */
    public String getPosition() {
        return position;
    }

    /**
     * @param position the position to set
     */
    public void setPosition(String position) {
        this.position = position;
    }

    /**
     * @return the tel
     */
    public String getTel() {
        return tel;
    }

    /**
     * @param tel the tel to set
     */
    public void setTel(String tel) {
        this.tel = tel;
    }

    /**
     * @return the qq
     */
    public String getQq() {
        return qq;
    }

    /**
     * @param qq the qq to set
     */
    public void setQq(String qq) {
        this.qq = qq;
    }

     /**
     * @return the Control
     */
    public String getControl() {
        return control;
    }

    /**
     * @param control the control to set
     */
    public void setControl(String control) {
        this.control = control;
    }
}











