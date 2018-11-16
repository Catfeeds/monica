<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<link rel="stylesheet" href="static/css/fo.css" />
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">
					
					<form action="salesorderbill/${msg }.do" name="Form" id="Form" method="post">
						<input type="hidden" name="SALESORDERBILL_ID" id="SALESORDERBILL_ID" value="${pd.SALESORDERBILL_ID}"/>
						<div id="zhongxin" style="padding-top: 13px;">
						<%--<table id="table_report" class="table table-striped table-bordered table-hover">
						</table>--%>
							<table style="border-collapse:separate; border-spacing:10px;width: 100%;padding-left: 1%">
								<tbody>
								<tr>
									<td style="width:6%;text-align: right;">
										<label>订单编号<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input type="text" readonly style="width: 100%;" class="input-text" >
									</td>

									<td style="width:6%;text-align: right;">
										<label>客户名称<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input type="text" onclick="toCus()" style="width: 100%;cursor: pointer;
													background: url(static/images/search.png) no-repeat;background-size: 20px 20px;
													background-position:right;background-color: #FFFFFF;" class="input-text">
									</td>

									<td style="width:6%;text-align: right;">
										<label>订单日期<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input type="date" style="width: 100%;" class="input-text">
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>订单类型<span style="color:red;">*</span>:</label>
									</td>
									<td>
										<select class="input-text"
												style="vertical-align:top;width: 100%;">
											<option></option>
										</select>
									</td>

									<td style="width:6%;text-align: right;">
										<label>业务代表<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input type="text" onclick="toSales()" style="width: 100%;cursor: pointer;
													background: url(static/images/search.png) no-repeat;background-size: 20px 20px;
													background-position:right;background-color: #FFFFFF;" class="input-text">
									</td>

									<td style="width:6%;text-align: right;">
										<label>提货日期<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input type="date" style="width: 100%;" class="input-text">
									</td>
								</tr>
								<tr>
									<td style="width:6%;text-align: right;">
										<label>客户信用<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input type="date" style="width: 100%;" class="input-text">
									</td>

									<td style="width:6%;text-align: right;">
										<label>订单备注:</label>
									</td>
									<td colspan="3">
										<textarea style="width: 100%;resize: none;" class="input-text" type="text"></textarea>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>包装:</label>
									</td>
									<td>
										<c:if test="${msg == 'save'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
												<c:forEach items="${packList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
											</select>
										</c:if>

										<c:if test="${msg == 'edit'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
											</select>
										</c:if>
									</td>

									<td style="width:6%;text-align: right;">
										<label>喷码:</label>
									</td>
									<td>
										<c:if test="${msg == 'save'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
												<c:forEach items="${codeSpurtingList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
											</select>
										</c:if>

										<c:if test="${msg == 'edit'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
											</select>
										</c:if>
									</td>

									<td rowspan="2" style="width:6%;text-align: center;">
										<label>其它特殊要求:</label>
									</td>
									<td rowspan="2">
										<textarea style="width: 100%;height:100%;resize: none;" class="input-text" type="text"></textarea>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>镜面抛:</label>
									</td>
									<td>
										<c:if test="${msg == 'save'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
												<c:forEach items="${mirrorbehindList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
											</select>
										</c:if>

										<c:if test="${msg == 'edit'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
											</select>
										</c:if>
									</td>

									<td style="width:6%;text-align: right;">
										<label>客户验货:</label>
									</td>
									<td>
										<c:if test="${msg == 'save'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
												<c:forEach items="${customerinspectionList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
											</select>
										</c:if>

										<c:if test="${msg == 'edit'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
											</select>
										</c:if>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>胶水:</label>
									</td>
									<td>
										<c:if test="${msg == 'save'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
												<c:forEach items="${glueList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
											</select>
										</c:if>

										<c:if test="${msg == 'edit'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
											</select>
										</c:if>
									</td>

									<td style="width:6%;text-align: right;">
										<label>跟柜物品:</label>
									</td>
									<td>
										<c:if test="${msg == 'save'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
												<c:forEach items="${articleList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
											</select>
										</c:if>

										<c:if test="${msg == 'edit'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
											</select>
										</c:if>
									</td>

									<td rowspan="2" style="width:6%;text-align: center;">
										<label>付款计划:</label>
									</td>
									<td rowspan="2">
										<textarea style="width: 100%;height:100%;resize: none;" class="input-text" type="text"></textarea>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>标识要求:</label>
									</td>
									<td>
										<c:if test="${msg == 'save'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
												<c:forEach items="${identificationrequirementsList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
											</select>
										</c:if>

										<c:if test="${msg == 'edit'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
											</select>
										</c:if>
									</td>

									<td style="width:6%;text-align: right;">
										<label>物流:</label>
									</td>
									<td>
										<c:if test="${msg == 'save'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
												<c:forEach items="${logisticsList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
											</select>
										</c:if>

										<c:if test="${msg == 'edit'}">
											<select class="input-text"
													style="vertical-align:top;width: 100%;">
												<option></option>
											</select>
										</c:if>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>制单人:</label>
									</td>
									<td>
										<input type="text" readonly style="width: 100%;" class="input-text" >
									</td>

									<td style="width:6%;text-align: right;">
										<label>制单日期:</label>
									</td>
									<td>
										<input id="FDATE" type="text" readonly style="width: 100%;" class="input-text">
									</td>
								</tr>
								</tbody>
						</table>
						</div>
						<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
					</form>
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

