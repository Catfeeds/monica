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
<title>门店订货</title>
<base href="<%=basePath%>">
<link href="static/css/indent.css" rel="stylesheet" type="text/css">
<link href="static/css/search1.css" rel="stylesheet" type="text/css">
<link href="static/css/base.css" rel="stylesheet" type="text/css">
<!-- <link href="static/css/radio.css" rel="stylesheet" type="text/css"> -->
<link href="static/css/main_style.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="static/themes/css/home.css">
<link rel="stylesheet" href="static/jquery-weui-build/css/jquery-weui.css">
<link rel="stylesheet" href="static/jquery-weui-build/lib/weui.css">
<script src="static/js/store/jquery-2.1.4.js"></script>
<script src="static/js/xback.js"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="format-detection" content="telephone=no" />
<!-- jsp文件头和头部 -->
<style>
/*订单状态*/
.state_box {
	height: 43px;
	position: relative;
	/* margin-left:25%; */
	width: 100%;
}

.withdrawals-panel {
	border: solid 1px #ccc;
	border-radius: 5px;
	background-color: #fff;
	padding: 0.6rem 0.5rem;
	margin-bottom: 1rem;
	overflow: hidden
}

.state {
	float: left;
	margin-left: 20%;
	width: 20%;
	line-height: 43px;
	color: #65646b;
	font-size: 14px;
	text-align: center
}

.state1 {
	float: left;
	margin-left: 0%;
	width: 20%;
	line-height: 43px;
	color: #65646b;
	font-size: 14px;
	text-align: center
}

.blue_block {
	width: 20%;
	position: absolute;
	left: 20%;
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
	width: 300%;
	position: relative;
	clear: both;
	left: 0
}

.order_box {
	float: left;
	width: 33.3%;
}

.order { /* height: 163px; */
	position: relative;
	background-color: #fff;
	border-radius: 5px;
	/*margin-bottom: 14px;*/
}

