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
        //页面加载完成就获取第一页数据
        $(function(){
           get_emps(1);
        });
        //发送ajax请求方法
        function get_emps (pn){
            $.ajax({
                url:"${APP_PATH}/emps/getempsbyjson",
                data:"pn="+ pn,
                type:"GET",
                success:function(data){
                    //显示员工列表信息
                    emp_table(data);
                    //显示分页数据
                    emp_pageMsg(data);
                    //显示分页导航
                    emp_pageMsg_nav(data);
                }
            });
        }

        //把ajax请求获取到的数据解释到页面显示
        function emp_table(data){
            //清空表格数据
            $("#empTable tbody").empty();
            //获得服务器返回的员工信息
            var emps = data.extend.pageInfo.list;
            //遍历员工信息
           $.each(emps,function(index,item){
               //构建员工Id单元格
               var empIdTD = $("<td></td>").append(item.empId);
               //构建员工姓名单元格
               var empNameTD = $("<td></td>").append(item.empName);
               //构建员工姓别单元格
               var genderTD = $("<td></td>").append(item.gender == "M" ? "男": "女");
               //构建员工邮箱单元格
               var emailTD = $("<td></td>").append(item.email);
               //构建部门信息单元格
               var departmentTD = $("<td></td>").append(item.department.deptName);
               // var addbtnTD = $("<td></td>").append("<button class='btn btn-primary btn-sm'><span class='glyphicon glyphicon-pencil' aria-hidden='true'></span>编辑</button>").append("<button class='btn btn-danger btn-sm'><span class='glyphicon glyphicon-trash'></span>删除</button>");
               //构建编辑按钮
               var edibtn = $("<button></button>").addClass("btn btn-primary btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
               //构建删除按钮
               var delbtn = $("<button></button>").addClass("btn btn-danger btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
               //把编辑与删除按钮加到单元格
               var btn = $("<td></td>").append(edibtn).append(" ").append(delbtn);
               //构建表格行，并把员工相关信息单元格加到表格行内
               $("<tr></tr>").append(empIdTD).append(empNameTD).append(genderTD).append(emailTD).append(departmentTD).append(btn).appendTo("#empTable tbody");
           });
        }

        //分页信息
        function emp_pageMsg(data){
            //删除分页信息
            $("#pagemsg").empty();
            var mypage = data.extend.pageInfo;
            $("#pagemsg").append("当前为第"+mypage.pageNum+"页,总"+mypage.pages+"页,总"+mypage.total+"条记录");
        }

        //构建分布条
        function emp_pageMsg_nav(data){
            //删除分页导航条
            $("#page_nav").empty();
            //构建nav标签
            var nav = $("<nav></nav>").attr("aria-label","Page navigation");
            //构建ul标签
            var ul =$("<ul></ul>").addClass("pagination");
            //构建首页导航
            var firstLi = $("<li></li>").append($("<a></a>").attr("href","#").append("首页"));
            //给首页导航添加单击事件并调用get_emps方法获取员工数据信息
            firstLi.click(function(){
                get_emps(1)
            });
            //构建上一页导航
            var preLi  = $("<li></li>").append($("<a></a>").attr("href","#").attr("aria-label","Previous").append($("<span></span>").attr("aria-hidden","true").append("&laquo;")));
            //给上一页导航添加单击事件并调用get_emps方法获取员工数据信息
            preLi.click(function(){
                get_emps(data.extend.pageInfo.pageNum - 1);
            });
            //如果为第1页则不显示首页和上一页导航
            if(data.extend.pageInfo.hasPreviousPage && data.extend.pageInfo.isFirstPage==false){
                //把首页与上一页导航加入ul
                ul.append(firstLi).append(preLi);
            }
            //遍历分页页码
            $.each(data.extend.pageInfo.navigatepageNums,function (index,item) {
                //构建分页li
                var pagenLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
                //如果当前页与页码相等，高亮页码
                if(data.extend.pageInfo.pageNum == item){
                    pagenLi.addClass("active");
                }
                //给页码导航添加单击事件并调get_emps方法获取员工分页数据
                pagenLi.click(function(){
                    get_emps(item);
                });
                // 把分页li加到ul
                ul.append(pagenLi);
            });
            //构建下一页导航li
            var nextLi  = $("<li></li>").append($("<a></a>").attr("href","#").attr("aria-label","Next").append($("<span></span>").attr("aria-hidden","true").append("&raquo;")));
            //给下一页导航添加单击事件并调get_emps方法获取员工分页数据
            nextLi.click(function(){
                get_emps(data.extend.pageInfo.pageNum + 1);
            });
            //构建尾页导航li
            var lastLi = $("<li></li>").append($("<a></a>").attr("href","#").append("尾页"));
            //给尾页导航添加单击事件，并调用get_emps方法获取员工分页数据
            lastLi.click(function(){
                get_emps(data.extend.pageInfo.pages);
            });
            //如果为最后一页，则不显示下一页与尾页导航
            if(data.extend.pageInfo.hasNextPage && data.extend.pageInfo.isLastPage==false){
                // 把下一页导航li和尾页导航li加到ul
                ul.append(nextLi).append(lastLi);
            }
           //把nav添加到id为page_nav的div中
           nav.append(ul).appendTo("#page_nav");
        }

    </script>
</body>
</html>
