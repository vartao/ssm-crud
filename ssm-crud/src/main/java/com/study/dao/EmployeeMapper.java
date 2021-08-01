package com.study.dao;

import com.study.bean.Employee;
import com.study.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    /*查询员工对象，并且将对应的部门对象查出来*/
    List<Employee> selectByExampleWithDept(EmployeeExample example);

    /*根据主键查询员工对象，同时将部门对象查询出来*/
    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByPrimaryKeySelective(Employee record);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);
}