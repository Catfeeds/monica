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
<title>销售订单</title>
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
								新增订单
								<div class="header_left" onclick="window.history.go(-1)">
									<img src="static/images/store/return.png">
								</div>
							</div>
							<div class="weui-cells">
								<a class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>客&nbsp;&nbsp;&nbsp;&nbsp;户</p>
									</div>
									<div  class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" id="" type="text" value="请选择客户">
									</div>
								</a>
								<a class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>类&nbsp;&nbsp;&nbsp;&nbsp;型 </p>
									</div>
									<div  class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" id="mobile" type="text" value="请选择类型">
									</div>
								</a>
								<a class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>提货日期</p>
									</div>
									<div  class="weui-cell__ft">
										<input class="weui-input" id="date" value="请选择日期" type="text">
									</div>
								</a>
								<a class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>跟单人员</p>
									</div>
									<div class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px"  type="text" value="请选择人员">
									</div>
								</a>
							</div>
							<p style="font-size: 18px;"><strong>备注</strong></p>
							<div style="margin-top: 3px" class="weui-cells">
								<a id="cbz" class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>1、包&nbsp;装</p>
									</div>
									<div  class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px"  type="text" id="bz" value="请选择客户">
									</div>
								</a>
								<a id="cjmp" class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>2、镜面抛 </p>
									</div>
									<div  class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" type="text" id="jmp" value="请选择类型">
									</div>
								</a>
								<a id="cjs" class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>3、胶水</p>
									</div>
									<div  class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" type="text" id="js" value="请选择日期">
									</div>
								</a>
								<a id="cbsyq" class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>4、标识要求</p>
									</div>
									<div class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" id="bsyq" type="text" value="请选择要求">
									</div>
								</a>
								<a id="cpm" class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>5、喷码</p>
									</div>
									<div class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" id="pm" type="text" value="请选择喷码">
									</div>
								</a>
								<a id="ckhyh" class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>6、客户验货</p>
									</div>
									<div class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" id="khyh" type="text" value="请选择验货">
									</div>
								</a>
								<a id="cggwp" class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>7、跟柜物品</p>
									</div>
									<div class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" id="ggwp" type="text" value="请选择物品">
									</div>
								</a>
								<a id="cwl" class="weui-cell weui-cell_access" href="javascript:;">
									<div class="weui-cell__bd">
										<p>8、物流</p>
									</div>
									<div class="weui-cell__ft">
										<input class="weui-input" style="margin-right: 1px" id="wl" type="text" placeholder="请选择物流" >
									</div>
								</a>

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

	<script src="static/jquery-weui-build/js/jquery-weui.js">
	</script>
	<script src="static/jquery-weui-build/lib/fastclick.js"></script>
	<script type="text/javascript">
		//("#date").click
		$(function(){
			var mydate = new Date();
			mydate.setTime(mydate.getTime());
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
			var today = null;
			$("#date").val(datestr);
			$("#date").calendar({
				onChange: function (p, values, displayValues) {
					console.log(values, displayValues);
				}
			});
			$("#date").val("请选择日期");
			var color ="#FFFFCC";
			$.ajax({
				url: "<%=basePath%>platformpage/loadDictionarise",
				type: "POST",
				data: {
				},
				success: function(data){
					console.log(data);
					//alert(data.listggwp);
					$("#ggwp").select({
						title: "选择跟柜物品",
						items: data.listggwp,
						onClose: function() {//选中触发事件
							if($("#ggwp").val() != ""){
								$("#cggwp").css("background-color",color);
							}
						}
					});
					$("#wl").select({
						title: "选择物流",
						items: data.listwl,
						onClose: function() {//选中触发事件
							//alert("11");
							if($("#wl").val() != ""){
								$("#cwl").css("background-color",color);
							}
						}
					});
					$("#khyh").select({
						title: "选择客户验货",
						items: data.listkhyh,
						onClose: function() {//选中触发事件
							//alert("11");
							if($("#khyh").val() != ""){
								$("#ckhyh").css("background-color",color);
							}
						}
					});
					$("#pm").select({
						title: "选择喷码",
						items: data.listpm,
						onClose: function() {//选中触发事件
							//alert("11");
							if($("#pm").val() != ""){
								$("#cpm").css("background-color",color);
							}
						}
					});
					$("#bsyq").select({
						title: "选择标识要求",
						items: data.listbsyq,
						onClose: function() {//选中触发事件
							//alert("11");
							if($("#bsyq").val() != ""){
								$("#cbsyq").css("background-color",color);
							}
						}
					});
					$("#js").select({
						title: "选择胶水",
						items: data.listjs,
						onClose: function() {//选中触发事件
							//alert("11");
							if($("#js").val() != ""){
								$("#cjs").css("background-color",color);
							}
						}
					});
					$("#jmp").select({
						title: "选择镜面抛",
						items: data.listjmp,
						onClose: function() {//选中触发事件
							//alert("11");
							if($("#jmp").val() != ""){
								$("#cjmp").css("background-color",color);
							}
						}
					});
					$("#bz").select({
						title: "选择包装",
						items: data.listbz,
						onClose: function() {//选中触发事件
							if($("#bz").val() != ""){
								$("#cbz").css("background-color",color);
							}
						}
					});
				},
				error: function(){
					alert("失败，请稍后重试！！");
				},
			});
		})


		/*;
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
				});*/
	</script>


</body>
</html>