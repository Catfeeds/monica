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
					
					<form action="itembase/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="ITEMBASE_ID" id="ITEMBASE_ID" value="${pd.ITEMBASE_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品代码:</td>
								<td><input type="text" name="FNUMBER" id="FNUMBER" value="${pd.FNUMBER}" maxlength="255" placeholder="这里输入商品代码" title="商品代码" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品名称:</td>
								<td><input type="text" name="FNAME" id="FNAME" value="${pd.FNAME}" maxlength="255" placeholder="这里输入商品名称" title="商品名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">规格型号:</td>
								<td><input type="text" name="FMODEL" id="FMODEL" value="${pd.FMODEL}" maxlength="255" placeholder="这里输入规格型号" title="规格型号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">基本单位:</td>
								<td><input type="text" name="FBASICUNIT" id="FBASICUNIT" value="${pd.FBASICUNIT}" maxlength="255" placeholder="这里输入基本单位" title="基本单位" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">销售单位:</td>
								<td><input type="text" name="FSALEUNIT" id="FSALEUNIT" value="${pd.FSALEUNIT}" maxlength="255" placeholder="这里输入销售单位" title="销售单位" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">采购单位:</td>
								<td><input type="text" name="FORDERUNIT" id="FORDERUNIT" value="${pd.FORDERUNIT}" maxlength="255" placeholder="这里输入采购单位" title="采购单位" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">采购单价:</td>
								<td><input type="number" name="FORDERPRICE" id="FORDERPRICE" value="${pd.FORDERPRICE}" maxlength="32" placeholder="这里输入采购单价" title="采购单价" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">销售单价:</td>
								<td><input type="number" name="FSALEPRICE" id="FSALEPRICE" value="${pd.FSALEPRICE}" maxlength="32" placeholder="这里输入销售单价" title="销售单价" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">商品ID:</td>
								<td><input type="number" name="FITEMID" id="FITEMID" value="${pd.FITEMID}" maxlength="32" placeholder="这里输入商品ID" title="商品ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">父项ID:</td>
								<td><input type="number" name="FPARENTID" id="FPARENTID" value="${pd.FPARENTID}" maxlength="32" placeholder="这里输入父项ID" title="父项ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">基本单位ID:</td>
								<td><input type="number" name="FUNITID" id="FUNITID" value="${pd.FUNITID}" maxlength="32" placeholder="这里输入基本单位ID" title="基本单位ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">销售单位ID:</td>
								<td><input type="number" name="FSALEUNITID" id="FSALEUNITID" value="${pd.FSALEUNITID}" maxlength="32" placeholder="这里输入销售单位ID" title="销售单位ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">采购单位ID:</td>
								<td><input type="number" name="FORDERUNITID" id="FORDERUNITID" value="${pd.FORDERUNITID}" maxlength="32" placeholder="这里输入采购单位ID" title="采购单位ID" style="width:98%;"/></td>
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
			if($("#FNUMBER").val()==""){
				$("#FNUMBER").tips({
					side:3,
		            msg:'请输入商品代码',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FNUMBER").focus();
			return false;
			}
			if($("#FNAME").val()==""){
				$("#FNAME").tips({
					side:3,
		            msg:'请输入商品名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FNAME").focus();
			return false;
			}
			if($("#FMODEL").val()==""){
				$("#FMODEL").tips({
					side:3,
		            msg:'请输入规格型号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FMODEL").focus();
			return false;
			}
			if($("#FBASICUNIT").val()==""){
				$("#FBASICUNIT").tips({
					side:3,
		            msg:'请输入基本单位',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FBASICUNIT").focus();
			return false;
			}
			if($("#FSALEUNIT").val()==""){
				$("#FSALEUNIT").tips({
					side:3,
		            msg:'请输入销售单位',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FSALEUNIT").focus();
			return false;
			}
			if($("#FORDERUNIT").val()==""){
				$("#FORDERUNIT").tips({
					side:3,
		            msg:'请输入采购单位',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FORDERUNIT").focus();
			return false;
			}
			if($("#FORDERPRICE").val()==""){
				$("#FORDERPRICE").tips({
					side:3,
		            msg:'请输入采购单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FORDERPRICE").focus();
			return false;
			}
			if($("#FSALEPRICE").val()==""){
				$("#FSALEPRICE").tips({
					side:3,
		            msg:'请输入销售单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FSALEPRICE").focus();
			return false;
			}
			if($("#FITEMID").val()==""){
				$("#FITEMID").tips({
					side:3,
		            msg:'请输入商品ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FITEMID").focus();
			return false;
			}
			if($("#FPARENTID").val()==""){
				$("#FPARENTID").tips({
					side:3,
		            msg:'请输入父项ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FPARENTID").focus();
			return false;
			}
			if($("#FUNITID").val()==""){
				$("#FUNITID").tips({
					side:3,
		            msg:'请输入基本单位ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FUNITID").focus();
			return false;
			}
			if($("#FSALEUNITID").val()==""){
				$("#FSALEUNITID").tips({
					side:3,
		            msg:'请输入销售单位ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FSALEUNITID").focus();
			return false;
			}
			if($("#FORDERUNITID").val()==""){
				$("#FORDERUNITID").tips({
					side:3,
		            msg:'请输入采购单位ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FORDERUNITID").focus();
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