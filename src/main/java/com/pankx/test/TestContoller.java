package com.pankx.test;

import com.github.pagehelper.PageInfo;
import com.pankx.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;


/**
 * 使用Spring提供的测试模块测试请求功能
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
//如果要注入ioc容器本身，可以使用注解@WebAppConfiguration 再使用@Autowired注解即可注入ioc容器
@WebAppConfiguration
public class TestContoller {
    /**
     * 虚拟的mvc
     * 可以用来模拟get、post等http请求
     */
    MockMvc mockMvc;
    //注入SpringMVC的ioc
    @Autowired
    WebApplicationContext context;
    //在测试方法运行前获取MockMvc对象
    @Before
    public void initMockMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    /**
     * 模拟get请求
     * @throws Exception
     */
    @Test
    public void testPage() throws Exception {
        //模拟get请求获取得结果
        MvcResult mvcResult =  mockMvc.perform(MockMvcRequestBuilders.get("/emps/getemps").param("pn","15")).andReturn();
        //此时请求域中会有一个pageInfo,可以取出pageInfo验证
        PageInfo page = (PageInfo) mvcResult.getRequest().getAttribute("pageInfo");
        //输出page的数据,如果有数据输出说明控制器类可能正常工作
        System.out.println(page);
        System.out.println("当前页码："+page.getPageNum());
        System.out.println("总页码："+ page.getPages());
        System.out.println("总记录数："+ page.getTotal());
        System.out.println("获取连续显示的页码：");
        int[] nums = page.getNavigatepageNums();
        for(int num: nums){
            System.out.print(num + " ");
        }
        System.out.println("\n");
        //获取员工数据
        List<Employee> lists = page.getList();
        System.out.println("以下为查询返回的员工数据\n");
        for (Employee employee : lists){
            //输出员工数据
            System.out.println(employee);
        }
    }

}
