<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="qywxuser/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="QYWXUSER_ID" id="QYWXUSER_ID" value="${pd.QYWXUSER_ID}"/>
						<input type="hidden"  value="${pd.ROLE}" name="ROLE" id="ROLE"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">管理id:</td>
								<td><input type="text" name="USERID" id="USERID" value="${pd.USERID}" maxlength="255" placeholder="这里输入管理id" title="管理id" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">员工名称:</td>
								<td><input type="text" name="NAME" id="NAME" value="${pd.NAME}" maxlength="255" placeholder="这里输入员工名称" title="员工名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">手机号码:</td>
								<td><input type="number" name="MOBILE" id="MOBILE" value="${pd.MOBILE}" maxlength="32" placeholder="这里输入手机号码" title="手机号码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">所属部门:</td>
								<td><input type="text" name="DEPARTMENT" id="DEPARTMENT" value="${pd.DEPARTMENT}" maxlength="255" placeholder="这里输入所属部门" title="所属部门" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">性别:</td>
								<td><input type="text" name="GENDER" id="GENDER" value="${pd.GENDER}" maxlength="255" placeholder="这里输入性别" title="性别" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">邮箱:</td>
								<td><input type="text" name="EMAIL" id="EMAIL" value="${pd.EMAIL}" maxlength="255" placeholder="这里输入邮箱" title="邮箱" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">座机:</td>
								<td><input type="text" name="TELEPHONE" id="TELEPHONE" value="${pd.TELEPHONE}" maxlength="255" placeholder="这里输入座机" title="座机" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">openid:</td>
								<td><input type="text" name="OPENID" id="OPENID" value="${pd.OPENID}" maxlength="255" placeholder="这里输入openid" title="openid" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">角色:</td>
								<%-- <td><input type="text" name="ROLE" id="ROLE" value="${pd.ROLE}" maxlength="255" placeholder="这里输入角色" title="角色" style="width:98%;"/></td> --%>
										<td>
											<c:set var="theString" value="${pd.ROLE}"/>
											 <label style="float:left;padding-left: 8px;padding-top:7px;">
											     <input name="checkbox1" type="checkbox"  <c:if test="${fn:contains(theString,'采购')}"> checked="checked" </c:if>  class="ace" id="checkbox1" value="采购">	
											     <span class="lbl">采购</span>
											 </label>
											 <label style="float:left;padding-left: 8px;padding-top:7px;">
											     <input name="checkbox1" type="checkbox" <c:if test="${fn:contains(theString,'门店')}">  checked="checked" </c:if> class="ace" id="checkbox2" value="门店">	
											     <span class="lbl">门店</span>
											 </label>
											 <label style="float:left;padding-left: 8px;padding-top:7px;">
											     <input name="checkbox1" type="checkbox" <c:if test="${fn:contains(theString,'管理员')}">  checked="checked" </c:if> class="ace" id="checkbox3" value="管理员">	
											     <span class="lbl">管理员</span>
											 </label>
											 <label style="float:left;padding-left: 8px;padding-top:7px;">
											     <input name="checkbox1" type="checkbox" <c:if test="${fn:contains(theString,'普通角色')}">  checked="checked" </c:if> class="ace" id="checkbox3" value="普通角色">	
											     <span class="lbl">普通角色</span>
											 </label>
										</td>
							</tr>
							<tr>
								<td style="text-align: center;" colspan="10">
									<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
									<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
								</td>
							</tr>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
			/* if($("#USERID").val()==""){
				$("#USERID").tips({
					side:3,
		            msg:'请输入管理id',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#USERID").focus();
			return false;
			}
			if($("#NAME").val()==""){
				$("#NAME").tips({
					side:3,
		            msg:'请输入员工名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#NAME").focus();
			return false;
			}
			if($("#MOBILE").val()==""){
				$("#MOBILE").tips({
					side:3,
		            msg:'请输入手机号码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#MOBILE").focus();
			return false;
			}
			if($("#DEPARTMENT").val()==""){
				$("#DEPARTMENT").tips({
					side:3,
		            msg:'请输入所属部门',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#DEPARTMENT").focus();
			return false;
			}
			if($("#GENDER").val()==""){
				$("#GENDER").tips({
					side:3,
		            msg:'请输入性别',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#GENDER").focus();
			return false;
			}
			if($("#EMAIL").val()==""){
				$("#EMAIL").tips({
					side:3,
		            msg:'请输入邮箱',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#EMAIL").focus();
			return false;
			}
			if($("#TELEPHONE").val()==""){
				$("#TELEPHONE").tips({
					side:3,
		            msg:'请输入座机',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TELEPHONE").focus();
			return false;
			}
			if($("#OPENID").val()==""){
				$("#OPENID").tips({
					side:3,
		            msg:'请输入openid',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#OPENID").focus();
			return false;
			}
			if($("#ROLE").val()==""){
				$("#ROLE").tips({
					side:3,
		            msg:'请输入角色',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ROLE").focus();
			return false;
			} */
			jqchk();
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		
		function jqchk(){ //jquery获取复选框值 
			var chk_value =[]; 
			$('input[name="checkbox1"]:checked').each(function(){ 
			chk_value.push($(this).val()); 
			}); 
			$("#ROLE").val(chk_value.length==0 ?'普通角色':chk_value);
			//alert(chk_value.length==0 ?'你还没有选择任何内容！':chk_value); 
		}
		</script>
</body>
</html>