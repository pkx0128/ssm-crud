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
    <script type="text/javascript" src="static/js/jquery-3.4.1.min.js"></script>
    <!--引入bootstrap-->
    <link rel="stylesheet" href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <script type="text/javascript" src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!--修改员工信息模态框-->
<div class="modal fade" id="edit_empModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >修改员工信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="edit_emp_form">
                    <div class="form-group">
                        <label for="empName" class="col-sm-2 control-label">姓名：</label>
                        <div class="col-sm-8">
<%--                            <input type="text" class="form-control" name="empName" id="edit_empName" placeholder="请输入你的姓名"/>--%>
                            <p class="form-control-static" id="edit_empName"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓别：</label>
                        <div class="col-sm-4">
                            <%--                                <input type="text" class="form-control" name="gender" id="gender"/>--%>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="edit_gender1" value="M"  checked = "checked">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="edit_gender2" value="F">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">email：</label>
                        <div class="col-sm-8">
                            <input type="email" class="form-control" name="email" id="edit_email" placeholder="请输入email地址"/>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门：</label>
                        <div class="col-sm-4">
                            <select name="dId" id="edit_department_select" class="form-control">
                                <%--                                    <option>开发部</option>--%>
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="edit_submit_btn">更新</button>
            </div>
        </div>
    </div>
</div>



    <!-- 新增员工信息模态框 -->
    <div class="modal fade" id="addempModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">新增员工信息</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="emp_form">
                        <div class="form-group">
                            <label for="empName" class="col-sm-2 control-label">姓名：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="empName" id="empName" placeholder="请输入你的姓名"/>
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">姓别：</label>
                            <div class="col-sm-4">
<%--                                <input type="text" class="form-control" name="gender" id="gender"/>--%>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1" value="M" checked>男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2" value="F">女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-sm-2 control-label">email：</label>
                            <div class="col-sm-8">
                                <input type="email" class="form-control" name="email" id="email" placeholder="请输入email地址"/>
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">部门：</label>
                            <div class="col-sm-4">
                                <select name="dId" id="department_select" class="form-control">
