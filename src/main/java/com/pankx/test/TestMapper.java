package com.pankx.test;

import com.pankx.bean.Employee;
import com.pankx.dao.DepartmentMapper;
import com.pankx.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

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
    //自动注tyDepartmentMapper对象
    @Autowired
    DepartmentMapper departmentMapper;
    //自动注入EmployeeMapper对象
    @Autowired
    EmployeeMapper employeeMapper;
    //自动注入SqlSession对象
    @Autowired
    SqlSession sqlSession;

    //如要测试注释中的方法，只需去掉注释即可
    @Test
    public void testDepartmentMapper(){
        //departmentMapper.selectByPrimaryKey(2);
        //System.out.println(departmentMapper.selectByPrimaryKey(7).getDeptName());
        //测试部门的插入
        //departmentMapper.insertSelective(new Department(null,"开发部"));
        //departmentMapper.insertSelective(new Department(null,"行政部"));

        //测试员工的插入
        //employeeMapper.insertSelective(new Employee(null,"pankx","m","764670547@qq.com",18));

        //批量插入多个员工可以使用可指操作的sqlSession
        EmployeeMapper employee = sqlSession.getMapper(EmployeeMapper.class);
        //批量插入1000条数据
        for (int i=0;i<1000;i++){
            String uuid = UUID.randomUUID().toString().substring(0,5);
            employee.insertSelective(new Employee(null,"pankx"+uuid,"M",uuid+"@qq.com",18));
        }
        System.out.println("批量完成");
    }
}
