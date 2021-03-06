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
	<%@ include file="../system/index/top.jsp"%>
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
					
					<form name="Form" id="Form" method="post">
						<input type="hidden" name="CLIENT_ID" id="CLIENT_ID" value="${pd.CLIENT_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table style="border-collapse:separate; border-spacing:10px;width: 100%;padding-left: 1%">
							<tr>
								<td style="width:6%;text-align: right;">FItemID<span style="color: red;">*</span>:</td>
								<td><input type="number" name="FITEMID" id="FITEMID" value="${pd.FITEMID}" maxlength="32" title="FItemID" readonly style="width:100%;"/></td>
							</tr>
							<tr>
								<td style="width:6%;text-align: right;">客户编码<span style="color: red;">*</span>:</td>
								<td><input type="text" name="FNUMBER" id="FNUMBER" value="${pd.FNUMBER}" maxlength="255" title="客户编码" readonly style="width:100%;"/></td>
							</tr>
							<tr>
								<td style="width:6%;text-align: right;">客户名称<span style="color: red;">*</span>:</td>
								<td><input type="text" name="FNAME" id="FNAME" value="${pd.FNAME}" maxlength="255" title="客户名称" readonly style="width:100%;"/></td>
							</tr>
							<tr>
								<td style="width:6%;text-align: right;">父级ID<span style="color: red;">*</span>:</td>
								<td><input type="number" name="FPARENTID" id="FPARENTID" value="${pd.FPARENTID}" maxlength="32" title="FParentID" readonly style="width:100%;"/></td>
							</tr>
							<tr>
								<td style="width:6%;text-align: right;">修改时间<span style="color: red;">*</span>:</td>
								<td><input type="text" name="FMODIFYTIME" id="FMODIFYTIME" value="${pd.FMODIFYTIME}" maxlength="255" title="FMODIFYTIME" readonly style="width:100%;"/></td>
							</tr>
							<tr>
								<td style="width:6%;text-align: right;">FDeleted<span style="color: red;">*</span>:</td>
								<td><input type="number" name="FDELETED" id="FDELETED" value="${pd.FDELETED}" maxlength="32" title="FDeleted" readonly style="width:100%;"/></td>
							</tr>
						</table>
						</div>
						<div style="text-align: right;height:45px; position:fixed;width: 100%;z-index:10000000;bottom: 0px;";>
							<%--<a class="btn btn-light btn-mini" onclick="save()">
								<i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon green"></i>保存
							</a>--%>

							<a style="margin-right: 45px;" class="btn btn-light btn-mini" onclick="top.Dialog.close();">
								<i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
							</a>
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
	<%@ include file="../system/index/foot.jsp"%>
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
		            msg:'请输入客户编码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FNUMBER").focus();
			return false;
			}
			if($("#FNAME").val()==""){
				$("#FNAME").tips({
					side:3,
		            msg:'请输入客户名称',
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