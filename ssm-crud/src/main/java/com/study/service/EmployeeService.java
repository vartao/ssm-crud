package com.study.service;

import com.study.bean.Employee;
import com.study.bean.EmployeeExample;
import com.study.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author tao
 * @create 2021-07-27 14:41
 * @Description
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /*新增的员工ID值没有正确的排列
    原因：左外连接查询会根据主表向从表一个一个的查，导致从表的dept_id等于1的先查出来。
    解决办法：在servie层改代码
    public ListEmployee getAll() {
		EmployeeExample example = new EmployeeExample();
		example.setOrderByClause(emp_id);
		return employeeMapper.selectByExampleWithDept(example);
	}*/

    // 查询所有员工
    public List<Employee> getAllEmployees(){
        EmployeeExample example = new EmployeeExample();
        example.setOrderByClause("emp_id");
        return employeeMapper.selectByExampleWithDept(example);
    }

    /**
     * @Description:保存员工
     * @Author: tao
     * @Date: 2021/7/30 21:22
     * @param employee:
     * @return: void
     **/
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 检验用户名是否可用
     * @param empName
     * @return
     */
    public boolean checkUser(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long l = employeeMapper.countByExample(example);
        // l==0的话，说明数据库没有数据，返回true就可以了
        return l == 0;
    }

    /**
     * @Description: 根据员工id查询员工
     * @Author: tao
     * @Date: 2021/7/31 14:49
     * @param id:
     * @return: com.study.bean.Employee
     **/
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKeyWithDept(id);
        return employee;
    }

    /**
     * @Description: 员工更新
     * @Author: tao
     * @Date: 2021/7/31 16:33
     * @param employee:  
     * @return: void
     **/
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * @Description: 员工删除
     * @Author: tao
     * @Date: 2021/7/31 20:29
     * @param id:
     * @return: void
     **/
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * @Description: 根据id批量删除员工
     * @Author: tao
     * @Date: 2021/7/31 23:04
     * @param ids:
     * @return: void
     **/
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        // delete from tb_emp where id in (1,2,3...)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
