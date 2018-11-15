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
	<title>条码追溯</title>
	<base href="<%=basePath%>">
	<link href="static/css/indent.css" rel="stylesheet" type="text/css">
	<link href="static/css/search1.css" rel="stylesheet" type="text/css">
	<link href="static/css/base.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="static/ace/css/bootstrap.css" />
	<link href="static/css/main_style.css" rel="stylesheet" type="text/css">
	<script src="static/js/store/jquery-2.1.4.js"></script>
	<script src="static/js/xback.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<meta name="format-detection" content="telephone=no" />
	<style>
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

		.btn1 {
			/*  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.55); */
			touch-action: manipulation;
			border: 1px solid transparent;
			padding: 6px 12px;
			font-size: 14px;
			line-height: 1.42857143;
			border-radius:0 5px 5px 0;
		}

		.btnQRcode {
			/*  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.55); */
			touch-action: manipulation;
			border: 1px solid transparent;
			padding: 6px 12px;
			font-size: 14px;
			line-height: 1.42857143;
			border-radius:5px 0px 0px 5px;
		}
		table {
			border-collapse: collapse;
			font-family: Futura, Arial, sans-serif;
		}
		caption {
			font-size: larger;
			margin: 1em auto;
		}
		th,td {
			padding: .65em;
		}
		th {
			background: #555;
			/*border: 1px solid #777;*/
			color: #fff;
		}
		td {
			/*background: #555;*/
			border: 1px solid #777;
		}
		tbody tr:nth-child(odd) {
			background: #ccc;
		}
		th:first-child {
			border-radius: 6px 0 0 0;
		}
		th:last-child {
			border-radius: 0 6px 0 0;
		}
		tr:last-child th:first-child {
			border-radius: 0 0 0 6px;
			background: #555;
		}
		tr:last-child th:last-child {
			border-radius: 0 0 6px 0;
			background: #555;
		}
	</style>
	<!-- jsp文件头和头部 -->

</head>
<body class="no-skin" id="body">
	<form action="platformQY/to_receive_order" method="post" name="Form" id="Form">
		<!-- -------------------------------------------- -->
		<!--header顶部标题-->
		<div class="header">
			条码追溯
			<div class="header_left" onclick="back()">
				<img src="static/images/store/return.png">
			</div>
		</div>

		<div style="width: 80%;margin-left:10%;  margin-top: 6px">
			<div class="input-group">
				<span class="input-group-btn">
						<button class="btnQRcode" type="button" onclick="tosearch()">
							<img style="width: 20px;height: 20px" src="static/images/platformQY/qr_code.png">
						</button>
				</span>
				<input name="keywords" type="text" class="form-control"
					   placeholder="输入搜索内容..." value="${pd.keywords }">
					<span class="input-group-btn">
						<button class="btn1" type="button" onclick="tosearch()">
							<img style="width: 20px;height: 20px" src="static/images/platformQY/search.png">
						</button>
					</span>
			</div>
		</div>
	</form>
	<div style="padding: 12px;font-size: 12px">
		<table cellspacing="0" cellpadding="0">
			<tr>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
			</tr>
			<tr>
				<td colspan="2" rowspan="4">图片</td>
				<td style="text-align: center" >二维码：</td>
				<td style="text-align: center" colspan="2">test二维码</td>
			</tr>
			<tr>
				<td style="text-align: center">商品编码：</td>
				<td style="text-align: center" colspan="2">test编码</td>
			</tr>
			<tr>
				<td style="text-align: center">商品名称：</td>
				<td style="text-align: center" colspan="2">test名称</td>
			</tr>
			<tr>
				<td style="text-align: center">规格型号：</td>
				<td style="text-align: center" colspan="2">test规格型号</td>
			</tr>
			<%--<tr style="height: 3px">
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
			</tr>--%>
		</table>

		<table style="margin-top: 3%">
			<%--<tr>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
			</tr>--%>
			<tr style="margin-top: 3px">
				<td style="text-align: center">批号：</td>
				<td style="text-align: center" colspan="2">test批号</td>
				<td style="text-align: center">色号：</td>
				<td style="text-align: center" colspan="2">test色号</td>
			</tr>
			<tr>
				<td style="text-align: center">生产日期：</td>
				<td style="text-align: center" colspan="2">test生产日期</td>
				<td style="text-align: center">等级：</td>
				<td style="text-align: center" colspan="2">test等级</td>
			</tr>
			<tr>
				<td style="text-align: center">生产设备：</td>
				<td style="text-align: center" colspan="2">test生产设备</td>
				<td style="text-align: center">检查员：</td>
				<td style="text-align: center" colspan="2">test检查员</td>
			</tr>
			<tr>
				<td style="text-align: center">库存状态：</td>
				<td style="text-align: center" colspan="5">test库存状态</td>
			</tr>
			<tr>
				<td style="text-align: center">Data</td>
				<td style="text-align: center" colspan="2">Data</td>
				<td style="text-align: center">Data</td>
				<td style="text-align: center" colspan="2">Data</td>
			</tr>
			<tr>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
				<th style="width: 17%"></th>
			</tr>
		</table>
	</div>
<script type="text/javascript">

</script>


</body>
</html>