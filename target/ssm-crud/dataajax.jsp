<%--
  Created by IntelliJ IDEA.
  User: pankx
  Date: 2020/3/19
  Time: 12:08 下午
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%--获取项目根目录--%>
<%pageContext.setAttribute("APP_PATH",request.getContextPath());%>

<html>
<head>
    <title>发送ajax请求获取数据</title>
    <!--引入jquery-->
    <script type="text/javascript" src="static/js/jquery-1.8.0.min.js"></script>
    <!--引入bootstrap-->
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>员工列表</h1>
            </div>
        </div>
        <!--按钮-->
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-offset-10">
                <button class="btn-sm btn-primary">新增</button>
                <button class="btn-sm btn-danger">删除</button>
            </div>
        </div>
        <!--员工列表-->
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="empTable">
                    <thead>
                        <tr>
                            <th>员工ID</th>
                            <th>员工姓名</th>
                            <th>员工姓别</th>
                            <th>电子邮件</th>
                            <th>部门名称</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>
            </div>
        </div>
        <!--分页-->
        <div class="row">
            <div class="col-md-6" id="pagemsg"></div>
            <div class="col-md-6" id="page_nav"></div>
        </div>
    </div>

    <script type="text/javascript">
        $(function(){
            $.ajax({
               url:"${APP_PATH}/emps/getempsbyjson",
                data:"pn=1",
                type:"GET",
                success:function(data){
                   console.log(data);
                   //显示表格数据
                   emp_table(data);
                   //显示分页数据
                    emp_pageMsg(data);
                    //显示分页导航
                    emp_pageMsg_nav(data);
                }

            });
        });

        //把ajax请求获取到的数据解释到页面显示
        function emp_table(data){
            var emps = data.extend.pageInfo.list;
           $.each(emps,function(index,item){
               var empIdTD = $("<td></td>").append(item.empId);
               var empNameTD = $("<td></td>").append(item.empName);
               var genderTD = $("<td></td>").append(item.gender == "M" ? "男": "女");
               var emailTD = $("<td></td>").append(item.email);
               var departmentTD = $("<td></td>").append(item.department.deptName);
               // var addbtnTD = $("<td></td>").append("<button class='btn btn-primary btn-sm'><span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>编辑</button>").append("<button class='btn btn-danger btn-sm'><span class='glyphicon glyphicon-trash'></span>删除</button>");
               var edibtn = $("<button></button>").addClass("btn btn-primary btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
               var delbtn = $("<button></button>").addClass("btn btn-danger btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
               var btn = $("<td></td>").append(edibtn).append(" ").append(delbtn);
               $("<tr></tr>").append(empIdTD).append(empNameTD).append(genderTD).append(emailTD).append(departmentTD).append(btn).appendTo("#empTable tbody");
           });
        }

        //分页信息
        function emp_pageMsg(data){
            var mypage = data.extend.pageInfo;
            $("#pagemsg").append("当前为第"+mypage.pageNum+"页,总"+mypage.pages+"页,总"+mypage.total+"条记录");
        }

        //构建分布条
        function emp_pageMsg_nav(data){
            var nav = $("<nav></nav>").attr("aria-label","Page navigation");
            var ul =$("<ul></ul>").addClass("pagination");
            var firstLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
            var preLi  = $("<li></li>").append($("<a></a>").attr("href","#").attr("aria-label","Previous").append($("<span></span>").attr("aria-hidden","true").append("&laquo;")));
            ul.append(firstLi).append(preLi);
            $.each(data.extend.pageInfo.navigatepageNums,function (index,item) {
                var pagenLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
                ul.append(pagenLi);
            });

            var nextLi  = $("<li></li>").append($("<a></a>").attr("href","#").attr("aria-label","Next").append($("<span></span>").attr("aria-hidden","true").append("&raquo;")));
            var lastLi = $("<li></li>").append($("<a></a>").attr("href","#").append("尾页"));
           ul.append(nextLi).append(lastLi);
           nav.append(ul).appendTo("#page_nav");
        }

    </script>
</body>
</html>
