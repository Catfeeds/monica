﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">

<!-- jsp文件头和头部 -->
<%@ include file="../index/top.jsp"%>
<!-- 百度echarts -->
<script src="plugins/echarts/echarts.min.js"></script>
<script type="text/javascript" src="static/ace/js/jquery.js"></script>
<script type="text/javascript">
setTimeout("top.hangge()",500);
</script>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">

							<div class="alert alert-block alert-success">
								<button type="button" class="close" data-dismiss="alert">
									<i class="ace-icon fa fa-times"></i>
								</button>
								<i class="ace-icon fa fa-check green"></i>
								欢迎使用 莫尔卡后台管理系统&nbsp;&nbsp;

							</div>

							<script type="text/javascript">
								var myChart = echarts.init(document.getElementById('main'));
								var myChart1 = echarts.init(document.getElementById('main1'));
								// 指定图表的配置项和数据
								var date = new Date();
								var option = {
									title: {
										text: '年份:'+date.getFullYear()+"年",
										textStyle:{
											fontSize:15
										}
									},
									tooltip: {},
									legend: {
										data:['每月订单量','每月提交订单量']
									},
									xAxis: {
										data: ["一","二","三","四","五","六","七","八","九","十","十一","十二"]
									},
									yAxis: {},
									series: [
										{
											name: '每月订单量',
											type: 'bar',
											data: []
											//data: [0, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0]
										},
										{
											name: '每月提交订单量',
											type: 'bar',
											data: []
										}
									]
								};



								// 使用刚指定的配置项和数据显示图表。
								myChart.setOption(option);


								option1 = {
									title : {
										text: '客户订单数据比例分析',
										textStyle:{
											fontSize:15
										},
										subtext: '当月订单比例数据',
										x:'center'
									},
									tooltip : {
										trigger: 'item',
										formatter: "{a} <br/>{b} : {c} ({d}%)"
									},
									legend: {
										orient: 'vertical',
										left: 'left',
										data: [/*'测试一','测试二','测试三','测试四','测试五'*/]
									},
									series : [
										{
											name: '访问来源',
											type: 'pie',
											radius : '55%',
											center: ['50%', '60%'],
											data:[
											],
											itemStyle: {
												emphasis: {
													shadowBlur: 10,
													shadowOffsetX: 0,
													shadowColor: 'rgba(0, 0, 0, 0.5)'
												}
											}
										}
									]
								};
								$("#month").change(function () {
									$.get('<%=basePath%>dataAnalysis/loadforClient?month='+this.value).done(function (data) {
										// 填入数据
										myChart1.setOption({
											legend:[{
												data: data.jsonarrdataOfClient
											}],
											series: [{
												// 根据名字对应到相应的系列
												name: '客户订单',
												data: data.jsonData1
											}]
										});
									});
								});
								$.get('<%=basePath%>dataAnalysis/load').done(function (data) {
									// 填入数据
									myChart.setOption({
										xAxis: {
											data: ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
										},
										series: [
											{
												// 根据名字对应到相应的系列
												name: '每月订单量',
												data: data.data2
											},
											{
												// 根据名字对应到相应的系列
												name: '每月提交订单量',
												data: data.data1
											},
										]
									});
									myChart1.setOption(option1);
								});

								// 异步加载数据
								$.get('<%=basePath%>dataAnalysis/loadforClient').done(function (data) {
									// 填入数据
									myChart1.setOption({
										legend:[{
											data: data.jsonarrdataOfClient
										}],
										series: [{
											// 根据名字对应到相应的系列
											name: '客户订单',
											data: data.jsonData1
										}]
									});
								});
								myChart1.setOption(option1);
						    </script>
							
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->


		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- inline scripts related to this page -->
	<script type="text/javascript">
		$(top.hangge());
	</script>

</body>
</html>