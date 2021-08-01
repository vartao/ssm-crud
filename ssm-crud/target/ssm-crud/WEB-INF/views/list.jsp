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
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>姓名</th>
                                <th>性别</th>
                                <th>邮箱</th>
                                <th>部门</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pageInfo.list}" var="emp">
                                <tr>
                                    <td>${emp.empId}</td>
                                    <td>${emp.empName}</td>
                                    <td>${emp.gender=="M"?"男":"女"}</td>
                                    <td>${emp.email}</td>
                                    <td>${emp.department.deptName}</td>
                                    <td>
                                        <button class="btn btn-primary btn-sm">
                                            <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
                                        </button>
                                        <button class="btn btn-danger btn-sm">
                                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6">
                当前${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录
            </div>
            <%--分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${APP_PATH}/emps?pageNum=1">首页</a></li>
                        <%--如果有上一页，就显示上一页按钮--%>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pageNum=${pageInfo.pageNum - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
                            <c:if test="${page_num == pageInfo.pageNum}">
                                <li class="active"><a href="">${page_num}</a></li>
                            </c:if>
                            <c:if test="${page_num != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pageNum=${page_num}">${page_num}</a></li>
                            </c:if>

                        </c:forEach>
                        <%--如果有下一页，就显示下一页按钮--%>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pageNum=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <li><a href="${APP_PATH}/emps?pageNum=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
