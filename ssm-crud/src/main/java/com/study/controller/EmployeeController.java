package com.study.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.study.bean.Employee;
import com.study.bean.Msg;
import com.study.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author tao
 * @create 2021-07-27 14:22
 * @Description 处理员工crud请求
 */
@Controller
public class EmployeeController {


    /**
     * 如果uri为 /emp/{id} ，请求方式为GET，就查询员工
     * 如果uri为 /emp ，     请求方式为POST，就保存员工
     * 如果uri为 /emp/{id} ，请求方式为PUT，就修改员工
     * 如果uri为 /emp/{id} ，请求方式为DELETE，就删除员工
     */

    @Autowired
    EmployeeService employeeService;


    /**
     * @Description: 要让ResponseBody正常工作，我们需要导入Jackson包，
     * 才能将返回给客户端的对象转换为json字符串
     * @Author: taoz
     * @Date: 2021/7/28 10:47
     * @param pageNum:  当前页码
     * @return: com.study.bean.Msg
     **/
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum){
        //引入PageHelper分页插件
        // 在查询之前调用，并传入参数(当前页码，每一页的容量(这里配置的5))
        PageHelper.startPage(pageNum, 5);
        // 紧跟着startPage后面的查询方法就是一个分页查询
        List<Employee> allEmployees = employeeService.getAllEmployees();
        // 使用PageInfo保证查询后的结果，只要将PageInfo的实例化对象交给页面就行了
        // 封装了详细的分页信息，包括有我们的查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(allEmployees,5);
        return Msg.success().add("pageInfo",page);
    }

    /**
     * @Description: 查询员工数据（分页）
     * @Author: tao
     * @Date: 2021/7/27 14:39
     * @return: java.lang.String
     **/
//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum,
//                          Model model){
//
//        // 引入PageHelper分页插件
//        // 在查询之前调用，并传入参数(当前页码，每一页的容量(这里配置的5))
//        PageHelper.startPage(pageNum, 5);
//        // 紧跟着startPage后面的查询方法就是一个分页查询
//        List<Employee> allEmployees = employeeService.getAllEmployees();
//        // 使用PageInfo保证查询后的结果，只要将PageInfo的实例化对象交给页面就行了
//        // 封装了详细的分页信息，包括有我们的查询出来的数据,传入连续显示的页数
//        PageInfo page = new PageInfo(allEmployees,5);
//        model.addAttribute("pageInfo",page);
//        return "list";
//    }

    /**
     * @Description:员工保存
     * 要加入依赖 hibernate-validator
     * 支持JSR303校验
     * @Author: tao
     * @Date: 2021/7/29 19:37
     * @param employee:  只要前端页面表单中的输入框name属性值和我们javabean的属性名一致，
     *                这里会将前端页面的表单中的数据直接封装为员工对象
     * @return: com.study.bean.Msg
     **/
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            // 校验失败 返回失败 在模态框显示失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误的字段名 = " + fieldError.getField());
                System.out.println("错误信息 = " + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    /**
     * @Description: 检测用户名
     * @Author: tao
     * @Date: 2021/7/31 9:32
     * @param empName:
     * @return: com.study.bean.Msg
     **/
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName")String empName){
        String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if(!empName.matches(reg)){
            return Msg.fail().add("va_msg","用户名必须是6-16为字母组合或者2-5位中文");
        }
        // 数据库用户名重复校验
        boolean flag = employeeService.checkUser(empName);
        if(flag){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名存在");
        }
    }


    /**
     * @Description: 根据员工id查询员工对象
     * @Author: tao
     * @Date: 2021/7/31 15:49
     * @param id:
     * @return: com.study.bean.Msg
     **/
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    /*取路径上的参数信息使用PathVariable 取请求参数使用RequestParam*/
    public Msg getEmp(@PathVariable("id")Integer id){
        Employee employee =  employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 如果ajax直接发送PUT请求，我们封装的数据为：
     * Employee
     *      {empId=1036, empName='null', gender='null', email='null', dId=null, department=null}
     * 而在请求头中是有数据的，email=ast12123%40nn.com&gender=M&dId=1
     *
     * 问题就在于请求体中有数据，但是Employee对象封装不上
     * 这样的话SQL语句就变成 update tbl_employee where emp_id = 1014 ，没有set字段，所以sql语法就有问题
     *
     * 而封装不上的原因在于
     * Tomcat:
     *      tomcat会将请求体中的数据封装为一个map，request.getParameter("empName")就会从这个map中取值
     *      而SpringMVC封装POJO对象的时候，会把POJO中每个属性的值调用request.getParameter()方法来获取
     *
     *      但是如果AJAX发送PUT请求，tomcat看到是PUT请求，就不会将请求体中的数据封装为map，
     *      只有POST请求才会封装请求体为map
     *
     *解决方案：
     * 我们要能支持直接发送PUT之类的请求，还要封装请求体中的数据
     *      在web.xml中配置上FormContentFilter过滤器
     *      他的作用是将请求体中的数据解析包装成map
     *      request被重新包装，request.getParameter()被重写，就会从自己封装的map中取出数据
     *
     * 员工更新方法
     * @param employee
     * @return
     */
    /*这里的empId和Javabean里面的属性名一致，就会将这个地址栏传递过来的参数字自动封装到这个员工对象中，
    没有这个id就不能根据id来修改员工信息了*/
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * @Description: 员工删除
     * 单个批量二合一
     * 单个删除：1
     * 多个删除：1-2-3
     * @Author: tao
     * @Date: 2021/7/31 21:00
     * @param ids: 字符串id
     * @return: com.study.bean.Msg
     **/
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        // 批量删除
        if(ids.contains("-")){
            // 要删除的id集合
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            // 组装id的集合
            for (String id : str_ids) {
                // 将字符串id转为数值型 存到集合中
                del_ids.add(Integer.parseInt(id));
            }
            // 调用批量删除方法
            employeeService.deleteBatch(del_ids);
        }else{
            //单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }
}
