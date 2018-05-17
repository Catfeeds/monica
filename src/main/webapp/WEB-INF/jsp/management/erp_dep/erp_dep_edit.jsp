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
					
					<form action="erp_dep/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ERP_DEP_ID" id="ERP_DEP_ID" value="${pd.ERP_DEP_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">FItemID:</td>
								<td><input type="number" name="FITEMID" id="FITEMID" value="${pd.FITEMID}" maxlength="32" placeholder="这里输入FItemID" title="FItemID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">编号:</td>
								<td><input type="text" name="FNUMBER" id="FNUMBER" value="${pd.FNUMBER}" maxlength="255" placeholder="这里输入编号" title="编号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">部门名称:</td>
								<td><input type="text" name="FNAME" id="FNAME" value="${pd.FNAME}" maxlength="255" placeholder="这里输入部门名称" title="部门名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">FParentID:</td>
								<td><input type="number" name="FPARENTID" id="FPARENTID" value="${pd.FPARENTID}" maxlength="32" placeholder="这里输入FParentID" title="FParentID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">FModifyTime:</td>
								<td><input type="text" name="FMODIFYTIME" id="FMODIFYTIME" value="${pd.FMODIFYTIME}" maxlength="255" placeholder="这里输入FModifyTime" title="FModifyTime" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">FDeleted:</td>
								<td><input type="number" name="FDELETED" id="FDELETED" value="${pd.FDELETED}" maxlength="32" placeholder="这里输入FDeleted" title="FDeleted" style="width:98%;"/></td>
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
			if($("#FITEMID").val()==""){
				$("#FITEMID").tips({
					side:3,
		            msg:'请输入FItemID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FITEMID").focus();
			return false;
			}
			if($("#FNUMBER").val()==""){
				$("#FNUMBER").tips({
					side:3,
		            msg:'请输入编号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FNUMBER").focus();
			return false;
			}
			if($("#FNAME").val()==""){
				$("#FNAME").tips({
					side:3,
		            msg:'请输入部门名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FNAME").focus();
			return false;
			}
			if($("#FPARENTID").val()==""){
				$("#FPARENTID").tips({
					side:3,
		            msg:'请输入FParentID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FPARENTID").focus();
			return false;
			}
			if($("#FMODIFYTIME").val()==""){
				$("#FMODIFYTIME").tips({
					side:3,
		            msg:'请输入FModifyTime',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FMODIFYTIME").focus();
			return false;
			}
			if($("#FDELETED").val()==""){
				$("#FDELETED").tips({
					side:3,
		            msg:'请输入FDeleted',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FDELETED").focus();
			return false;
			}
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});
		</script>
</body>
</html>