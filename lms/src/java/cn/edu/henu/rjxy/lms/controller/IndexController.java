/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.edu.henu.rjxy.lms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author liubingxu
 */
@Controller
@RequestMapping("/")
public class IndexController {
    @RequestMapping("index")
    public String index1(){
        return "index";
    }
}
