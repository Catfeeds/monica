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
<link href="static/css/indent.css" rel="stylesheet" type="text/css">
<link href="static/css/search1.css" rel="stylesheet" type="text/css">
<link href="static/css/base.css" rel="stylesheet" type="text/css">

<link href="static/css/main_style.css" rel="stylesheet" type="text/css">
<script src="static/js/store/jquery-2.1.4.js"></script>

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
	height: 115px;
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
	width: 65px;
	height: 25px;
	border: 1px solid #ccc;
	text-align: center;
	line-height: 25px;
	border-radius: 3px;
	float: right;
	margin-top: 6px;
	margin-right: 4%;
	color: #65646b;
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
</style>
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
							<!-- -------------------------------------------- -->
							<!--header顶部标题-->
							<div class="header">
								门店客户
								<div class="header_left" onclick="window.history.go(-1)">
									<img src="static/images/store/return.png">
								</div>
							</div>
							<div class="search-fixed">
								<div class="bg-white pl20 pr20 pt14 pb14">
									<table style="width: 100%">
										<tr>
											<td style="width: 72%"><div class="search pos_rel">
													<input type="text" value="请输入客户名称或手机" class="keywords "
														onclick="this.value=''"
														onblur="if(this.value=='') this.value='请输入商品的关键字'"></input><input
														type="button" value="&#xe60d;"
														class="iconfont btn_search f36 pos_abs"></input>
												</div>
											</td>
											<td style="width: 10px">
											</td>
											<td>
												<button id="addClient"  type="button" class="btn btn-primary" onclick="addClient()">新增客户</button>
											</td>
										</tr>
									</table>


								</div>
							</div>
							<!--订单状态-->
							<div class="state_box">
								<div class="state">线索客户</div>
								<div class="state">意向客户</div>
								<div class="state">订单客户</div>
								<div class="state">失败客户</div>
								<div class="blue_block"></div>
							</div>
							<!--订单信息-->
							<div class="move_box">
								<div class="move">

									<!--未付款-->
									<div class="order_box" style="padding: 10px">
										<div class="withdrawals-panel">
											<div class="order"">
												<div class="border_top"></div>
												<div class="order_title">
													张三（先生）<em style="margin-left: 30%">13112772390</em>
												</div>
												<div class="order_text">
													<div class="border_top"></div>
													<h2 style="font-size: 15px">信息来源：XXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">送货地址：XXXXXXXXXXXXXXXXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">购买意向:XXXXXXXXXXXX</h2>
													<div class="border_bottom"></div>
												</div>
												<!-- <div class="cancel"
												style="border:#ff7f00 1px solid; color:#ff7f00;">未付款</div> -->
												<div class="border_bottom"></div>
											</div>
										</div>
										<div class="withdrawals-panel">
											<div class="order"">
												<div class="border_top"></div>
												<div class="order_title">
													张三（先生）<em style="margin-left: 30%">13112772390</em>
												</div>
												<div class="order_text">
													<div class="border_top"></div>
													<h2 style="font-size: 15px">信息来源：XXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">送货地址：XXXXXXXXXXXXXXXXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">购买意向:XXXXXXXXXXXX</h2>
													<div class="border_bottom"></div>
												</div>
												<!-- <div class="cancel"
												style="border:#ff7f00 1px solid; color:#ff7f00;">未付款</div> -->
												<div class="border_bottom"></div>
											</div>
										</div>
									</div>

									<div class="order_box" style="padding: 10px">
										<div class="withdrawals-panel">
											<div class="order"">
												<div class="border_top"></div>
												<div class="order_title">
													张三（先生）<em style="margin-left: 30%">13112772390</em>
												</div>
												<div class="order_text">
													<div class="border_top"></div>
													<h2 style="font-size: 15px">信息来源：XXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">送货地址：XXXXXXXXXXXXXXXXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">购买意向:XXXXXXXXXXXX</h2>
													<div class="border_bottom"></div>
												</div>
												<!-- <div class="cancel"
												style="border:#ff7f00 1px solid; color:#ff7f00;">未付款</div> -->
												<div class="border_bottom"></div>
											</div>
										</div>
										<div class="withdrawals-panel">
											<div class="order"">
												<div class="border_top"></div>
												<div class="order_title">
													张三（先生）<em style="margin-left: 30%">13112772390</em>
												</div>
												<div class="order_text">
													<div class="border_top"></div>
													<h2 style="font-size: 15px">信息来源：XXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">送货地址：XXXXXXXXXXXXXXXXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">购买意向:XXXXXXXXXXXX</h2>
													<div class="border_bottom"></div>
												</div>
												<!-- <div class="cancel"
												style="border:#ff7f00 1px solid; color:#ff7f00;">未付款</div> -->
												<div class="border_bottom"></div>
											</div>
										</div>
										<div class="withdrawals-panel">
											<div class="order"">
												<div class="border_top"></div>
												<div class="order_title">
													张三（先生）<em style="margin-left: 30%">13112772390</em>
												</div>
												<div class="order_text">
													<div class="border_top"></div>
													<h2 style="font-size: 15px">信息来源：XXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">送货地址：XXXXXXXXXXXXXXXXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">购买意向:XXXXXXXXXXXX</h2>
													<div class="border_bottom"></div>
												</div>
												<!-- <div class="cancel"
												style="border:#ff7f00 1px solid; color:#ff7f00;">未付款</div> -->
												<div class="border_bottom"></div>
											</div>
										</div>
									</div>


									<div class="order_box" style="padding: 10px">
										<div class="withdrawals-panel">
											<div class="order"">
												<div class="border_top"></div>
												<div class="order_title">
													张三（先生）<em style="margin-left: 30%">13112772390</em>
												</div>
												<div class="order_text">
													<div class="border_top"></div>
													<h2 style="font-size: 15px">信息来源：XXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">送货地址：XXXXXXXXXXXXXXXXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">购买意向:XXXXXXXXXXXX</h2>
													<div class="border_bottom"></div>
												</div>
												<!-- <div class="cancel"
												style="border:#ff7f00 1px solid; color:#ff7f00;">未付款</div> -->
												<div class="border_bottom"></div>
											</div>
										</div>
										<div class="withdrawals-panel">
											<div class="order"">
												<div class="border_top"></div>
												<div class="order_title">
													张三（先生）<em style="margin-left: 30%">13112772390</em>
												</div>
												<div class="order_text">
													<div class="border_top"></div>
													<h2 style="font-size: 15px">信息来源：XXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">送货地址：XXXXXXXXXXXXXXXXXXXXXX</h2>
													<br>
													<h2 style="font-size: 15px">购买意向:XXXXXXXXXXXX</h2>
													<div class="border_bottom"></div>
												</div>
												<!-- <div class="cancel"
												style="border:#ff7f00 1px solid; color:#ff7f00;">未付款</div> -->
												<div class="border_bottom"></div>
											</div>
										</div>
									</div>
								</div>
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
	<!-- ace scripts -->
	<!-- <script src="static/ace/js/ace/ace.js"></script> -->
	<script type="text/javascript">
		//$(top.hangge());
		$(".state:eq(0)").click(
			function(){
				$(".blue_block").animate({left:'0%'})
				$(".move").css("left","0%")
				}
		);
		$(".state:eq(1)").click(
			function(){
				$(".blue_block").animate({left:'25%'})
				$(".move").css("left","-100%")
				}
		);
		$(".state:eq(2)").click(
			function(){
				$(".blue_block").animate({left:'50%'})
				$(".move").css("left","-200%")
				}
		);
		$(".state:eq(3)").click(
			function(){
				$(".blue_block").animate({left:'75%'})
				$(".move").css("left","-300%")
				}
		);
		
		function _touch(){
              var startx;//让startx在touch事件函数里是全局性变量。
              var endx;
               var el=document.getElementById('main-container');
              function cons(){   //独立封装这个事件可以保证执行顺序，从而能够访问得到应该访问的数据。
                     //console.log(starty,endy);
                     if(startx>endx ){  //判断左右移动程序
                     		//alert(startx-endx);
	                     	if(parseInt($(".move").css("left"))/parseInt($(window).width())==0 &&  (startx-endx)>70 || (startx-endx)<-70){
	                     		$(".blue_block").animate({left:'25%'});
								$(".move").css("left","-100%");
	                     	}else if(parseInt($(".move").css("left"))/parseInt($(window).width())==-1 &&  (startx-endx)>70 || (startx-endx)<-70){
								$(".blue_block").animate({left:'50%'});
								$(".move").css("left","-200%");
	                     	}else if(parseInt($(".move").css("left"))/parseInt($(window).width())==-2 &&  (startx-endx)>70 || (startx-endx)<-70){
	                     		$(".blue_block").animate({left:'75%'});
								$(".move").css("left","-300%");
	                     	}
                      }else{
                          //alert(parseInt($(".move").css("left"))/parseInt($(window).width()));
                         // alert(startx-endx);
                          if(parseInt($(".move").css("left"))/parseInt($(window).width())==-1 && (startx-endx)<-70 || (startx-endx)>70){
                         	 $(".blue_block").animate({left:'0%'});
							 $(".move").css("left","0%");
                          }else if(parseInt($(".move").css("left"))/parseInt($(window).width())==-2 && (startx-endx)<-70 || (startx-endx)>70){
                          	$(".blue_block").animate({left:'25%'});
							$(".move").css("left","-100%");
                          }else if(parseInt($(".move").css("left"))/parseInt($(window).width())==-3 && (startx-endx)<-70 || (startx-endx)>70  ){
                          	$(".blue_block").animate({left:'50%'});
							$(".move").css("left","-200%");
                          }
                     }
               }
               el.addEventListener('touchstart',function(e){
                       var touch=e.changedTouches;
                     startx=touch[0].clientX;
                    starty=touch[0].clientY;
            });
             el.addEventListener('touchend',function(e){
                 var touch=e.changedTouches;
                     endx=touch[0].clientX;
                      endy=touch[0].clientY;
                      cons();  //startx endx 的数据收集应该放在touchend事件后执行，而不是放在touchstart事件里执行，这样才能访问到touchstart和touchend这2个事件产生的startx和endx数据。另外startx和endx在_touch事件函数里是全局性的，所以在此函数中都可以访问得到，所以只需要注意事件执行的先后顺序即可。
           });
     }
       _touch();
       
       function addClient(){
       		$("#addClient").css("color","#006699");
       		window.location.href="http://jittest.s1.natapp.cc/ssww/store/addClient";
       }
	</script>


</body>
</html>