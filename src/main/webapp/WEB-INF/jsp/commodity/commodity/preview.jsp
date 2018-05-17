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

<!-- jsp文件头和头部 -->
<link rel="stylesheet" href="static/css/zyupload-1.0.0.css "
	type="text/css">
<link rel="stylesheet" type="text/css"
	href="plugins/webuploader/webuploader.css" />
<link rel="stylesheet" type="text/css"
	href="plugins/webuploader/style.css" />
<link rel="stylesheet" href="static/ace/css/bootstrap.min.css" />
<link href="static/css/fileinput.css" media="all" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>
<script src="static/js/fileinput.js" type="text/javascript"></script>
<script src="static/js/fileinput_locale_de.js" type="text/javascript"></script>

<%@ include file="../../system/index/top.jsp"%>
<!-- <script src="static/js/zDialog/zDialog.js" type="text/javascript"></script>
<script src="static/js/zDialog/zDrag.js" type="text/javascript"></script> -->
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
							<!-- =========================================================================== -->
							<c:choose>
								<c:when test="${pd1 == null}">
									<div class="center">
										<td colspan="100" class="center">没有主图片</td>
									</div>
								</c:when>
								<c:otherwise>
									<div class="form-group" style="width: 750px;height: 500px">
										<img style="width: 95%;height: 95%"
											src="${pic_qzurl}${pd1.PIC_URL}" />
									</div>
								</c:otherwise>
							</c:choose>
							<!-- =========================================================================== -->
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

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>

	<script type="text/javascript">
		$(top.hangge());
		
	</script>


</body>
</html>