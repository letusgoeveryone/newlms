/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.model;

import java.util.LinkedList;
import java.util.List;

/**
 *
 * @author Name : liubingxu Email : 2727826327qq.com
 */
public class Tree3 {
    private Integer id;  
    private String state;
    private String text; 
    private String attributes;
    private Tree3 target;
    private String domId;
    private boolean checked;
    private String[] resource;
    private List<Tree1> children = new LinkedList(); //子节点

    public Tree3 getTarget() {
        return target;
    }

    public void setTarget(Tree3 target) {
        this.target = target;
    }

    public String[] getResource() {
        return resource;
    }

    public void setResource(String[] resource) {
        this.resource = resource;
    }

    public String getDomId() {
        return domId;
    }

    public void setDomId(String domId) {
        this.domId = domId;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
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

    public String getAttributes() {
        return attributes;
    }

    public void setAttributes(String attributes) {
        this.attributes = attributes;
    }

    public List<Tree1> getChildren() {
        return children;
    }

    public void setChildren(List<Tree1> children) {
        this.children = children;
    }
    
}
