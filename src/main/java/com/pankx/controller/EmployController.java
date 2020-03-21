package com.pankx.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pankx.bean.Employee;
import com.pankx.bean.Msg;
import com.pankx.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

/**
 * 员工列表处理器
 */
@RequestMapping("/emps")
@Controller
public class EmployController {
    //注入EmployeeService
    @Autowired
    private EmployeeService employeeService;

    /**
     * 实现ajax数据返回
     * @param pn
     * @return
     */
    @RequestMapping("/getempsbyjson")
    //要返回Json数据，需引入jackson包
    @ResponseBody
    public Msg getEmpsByJson(@RequestParam(value = "pn",defaultValue = "1")int pn){
        //使用PageHelper开始分页，页面编号为pn(既第pn页)，
        PageHelper.startPage(pn,5);
        //此查询为分页查询
        List<Employee> list = employeeService.getAll();
        //使用PageInfo封查询结果,并设置连续显示页面的导航页数
        PageInfo pageInfo = new PageInfo(list,5);
        Msg msg = Msg.success().add("pageInfo",pageInfo);
        return msg;
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

    /**
     * 保存数据到数据库
     * 请求/emps的约定
     * /emps/{param} GET 为查询数据
     * /emps POST 保存数据
     * /emps/{param} PUT 修改数据
     * /emps/{param} DELETE 删除数据
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emps",method = POST)
    @ResponseBody
    public Msg saveEmployee(Employee employee){
        employeeService.insertEmployee(employee);
        return Msg.success();
    }

    /**
     * 根据姓名查询
     * @param empName
     * @return
     */
    @RequestMapping("/checkname")
    @ResponseBody
    public Msg checkname(@RequestParam("empName") String empName){
        System.out.println("========"+employeeService.getByName(empName));
        //校验员工姓名的正则，支持6到16位a到z和A到Z和数字的组合或者2到6位的中文字符
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,6}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","员工姓名必须为6到16位大小写字母和数字的组合或者2到6位的中文字符");
        }
//        //返回true表示姓名可用，返回false表示姓名重复,不可用
        if(employeeService.getByName(empName)){
            return Msg.success().add("va_msg","用户名可用");
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }
}
