<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<link rel="stylesheet" href="static/css/weui.min.css">
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
									<li class="flex flex-v flex-align-center"  style="margin-left: 18%">
									<p style="font-size: 38px">3</p><br>
										<p>代办流程</p><br><a onclick="onclick1()"><em>点击查看</em></a></li>
									<li class="flex flex-v flex-align-center" style="margin-right: 18%">
									<p style="font-size: 38px">5</p><br>
										<p>未读消息</p><br><a onclick="onclick1()"> <em>点击查看</em></a></li>
									<!-- <li class="flex flex-v flex-align-center"><img
										src="images/wallet_card.png" class="ca" alt="">
										<p>银行卡</p></li> -->
								</ul>
								<!-- 服务 -->
								<!-- <div class="weui-cells__title">功能服务</div> -->
								<div class="weui-grids">
									<a href="<%=basePath%>store/new_page" class="weui-grid js_grid">
										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/newspaper.png" alt="">
										</div>
										<p class="weui-grid__label">新闻公告</p> </a> <a onclick="onclick1()"
										class="weui-grid js_grid">
										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/cart.png" alt="">
										</div>
										<p class="weui-grid__label">门店商城</p> </a> <a href="<%=basePath%>store/list_indent"
										class="weui-grid js_grid">
										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/page_paste.png" alt="">
										</div> 
										<p class="weui-grid__label">客户订单</p> </a> <a 
										class="weui-grid js_grid">
										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/coins_delete.png" alt="">
										</div>
										<p class="weui-grid__label">优惠审判</p> </a> 
										
										<a onclick="onclick1()"
										class="weui-grid js_grid">
										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/cart_delete.png" alt="">
										</div>
										<p class="weui-grid__label">退货管理</p> </a>
										
										 <a href="<%=basePath%>store/report"
										class="weui-grid js_grid">

										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/chart_bar.png" alt="">
										</div>
										<p class="weui-grid__label">门店报表</p> </a>
										
										 <a onclick="onclick1()"
										class="weui-grid js_grid">

										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/brick.png" alt="">
										</div>
										<p class="weui-grid__label">库存查询</p> </a>
										
										 <a href="<%=basePath%>store/list_client"
										class="weui-grid js_grid">

										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/group.png" alt="">
										</div>
										<p class="weui-grid__label">门店客户</p> </a>
										
										 <a onclick="onclick1()"
										class="weui-grid js_grid">

										<div >
											<img style="width: 35px;height: 35px" src="static/images/store/message.png" alt="">
										</div>
										<p class="weui-grid__label">我的消息</p> </a>

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
		function onclick1(){
			alert("暂无内容！！");
		}
	</script>


</body>
</html>