.order_title {
	/*margin-top: 5px;*/
	border-radius: 10px;
	line-height: 23px;
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

.float_div {
	position: absolute;
	width: 45px;
	height: 45px;
	margin-top: 60px;
	margin-right: 15px;
	right: 10px;
	/* top: -0px; */
	float: right;
	z-index: 10;
	border-radius: 10px;
	/* background-color: yellow; */
}
</style>
</head>
<body class="no-skin" id="body">

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
								我的订单
								<div class="header_left" onclick="window.history.go(-1)">
									<img src="static/images/store/return.png">
								</div>
							</div>
							<!--订单状态-->
							<div class="state_box">
								<div class="state">今日订单</div>
								<div class="state1">订单模板</div>
								<div class="state1">历史记录</div>
								<div class="blue_block"></div>
							</div>
							<!--订单信息-->
							<div class="move_box" id="move_box">
								<div class="move">
									<div id="order" class="order_box" style="padding: 10px;">
										<c:if test="${empty list}">
											<div class="withdrawals-panel" align="center">
												<p style="font-size: 18px">===今日没有订单===</p>
											</div>
										</c:if>
										<c:if test="${not empty list}">
											<c:forEach items="${list}" var="var" varStatus="vs">
												<div class="withdrawals-panel"
													<c:if test="${var.FSTATUS == 1}">
														name="yes" 
													</c:if>
													<c:if test="${var.FSTATUS == 0}">
														name = "no" 
													</c:if>
													id="${var.SALESORDERBILL_ID }"
													onclick="checkbox('${var.SALESORDERBILL_ID}','${var.FSTATUS }')">
													<div class="order">
														<div class="border_top"></div>
														<div class="order_title">
															<table style="width: 100%">
																<tr>
																	<td>订单编号：<em style="margin-left: 3%">${var.FBILLNO}</em></td>
																	<td style="width: 10%"><a
																		onclick="edit('${var.SALESORDERBILL_ID}')"
																		style="margin-top: 5px;width:65px;text-align: center;display: block;
																			height: 28px;line-height: 28px;
																			<c:if test="${var.FSTATUS == 0}">
																				background: #666666;
																			</c:if>
																			<c:if test="${var.FSTATUS == 1}">
																				background: #CC9966;
																			</c:if>
																			border-radius: 15px;color: #fff;font-size: 14px;margin-right:5px;">
																			<c:if test="${var.FSTATUS == 0}">
																				修改订单
																			</c:if> <c:if test="${var.FSTATUS == 1}">
																				查看订单
																			</c:if> </a></td>
																</tr>
															</table>

														</div>
														<div class="order_text">
															<div class="border_top"></div>
															<h2 style="font-size: 15px;margin-top: 10px">
																日期： <em style="margin-left:5%"> <fmt:formatDate
																		value="${var.FDATE}" type="date" dateStyle="long" /> </em>
															</h2>
															<div class="border_bottom"></div>
														</div>
														<div class="order_text">
															<div class="border_top"></div>
															<h2 style="font-size: 15px;margin-top: 10px">
																类别：<em style="margin-left:5%">${var.FTYPE}</em>
															</h2>
															<div class="border_bottom"></div>
														</div>
														<div class="order_text">
															<table style="width: 100%">
																<tr>
																	<td>
																		<div class="border_top"></div>
																		<h2 style="font-size: 15px;margin-top: 10px">
																			状态：
																			<c:if test="${var.FSTATUS == 0}">
																				<em style="margin-left:5%">草稿</em>
																		</h2>
																		</c:if> <c:if test="${var.FSTATUS == 1}">
																			<em style="margin-left:5%">已提交</em>
																			</h2>
																		</c:if></td>
																	<td align="right" style="margin-right: 45px">
																		<div class="border_top"></div>
																		<h2 style="font-size: 15px;margin-top: 10px">
																			同步状态：
																			<c:if test="${var.FSYNSTATUS == 0}">
																				<em >未同步</em>
																		</h2>
																		</c:if> <c:if test="${var.FSYNSTATUS == 1}">
																			<em >同步成功</em>
																			</h2>
																		</c:if> <c:if test="${var.FSYNSTATUS == -1}">
																			<em >未同步</em>
																			</h2>
																		</c:if> <c:if test="${var.FSYNSTATUS == 2}">
																			<em >未同步</em>
																			</h2>
																		</c:if> <c:if test="${var.FSYNSTATUS == -2}">
																			<em >同步成功</em>
																			</h2>
																		</c:if></td>
																</tr>
															</table>


															<br>
															<div class="border_bottom"></div>
														</div>
														<%-- <div class="order_text">
															<div class="border_top"></div>
															<h2 style="font-size: 15px;margin-top: 10px">同步：<em style="margin-left:5%">${var.FSTATUS}</em></h2>
															<br>
															<div class="border_bottom"></div>
														</div> --%>
													</div>
												</div>
											</c:forEach>
										</c:if>
										<br>
										<br>
									</div>
									<!--模板-->
									<div id="template" class="order_box " style="padding: 10px;">
										<c:if test="${empty varList}">
											<div class="withdrawals-panel" align="center">
												<p style="font-size: 18px">===没有分配该用户模板===</p>
											</div>
										</c:if>
										<c:if test="${not empty varList}">
											<c:forEach items="${varList}" var="var" varStatus="vs">
												<div class="withdrawals-panel" value="${var.SOTEMPLATE_ID }"
													id="${var.SOTEMPLATE_ID }"
													onclick="radio('${var.SOTEMPLATE_ID }')">
													<div id="or${var.SOTEMPLATE_ID }" class="order">
														<div class="border_top"></div>
														<div class="order_title">
															模板名称：<em style="margin-left: 3%">${var.SOTEMPLATE_NAME
																}</em>
														</div>
														<div class="cancel" id="can${var.SOTEMPLATE_ID}"
															name="${var.SOTEMPLATE_ID}"
															style="border:#ff7f00 1px solid; color:#666633;display: none"
															value="">点击选中</div>
														<div class="border_bottom"></div>
													</div>
												</div>
											</c:forEach>
										</c:if>
										<br>
										<br>
									</div>
									<!-- 历史记录 -->
									<div id="history" class="order_box" style="padding: 10px;margin-top: -10px">
										<div class="weui-cells weui-cells_form">
											<div class="weui-cell">
									        <div class="weui-cell__hd"><label for="date" class="weui-label">订单日期</label></div>
									        <div class="weui-cell__bd">
									        <table>
									        	<tr>
									        		<td style="width: 40%;"align="center">
									        			<input class="weui-input" id="date" type="text" >
									        		</td>
									        		<td align="center">至</td>
									        		<td style="width: 40%;"align="center">
									        			<input class="weui-input" id="date1" type="text" >
									        		</td>
									        	</tr>
									        </table>
									        </div>
									      </div>
									      <c:if test="${not empty hisToryList}">
											<c:forEach items="${hisToryList}" var="var" varStatus="vs">
												<div class="withdrawals-panel"
													<c:if test="${var.FSTATUS == 1}">
														name="yes" 
													</c:if>
													<c:if test="${var.FSTATUS == 0}">
														name = "no" 
													</c:if>
													id="${var.SALESORDERBILL_ID }">
													<div class="order">
														<div class="border_top"></div>
														<div class="order_title">
															<table style="width: 100%">
																<tr>
																	<td>订单编号：<em style="margin-left: 3%">${var.FBILLNO}</em></td>
																	<td style="width: 10%"><a
																		onclick="edit('${var.SALESORDERBILL_ID}')"
																		style="margin-top: 5px;width:65px;text-align: center;display: block;
																			height: 28px;line-height: 28px;
																			<c:if test="${var.FSTATUS == 0}">
																				background: #666666;
																			</c:if>
																			<c:if test="${var.FSTATUS == 1}">
																				background: #CC9966;
																			</c:if>
																			border-radius: 15px;color: #fff;font-size: 14px;margin-right:5px;">
																			<c:if test="${var.FSTATUS == 0}">
																				修改订单
																			</c:if> <c:if test="${var.FSTATUS == 1}">
																				查看订单
																			</c:if> </a></td>
																</tr>
															</table>

														</div>
														<div class="order_text">
															<div class="border_top"></div>
															<h2 style="font-size: 15px;margin-top: 10px">
																日期： <em style="margin-left:5%"> <fmt:formatDate
																		value="${var.FDATE}" type="date" dateStyle="long" /> </em>
															</h2>
															<div class="border_bottom"></div>
														</div>
														<div class="order_text">
															<div class="border_top"></div>
															<h2 style="font-size: 15px;margin-top: 10px">
																类别：<em style="margin-left:5%">${var.FTYPE}</em>
															</h2>
															<div class="border_bottom"></div>
														</div>
														<div class="order_text">
															<table style="width: 100%">
																<tr>
																	<td>
																		<div class="border_top"></div>
																		<h2 style="font-size: 15px;margin-top: 10px">
																			状态：
																			<c:if test="${var.FSTATUS == 0}">
																				<em style="margin-left:5%">草稿</em>
																		</h2>
																		</c:if> <c:if test="${var.FSTATUS == 1}">
																			<em style="margin-left:5%">已提交</em>
																			</h2>
																		</c:if></td>
																	<td align="right" style="margin-right: 45px">
																		<div class="border_top"></div>
																		<h2 style="font-size: 15px;margin-top: 10px">
																			同步状态：
																			<c:if test="${var.FSYNSTATUS == 0}">
																				<em >未同步</em>
																		</h2>
																		</c:if> <c:if test="${var.FSYNSTATUS == 1}">
																			<em >成功</em>
																			</h2>
																		</c:if> <c:if test="${var.FSYNSTATUS == -1}">
																			<em >未同步</em>
																			</h2>
																		</c:if> <c:if test="${var.FSYNSTATUS == 2}">
																			<em >未同步</em>
																			</h2>
																		</c:if> <c:if test="${var.FSYNSTATUS == -2}">
																			<em >成功</em>
																			</h2>
																		</c:if></td>
																</tr>
															</table>


															<br>
															<div class="border_bottom"></div>
														</div>
														<%-- <div class="order_text">
															<div class="border_top"></div>
															<h2 style="font-size: 15px;margin-top: 10px">同步：<em style="margin-left:5%">${var.FSTATUS}</em></h2>
															<br>
															<div class="border_bottom"></div>
														</div> --%>
													</div>
												</div>
											</c:forEach>
										</c:if>
								      </div>
								      <br>
								      <br>
									</div>
								</div>
								<div class="aui-invitation-footer">
									<a onclick="create()" id="create"
										style="width:90%; background:#0099CC;display: none">创建订单</a> <a
										onclick="sumbit()" id="sumbit"
										style="width:90%; background:#0099CC;display: ">提交</a>
									<a onclick="searchByDate()" id="searchByDate"
										style="width:90%; background:#0099CC;display: none">开始查询</a>
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
		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i> </a>
		<!-- /.main-content -->
		

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%-- <%@ include file="../../system/index/foot.jsp"%> --%>
	<!-- ace scripts -->
	<!-- <script src="static/ace/js/ace/ace.js"></script> -->
	<link rel="stylesheet" href="static/css/jquery-confirm.css">
	<script src="static/js/jquery-confirm.js"></script>
	<script>
	  $(function() {
	    FastClick.attach(document.body);
	    $("#date").val(date());
     	 $("#date1").val(date());
     	 if('${isHistory}' == "is"){
     	 	 $(".blue_block").animate({left:'60%'});
			$(".move").css("left","-200%");
			if($("#body").height()>$("#history").height()){
				$("#move_box").height($("#body").height()-88);
			}else{
				$("#move_box").height($("#history").height());
			}
			
			$("#create").css("display","none");
			$("#sumbit").css("display","none");
			$("#searchByDate").css("display","");
     	 }
     	
	  });
	</script>
	<script src="static/jquery-weui-build/js/jquery-weui.js">
	</script>
	<script src="static/jquery-weui-build/lib/fastclick.js"></script>
	<script type="text/javascript">
		function checkbox(value1,value2){
			if(value2 == 0 && $("#"+value1).val() != "yes"){
				$("#"+value1).css("background-color","#0099CC"); 
				$("#"+value1).val("yes");
			}else if( $("#"+value1).val() == "yes"){
				$("#"+value1).css("background-color",""); 
				$("#"+value1).val("");
			}
		}
		//$(top.hangge());
		$(".state:eq(0)").click(
			function(){
				$(".blue_block").animate({left:'20%'});
				$(".move").css("left","0%");
					if($("#body").height()>$("#order").height()){
						$("#move_box").height($("#body").height()-88);
					}else{
						$("#move_box").height($("#order").height());
					}
					$("#sumbit").css("display","");
					$("#create").css("display","none");
					$("#searchByDate").css("display","none");
				}
		);
		$(".state1:eq(0)").click(

			function(){
				$(".blue_block").animate({left:'40%'})
				$(".move").css("left","-100%");
				if($("#body").height()>$("#template").height()){
						$("#move_box").height($("#body").height()-88);
					}else{
						$("#move_box").height($("#template").height());
					}
					
					$("#create").css("display","");
					$("#sumbit").css("display","none");
					$("#searchByDate").css("display","none");
				}
		);
		$(".state1:eq(1)").click(
			function(){
				$(".blue_block").animate({left:'60%'})
				$(".move").css("left","-200%");
				if($("#body").height()>$("#history").height()){
						$("#move_box").height($("#body").height()-88);
					}else{
						$("#move_box").height($("#history").height());
					}
					
					$("#create").css("display","none");
					$("#sumbit").css("display","none");
					$("#searchByDate").css("display","");
				}
		);
		
		function searchByDate(){
			var date = $("#date").val();
			var date1 = $("#date1").val();
			window.location.href="<%=basePath%>template_Order/toOrder?USERID="+'${pd.USERID}'+"&date="+date+"&date1="+date1;
		}
		
	  
      function date(){
      		 //昨天的时间
			var mydate = new Date();
			mydate.setTime(mydate.getTime()-24*60*60*1000);
			//var s1 = mydate.getFullYear()+"-" + (day1.getMonth()+1) + "-" + day1.getDate();
			// alert(s1);
    	  var year = mydate.getFullYear();
    	  if((mydate.getMonth()+1)<10){
    		  var month = "0" + (mydate.getMonth()+1);
    	  }else{
    		  var month = mydate.getMonth()+1;
    	  }
    	  if(mydate.getDate()<10){
    		  var ri = "0" + mydate.getDate();
    	  }else{
    		  var ri = mydate.getDate();
    	  }
    	  if(mydate.getHours()<10){
    		  var hours = "0" + mydate.getHours();
    	  }else{
    		  var hours = mydate.getHours();
    	  }
    	  if(mydate.getMinutes()<10){
    		  var minutes = "0" + mydate.getMinutes();
    	  }else{
    		  var minutes = mydate.getMinutes();
    	  }
    	  var datestr = year+"/"+month+"/"+ri;
    	  return datestr;
      }
		
		$("#date").calendar({
	        onChange: function (p, values, displayValues) {
	          console.log(values, displayValues);
	        }
	      });
	     $("#date1").calendar({
	        onChange: function (p, values1, displayValues) {
	          console.log(values1, displayValues);
	        }
	      });
		/* 
		$(function (){
			//if()
			$(".blue_block").animate({left:'60%'});
				$(".move").css("left","-200%");
				if($("#body").height()>$("#order").height()){
						$("#move_box").height($("#body").height()-88);
					}else{
						$("#move_box").height($("#order").height());
					}
					
					$("#create").css("display","");
					$("#sumbit").css("display","none");
				}); */
		
		
		function radio(value){
			//alert($("#"+value).html());
			$(".withdrawals-panel").each(function() {
			    var $this = $(this);
			    $this.css("background-color","");
			});
			$(".cancel").each(function() {
			    var $this = $(this);
			    $this.val("no");
			});
			$(".order").each(function() {
				var $this = $(this);
				$this.css("background-color","");
			});

			$("#can"+value).val("yes");
			$("#"+value).css("background-color","#0099CC");
			$("#or"+value).css("background-color","#FFFFCC");
		}
		
		 function create(){
       		//alert("create()");alert(
       		var count = 0 ;
       		var SOTEMPLATE_ID = "";
       		$(".cancel").each(function() {
			    var $this = $(this);
			  	//alert($this.val());
			    if($this.val()==="yes"){
					SOTEMPLATE_ID = $this.attr("name");
			    	count ++ ;
			    }
			});
			if(count != 0 ){
				window.location.href="<%=basePath%>template_Order/createOrder?SOTEMPLATE_ID="+SOTEMPLATE_ID+ "&USERID="+'${pd.USERID}';
			}else{
				alert("请选择一个模板");
			}
			
			//alert(create);
       }
       
       function sumbit(){
       		$.confirm({
			    title: '是否提交改订单？',
			    boxWidth: '80%',
			    content: '',
			    buttons: {
			   		     提交: function () {
			            var count = 0;
			       		var strArr = "";
			       		$("#order .withdrawals-panel").each(function() {
			       			//alert($(this).val());
						    if($(this).val() == "yes"){
						    	strArr += $(this).attr("id");
						    	strArr += ",";
						    }
						});
						strArr = strArr.substring(0, strArr.length - 1);
						if(strArr.length > 2){
							$.ajax({
					    		url: "<%=basePath%>template_Order/SomeSumbit",
					    		type: "POST",
								data: { 
										strArr : strArr,
									  }, 
								success: function(data){
										window.location.reload();
					   				 }, 
					   			error: function(){
					        		alert("失败，请稍后重试！！");
					    		},
							});
						}else{
							//alert("请选择提交的订单...");
						}
			        },
			     		   取消: function () {
			        },
			    }
			});
		       		
       }
       
       function edit(value){
       		window.location.href="<%=basePath%>template_Order/toEditOrder?SALESORDERBILL_ID=" + value + "&USERID="+'${pd.USERID}';
		}

		function _touch() {
			$("#move_box").height($("#order").height());
			var startx;//让startx在touch事件函数里是全局性变量。
			var endx;
			var el = document.getElementById('main-container');
			function cons() { //独立封装这个事件可以保证执行顺序，从而能够访问得到应该访问的数据。
				//console.log(starty,endy);
				if (startx > endx) { //判断左右移动程序
					//alert(parseInt($(".move").css("left"))/parseInt($(window).width()));
					//alert(startx-endx);
					if (parseInt($(".move").css("left"))
							/ parseInt($(window).width()) == 0
							&& (startx - endx) > 70 || (startx - endx) < -70) {
						// alert("0");
						$(".blue_block").animate({
							left : '40%'
						});
						$(".move").css("left", "-100%");
						if ($("#body").height() > $("#template").height()) {
							$("#move_box").height($("#body").height() - 88);
						} else {
							$("#move_box").height($("#template").height());
						}

						$("#create").css("display", "");
						$("#sumbit").css("display", "none");
						$("#searchByDate").css("display","none");
						
					} else if ((parseInt($(".move").css("left"))
							/ parseInt($(window).width()) == -1)
							&& (startx - endx) > 70 || (startx - endx) < -70) {
						$(".blue_block").animate({
							left : '60%'
						});
						$(".move").css("left", "-200%");

						if ($("#body").height() > $("#history").height()) {
							$("#move_box").height($("#body").height() - 88);
						} else {
							$("#move_box").height($("#history").height());
						}
						$("#sumbit").css("display", "none");
						$("#create").css("display", "none");
						$("#searchByDate").css("display","");
					}
				} else {
					//alert(parseInt($(".move").css("left"))/parseInt($(window).width()));
                    //alert(startx-endx);
					 if(parseInt($(".move").css("left"))/parseInt($(window).width())==-2 
					 	&& (startx-endx)<-70 || (startx-endx)>70){
						$(".blue_block").animate({
							left : '40%'
						});
						$(".move").css("left", "-100%");
	
						if ($("#body").height() > $("#template").height()) {
							$("#move_box").height($("#body").height() - 88);
						} else {
							$("#move_box").height($("#template").height());
						}
						$("#sumbit").css("display", "none");
						$("#create").css("display", "");
						$("#searchByDate").css("display","none");
					}
					else if ((parseInt($(".move").css("left"))
							/ parseInt($(window).width()) == -1)
							&& (startx - endx) > 70 || (startx - endx) < -70) {
						$(".blue_block").animate({
							left : '20%'
						});
						$(".move").css("left", "0%");

						if ($("#body").height() > $("#order").height()) {
							$("#move_box").height($("#body").height() - 88);
						} else {
							$("#move_box").height($("#order").height());
						}
						$("#sumbit").css("display", "");
						$("#create").css("display", "none");
						$("#searchByDate").css("display","none");
					}
				}
			}
			el.addEventListener('touchstart', function(e) {
				var touch = e.changedTouches;
				startx = touch[0].clientX;
				starty = touch[0].clientY;
			});
			el.addEventListener('touchend', function(e) {
				var touch = e.changedTouches;
				endx = touch[0].clientX;
				endy = touch[0].clientY;
				cons(); //startx endx 的数据收集应该放在touchend事件后执行，而不是放在touchstart事件里执行，这样才能访问到touchstart和touchend这2个事件产生的startx和endx数据。另外startx和endx在_touch事件函数里是全局性的，所以在此函数中都可以访问得到，所以只需要注意事件执行的先后顺序即可。
			});
		}
		_touch();

		;
		!function(pkg, undefined) {
			var STATE = 'x-back';
			var element;

			var onPopState = function(event) {
				event.state === STATE && fire();
			}

			var record = function(state) {
				history.pushState(state, null, location.href);
			}

			var fire = function() {
				var event = document.createEvent('Events');
				event.initEvent(STATE, false, false);
				element.dispatchEvent(event);
			}

			var listen = function(listener) {
				element.addEventListener(STATE, listener, false);
			}

			;
			!function() {
				element = document.createElement('span');
				window.addEventListener('popstate', onPopState);
				this.listen = listen;
				record(STATE);
			}.call(window[pkg] = window[pkg] || {});

		}('XBack');

		XBack.listen(function() {
					window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=ww49c384af1f4dac63&redirect_uri="
							+ "${httpUrl}"
							+ "/mcfound/platformQY/index&response_type=code&scope=snsapi_base&agentid=1000003&state=STATE#wechat_redirect";
				});
	</script>


</body>
</html>