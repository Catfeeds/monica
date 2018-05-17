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
<link rel="stylesheet" href="static/css/form.css" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<!-- <link href="static/css/indent.css" rel="stylesheet" type="text/css"> -->
<!-- <link rel="stylesheet" type="text/css" href="static/css/ui.css" /> -->
<link href="static/css/indent.css" rel="stylesheet" type="text/css">
<link href="iTunesArtwork@2x.png" sizes="114x114" rel="apple-touch-icon-precomposed">
<!-- jsp文件头和头部 -->
<%-- <%@ include file="../../system/index/top.jsp"%> --%>
<script type="text/javascript"> 
        !function(J){function H(){var d=E.getBoundingClientRect().width;var e=(d/7.5>100*B?100*B:(d/7.5<42?42:d/7.5));E.style.fontSize=e+"px",J.rem=e}var G,F=J.document,E=F.documentElement,D=F.querySelector('meta[name="viewport"]'),B=0,A=0;if(D){var y=D.getAttribute("content").match(/initial\-scale=([\d\.]+)/);y&&(A=parseFloat(y[1]),B=parseInt(1/A))}if(!B&&!A){var u=(J.navigator.appVersion.match(/android/gi),J.navigator.appVersion.match(/iphone/gi)),t=J.devicePixelRatio;B=u?t>=3&&(!B||B>=3)?3:t>=2&&(!B||B>=2)?2:1:1,A=1/B}if(E.setAttribute("data-dpr",B),!D){if(D=F.createElement("meta"),D.setAttribute("name","viewport"),D.setAttribute("content","initial-scale="+A+", maximum-scale="+A+", minimum-scale="+A+", user-scalable=no"),E.firstElementChild){E.firstElementChild.appendChild(D)}else{var s=F.createElement("div");s.appendChild(D),F.write(s.innerHTML)}}J.addEventListener("resize",function(){clearTimeout(G),G=setTimeout(H,300)},!1),J.addEventListener("pageshow",function(b){b.persisted&&(clearTimeout(G),G=setTimeout(H,300))},!1),H()}(window);
        if (typeof(M) == 'undefined' || !M){
            window.M = {};
        }
     </script>   
</head>
<body class="no-skin">

							<!-- -------------------------------------------- -->
					<div class="header">
								请输入详细客户信息
								<div class="header_left" onclick="window.history.go(-1)">
									<img src="static/images/store/return.png">
								</div>
							</div>		
		<ul class="information">
			<h2>基本信息</h2>
			<li>
				<label>客&nbsp;户&nbsp;姓&nbsp;名：</label>
				<input class="infor-input" placeholder=""  type="text"  maxlength="100" name="" />
			</li>
			<li>
				<label>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 别：</label>
				<select class="infor-input">
					<option>男</option>
					<option>女</option>
					
				</select>
			</li>
			<li>
				<label>手&nbsp;机&nbsp;号&nbsp;码：</label>
				<input class="infor-input" placeholder="" type="number"  maxlength="100" name="" />
			</li>
			<li>
				<label>联&nbsp;系&nbsp;地&nbsp;址：</label>
				<input class="infor-input btn" placeholder="" type="text" maxlength="100" name="" />
			    <div id='result' ></div>
			</li>
			<li>
				<label>详&nbsp;细&nbsp;地&nbsp;址：</label>
				<input class="infor-input" placeholder="" type="text" maxlength="100" name="" />
			</li>
			<li>
				<label>微&nbsp;&nbsp;信&nbsp;&nbsp;号：</label>
				
				<input class="infor-input" placeholder="" type="text" maxlength="100" name="" />
			</li>
			<li>
				<label>信&nbsp;息&nbsp;来&nbsp;源：</label>
				<select class="infor-input">
					<option>微信号管理</option>
					<option>网络搜索</option>
					<option>朋友介绍</option>
					<option>路过</option>
					<option>其他</option>
				</select>
			</li>
			<li>
				<label>客&nbsp;户&nbsp;类&nbsp;型：</label>
				<select class="infor-input">
					<option>线索客户</option>
					<option>意向客户</option>
				</select>
			</li>
		</ul>
		
		
		<div class="ture">注：请核实信息再保存</div>
		<a class="submit-btn">提交</a>


							<!-- -------------------------------------------- -->


	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%-- <%@ include file="../../system/index/foot.jsp"%> --%>
	<!-- ace scripts -->
	<!-- <script src="static/ace/js/ace/ace.js"></script> -->
	<script type="text/javascript">
		//$(top.hangge());
	</script>


</body>
</html>