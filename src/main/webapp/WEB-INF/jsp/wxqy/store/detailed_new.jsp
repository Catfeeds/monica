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
<!--[if lt IE 9]>
  <script src="http://cdn.static.runoob.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
  <![endif]-->
<script src="static/js/store/jquery-2.1.4.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<link href="static/css/indent_new.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="static/css/ui_new.css" />
<!-- <link href="static/css/indent.css" rel="stylesheet" type="text/css"> -->
<link href="iTunesArtwork@2x.png" sizes="114x114" rel="apple-touch-icon-precomposed">
<!-- jsp文件头和头部 -->
<%-- <%@ include file="../../system/index/top.jsp"%> --%>

</head>
<body class="no-skin">
<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">
							<!-- -------------------------------------------- -->
								<div class="">
									<div class="header">
									全文内容
										<div class="header_left" onclick="window.history.go(-1)">
											<img src="static/images/store/return.png">
										</div>
									</div>
									



								</div>
								<div  style="margin: 18px;margin-top: 65px;">
										<p style="font-size:25px">${pageData.TITLE }</p><br>
										<p style="line-height: 20px">11月17日&nbsp;&nbsp;&nbsp;${pageData.AUTHOR }</p><br>
										<div style="line-height: 30px;margin-left: 5px;margin-right: 5px">${pageData.NEW_CONTENT }</div>
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
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<script type="text/javascript">
		
	</script>


</body>
</html>