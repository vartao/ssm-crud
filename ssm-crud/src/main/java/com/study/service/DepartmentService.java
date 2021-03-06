package com.study.service;

/**
 * @author tao
 * @create 2021-07-29 17:34
 * @Description
 */

import com.study.bean.Department;
import com.study.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }

}
