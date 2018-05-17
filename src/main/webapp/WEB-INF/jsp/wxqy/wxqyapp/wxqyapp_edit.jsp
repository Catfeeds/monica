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
					
					<form action="wxqyapp/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="WXQYAPP_ID" id="WXQYAPP_ID" value="${pd.WXQYAPP_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<table id="table_report" class="table table-striped table-bordered table-hover">
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应用名称:</td>
								<td><input type="text" name="APPNAME" id="APPNAME" value="${pd.APPNAME}" maxlength="255" placeholder="这里输入应用名称" title="应用名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应用SECRET:</td>
								<td><input type="text" name="APPSECRET" id="APPSECRET" value="${pd.APPSECRET}" maxlength="255" placeholder="这里输入应用SECRET" title="应用SECRET" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">应用AGENTID:</td>
								<td><input type="text" name="APPAGENTID" id="APPAGENTID" value="${pd.APPAGENTID}" maxlength="255" placeholder="这里输入应用AGENTID" title="应用AGENTID" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">新增时间:</td>
								<td><input class="span10 date-picker" name="CREATETIME" id="CREATETIME" value="${pd.CREATETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="新增时间" title="新增时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">修改时间:</td>
								<td><input class="span10 date-picker" name="UPDATETIME" id="UPDATETIME" value="${pd.UPDATETIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="修改时间" title="修改时间" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">创建人:</td>
								<td><input type="text" name="CREATEMAN" id="CREATEMAN" value="${pd.CREATEMAN}" maxlength="255" placeholder="这里输入创建人" title="创建人" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">回调路径:</td>
								<td><input type="text" name="APPURL" id="APPURL" value="${pd.APPURL}" maxlength="255" placeholder="这里输入回调路径" title="回调路径" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">token名称:</td>
								<td><input type="text" name="TOKEN" id="TOKEN" value="${pd.TOKEN}" maxlength="255" placeholder="这里输入token名称" title="token名称" style="width:98%;"/></td>
							</tr>
							<tr>
								<td style="width:75px;text-align: right;padding-top: 13px;">EncodingAESKey:</td>
								<td><input type="text" name="ENCODINGAESKEY" id="ENCODINGAESKEY" value="${pd.ENCODINGAESKEY}" maxlength="255" placeholder="这里输入EncodingAESKey" title="EncodingAESKey" style="width:98%;"/></td>
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
			if($("#APPNAME").val()==""){
				$("#APPNAME").tips({
					side:3,
		            msg:'请输入应用名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#APPNAME").focus();
			return false;
			}
			if($("#APPSECRET").val()==""){
				$("#APPSECRET").tips({
					side:3,
		            msg:'请输入应用SECRET',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#APPSECRET").focus();
			return false;
			}
			if($("#APPAGENTID").val()==""){
				$("#APPAGENTID").tips({
					side:3,
		            msg:'请输入应用AGENTID',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#APPAGENTID").focus();
			return false;
			}
			if($("#CREATETIME").val()==""){
				$("#CREATETIME").tips({
					side:3,
		            msg:'请输入新增时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATETIME").focus();
			return false;
			}
			if($("#UPDATETIME").val()==""){
				$("#UPDATETIME").tips({
					side:3,
		            msg:'请输入修改时间',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#UPDATETIME").focus();
			return false;
			}
			if($("#CREATEMAN").val()==""){
				$("#CREATEMAN").tips({
					side:3,
		            msg:'请输入创建人',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#CREATEMAN").focus();
			return false;
			}
			if($("#APPURL").val()==""){
				$("#APPURL").tips({
					side:3,
		            msg:'请输入回调路径',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#APPURL").focus();
			return false;
			}
			if($("#TOKEN").val()==""){
				$("#TOKEN").tips({
					side:3,
		            msg:'请输入token名称',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#TOKEN").focus();
			return false;
			}
			if($("#ENCODINGAESKEY").val()==""){
				$("#ENCODINGAESKEY").tips({
					side:3,
		            msg:'请输入EncodingAESKey',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#ENCODINGAESKEY").focus();
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