<div style="margin-bottom: 0px" class="weeks">
	<ul style="margin-left: 0px;margin-bottom: 0px" class="weekItem" id="weektab">
		<li>订单明细</li>
		<li>变更日志</li>
	</ul>
	<div class="box01_c" id="spmx">
		<a style="margin-left: 10px" class="btn btn-success btn-xs">
			<i class="ace-icon fa glyphicon-plus bigger-110 nav-search-icon yellow"></i>新增
		</a>
		<a class="btn btn-primary  btn-xs">
			<i class="ace-icon fa fa-trash-o bigger-120 nav-search-icon "></i>删除
		</a>
		<table id="taspmx" class="table table-striped table-bordered table-hover"
			   style="margin-top:5px;">
			<tr>
				<th style="width: 35px" class="center"></th>
				<th style="width: 50px;" class="center">序号</th>
				<th class="center">产品编号</th>
				<th class="center">产品名称</th>
				<th class="center">规格型号</th>
				<th class="center">计量单位</th>
				<th class="center">数量</th>
				<th class="center">单价</th>
				<th class="center">金额</th>
				<th class="center">备注</th>
			</tr>
			<tr id="trspmx">
			</tr>
		</table>
	</div>
	<div class="box01_c" style="display: none" id="xmtd">
		<table id="taxmtd" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
			<tr>
				<th style="width: 35px" class="center"></th>
				<th style="width: 50px;" class="center">序号</th>
				<th class="center">变更日期</th>
				<th class="center">变更人</th>
				<th class="center">变更后版本</th>
				<th class="center">备注</th>
			</tr>
			<tr id="trxmtd">
			</tr>
		</table>
	</div>
</div>

<br><br>

<div style="text-align: right;height:45px;
		background: url(static/login/images/topbg.png) repeat-x; position:fixed;width: 100%;z-index:10000000;bottom: 0px;";>
	<a style="margin-top: 10px;" class="btn btn-light btn-xs">
		<i class="ace-icon glyphicon glyphicon-ok bigger-110 nav-search-icon green"></i>审核
	</a>

	<a style="margin-top: 10px;" class="btn btn-light btn-xs">
		<i class="ace-icon glyphicon glyphicon-edit bigger-110 nav-search-icon blue"></i>变更
	</a>

	<a style="margin-top: 10px;" class="btn btn-light btn-xs" onclick="save()">
		<i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon green"></i>保存
	</a>

	<a style="margin-top: 10px;margin-right: 10px;" class="btn btn-light btn-xs" onclick="top.Dialog.close();">
		<i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
	</a>
</div>


	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		/*function save(){
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}*/
		
		$(function() {
            week_init();
            if(${msg == 'save'}){
                if($("#FDATE").val() == null || $("#FDATE").val() == ""){
                    var myDate = new Date();
                    var year = myDate.getFullYear();
                    var month = myDate.getMonth()+1;
                    month = month < 10 ? '0' + month : month
                    var day = myDate.getDate();
                    day = day < 10 ? ('0' + day) : day;
                    var hour = myDate.getHours() < 10 ? "0" + myDate.getHours() : myDate.getHours();
                    var minute = myDate.getMinutes() < 10 ? "0" + myDate.getMinutes() : myDate.getMinutes();
                    var second = myDate.getSeconds() < 10 ? "0" + myDate.getSeconds() : myDate.getSeconds();
                    $("#FDATE").val(year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second);
                }
            }
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
		});

        function week_init() {
            $("#weektab li").each(function (i) {
                $(this).click(function () {
                    week_click(i);
                }).hover(function () {
                    $(this).addClass('hover');
                }, function (event) {
                    $(this).removeClass('hover');
                });
            });
            week_click('0');
            //$("#weekcon dl:last").css({"padding-bottom":"0","margin-bottom":"10px"});
        }
        function week_click(num) {
            if (num == "0") {
                $("#spmx").css("display", "");
                $("#xmtd").css("display", "none");
            } else if (num == "1") {
                $("#spmx").css("display", "none");
                $("#xmtd").css("display", "");
            }
            $("#weektab li").removeClass('on').eq(num).addClass('on');
        }
		</script>
</body>
</html>