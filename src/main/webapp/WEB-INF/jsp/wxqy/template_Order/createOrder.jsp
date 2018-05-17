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
								新增订单
								<div class="header_left" onclick="window.history.go(-1)">
									<img src="static/images/store/return.png">
								</div>
							</div>
							<input type="hidden" name="SOTEMPLATE_ID" id="SOTEMPLATE_ID" value="${pageData.SOTEMPLATE_ID }"/>
							<input type="hidden" name="FDEPTID" id="FDEPTID" value="${pageData.FDEPTID }"/>
							<input type="hidden" name="CLIENT_ID" id="CLIENT_ID" value="${pageData.CLIENT_ID }"/>
							<input type="hidden" name="FBILLNO" id="FBILLNO" value="${pageData.FBILLNO }"/>
							<input type="hidden" name="SALESORDERBILL_ID" id="SALESORDERBILL_ID" value="${pd.SALESORDERBILL_ID }"/>
							<div class="aui-car-box-list-item-hread">
								<div class="aui-car-box-list-text">
									<h4>
										<table style="width: 100%">
											<tr>
												<td>
													<a >名称：${pageData.SOTEMPLATE_NAME }  </a>
												</td>
												<td align="right">
													<div class="">
														<a >状态：草稿  </a>
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
									<%-- <div class="aui-car-box-list-text-price">
										<table style="width: 100%">
											<tr>
												<td>
													<div class="aui-car-box-list-text-pri">
														类别：<b class="price">${pageData.FTYPE }</b>
													</div>
												</td>
												<!-- <td align="right">
													<div align="right">
														<input type="button"   value="保存" onclick="save()"
															style="width: 48px;height: 22px"  />
														<input type="button"   value="提交" onclick="sumbit()"
															style="width: 48px;height: 22px"  />
													</div>
												</td> -->
											</tr>
										</table>
										
									</div> --%>
								</div>
	
							</div>
							<!-- 新增 -->
							<c:if test="${not empty repList}">
								<div class="aui-car-box-list" style="margin-top: 5px">
									<ul>
										<c:forEach items="${repList}" var="var" varStatus="vs">
											
											<li>
												<div class="aui-car-box-list-item">
													<%-- <c:if test="${pageData.FSTATUS == 0}"> --%>
													<div class="float_div "
															onclick="delForRep('${var.REPLENISH_ITEM_ID}')">
															<img alt="删除" src="static/images/order/close.png"
																style="width: 100%;height: 100%">
														</div>
													<%-- 	</c:if> --%>
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
																	onfocus="this.select()"
																  value='<fmt:formatNumber type="number"  
																	 value="${var.FAUXQTY}" pattern="0" maxFractionDigits="0"/>' 																	style="width: 48px;height: 21px" class='ace' />
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
							<div class="aui-car-box-list"  style="margin-top: 5px">
								<ul>
									<c:forEach items="${varList}" var="var" varStatus="vs">
										
										<li>
											<div class="aui-car-box-list-item" id="${var.SOTEMPLATEENTRY_ID}">
												<div class="aui-car-box-list-text">
													<div class="float_div "
														onclick="del('${var.SOTEMPLATEENTRY_ID}')">
														<img alt="删除" src="static/images/order/close.png"
															style="width: 100%;height: 100%">
													</div>
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
															<!-- <a href="javascript:;" class="minus">-</a> -->
															<input type='number' id='${var.FITEMID}' name="${var.FENTRYID}" 
																onfocus="this.select()"
																 value='<fmt:formatNumber type="number"  
																 value="${var.FAUXQTY}" pattern="0" maxFractionDigits="0"/>' 
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
					<!-- 	</div>
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
		<!-- /.main-content -->
			<!-- <div class="aui-invitation-footer">
				<a onclick="create()" id="create" style="width:90%; background:#009999;display: none" >创建订单</a>
				<a onclick="sumbit()" id="sumbit" style="width:90%; background:#009999;display: " >提交</a>
			</div> -->
		<div class="aui-invitation-footer1">
				<a style="background-color: #00FFCC" value="添加物料" onclick="addItem()" >添加物料</a>
				<a style="background-color: #009966" value="保存" onclick="save()" >保存</a>
				<a style="background-color: #0099FF" value="提交" onclick="sumbit()"  >提交</a>
				<%-- <a onclick="confirm('${pd_one.FINTERID}','${pd_one.FVENDORID}')" style="background:#009999">发货确认</a>
				<a onclick="window.history.go(-1)" >退出</a> --%>
			</div>
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
		function del(value){
			bootbox.confirm("确定要删除该物料吗?", function(result) {
				if(result) {
						$("#"+value).css("display","none");
						$("#"+value+" .aui-car-box-list-text-arithmetic input").val(0);
						//alert($("#"+value+".aui-car-box-list-text-arithmetic input").attr("name"));
					}
			});
		}
		
		function addItem(){
			window.location.href="<%=basePath%>template_Order/replenish_item?SALESORDERBILL_ID=${pd.SALESORDERBILL_ID }"
									+"&SOTEMPLATE_ID="+"${pd.SOTEMPLATE_ID}"+ "&USERID="+'${pd.USERID}';
		}
		
		var mydate = new Date();
		function save(){
			var FDEPTID = $("#FDEPTID").val();
			var FTEMPID = $("#SOTEMPLATE_ID").val();
			var FDATE = $("#FDATE").text();
			var CLIENT_ID = $("#CLIENT_ID").val();
			var jsonstr = '['; 
			$('.aui-car-box-list-text-arithmetic input').each(function(){
					if($(this).val() != "0" &&$(this).val()!=null){
						jsonstr += '{';
						jsonstr += '"FITEMID":"' +$(this).attr("id")+ '",';
						jsonstr += '"FENTRYID":"' +$(this).attr("name")+ '",';
						jsonstr += '"FAUXQTY":"' +$(this).val();
						jsonstr += '"}';
						jsonstr += ',';
					}
				}
            );

            jsonstr = jsonstr.substring(0, jsonstr.length - 1);
            jsonstr += ']';

            var newjsonstr = '['; 
			$('.aui-car-box-list-text-arithmetic1 input').each(function(){ 
					 newjsonstr += '{';  
	                 newjsonstr += '"FITEMID":"' +$(this).attr("id")+ '",';  
	                 newjsonstr += '"FAUXQTY":"' +$(this).val();  
	                 newjsonstr += '"}';
	                 newjsonstr += ',';
				}

            );
            newjsonstr = newjsonstr.substring(0, newjsonstr.length - 1);
            newjsonstr += ']';
			//if(newjsonstr.length)
			if (jsonstr.length < 5 && newjsonstr.length<5){
				alert("没有订单物料，请添加再保存订单！！");
				return;
			}
			bootbox.confirm("确定要保存该订单吗?", function(result) {
				if(result) {
						$.ajax({
				    		url: "<%=basePath%>template_Order/save",
				    		type: "POST",
							data: { 
									FDEPTID : FDEPTID, //部门id
									FTEMPID : FTEMPID, //模板id
									CLIENT_ID : CLIENT_ID, //客户id
									FCustID : CLIENT_ID, //客户id
									jsonstr : jsonstr,
									newjsonstr : newjsonstr
								  }, 
							success: function(data){
									//javascript:history.back(-1);
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
			var FTEMPID = $("#SOTEMPLATE_ID").val();
			//var FBILLNO = "DIDA"+mydate.getFullYear()+(mydate.getMonth()+1)+mydate.getDate()+mydate.getHours()+mydate.getMinutes()+mydate.getSeconds();
			var FDATE = $("#FDATE").text();
			var CLIENT_ID = $("#CLIENT_ID").val();
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
			bootbox.confirm("确定要提交该订单吗?", function(result) {
				if(result) {
						$.ajax({
		    		url: "<%=basePath%>template_Order/sumbit",
		    		type: "POST",
					data: { 
							FDEPTID : FDEPTID, //部门id
							FTEMPID : FTEMPID, //模板id
							//FBILLNO : FBILLNO, //订单编号
							CLIENT_ID : CLIENT_ID, //客户id
							FCustID : CLIENT_ID, //客户id
							jsonstr : jsonstr,
							//FDATE : FDATE,
							newjsonstr : newjsonstr
						  }, 
					success: function(data){
							//javascript:history.go(-1);
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
		
		getDate();
		
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
		
		function getDate(){
			$("#FDATE").text(mydate.getFullYear()+"年"+(mydate.getMonth()+1)+"月"+mydate.getDate()+"日"); 
		}
	</script>


</body>
</html>