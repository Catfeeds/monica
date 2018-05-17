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
<title>采购收货</title>
<base href="<%=basePath%>">
<link href="static/css/indent.css" rel="stylesheet" type="text/css">
<link href="static/css/search1.css" rel="stylesheet" type="text/css">
<link href="static/css/base.css" rel="stylesheet" type="text/css">
<!-- bootstrap & fontawesome -->
		<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
<link href="static/css/main_style.css" rel="stylesheet" type="text/css">
<script src="static/js/store/jquery-2.1.4.js"></script>
<script src="static/js/xback.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="format-detection" content="telephone=no" />
<!-- jsp文件头和头部 -->
<style>
/*订单状态*/
.state_box {
	height: 43px;
	position: relative
}

.withdrawals-panel {
	border: solid 1px #ccc;
	border-radius: 5px;
	background-color: #fff;
	padding: 0.8rem 0.6rem;
	margin-bottom: 1rem;
	overflow: hidden
}

.state {
	float: left;
	width: 25%;
	line-height: 43px;
	color: #65646b;
	font-size: 14px;
	text-align: center
}

.blue_block {
	width: 25%;
	position: absolute;
	left: 0;
	bottom: 0;
	height: 2px;
	background-color: #01aff0;
}
/*订单信息*/
.move_box {
	width: 100%;
	overflow: hidden
}

.move {
	width: 500%;
	position: relative;
	clear: both;
	left: 0
}

.order_box {
	float: left;
	/* margin-left:5%;
	margin-right:5%; */
	width: 20%;
}

.order {
	/* height: 163px; */
	position: relative;
	background-color: #fff;
	margin-bottom: 14px;
}

.order_title {
	margin-top: 5px;
	line-height: 40px;
	color: #191919;
	padding-left: 4%;
	font-size: 16px;
}

.order_text {
	width: 92%;
	margin-left: 4%;
	position: relative;
	height: 48px;
	padding-top: 5px;
	box-sizing: border-box
}

.order_text h1,.order_text h2 {
	line-height: 20px;
	color: #191919;
	font-size: 14px;
}

.order_text p {
	position: absolute;
	top: 0;
	right: 0;
	line-height: 100px;
	color: #65646b;
	font-size: 16px;
}

.cancel {
	width: 85px;
	height: 30px;
	border: 1px solid #ccc;
	text-align: center;
	line-height: 25px;
	border-radius: 3px;
	float: right;
	margin-top: 7px;
	margin-right: 4%;
	color: #65646b;
	font-size: 12px;
}
/*底部导航*/
.nav_box {
	width: 100%;
	height: 51px;
	position: fixed;
	left: 0;
	bottom: 0;
	background-color: #fff;
}

.nav_index,.nav_order,.nav_my {
	width: 33.3%;
	float: left;
}

.nav_box img {
	width: 18px;
	height: auto;
	position: relative;
	left: 50%;
	margin-left: -9px;
	margin-top: 8px;
}

.nav_box h1 {
	font-size: 12px;
	text-align: center;
	color: #65646b;
	line-height: 25px;
}

.nav_box .current_nav {
	color: #01aff0;
}

