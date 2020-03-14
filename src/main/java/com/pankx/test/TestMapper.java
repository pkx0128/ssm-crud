package com.pankx.test;

import com.pankx.bean.Department;
import com.pankx.bean.Employee;
import com.pankx.dao.DepartmentMapper;
import com.pankx.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试dao层的工作
 * 推荐Spring的项目使用Spring的单元测试，可以自动注入我们需要的组件
 * 1.导入Spring-test依赖
 * 2.使用@ContextConfiguration指定Spring配置文件的位置
 * 3.使用@Autowired自动注入对象
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestMapper {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Test
    public void testDepartmentMapper(){
//        departmentMapper.selectByPrimaryKey(2);
//        System.out.println(departmentMapper.selectByPrimaryKey(7).getDeptName());
        //测试插入
        departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"行政部"));

    }

}