<%--                                    <option>开发部</option>--%>
                                </select>
                            </div>
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="submit_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

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
                <button class="btn-sm btn-primary" id="add_emp_btn">新增</button>
                <button class="btn-sm btn-danger" id="del_emp_btn">删除</button>
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
                    <tbody id="emptbody"></tbody>
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
        //定义总记录数变量
        var Maxpages;
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
            $("#emptbody").empty();
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
               var edibtn = $("<button></button>").attr("id","edit_btn").attr("edit_empId",item.empId).addClass("btn btn-primary btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
               //构建删除按钮
               var delbtn = $("<button></button>").attr("id","del_btn").attr("del_empId",item.empId).addClass("btn btn-danger btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
               //把编辑与删除按钮加到单元格
               var btn = $("<td></td>").attr("id","btn_td").append(edibtn).append(" ").append(delbtn);
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
            Maxpages = mypage.total;
        }

        //构建分页条
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
            if(data.extend.pageInfo.hasPreviousPage){
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
            if(data.extend.pageInfo.hasNextPage){
                // 把下一页导航li和尾页导航li加到ul
                ul.append(nextLi).append(lastLi);
            }
           //把nav添加到id为page_nav的div中
           nav.append(ul).appendTo("#page_nav");
        }
        //点击新增按钮打开模态框
        $("#add_emp_btn").click(function(){
            //重置表单
            $("#emp_form")[0].reset();
            //打开模态框之前发送ajax请求获取部门信息
            get_dept("#department_select");
            //点击新增按钮弹出模态框
            $("#addempModel").modal({
                backdrop:"static"
            });
        });

        //发送ajax请求获取部门信息
        function get_dept(ele){
            $.ajax({
                url:"${APP_PATH}/depts/getdepts",
                type:"GET",
                success:function(data){
                    //清空结点数据
                    $(ele).empty();
                    //遍历部门信息
                    $.each(data.extend.department,function(index,item){
                        console.log(item);
                        // var option = $("<option></option>").append(item.deptName);
                        $(ele).append($("<option></option>").append(item.deptName).attr("value",item.deptId));
                    })
                }
            });
        }
        //校验表单数据
        function validata_form(){
            //获取用户名
            var empName = $("#empName").val();
            //定义正则表达式，支持6到16位a到z和A到Z和数字的组合或者3到6位的中文字符
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,6}$)/
            //校验用户名
            if(!regName.test(empName)){
                validata_show($("#empName"),"error","必须为6到16位字母和数字的组合或者2到6位的中文字符");
                return false;
            }else{
                validata_show($("#empName"),"success","");
            }

            //获取email
            var email = $("#email").val();
            var regemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
            //检验邮箱
            if(!regemail.test(email)){
                validata_show($("#email"),"error","邮箱地址错误");
                return false;
            }else{
                validata_show($("#email"),"success","");
            }
            //校验通过
            return true;
        }
        //校验提示信息方法
        function validata_show(ele,status,msg){
            if(status == "success"){
                ele.parent().removeClass("has-error").addClass("has-success");
                ele.next("span").empty();
                ele.next("span").append(msg);
            }else if(status == "error"){
                ele.next("span").empty();
                // console.log("邮箱不规范");
                ele.parent().addClass("has-error");
                ele.next("span").append(msg);
            }
        }
        //通过ajax检验姓名是否重复
            $("#empName").change(function(){
               $.ajax({
                   url:"${APP_PATH}/emps/checkname",
                   type:"GET",
                   data:"empName="+$("#empName").val(),
                   success:function(rel){
                       console.log("rel====="+rel.extend.va_msg);
                       if(rel.code == 100 ){
                           validata_show($("#empName"),"success",rel.extend.va_msg);
                           $("#submit_btn").attr("ajax_validata_name",rel.extend.va_msg);
                       }else if(rel.code == 200){
                           validata_show($("#empName"),"error",rel.extend.va_msg);
                           $("#submit_btn").attr("ajax_validata_name",rel.extend.va_msg);
                       }
                   }
               });
            });
        //提交form表单
        $("#submit_btn").click(function(){
            //执行数据校验方法
            if(!validata_form()){
                return false;
            }
            //判断姓名校验是否成功
            if($("#submit_btn").attr("ajax_validata_name") == "error"){
                return false;
            }
                //发送ajax提交表单信息
                $.ajax({
                    url:"${APP_PATH}/emps/emps",
                    type:"POST",
                    data:$("#emp_form").serialize(),//序列化表单数据
                    success:function(rdata){
                        if(rdata.code == 100){
                            //关闭模态框
                            $("#addempModel").modal('hide');
                            //跳到最后一页面，显示新增的数据，由于总记录数总是大于页数，如果要显示最后一页可传入总记录数作为页码变量
                            get_emps(Maxpages);
                        }else{
                            console.log(rdata);
                            if(undefined != rdata.extend.s_error.email){
                                validata_show($("#email"),"error",rdata.extend.s_error.email);
                            }
                            if(undefined != rdata.extend.s_error.empName){
                                validata_show($("#empName"),"error",rdata.extend.s_error.empName);
                            }

                        }

                    }
                });
        });

        //给每条员工数据的编辑按钮添加单击事件
        $(document).on("click","#edit_btn",function(){
            //重置表单
            $("#edit_emp_form")[0].reset();
            //清空姓名内容
            $("#edit_empName").empty();
           // alert("编辑按钮");
            //使用ajax获取部门信息
            get_dept("#edit_department_select");
           //弹出模态框
            $("#edit_empModel").modal({
                backdrop:"statuc"
            });
            //查询要修改的员工信息显示到修改模态框
            edit_get_emp_byId($("#edit_btn").attr("edit_empId"));

        });
        //使用ajax请求要修改的员工信息显示到修改模态框
        function edit_get_emp_byId(id){
            $.ajax({
                url:"${APP_PATH}/emps/emps/"+id,
                type:"GET",
                success:function(rel){
                    console.log(rel);
                    $("#edit_empName").append(rel.extend.emp.empName);
                    $("#edit_emp_form input[name=gender]").val([rel.extend.emp.gender]);
                    $("#edit_email").val(rel.extend.emp.email);
                    $("#edit_department_select").val([rel.extend.emp.dId]);
                }
            });
        }

    </script>
</body>
</html>
