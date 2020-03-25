package com.pankx.service;

import com.pankx.bean.Employee;
import com.pankx.bean.EmployeeExample;
import com.pankx.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("employeeService")
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

    /**
     * 保存员工数据到数据库
     * @param employee
     * @return
     */
    public int insertEmployee(Employee employee){
        return employeeMapper.insertSelective(employee);
    }

    /**
     * 根据名字查询
     * @param empName
     * @return返回true表示姓名可用，返回false表示姓名重复
     */
    public boolean getByName(String empName){
        //创建EmployeeExample对象
        EmployeeExample example = new EmployeeExample();
        //设置条件
        example.createCriteria().andEmpNameEqualTo(empName);
        //返回true表示姓名可用，返回false表示姓名重复,不可用
        return employeeMapper.countByExample(example) == 0;
    }

    /**
     * 根据id查询员工信息
     * @param id
     * @return
     */
    public Employee getempById(Integer id){
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

}
