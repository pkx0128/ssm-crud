package com.pankx.test;

import com.github.pagehelper.PageInfo;
import com.pankx.bean.Employee;
import com.pankx.service.EmployeeService;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
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
@WebAppConfiguration
public class TestContoller {
    //虚拟mvc
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
        //模拟请求获取得结果
        MvcResult mvcResult =  mockMvc.perform(MockMvcRequestBuilders.get("/emps/getemps").param("pn","1")).andReturn();
        //此时请求域中会有一个pageInfo,可以取出pageInfo验证
        PageInfo page = (PageInfo) mvcResult.getRequest().getAttribute("pageInfo");
        //输出page的数据
        System.out.println(page);
    }

}
