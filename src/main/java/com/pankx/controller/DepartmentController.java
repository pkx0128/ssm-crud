package com.pankx.controller;

import com.pankx.bean.Department;
import com.pankx.bean.Msg;
import com.pankx.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
/**
 * 部门控制器类
 */
@RequestMapping("/depts")
@Controller
public class DepartmentController {
    //注入DepartmentService对象
    @Autowired
    private DepartmentService departmentService;
    @RequestMapping("/getdepts")
    @ResponseBody
    public Msg getdepartment(){
        List<Department> list = departmentService.getDepartments();
       return Msg.success().add("department",list);
    }
}
