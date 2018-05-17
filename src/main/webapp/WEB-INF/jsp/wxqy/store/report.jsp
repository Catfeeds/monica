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
<script src="static/js/store/jquery-2.1.4.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<!-- <link href="static/css/indent.css" rel="stylesheet" type="text/css"> -->
<link rel="stylesheet" type="text/css" href="static/css/ui.css" />
<link href="static/css/indent.css" rel="stylesheet" type="text/css">
<link href="iTunesArtwork@2x.png" sizes="114x114" rel="apple-touch-icon-precomposed">
<!-- jsp文件头和头部 -->
<%-- <%@ include file="../../system/index/top.jsp"%> --%>

</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
							<!-- -------------------------------------------- -->
							<div class="" style="overflow:hidden">
								<div class="">

									<!-- <div class="my-info">
										<div class="my-info-background"></div>
										<img class="my-avatar" src="images/user.png"> <span
											class="name"><a href="login.html" style="color:#fff">立即登录</a>
										</span>
									</div> -->
									<div class="header">
										门店报表
										<div class="header_left" onclick="window.history.go(-1)">
											<img src="static/images/store/return.png">
										</div>
									</div>
									<div class="aui-list-cells">
										<a  class="aui-list-cell">
											<div class="aui-list-cell-fl">
												<img src="static/images/store/chart_bar.png">
											</div>
											<div class="aui-list-cell-cn">门店日收款排行榜</div>
											<div class="aui-list-cell-fr"></div> </a>
										 <a href="http://jittest.s1.natapp.cc/ssww/store/trendAnalysis"
											class="aui-list-cell">
											<div class="aui-list-cell-fl">
												<img src="static/images/store/chart_pie.png">
											</div>
											<div class="aui-list-cell-cn">应收账款趋势分析</div>
											<div class="aui-list-cell-fr"></div> </a>
										 <a href="http://jittest.s1.natapp.cc/ssww/store/timeRateAnalysis"  class="aui-list-cell">
											<div class="aui-list-cell-fl">
												<img src="static/images/store/chart_bar.png">
											</div>
											<div class="aui-list-cell-cn">应收账款回款及时率分析</div>
											<div class="aui-list-cell-fr"></div> </a> 
										<div class="devider b-line"></div>
									
									</div>



								</div>
							</div>


							<!-- -------------------------------------------- -->

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<script type="text/javascript">
	</script>


</body>
</html>