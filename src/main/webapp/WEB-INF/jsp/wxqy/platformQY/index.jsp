<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>协同平台</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="static/css/weui.css">
<link rel="stylesheet" href="static/css/jquery-weui.css">
<link rel="stylesheet" href="static/css/reset.css">
<link rel="stylesheet" href="static/css/box-flex.css">
<link rel="stylesheet" href="static/css/style.css">
<script src="static/js/store/jquery-2.1.4.js"></script>
<script src="static/js/store/adaptive.js" type="text/javascript"
	charset="utf-8"></script>
<script type="text/javascript">
	adaPtive(); //铺页面调用				
	//页面加载时调用
	$(function() {
		direction();
	});
	//用户变化屏幕方向时调用
	$(window).on('orientationchange', function(e) {
		direction();
	});
	//调用adaptive
	function adaPtive(max) {
		window['adaptive'].desinWidth = 720;
		window['adaptive'].baseFont = 24;
		window['adaptive'].scaleType = 1;
		window['adaptive'].maxWidth = max;
		window['adaptive'].init();
	}
	//判断手机屏幕方向
	function direction() {
		if (window.orientation == 90 || window.orientation == -90) {
			adaPtive(320);
			return false;
		} else if (window.orientation == 0 || window.orientation == 180) {
			adaPtive();
			return false;
		}
	}
</script>
<!-- jsp文件头和头部 -->
<%-- <%@ include file="../../system/index/top.jsp"%> --%>

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

							<div class="weui-msg wallet-main clearfix" style="margin-top: 0">
								<ul
									class="wallet-control flex flex-pack-justify flex-pack-center">
									<li class="flex flex-v flex-align-center">
										<p style="font-size: 38px">1</p>
										<br>
										<p>待办报价</p>
										<br>
									<a onclick="onclick1()"><em>点击查看</em>
									</a>
									</li>
									<li class="flex flex-v flex-align-center">
										<p style="font-size: 38px">3</p>
										<br>
										<p>新的订单</p>
										<br>
									<a onclick="onclick1()"> <em>点击查看</em>
									</a>
									</li>
									<li class="flex flex-v flex-align-center">
										<p style="font-size: 38px">5</p>
										<br>
										<p>待发货订单</p>
										<br>
									<a onclick="onclick1()"> <em>点击查看</em>
									</a>
									</li>
								</ul>
								<!-- 服务 -->
								<!-- <div class="weui-cells__title">功能服务</div> -->
								<div class="weui-grids">
									<c:set var="theString" value="${userData.ROLE}" />
									<%-- <a href="<%=basePath%>store/new_page" class="weui-grid js_grid"> --%>
									<a onclick="onclick1()"
										class="weui-grid js_grid">
										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/newspaper.png" alt="">
										</div>
										<p class="weui-grid__label">新闻公告</p> </a>

										<%-- <c:if test="${fn:contains(theString,'门店') ||fn:contains(theString,'管理员')}"> --%>
									<a href="<%=basePath%>template_Order/toOrder?USERID=${UserId}" class="weui-grid js_grid">
										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/house.png" alt="">
										</div>
										<p class="weui-grid__label">门店订货</p> </a> 
									<%-- <a
										href="<%=basePath%>order/receive_order?FVENDORID=${FVENDORID}"
										class="weui-grid js_grid"> --%>
									<a onclick="onclick1()"
										class="weui-grid js_grid">
										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/page_white_stack.png" alt="">
										</div>
										<p class="weui-grid__label">订单管理</p> </a>
									<a
										class="weui-grid js_grid">
										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/message.png" alt="">
										</div>
										<p class="weui-grid__label">客户预约</p> </a>
										<%-- </c:if>
										
										<c:if test="${fn:contains(theString,'采购') ||fn:contains(theString,'管理员')}"> --%>
									<%-- <a href="<%=basePath%>platformQY/to_receive_order"
										class="weui-grid js_grid"> --%>
									<a onclick="onclick1()"
										class="weui-grid js_grid">
										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/truck.png" alt="">
										</div>
										<p class="weui-grid__label">采购收货</p> </a>
									<%-- </c:if> --%>

									<%-- <a href="<%=basePath%>platformQY/toCheck"
										class="weui-grid js_grid"> --%>
									<a onclick="onclick1()"
										class="weui-grid js_grid">
	
										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/clock_.png" alt="">
										</div>
										<p class="weui-grid__label">预警提醒</p> </a>
									<a href="<%=basePath%>dataAnalysis/toLoadAnalysis?USERID=${UserId}"
										class="weui-grid js_grid">

										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/chart_curve.png" alt="">
										</div>
										<p class="weui-grid__label">数据分析</p> </a> 
									<%-- <a
										href="<%=basePath%>store/list_client"
										class="weui-grid js_grid"> --%>
									<a onclick="onclick1()"
										class="weui-grid js_grid">
										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/gps.png" alt="">
										</div>
										<p class="weui-grid__label">任务管理</p> </a>
									<a onclick="onclick1()"
										class="weui-grid js_grid">

										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/checkbox.png" alt="">
										</div>
										<p class="weui-grid__label">流程管理</p> </a>
									<a onclick="onclick1()"
										class="weui-grid js_grid">

										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/calendar.png" alt="">
										</div>
										<p class="weui-grid__label">日程管理</p> </a>
									<a onclick="onclick1()"
										class="weui-grid js_grid">

										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/page_white_edit.png" alt="">
										</div>
										<p class="weui-grid__label">工作报告</p> </a>
									<a href="<%=basePath%>http/testEwm"
										class="weui-grid js_grid">

										<div>
											<img style="width: 35px;height: 35px"
												src="static/images/platformQY/user_male.png" alt="">
										</div>
										<p class="weui-grid__label">个人中心</p> </a>

								</div>
								<!-- 服务 -->

							</div>

							<!-- -------------------------------------------- -->
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

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%-- <%@ include file="../../system/index/foot.jsp"%> --%>
	<script type="text/javascript">
		//$(top.hangge());
		function onclick1() {
			alert("暂无内容！！");
		}
		$(document.body).css({
			"overflow-x" : "hidden",
			"overflow-y" : "hidden"
		});
	</script>


</body>
</html>