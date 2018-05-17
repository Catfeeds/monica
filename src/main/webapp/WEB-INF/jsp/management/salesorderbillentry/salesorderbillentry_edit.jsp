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
					
					<form action="salesorderbillentry/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SALESORDERBILLENTRY_ID" id="SALESORDERBILLENTRY_ID" value="${pd.SALESORDERBILLENTRY_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">序号:</td>
								<td><input type="number" name="FENTRYID" id="FENTRYID" value="${pd.FENTRYID}" maxlength="32" placeholder="这里输入序号" title="序号" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">物料ID:</td>
								<td><input type="number" name="FITEMID" id="FITEMID" value="${pd.FITEMID}" maxlength="32" placeholder="这里输入物料ID" title="物料ID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">数量:</td>
								<td><input type="number" name="FAUXQTY" id="FAUXQTY" value="${pd.FAUXQTY}" maxlength="32" placeholder="这里输入数量" title="数量" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">要求到货时间:</td>
								<td><input type="text" name="FDATE" id="FDATE" value="${pd.FDATE}" maxlength="255" placeholder="这里输入要求到货时间" title="要求到货时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">不含税单价:</td>
								<td><input type="number" name="FAUXPRICE" id="FAUXPRICE" value="${pd.FAUXPRICE}" maxlength="32" placeholder="这里输入不含税单价" title="不含税单价" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">不含金额:</td>
								<td><input type="number" name="FAMOUNT" id="FAMOUNT" value="${pd.FAMOUNT}" maxlength="32" placeholder="这里输入不含金额" title="不含金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">税率:</td>
								<td><input type="number" name="FTAXRATE" id="FTAXRATE" value="${pd.FTAXRATE}" maxlength="32" placeholder="这里输入税率" title="税率" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">含税单价:</td>
								<td><input type="number" name="FALLPRICE" id="FALLPRICE" value="${pd.FALLPRICE}" maxlength="32" placeholder="这里输入含税单价" title="含税单价" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">含税金额:</td>
								<td><input type="number" name="FALLAMOUNT" id="FALLAMOUNT" value="${pd.FALLAMOUNT}" maxlength="32" placeholder="这里输入含税金额" title="含税金额" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">备注:</td>
								<td><input type="text" name="FREMARK" id="FREMARK" value="${pd.FREMARK}" maxlength="255" placeholder="这里输入备注" title="备注" style="width:98%;"/></td>
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
			if($("#FENTRYID").val()==""){
				$("#FENTRYID").tips({
					side:3,
		            msg:'请输入序号',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FENTRYID").focus();
			return false;
			}
			if($("#FITEMID").val()==""){
				$("#FITEMID").tips({
					side:3,
		            msg:'请输入物料ID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FITEMID").focus();
			return false;
			}
			if($("#FAUXQTY").val()==""){
				$("#FAUXQTY").tips({
					side:3,
		            msg:'请输入数量',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FAUXQTY").focus();
			return false;
			}
			if($("#FDATE").val()==""){
				$("#FDATE").tips({
					side:3,
		            msg:'请输入要求到货时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FDATE").focus();
			return false;
			}
			if($("#FAUXPRICE").val()==""){
				$("#FAUXPRICE").tips({
					side:3,
		            msg:'请输入不含税单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FAUXPRICE").focus();
			return false;
			}
			if($("#FAMOUNT").val()==""){
				$("#FAMOUNT").tips({
					side:3,
		            msg:'请输入不含金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FAMOUNT").focus();
			return false;
			}
			if($("#FTAXRATE").val()==""){
				$("#FTAXRATE").tips({
					side:3,
		            msg:'请输入税率',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FTAXRATE").focus();
			return false;
			}
			if($("#FALLPRICE").val()==""){
				$("#FALLPRICE").tips({
					side:3,
		            msg:'请输入含税单价',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FALLPRICE").focus();
			return false;
			}
			if($("#FALLAMOUNT").val()==""){
				$("#FALLAMOUNT").tips({
					side:3,
		            msg:'请输入含税金额',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FALLAMOUNT").focus();
			return false;
			}
			if($("#FREMARK").val()==""){
				$("#FREMARK").tips({
					side:3,
		            msg:'请输入备注',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#FREMARK").focus();
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