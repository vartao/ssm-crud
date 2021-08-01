<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: hu tao
  Date: 2021/7/27
  Time: 14:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%
        /*将项目名取出来*/
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <%--web路径：
        不以/开头的相对路径，找资源，以当前的资源路径为基准，经常出问题
        以/开头的相对路径，找资源，以服务器的路径为标准(https://localhosst:8080);需要加上项目名
            https://localhosst:8080/crud
    --%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <%--引入样式--%>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">

                <%--表单---------------------------------------------------%>
                <form class="form-horizontal">
                    <%--姓名--%>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                          <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <%--邮箱--%>
                    <div class="form-group">
                        <label for="email_add_input"  class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%--性别--%>
                    <div class="form-group">
                        <label for="gender1_add_input" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <%--部门名--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id就行--%>
                            <select name="dId" class="form-control">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <%---------------------------------------------------------%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">

                <%--表单---------------------------------------------------%>
                <form class="form-horizontal">
                    <%--姓名--%>
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <%--显示错误信息--%>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%--邮箱--%>
                    <div class="form-group">
                        <label for="email_add_input"  class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <%--性别--%>
                    <div class="form-group">
                        <label for="gender1_add_input" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>

                    <%--部门名--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门名</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id就行--%>
                            <select name="dId" class="form-control" id="deptName_add_input">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <%---------------------------------------------------------%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-hover" id="emps_table">
                    <thead>
                    <tr>
                        <th>
                            <%-- 一键全选 --%>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>邮箱</th>
                        <th>部门</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script>

    /*--------------首页展示数据以及分页条数据----------------------------*/
    //记录总记录数据
    var totalRecord,currentPage;
    //1、页面加载完成以后，直接发送一个ajax请求，要到分页数据
    /*页面加载完成*/
    $(function (){
        // 一进来跳转到第一页
        to_page(1)
    });

    // 指定跳转到哪一页
    function to_page(pageNum){
        //每次页面跳转时，都将全选/全不选设置为false
        $("#check_all").prop("checked", false);

        $.ajax({
            url:"${APP_PATH}/emps",
            data:{pageNum},
            type:"get",
            success:function (result) {
                // 解析员工数据
                build_emps_table(result);
                // 解析并显示分页数据
                build_page_info(result.extend.pageInfo);
                // 解析显示分页条数数据
                build_page_nav(result.extend.pageInfo);
            }
        })
    }
    /*创建员工表格信息*/
    function build_emps_table(result){
        // 清空表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        /*jquery的遍历方法，item为遍历数组中的每一个*/
        $.each(emps,function (index,item){
            //在员工数据的最左边加上多选框
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId)
            var empNameTd = $("<td></td>").append(item.empName)
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女")
            var emailTd = $("<td></td>").append(item.email)
            var deptNameTd = $("<td></td>").append(item.department.deptName)

            // 编辑按钮
            var editBtn =$("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑"));
            // 为编辑按钮添加一个自定义的属性，来表示当前员工id
            editBtn.attr("edit-id",item.empId)
            //删除按钮
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash").append("删除"));
            // 为删除按钮添加自定义属性来表示当前删除的员工id
            delBtn.attr("del-id",item.empId)
            //把两个按钮放到一个单元格中，并且按钮之间留点空隙
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            //append方法执行完成以后还是会返回原来的元素，所以可以一直.append添加元素，
            //将上面的td添加到同一个tr里
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");//将tr添加到tbody标签中
        })
    }
    // 解析显示分页信息
    function build_page_info(result){
        // 清空分页信息
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.pageNum+"页,总"+result.pages+"页,总"+result.total+"条记录")
        totalRecord = result.total
        currentPage = result.pageNum
    }
    /*分页导航信息*/
    function build_page_nav(result){
        // 清空分页导航信息
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        // page_nav_area 构建元素
        // 首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"))
        // 上一页
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"))
        // 如果没有上一页
        if(result.hasPreviousPage==false){
            firstPageLi.addClass("disable")
            prePageLi.addClass("disable")
        }else{
            // 为元素添加点击翻页的事件
            firstPageLi.click(function (){
                to_page(1);
            })
            prePageLi.click(function (){
                to_page(result.pageNum - 1)
            })
        }


        //添加首页和前一页 构建元素
        ul.append(firstPageLi).append(prePageLi)
        // 下一页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"))
        // 最后一页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"))

        // 如果没有下一页
        if(result.hasNextPage==false){
            nextPageLi.addClass("disable")
            lastPageLi.addClass("disable")
        }else{
            lastPageLi.click(function (){
                to_page(result.pages)
            })

            nextPageLi.click(function (){
                to_page(result.pageNum + 1)
            })
        }

        $.each(result.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item))
            if(item == result.pageNum){
                numLi.addClass("active")
            }
            numLi.click(function (){
                to_page(item)
            })
            ul.append(numLi)
        })

        // 添加下一个和末页
        ul.append(nextPageLi).append(lastPageLi)

        // 把ul加入到nav
        var navEle = $("<nav></nav>").append(ul)
        navEle.appendTo("#page_nav_area")

    }

    /*--------------------------新增员工模态框出现以及保存新员工------------------------*/
    // 重置表单函数
    // ele 表单元素
    function reset_form(ele){
        //重置表单内容
        $(ele)[0].reset()
        // 清空表单样式以及校验信息内容
        // 找到表单下面任何元素，只要具有这两个class属性的就移除属性
        $(ele).find("*").removeClass("has-error has-success")
        $(ele).find(".help-block").text("")
    }


    // 点击新增按钮 弹出模态框
    $("#emp_add_modal_btn").click(function (){
        // 清除表单数据 重置表单 (表单的数据以及样式)
        //为啥要加[0]，因为jquery没有重置方法，dom对象有
        reset_form("#empAddModal form")

        // 发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select")
        $("#empAddModal").modal({
            backdrop:"static"
        })
    })

    // 得到部门信息函数
    function getDepts(ele) {
        // 清空下拉 列表的值
        $(ele).empty()
        // 发送ajax请求
        $.ajax({
            url:"${APP_PATH}/depts",
            async:false,
            type: "GET",
            success:function (result){
                // {code: 100, msg: "处理成功", extend: {…}}
                // code: 100
                // extend:
                //     depts: (2) [{…}, {…}]
                // 将显示信息添加到下拉部门列表中
                $("#empAddModal select").append()
                $.each(result.extend.depts,function(){
                    var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId)
                    optionEle.appendTo(ele)
                })
            }
        })
    }

    // 显示校验信息函数
    function show_validate_msg(ele,status,msg){
        // 每次都要清除当前元素校验的状态
        $(ele).parent().removeClass("has-success has-error")
        $(ele).next("span").text("")
        if("success" == status){
            $(ele).parent().addClass("has-success")
            $(ele).next("span").text(msg)
        }else if("error" == status){
            $(ele).parent().addClass("has-error")
            $(ele).next("span").text(msg)
        }
    }

    // 校验邮箱姓名函数
    function validate_add_form(){
        // 清空
        //1、拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            // alert("姓名格式不正确")
            show_validate_msg("#empName_add_input","error","用户名可以是2-5位中文或者6-16位英文和数字的组合")
            // $("#empName_add_input").parent().addClass("has-error")
            // $("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文和数字的组合")
            return false
        }else{
            show_validate_msg("#empName_add_input","success","")
            // $("#empName_add_input").parent().addClass("has-success")
            // $("#empName_add_input").next("span").text("")

        }

        // 2、校验邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if(!regEmail.test(email)){
            show_validate_msg("#email_add_input","error","邮箱格式不正确")
            return false
        }else{
            show_validate_msg("#email_add_input","success","")
        }

        return true
    }

    // 用户名输入框内容改变监听 用户名是否存在
    $("#empName_add_input").change(function (){
        var empName = this.value;
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:{empName},
            type:"GET",
            success:function (result){
                if(result.code == 100){
                    show_validate_msg("#empName_add_input","success","用户名可用")
                    // 将按钮开放
                    $("#emp_save_btn").attr("disabled",false)
                    // 给保存按钮添加属性
                    $("#emp_save_btn").attr("ajax-va","success")
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg)
                    // 将按钮禁用
                    $("#emp_save_btn").attr("disabled",true)
                    $("#emp_save_btn").attr("ajax-va","error")
                }
            }
        })
    })

    // 保存员工按钮点击
    $("#emp_save_btn").click(function (){
        // 1、将模态框的表单数据提交给服务器进行保存
        // 1、先校验数据
        if(!validate_add_form()){return false}

        // 1、判断之前的ajax用户名校验是否成功。如果成功。
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        // 2、发送ajax请求保存员工
        // serialize能将表格中的数据序列化为字符串，用于ajax请求
        // $("#empAddModal form").serialize()
        $.ajax({
            url:'${APP_PATH}/emp',
            type:'POST',
            data: $("#empAddModal form").serialize(),
            success:function (result){
                if(result.code == 100){
                    // alert(result.msg)
                    // 员工保存成功
                    //1、关闭模态框
                    $('#empAddModal').modal('hide')
                    //2、来到最后一页，显示刚才保存的数据
                    // 分页插件他会把大于总页码的页码查出总是最后一页的数据
                    to_page(totalRecord+1)
                }else{
                    // 显示失败信息
                    // 有哪个字段错误就显示哪个字段的
                    if(undefined != result.extend.errorFields.email){
                        // 显示邮箱错误信息
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email)
                    }
                    if (undefined != result.extend.errorFields.empName){
                        // 显示员工名字的错误信息
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName)
                    }
                }

            }

        })
    })


    /*-------------编辑员工信息-----------------------------------*/

    // 点击编辑按钮触发的事件
    // 参考jQuery中的on方法，按钮创建之后还是会继续绑定
    $(document).on("click",".edit_btn",function (){
        // alert("edit");
        //清除错误属性
        // 找到表单下面任何元素，只要具有这两个class属性的就移除属性
        $("#empUpdateModal form").find("*").removeClass("has-error has-success")
        $("#empUpdateModal form").find(".help-block").text("")


        //1、查出部门信息。并且显示部门列表
        getDepts("#empUpdateModal select")

        //2、查出员工信息。显示员工信息
        getEmp($(this).attr("edit-id"))

        //3、把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"))
        $("#empUpdateModal").modal({
            backdrop:"static"
        })
    })

    // 员工查询
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result){
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName)
                $("#email_update_input").val(empData.email)
                $("#empUpdateModal input[name = gender]").val([empData.gender])
                $("#empUpdateModal select").val([empData.dId])
            }
        })
    }

    // 点击更新 更新员工信息
    $("#emp_update_btn").click(function () {
        // 验证邮箱
        // 1、校验邮箱信息
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
        if(!regEmail.test(email)){
            show_validate_msg("#email_update_input","error","邮箱格式不正确")
            return false
        }else{
            show_validate_msg("#email_update_input","success","")
        }

        //2、发送ajax请求保存更新的员工数据
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            // 方法一
            // type:"POST",
            // data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            // 方法二
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result){
                // alert(result.msg)
                // 关闭对话框
                $("#empUpdateModal").modal("hide")
                // 跳转到修改页
                to_page(currentPage);
            }
        })
    });

    /*--------------删除员工--------------------------------------*/

    // 点击单个删除按钮触发的事件
    $(document).on("click",".delete_btn",function (){
        // 弹出是否删除确认框
        var empName = $(this).parents("tr").find("td:eq(2)").text()
        var empId = $(this).attr("del-id");
        if (confirm("确认删除【"+empName+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result){
                    alert(result.msg)
                    to_page(currentPage)
                }
            })
        }

    })

    // 全选/不全选按钮
    $("#check_all").click(function (){
        //   attr获取checked是undefined，因为我们没有定义checked属性，attr获取的是自定义属性值
        //    而我们这些dom原生的属性，可以用prop来获取这些值
        //     alert($(this).prop("checked"));
        //    让所有复选框状态同步
        // .check_item每个员工的选择框
        $(".check_item").prop("checked",$(this).prop("checked"))
    })

    // 当本页面所有复选框都选上时，自动将全选复选框选上
    $(document).on("click", ".check_item", function () {
        //判断当前选择中的元素是否是当前页面所有check_item的个数
        var flag = $(".check_item:checked").length == $(".check_item").length

        $("#check_all").prop("checked",flag)
    })

    // 点击删除按钮
    $("#emp_delete_all_btn").click(function (){
        // 要删除的名字
        var empNames = "";
        // 要删除的id
        var del_idstr = "";
        $.each($(".check_item:checked"),function () {
            //this 值的是被选中的员工复选框
            empNames += $(this).parents("tr").find("td:eq(2)").text()+","
            // 组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-"
        })
        // 去除多余的,
        empNames = empNames.substring(0,empNames.length-1)
        // 删除id多余的-
        del_idstr = del_idstr.substring(0,del_idstr.length-1)
        if(confirm("确认删除【"+empNames+"】吗？")){
            // 发送ajax请求删除
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg)
                    // 回到当前页面
                    to_page(currentPage)
                }
            })
        }
    })
</script>
</body>
</html>
