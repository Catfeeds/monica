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
<link href="static/css/base.css" rel="stylesheet" type="text/css">
<link href="static/css/search2.css" rel="stylesheet" type="text/css">
<!-- bootstrap & fontawesome -->
<link rel="stylesheet" type="text/css" href="static/themes/css/home.css">
<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
<script src="static/js/store/jquery-2.1.4.js"></script>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="format-detection" content="telephone=no" />
<!-- jsp文件头和头部 -->
<style>
.float_div {
	position: absolute;
	width: 40px;
	height: 40px;
	/* border: 1px solid red; */
	/* margin-right:0px;*/
	margin-top: 10px;
	right: 10px;
	/* top: -0px; */
	float: right;
	z-index: 100;
	border-radius: 10px;
	/* background-color: yellow; */
}

.btn1 { /*  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.55); */
	touch-action: manipulation;
	border: 1px solid transparent;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.42857143;
	border-radius: 0 5px 5px 0;
}
</style>
</head>
<body class="no-skin" id="body">
	<form
		action=""
		method="post" name="Form" id="Form">
		<!-- -------------------------------------------- -->
		<!--header顶部标题-->
		<div class="header">
			物料查询
			<div class="header_left">
				<img src="static/images/store/return.png">
			</div>
		</div>
		<div style="width: 80%;margin-left:10%;  margin-top: 6px">
			<div class="input-group">
				<input name="keywords" type="text" class="form-control" id="keywords"
					placeholder="输入搜索内容..." value="${pd.keywords }"> <span
					class="input-group-btn">
					<button class="btn1" type="button" onclick="tosearch()">搜
						索</button> </span>
			</div>
		</div>
		<!--订单信息-->
		<div class="aui-car-box-list" style="margin-top: 5px">
			<ul>
				<c:if test="${not empty pageDatas}">
					<c:forEach items="${pageDatas}" var="var" varStatus="vs">
						<li>
							<div class="aui-car-box-list-item">
								<div class="aui-car-box-list-text"
									onclick="toSelect('${var.FITEMID }')">
									<div id="${var.FITEMID }" class="float_div" 
										style="display: none;">
										<img src="static/images/icon_nav_msg.png"
											style="width: 35px;height: 35px" />
									</div>
									<div class="aui-car-box-list-text-price">
										<h4>
											<a>名称： ${var.FNAME}</a>
										</h4>

										<div class="aui-car-box-list-text-f">单位：</div>
										<div class="aui-car-box-list-text-dw">${var.FSALEUNIT}</div>

									</div>
									<div class="aui-car-box-list-text-price">
										<div class="aui-car-box-list-text-pri">
											规格型号：<b class="price">${var.FMODEL}</b>
										</div>

									</div>
								</div>

							</div></li>
					</c:forEach>
					<br><br><br>
				</c:if>
			</ul>
			
		</div>
	</form>
	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up"
		class="btn-scroll-up btn btn-sm btn-inverse"> <i
		class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i> </a>
	<div class="aui-invitation-footer">
		<c:if test="${not empty pd.SOTEMPLATE_ID}">
			<a style="background-color: #0099CC" value="选中返回"
				onclick="selected()">选中返回</a>
		</c:if>
		<c:if test="${empty pd.SOTEMPLATE_ID}">
			<a style="background-color: #0099CC" value="选中返回"
				onclick="selectedAndBack()">选中返回</a>
		</c:if>
		<%--<a style="background-color: #0099CC" value="选中返回"
		   onclick="selected()">选中返回</a>--%>
		<a style="background-color: #00CC99" value="返回" onclick="toBack()">返回</a>
	</div>

	<!-- </div> -->
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%-- <%@ include file="../../system/index/foot.jsp"%> --%>
	<!-- ace scripts -->
	<!-- <script src="static/ace/js/ace/ace.js"></script> -->
	<script type="text/javascript">
       function toSelect(value){
       		if($("#"+value).css("display") == "none"){
       			$("#"+value).css("display","");
       		}else{
       			$("#"+value).css("display","none");
       		}
       		
       }
       
       $('#Form').on('submit', function(){
		      tosearch();
		     event.preventDefault(); //阻止form表单默认提交
		})
       
       function selectedAndBack(){
       		var SALESORDERBILL_ID = "${pd.SALESORDERBILL_ID }";
       		var jsonstr = '['; 
       		$(".aui-car-box-list-text .float_div").each(function(){
       			if($(this).css("display") != "none"){
       				jsonstr += '{';
       				jsonstr += '"FITEMID":"' +$(this).attr("id"); 
       				jsonstr += '"}';
	                jsonstr += ',';
       			}
			  });
			jsonstr = jsonstr.substring(0, jsonstr.length - 1); 
            jsonstr += ']'; 
            $.ajax({
		    		url: "<%=basePath%>template_Order/save_replenish_item",
		    		type: "POST",
					data: { 
							SALESORDERBILL_ID : SALESORDERBILL_ID, //订单id
							jsonstr : jsonstr,
						  }, 
					success: function(data){
						if(data.arrStr != null && data.arrStr != ""){
							alert("订单模板已存在:"+data.arrStr+"。请勿重复添加！！");
							window.location.href = document.referrer;//返回上一页并刷新
						}else {
							window.location.href = document.referrer;//返回上一页并刷新
						}

							<%-- window.location.href="<%=basePath%>template_Order/createOrder?SALESORDERBILL_ID=${pd.SALESORDERBILL_ID }"+"&SOTEMPLATE_ID="+"${pd.SOTEMPLATE_ID}"; --%>
		   				 }, 
		   			error: function(){
		        		alert("失败，请稍后重试！！");
		    		},
				});
				
       }
       
       function selected(){
       		var SALESORDERBILL_ID = "${pd.SALESORDERBILL_ID }";
		   	var SOTEMPLATE_ID = '${pd.SOTEMPLATE_ID }';
       		var jsonstr = '[';
       		$(".aui-car-box-list-text .float_div").each(function(){
       			if($(this).css("display") != "none"){
       				jsonstr += '{';
       				jsonstr += '"FITEMID":"' +$(this).attr("id"); 
       				jsonstr += '"}';
	                jsonstr += ',';
       			}
			  });
			jsonstr = jsonstr.substring(0, jsonstr.length - 1); 
            jsonstr += ']'; 
            $.ajax({
		    		url: "<%=basePath%>template_Order/save_replenish_item",
		    		type: "POST",
					data: { 
							SALESORDERBILL_ID : SALESORDERBILL_ID, //订单id
							jsonstr : jsonstr,
							SOTEMPLATE_ID : SOTEMPLATE_ID
						  }, 
					success: function(data){
							//window.location.href = document.referrer;//返回上一页并刷新
							if(data.arrStr != null && data.arrStr != ""){
								alert("订单模板已存在:"+data.arrStr+"。请勿重复添加！！");
								window.location.href="<%=basePath%>template_Order/createOrder?SALESORDERBILL_ID=${pd.SALESORDERBILL_ID }&SOTEMPLATE_ID="+SOTEMPLATE_ID+ "&USERID="+'${pd.USERID}';

							}else {
								window.location.href="<%=basePath%>template_Order/createOrder?SALESORDERBILL_ID=${pd.SALESORDERBILL_ID }&SOTEMPLATE_ID="+SOTEMPLATE_ID+ "&USERID="+'${pd.USERID}';

							}
									   				 },
		   			error: function(){
		        		alert("失败，请稍后重试！！");
		    		},
				});
				
       }
       
        function tosearch(){
        		var keywords = encodeURI(encodeURI($("#keywords").val()));
        		$.ajax({
				       type: "GET",
				       url: "template_Order/replenish_item?SALESORDERBILL_ID=${pd.SALESORDERBILL_ID }&keywords="+keywords+"&SOTEMPLATE_ID="+'${pd.SOTEMPLATE_ID}'+ "&USERID="+'${pd.USERID}',
				       data: $('#registSubmit').serialize(),
					   }).success(function(message) {
					   	$(":root").html(message);
					     console.log(message);
					   }).fail(function(err){
					     console.log(err);
					   });
					//$("#Form").submit();
			}
			
		function toBack(){
			javascript:history.back(-1);
		}
	</script>


</body>
</html>