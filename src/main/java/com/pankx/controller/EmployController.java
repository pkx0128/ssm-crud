package com.pankx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pankx.bean.Employee;
import com.pankx.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 员工列表处理器
 */
@RequestMapping("/emps")
@Controller
public class EmployController {
    //注入EmployeeService
    @Autowired
    private EmployeeService employeeService;

    @RequestMapping("/getempsbyjson")
    //要返回Json数据，需引入jackson包
    @ResponseBody
    public PageInfo getEmpsByJson(@RequestParam(value = "pn",defaultValue = "1")int pn){
        //使用PageHelper开始分页，页面编号为pn(既第pn页)，
        PageHelper.startPage(pn,5);
        //此查询为分页查询
        List<Employee> list = employeeService.getAll();
        //使用PageInfo封查询结果,并设置连续显示页面的导航页数
        PageInfo pageInfo = new PageInfo(list,5);
        return pageInfo;
    }



    /**
     * 查询所有数据，
     * @return
     */
    @RequestMapping("/getemps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") int pn, Model model){
        //开始分页，页码编号pn，页面的数据条数为5
        PageHelper.startPage(pn,5);
        //此查询为分页查询
        List<Employee> list = employeeService.getAll();
        //使用PageInfo封查询结果,并设置连续显示页面的导航页数
        PageInfo pageInfo = new PageInfo(list,5);
        //存入请求域
        model.addAttribute("pageInfo",pageInfo);
        return "emplist";
    }
}
