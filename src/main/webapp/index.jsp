<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工信息</title>
<%
	pageContext.setAttribute("app_path", request.getContextPath());//http://localhost:3306/ssm-crud/
%>
<script type="text/javascript"
	src=" ${app_path}/static/js/JQuery-2.1.4.js"></script>
<link
	href="${app_path}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${app_path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
	<!-- 修改员工表单模块 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<!-- 表单元素 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
								<span id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="email@qq.com"> <span
									id="helpBlock2" class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="m"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="f"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!--部门提交  -->
								<select class="form-control" name="dId" id="select_dept">
								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						id="emp_update_save_btn">编辑</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 添加员工表单模块 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<!-- 表单元素 -->
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="empName"> <span
									id="helpBlock2" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="email@qq.com"> <span
									id="helpBlock2" class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="m"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="f"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<!--部门提交  -->
								<select class="form-control" name="dId" id="select_dept">
								</select>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">添加</button>
				</div>
			</div>
		</div>
	</div>


	<!--搭建显示页面  -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div calss="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!--  按钮-->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emps_delete_btn">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
							<input type="checkbox" id="check_all">
							</th>
							<th>id</th>
							<th>empname</th>
							<th>gender</th>
							<th>email</th>
							<th>dept</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字 -->
			<div id="page_info_area"></div>
			<!-- 分页条 -->
			<div id="page_info_areas"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord, current;
		$(function() {
			//去首页
			to_page(1)
		});

		function to_page(pn) {
			$.ajax({
				url : '${app_path}/emps',
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {

					/* console.log(result) */
					//1、解析并显示员工信息
					build_emps_table(result);
					//2、解析并显示分页信息
					build_page_info(result);
					//2、解析并显示分页条信息
					build_page_nav(result);
				}
			});
		}
		//分页条
		function build_page_nav(result) {
			//清空分页条
			$("#page_info_areas").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var fistPage = $("<li></li>").append($('<a></a>').append("首页"));
			var prePage = $("<li></li>").append(
					$("<a></a>").append($("<span></span>").append("&laquo;")));

			if (result.extend.pageInfo.hasPreviousPage == false) {
				fistPage.addClass("disabled");
				prePage.addClass("disabled");
			} else {
				fistPage.click(function() {
					to_page(1);
				})
				prePage.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});

			}
			var nextPage = $("<li></li>").append(
					$("<a></a>").append($("<span></span>").append("&raquo;")));
			var lastPage = $("<li></li>").append($('<a></a>').append("末页"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPage.addClass("disabled");
				lastPage.addClass("disabled");
			} else {
				lastPage.click(function() {
					to_page(result.extend.pageInfo.pages);
				})
				nextPage.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});

			}
			ul.append(fistPage).append(prePage);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {

				var numLi = $("<li></li>").append($("<a></a>").append(item));
				numLi.click(function() {
					to_page(item);
				});
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}

				ul.append(numLi);
			})

			ul.append(nextPage).append(lastPage);
			var navEle = $("<nav></nav>").append(ul);
			//$("#page_info_areas").append(navEle);
			navEle.appendTo("#page_info_areas");
		}
		//分页信息
		function build_page_info(result) {
			//清空分页信息
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页，总"
							+ result.extend.pageInfo.pages + "页，总"
							+ result.extend.pageInfo.total + "条记录")
			totalRecord = result.extend.pageInfo.total
			current = result.extend.pageInfo.pageNum;
		}
		//表格信息
		function build_emps_table(result) {
			//清空表格信息
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				//alert(item.empName)
				 var checkBoxTd =$("<td></td>").append("<input type='checkbox' class='check_item'/>")
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var emailTd = $("<td></td>").append(item.email);
				var deptTd = $("<td></td>").append(item.dept.deptName);
				var genderTd = $("<td></td>").append(
						item.gender == "m" ? "男" : "女");
				/* <button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>新增
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
								</button>
				 */
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm").append(
						$('<span></span>').addClass(
								"glyphicon glyphicon-pencil edit_btn").append(
								"编辑").attr("edit_id", item.empId));
				//为编辑按钮添加一个自定义的属性，来表示当前的员工
				//editBtn.attr("edit_id",item.empId);
				var deiBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm del_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash").append(
										"删除"));
				deiBtn.attr("del_id",item.empId)
				var btn = $("<td></td>").append(editBtn).append(" ").append(
						deiBtn)
				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptTd).append(btn)
						.appendTo("#emps_table tbody")
			})
		}
		function reset_form(ele) {
			$(ele)[0].reset();//清空表单元素
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//新增 按钮点击事件
		$("#emp_add_modal_btn").click(function() {
			reset_form('#empAddModal form')
			//$('#empAddModal form')[0].reset();
			//发送ajax请求查出部门信息显示在下拉列表中
			getDepts('#empAddModal select');
			//显示模态框
			$('#empAddModal').modal({
				backdrop : 'static'
			})
		})
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${app_path}/depts",
				type : "GET",
				success : function(result) {
					//显示部们信息
					//$("#select_dept").append();
					$.each(result.extend.depts, function() {
						var options = $(ele).append(
								$("<option></option>").append(this.deptName)
										.attr("value", this.deptId));
						//options.appendTo(ele);
					})
				}
			})
		}
		//用户表单验证和发送
		function valDate_add_from() {
			var empName = $("#empName_add_input").val();
			//var RegName=(/^[a-z0-9_-]{3,16}$/)||(/^[\u2E80-\u9FFF]+$/)	错误示范
			var RegName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/
			if (!RegName.test(empName)) {
				//alert("用户名可以是2-5位中文，或者6-16位英文");
				//清空之前的元素
				/* $("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text("用户名可以是2-5位中文或者6-16位英文") */
				show_valdate_msg("#empName_add_input", "error",
						"用户名可以是2-5位中文或者6-16位英文 ")
				return false;
			} else {
				show_valdate_msg("#empName_add_input", "success", " ")
			}
			var email = $("#email_add_input").val();
			var regEamil = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if (!regEamil.test(email)) {
				//alert("邮箱不合法！");
				show_valdate_msg("#email_add_input", "error", "邮箱不合法！")
				return false;
			} else {
				show_valdate_msg("#email_add_input", "success", " ")
			}
			return true;
		}
		//显示校验的错误信息
		function show_valdate_msg(ele, status, msg) {
			$(ele).parent().removeClass("has-success has-error")
			$(ele).next("span").text(" ")

			if (status == "success") {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if (status == "error") {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg)
			}
		}
		//校验用户名是否可用
		$("#empName_add_input").change(
				function() {
					var value = $("#empName_add_input").val();
					//发送ajax请求验证用户名是否可用
					$.ajax({
						url : "${app_path}/checkuser",
						type : "POST",
						data : "empName=" + value,
						success : function(result) {
							if (result.code == 100) {
								show_valdate_msg("#empName_add_input",
										"success", "用户名可用！")
								$("#emp_save_btn").attr("ajax_val", "success");
							} else {
								show_valdate_msg("#empName_add_input", "error",
										result.extend.va_msg)
								$("#emp_save_btn").attr("ajax_val", "error");
							}
						}
					})
				})
		//发送用户信息
		$("#emp_save_btn").click(
				function() {
					if (!valDate_add_from()) {
						return false;
					}
					//如果这个用户名不正确,不发送请求
					if ($(this).attr("ajax_val") == "error") {
						return false;
					}
					$.ajax({
						url : "${app_path}/emp",
						type : "POST",
						data : $("#empAddModal form").serialize(),
						success : function(result) {
							console.log(result)
							if (result.code == 100) {
								//alert(result.msg);
								//1、关闭模态框
								$("#empAddModal").modal('hide');
								//2、来到最后一页
								to_page(totalRecord);
							} else {
								if (result.extend.error.empName != undefined) {
									show_valdate_msg("#empName_add_input",
											"error",
											result.extend.error.empName)
								}
								if (result.extend.error.email != undefined) {
									show_valdate_msg("#email_add_input",
											"error", result.extend.error.email)
								}
							}
						}
					})
					getDepts();
				})
		
		//为每一个编辑按钮绑定点击事件
		$(document).on("click", ".edit_btn", function() {
			//alert("22")
			//将编辑按钮附上点击事件，将修改模块的编辑按钮附上id值
			$("#emp_update_save_btn").attr("edit_id", $(this).attr("edit_id"));
			//获得部门显示下拉列表
			getDepts('#empUpdateModal select');
			//获得员工信息
			getEmp($(this).attr("edit_id"))
			$('#empUpdateModal').modal({
				backdrop : 'static'
			})
		})
		function getEmp(id) {
			$.ajax({
				url : "${app_path}/emp/" + id,
				type : "GET",
				success : function(result) {
					console.log(result)

					$("#email_update_input").val(result.extend.employee.email)
					$("#empName_update_static").text(
							result.extend.employee.empName)
					$("#empUpdateModal input[name=gender]").val(
							[ result.extend.employee.gender ])
					$("#empUpdateModal select").val(
							[ result.extend.employee.dId ])
				}
			})
		}
		/*修改按钮点击事件  */
		$("#emp_update_save_btn").click(function() {
			//将表单序列化
			var formInfo = $("#empUpdateModal form").serialize()
			var empName = "empName=" + $("#empName_update_static").val();
			//获取id值
			var empId = $("#emp_update_save_btn").attr("edit_id")
			//验证邮箱
			var email = $("#email_update_input").val();
			var regEamil = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if (!regEamil.test(email)) {
				//alert("邮箱不合法！");
				show_valdate_msg("#email_update_input", "error", "邮箱不合法！")
				return false;
			} else {
				show_valdate_msg("#email_update_input", "success", " ")
			}
			//发送ajax请求将信息发送到服务器
			$.ajax({
				url : "${app_path}/emp/" + empId,
				type : "PUT",
				data : formInfo,
				success : function(result) {
					console.log(result)
					console.log(formInfo)
					//1、关闭模态框
					$("#empUpdateModal").modal('hide')
					//2、回到当前页
					to_page(current);
				}
			})
		})
		//为每一个删除按钮绑定点击事件,单个删除
		$(document).on("click", ".del_btn", function() {
		 var empEame=$(this).parents("tr").find("td:eq(2)").text()
			if(confirm("确认删除【"+empEame+"】吗？")){
				$.ajax({
					url:"${app_path}/emp/"+$(this).attr("del_id"),
					type:"DELETE",
					success:function(result){
						alert(result.msg)
						//回到本页
						 to_page(current);
					}
					
				})
			}
		})
		//全选，全不选
		$("#check_all").click(function(){
			//prop是系统属性
			//attr是自定义属性
			var flag=$("#check_all").prop("checked")
			$(".check_item").prop("checked",flag)
		})
		//表单复选框都选则全选
		$(document).on("click",".check_item",function(){
			var flag=$(".check_item:checked").length==$(".check_item").length
			$("#check_all").prop("checked",flag)
		})
		//批量删除
		$("#emps_delete_btn").click(function(){
			var names=""
			var ids=""
			$.each($(".check_item:checked"),function(){
				names+=$(this).parents("tr").find("td:eq(2)").text()+","
			})
			names=names.substring(0,names.length-1)
			$.each($(".check_item:checked"),function(){
				ids+=$(this).parents("tr").find("td:eq(1)").text()+"-"
			})
			ids=ids.substring(0,ids.length-1)
			//alert(ids)
			if(confirm("你确定要删除【"+names+"】吗？")){
				
			 $.ajax({
				url:"${app_path}/emp/"+ids,
				type:"DELETE",
				success:function(result){
					alert(result.msg);
					to_page(current);
				}
			}) 
			}
		})
	</script>
</body>
</html>