.btn-primary {
	background-color: #428bca !important;
	border-color: #428bca;
	border-radius: 5px;
	width: 90%;
	height: 100%;
	border: 1px;
}
.btn1 {
   /*  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.55); */
    touch-action: manipulation;
    border: 1px solid transparent;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    border-radius:0 5px 5px 0;
}
/* header {
    height: 50px;
    background-color: #06c1ae;
    position: fixed;
    width: 100%;
    z-index: 9999;
    display: -webkit-box;
    top: 0;
} */
</style>
</head>
<body class="no-skin" id="body">

	<!-- /section:basics/navbar.layout -->
	<!-- <div class="main-container" id="main-container">
		/section:basics/sidebar
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12"> -->
							<form action="platformQY/to_receive_order" method="post" name="Form" id="Form">
								<!-- -------------------------------------------- -->
								<!--header顶部标题-->
								<div class="header">
									待验收订单列表
									<div class="header_left" onclick="back()">
										<img src="static/images/store/return.png">
									</div>
								</div>

								<div style="width: 80%;margin-left:10%;  margin-top: 6px">
									<div class="input-group">
										<input name="keywords" type="text" class="form-control"
											placeholder="输入搜索内容..." value="${pd.keywords }"> <span
											class="input-group-btn">
											<button class="btn1" type="button" onclick="tosearch()">搜
												索</button> </span>
									</div>
								</div>
								<!--订单信息-->
								<div class="move_box" id="move_box">
									<div class="move">
										<div id="listNotReceive" class="order_box"
											style="padding: 10px">
											<c:forEach items="${allOrder}" var="var" varStatus="vs">
												<div class="withdrawals-panel">
													<div class="order"">
														<div class="border_top"></div>
														<div class="order_title">
															供 应 商：<em style="margin-left: 3%">${var.FNAME}</em>
														</div>
														<div class="order_title">
															订单日期：<em style="margin-left: 3%">${fn:substring(var.FDATE,0,10)}</em>
														</div>
														<div class="order_text">
															<div class="border_top"></div>
															<h2 style="font-size: 15px;margin-top: 10px">
																订单编号：<em style="margin-left:5%">${var.FBILLNO}</em>
															</h2>
															<br>
															<div class="border_bottom"></div>
														</div>
														<div class="cancel"
															onclick="toDetail_order(${var.FINTERID})"
															style="border:#ff7f00 1px solid; color:#ff7f00;">点击查看</div>
														<div class="border_bottom"></div>
													</div>
												</div>
											</c:forEach>
										</div>

									</div>
								</div>
							</form>

							<!-- -------------------------------------------- -->
						<!-- </div>
						/.col
					</div>
					/.row
				</div>
				/.page-content
			</div>
		</div> -->
		<!-- /.main-content -->
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	<!-- </div> -->
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%-- <%@ include file="../../system/index/foot.jsp"%> --%>
	<!-- ace scripts -->
	<!-- <script src="static/ace/js/ace/ace.js"></script> -->
	<script type="text/javascript">
       function toDetail_order(FINTERID){
       		window.location.href="<%=basePath%>platformQY/detail_order?FINTERID="+FINTERID;
       }
       
        function tosearch(){
				$("#Form").submit();
			}
       
      function back(){
			window.location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=ww49c384af1f4dac63&redirect_uri="+"${httpUrl}"+"/ssww/platformQY/index&response_type=code&scope=snsapi_base&agentid=1000003&state=STATE#wechat_redirect";
      }
      
      <%--  function pushHistory() { 
				var state = { 
					title: null, 
					url: "<%=basePath%>platformQY/to_receive_order",
				}; 
				window.history.pushState(null, null, "<%=basePath%>platformQY/to_receive_order"); 
			} 
      
			
		$(function(){ 
			pushHistory(); 
			window.addEventListener("popstate", function(e) { 
				//alert("测试");
				window.location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=ww49c384af1f4dac63&redirect_uri="+"${httpUrl}"+"/ssww/platformQY/index&response_type=code&scope=snsapi_base&agentid=1000003&state=STATE#wechat_redirect";
				//window.history.go(-1);  //返回上一页
				//window.history.back();  //返回上一页
			}, false); 
		}); --%>
		;!function(pkg, undefined){
		    var STATE = 'x-back';
		    var element;
		
		    var onPopState = function(event){
		        event.state === STATE && fire();
		    }
		
		    var record = function(state){
		        history.pushState(state, null, location.href);
		    }
		
		    var fire = function(){
		        var event = document.createEvent('Events');
		        event.initEvent(STATE, false, false);
		        element.dispatchEvent(event);
		    }
		
		    var listen = function(listener){
		        element.addEventListener(STATE, listener, false);
		    }
		
		    ;!function(){
		        element = document.createElement('span');
		        window.addEventListener('popstate', onPopState);
		        this.listen = listen;
		        record(STATE);
		    }.call(window[pkg] = window[pkg] || {});
		
		}('XBack');
				
		XBack.listen(function(){
		    window.location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=ww49c384af1f4dac63&redirect_uri="+"${httpUrl}"+"/ssww/platformQY/index&response_type=code&scope=snsapi_base&agentid=1000003&state=STATE#wechat_redirect";
		});
	</script>


</body>
</html>