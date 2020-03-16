package com.pankx.service;

import com.pankx.bean.Employee;
import com.pankx.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {

    //注入EmployeeMapper
    @Autowired
    private EmployeeMapper employeeMapper;

    /**
     * 查询所有用户信息
     * @return
     */
    public List<Employee> getAll(){
        System.out.println("getAll。。。。执行了");
        return employeeMapper.selectByExampleWithDept(null);
    }

}
