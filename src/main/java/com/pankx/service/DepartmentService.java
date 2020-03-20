package com.pankx.service;

import com.pankx.bean.Department;
import com.pankx.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    //注入dao类DepartmentMapper的对象
    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 调用dao方法查询所有部门信息
     * @return
     */
    public List<Department> getDepartments(){
        return departmentMapper.selectByExample(null);
    }
}
