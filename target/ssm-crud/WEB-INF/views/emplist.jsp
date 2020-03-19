<%--
  Created by IntelliJ IDEA.
  User: pankx
  Date: 2020/3/16
  Time: 12:26 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    //获取项目目录
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
<%--
    web路径：
    不带/开始的相对路径，找资源以当前资源路径为基准查找
    带/开始的相对路径，找资源是以服务器的根路径为基准查找
--%>
    <title>员工列表</title>
        <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.8.0.min.js"></script>
        <!-- Bootstrap -->
        <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet"/>
        <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12">
                <h1>员工列表</h1>
            </div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <%--列表数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>员工ID</th>
                        <th>员工姓名</th>
                        <th>员工姓别</th>
                        <th>电子邮箱</th>>
                        <th>部门名称</th>
                        <th>操作</th>
                    </tr>
                    <c:forEach var="myemp" items="${pageInfo.list}">
                        <tr>
                            <td>${myemp.empId}</td>
                            <td>${myemp.empName}</td>
                            <td>${myemp.gender == "M"?"男":"女"}</td>
                            <td>${myemp.email}</td>
                            <td>${myemp.department.deptName}</td>
                            <td>
                                <button class="btn btn-primary btn-sm"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
                                <button class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除</button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <%--分布信息--%>
        <div class="row">
            <%--分页信息--%>
            <div class="col-md-6">
                当前为第${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录
            </div>
            <%--分页条--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <%--当当前页为第一页时,设置首页按钮不可见--%>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li><a href="${APP_PATH}/emps/getemps?pn=1">首页</a></li>
                        </c:if>
                        <%--当当前页为第一页时设置上一页按钮不可见--%>
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps/getemps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <%--连续显示的页码--%>
                        <c:forEach var="pageN" items="${pageInfo.navigatepageNums}">
                            <c:if test="${pageN == pageInfo.pageNum}">
                                <li class="active"><a href="#">${pageN}</a></li>
                            </c:if>
                            <c:if test="${pageN != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps/getemps?pn=${pageN}">${pageN}</a> </li>
                            </c:if>
                        </c:forEach>
                        <%--当当前页为最后一页时设置下一页按钮不可见--%>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps/getemps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <%--当当前页为最后一页时设置尾页按钮不可见--%>
                        <c:if test="${pageInfo.hasNextPage}">
                            <li><a href="${APP_PATH}/emps/getemps?pn=${pageInfo.pages}">尾页</a></li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
