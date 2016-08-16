/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

import java.util.LinkedList;
import java.util.List;

/**
 *  教师课程编辑类
 * @author Name : liubingxu Email : 2727826327qq.com
 */
public class AutoCourseNode {
    private Integer id;  
    private String state;
    private String text; 
    private String attributes;
    private String[] resource;
    private List<TeacherCourseResult> children = new LinkedList(); //子节点

    public String getAttributes() {
        return attributes;
    }

    public void setAttributes(String attributes) {
        this.attributes = attributes;
    }
 
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public List<TeacherCourseResult> getChildren() {
        return children;
    }

    public void setChildren(List<TeacherCourseResult> children) {
        this.children = children;
    }
    
}
