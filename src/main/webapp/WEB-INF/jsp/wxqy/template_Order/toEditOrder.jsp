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
<link href="static/css/base.css" rel="stylesheet" type="text/css">
<!-- <link href="static/css/radio.css" rel="stylesheet" type="text/css"> -->

<link rel="stylesheet" type="text/css" href="static/themes/css/home.css">
<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
<script src="static/js/store/jquery-2.1.4.js"></script>
<script src="static/js/aui-car.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="format-detection" content="telephone=no" />
<!-- jsp文件头和头部 -->
<style>
.float_div {
	position: absolute;
	width: 30px;
	height: 30px;
	/* border: 1px solid red; */
	/* margin-right:0px;
	margin-top:0px; */
	right: 0px;
	/* top: -0px; */
	float: right;
	z-index: 100;
	border-radius: 10px;
	/* background-color: yellow; */
}
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
							<!-- -------------------------------------------- -->
							<!--header顶部标题-->
							<div class="header">
								修改订单
								<div class="header_left" onclick="window.history.go(-1)">
									<img src="static/images/store/return.png">
								</div>
							</div>
							<input type="hidden" name="SALESORDERBILL_ID" id="SALESORDERBILL_ID" value="${pageData.SALESORDERBILL_ID }"/>
							<input type="hidden" name="FDEPTID" id="FDEPTID" value="${pageData.FDEPTID }"/>
							<input type="hidden" name="FBILLNO" id="FBILLNO" value="${pageData.FBILLNO }"/>
							
							<div class="aui-car-box-list-item-hread">
								<div class="aui-car-box-list-text">
									
									<h4>
										<table style="width: 100%">
											<tr>
												<td>
													<a >订单编号：${pageData.FBILLNO }  </a>
												</td>
												<td align="right">
													<div class="">
														<c:if test="${pageData.FSTATUS == 0}">
															<a id="zt">状态：草稿  </a>
														</c:if>
														<c:if test="${pageData.FSTATUS == 1}">
															<a id="zt">状态：已提交  </a>
														</c:if>
													</div>
												</td>
											</tr>
										</table>
									</h4>
									<div class="aui-car-box-list-text-price">
										<div class="aui-car-box-list-text-pri">
											日期：<b id="FDATE" class="price"></b>
										</div>
									</div>
								</div>
	
							</div>
							<!-- 新增 -->
							<c:if test="${not empty repList}">
								<div class="aui-car-box-list" style="margin-top: 5px">
									<ul>
										<c:forEach items="${repList}" var="var" varStatus="vs">
											
											<li>
												<div class="aui-car-box-list-item">
													<c:if test="${pageData.FSTATUS == 0}">
													<div class="float_div "
															onclick="delForRep('${var.REPLENISH_ITEM_ID}')">
															<img alt="删除" src="static/images/order/close.png"
																style="width: 100%;height: 100%">
														</div>
														</c:if>
													<div class="aui-car-box-list-text">
														<div class="aui-car-box-list-text-price">
															<h4>
																<a >名称：  ${var.FNAME}</a>
															</h4> 
															<div class="aui-car-box-list-text-f">
																单位：
															</div>
															<div class="aui-car-box-list-text-dw">
																 ${var.FSALEUNIT}
															</div>
														</div>
														<div class="aui-car-box-list-text-price">
															<div class="aui-car-box-list-text-pri">
																规格型号：<b class="price">${var.FMODEL}</b>
															</div>
															<div class="aui-car-box-list-text-f">
															数量：
															</div>
															<div class="aui-car-box-list-text-arithmetic1">
																<input type='number' id='${var.FITEMID}'  
																	<c:if test="${pageData.FSTATUS == 1}">
																		readonly="readonly"
																	</c:if>
																	onfocus="this.select()"
																	   value='<fmt:formatNumber type="number"
																 value="${var.FAUXQTY}" pattern="0" maxFractionDigits="1"/>'
																	   style="width: 48px;height: 21px" class='ace' />
															</div>
														</div>
													</div>
						
												</div>
											</li>
										</c:forEach>
									</ul>
								</div>
							<!-- 原有 -->
							<hr>
							</c:if>
							<div class="aui-car-box-list" style="margin-top: 5px">
								<ul>
									<c:forEach items="${varList}" var="var" varStatus="vs">
										
										<li>
											<div class="aui-car-box-list-item">
												<c:if test="${pageData.FSTATUS == 0}">
												<div class="float_div "
														onclick="del('${var.SALESORDERBILLENTRY_ID}')">
														<img alt="删除" src="static/images/order/close.png"
															style="width: 100%;height: 100%">
													</div>
													</c:if>
												<div class="aui-car-box-list-text">
													<div class="aui-car-box-list-text-price">
														<h4>
															<a >名称：  ${var.FNAME}</a>
														</h4> 
														<div class="aui-car-box-list-text-f">
															单位：
														</div>
														<div class="aui-car-box-list-text-dw">
															 ${var.FSALEUNIT}
														</div>
													</div>
													<div class="aui-car-box-list-text-price">
														<div class="aui-car-box-list-text-pri">
															规格型号：<b class="price">${var.FMODEL}</b>
														</div>
														<div class="aui-car-box-list-text-f">
														数量：
														</div>
														<div class="aui-car-box-list-text-arithmetic">
															<input type='number' id='${var.FITEMID}' name="${var.FENTRYID}" 
																<c:if test="${pageData.FSTATUS == 1}">
																	readonly="readonly"
																</c:if>
																onfocus="this.select()"
															  value='<fmt:formatNumber type="number"
																 value="${var.FAUXQTY}" pattern="0" maxFractionDigits="1"/>'
																   style="width: 48px;height: 21px" class='ace' />
														</div>
													</div>
												</div>
					
											</div>
										</li>
									</c:forEach>
								</ul>
							</div>
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
		<br><br>
		<c:if test="${pageData.FSTATUS == 0}">
			<div class="aui-invitation-footer1">
				<a style="background-color: #00FFCC" value="添加物料" onclick="addItem()" >添加物料</a>
				<a style="background-color: #009966" value="保存" onclick="save()" >保存修改</a>
				<a style="background-color: #0099FF" value="提交" onclick="sumbit()"  >提交</a>
			</div>
		</c:if>
	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<!-- <script src="static/ace/js/ace/ace.js"></script> -->
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<script type="text/javascript">
		//window.opener.document.location.reload();
		var mydate = new Date();
		function save(){
			var FDEPTID = $("#FDEPTID").val();
			var SALESORDERBILL_ID = $("#SALESORDERBILL_ID").val();
			//aui-car-box-list-text-arithmetic
			var jsonstr = '['; 
			$('.aui-car-box-list-text-arithmetic input').each(function(){ 
					 //alert($(this).attr("id"));
					 jsonstr += '{';  
	                 jsonstr += '"FITEMID":"' +$(this).attr("id")+ '",';  
	                 jsonstr += '"FENTRYID":"' +$(this).attr("name")+ '",';
	                 jsonstr += '"FAUXQTY":"' +$(this).val();  
	                 jsonstr += '"}';
	                 jsonstr += ','; 
				}
            ); 
            jsonstr = jsonstr.substring(0, jsonstr.length - 1); 
            jsonstr += ']'; 
            
            var newjsonstr = '['; 
			$('.aui-car-box-list-text-arithmetic1 input').each(function(){ 
					 //alert($(this).attr("id"));
					 newjsonstr += '{';  
	                 newjsonstr += '"FITEMID":"' +$(this).attr("id")+ '",';  
	                 newjsonstr += '"FAUXQTY":"' +$(this).val();  
	                 newjsonstr += '"}';
	                 newjsonstr += ','; 
				}
            ); 
            newjsonstr = newjsonstr.substring(0, newjsonstr.length - 1); 
            newjsonstr += ']';  
           // alert(jsonstr);
			bootbox.confirm("确定要修改该订单吗?", function(result) {
				if(result) {
						$.ajax({
				    		url: "<%=basePath%>template_Order/editOrderInfo",
				    		type: "POST",
							data: { 
									FDEPTID : FDEPTID, //部门id
									SALESORDERBILL_ID : SALESORDERBILL_ID, //订单id
									jsonstr : jsonstr,
									newjsonstr : newjsonstr
								  }, 
							success: function(data){
									$.ajax({
								    		url: "<%=basePath%>template_Order/deleteAllDate",
								    		type: "POST",
											data: { 
												  }, 
											success: function(data){
													//window.location.href = document.referrer;//返回上一页并刷新  
													window.location.href="<%=basePath%>template_Order/toOrder?USERID="+'${pd.USERID}';
								   				 }, 
								   			error: function(){
								        		alert("失败，请稍后重试！！");
								    		},
										});
				   				 }, 
				   			error: function(){
				        		alert("失败，请稍后重试！！");
				    		},
						});
					}
				});
		}
		
		function sumbit(){
			var FDEPTID = $("#FDEPTID").val();
			var SALESORDERBILL_ID = $("#SALESORDERBILL_ID").val();
			//aui-car-box-list-text-arithmetic
			var jsonstr = '['; 
			$('.aui-car-box-list-text-arithmetic input').each(function(){ 
					 //alert($(this).attr("id"));
					 jsonstr += '{';  
	                 jsonstr += '"FITEMID":"' +$(this).attr("id")+ '",';  
	                 jsonstr += '"FENTRYID":"' +$(this).attr("name")+ '",';
	                 jsonstr += '"FAUXQTY":"' +$(this).val();  
	                 jsonstr += '"}';
	                 jsonstr += ','; 
				}
            ); 
            jsonstr = jsonstr.substring(0, jsonstr.length - 1); 
            jsonstr += ']';  
           // alert(jsonstr);
            var newjsonstr = '['; 
			$('.aui-car-box-list-text-arithmetic1 input').each(function(){ 
					 //alert($(this).attr("id"));
					 newjsonstr += '{';  
	                 newjsonstr += '"FITEMID":"' +$(this).attr("id")+ '",';  
	                 newjsonstr += '"FAUXQTY":"' +$(this).val();  
	                 newjsonstr += '"}';
	                 newjsonstr += ','; 
				}
            ); 
            newjsonstr = newjsonstr.substring(0, newjsonstr.length - 1); 
            newjsonstr += ']';  
			bootbox.confirm("确定要修改并提交该订单吗?", function(result) {
				if(result) {
						$.ajax({
		    		url: "<%=basePath%>template_Order/editOrderInfoAndSumbit",
		    		type: "POST",
					data: { 
							FDEPTID : FDEPTID, //部门id
							SALESORDERBILL_ID : SALESORDERBILL_ID, //订单id
							jsonstr : jsonstr,
							newjsonstr : newjsonstr
						  }, 
					success: function(data){
							$.ajax({
						    		url: "<%=basePath%>template_Order/deleteAllDate",
						    		type: "POST",
									data: { 
										  }, 
									success: function(data){
											window.location.href="<%=basePath%>template_Order/toOrder?USERID="+'${pd.USERID}';
						   				 }, 
						   			error: function(){
						        		alert("失败，请稍后重试！！");
						    		},
								});
		   				 }, 
		   			error: function(){
		        		alert("失败，请稍后重试！！");
		    		},
				});
					}
				});
		}
		
		function addItem(){
			window.location.href="<%=basePath%>template_Order/replenish_item?SALESORDERBILL_ID=${pageData.SALESORDERBILL_ID }";
		}
		
		
		function del(SALESORDERBILLENTRY_ID){
			bootbox.confirm("确定要删除该项订单物料吗?", function(result) {
				if(result) {
						$.ajax({
		    		url: "<%=basePath%>template_Order/delete.do",
		    		type: "POST",
					data: { 
							SALESORDERBILLENTRY_ID : SALESORDERBILLENTRY_ID, //订单物料id
						  }, 
					success: function(data){
							location.reload();
		   				 }, 
		   			error: function(){
		        		alert("失败，请稍后重试！！");
		    		},
				});
					}
				});
		}
		
		function delForRep(value){
			$.ajax({
	    		url: "<%=basePath%>template_Order/deleteByREPLENISH_ITEM_ID",
	    		type: "POST",
				data: { 
						REPLENISH_ITEM_ID : value, 
					  }, 
				success: function(data){
						location.reload();
	   				 }, 
	   			error: function(){
	        		alert("失败，请稍后重试！！");
	    		},
			});
		}
		
		getDate();
		
		function getDate(){
			$("#FDATE").text(mydate.getFullYear()+"年"+(mydate.getMonth()+1)+"月"+mydate.getDate()+"日"); 
		}
	</script>


</body>
</html>