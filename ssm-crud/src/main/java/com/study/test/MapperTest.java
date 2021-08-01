package com.study.test;

/**
 * @author tao
 * @create 2021-07-27 8:21
 * @Description 测试dao层的工作
 * 推荐spring的项目就可以使用spring的单元测试，可以自动注入我们需要的组件
 * 1、导入springTest模块
 * 2、@ContextConfiguration指定spring配置文件的位置
 */


import com.study.bean.Employee;
import com.study.dao.DepartmentMapper;
import com.study.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;
/*spring单元测试类*/
@RunWith(SpringJUnit4ClassRunner.class)
/*读取配置文件*/
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    /*注入批量插入的sqlSession*/
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
//        System.out.println("departmentMapper = " + departmentMapper);

        /*插入几个部门*/
//        Department department1 = new Department(null, "开发部");
//        Department department2 = new Department(null, "测试部");
//        departmentMapper.insertSelective(department1);
//        departmentMapper.insertSelective(department2);

        /*测试插入员工*/
//        Employee employee = new Employee(null, "胡涛", "男", "2223@qq.com", 1);
//        employeeMapper.insertSelective(employee);

        /*批量插入员工,如果不导入这个批量插入的sqlSession,使用上面的插入，会要很长时*/
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uid, "男", uid+"@qq.com", 1));
        }
        System.out.println("插入完成");
    }

}
