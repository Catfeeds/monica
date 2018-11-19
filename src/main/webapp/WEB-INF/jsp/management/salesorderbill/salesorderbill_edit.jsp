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
						<input type="hidden" id="SALESORDERBILL_ID" name="SALESORDERBILL_ID" value="${pd.SALESORDERBILL_ID}"/>
						<input type="hidden" id="FCLIENTID" name="FCLIENTID" value="${pd.FCLIENTID}"/>
						<input type="hidden" id="FSALESID" name="FSALESID" value="${pd.FSALESID}"/>
						<input type="hidden" id="FORDERPERSON" name="FORDERPERSON" value="${pd.FORDERPERSON}"/>
						<div id="zhongxin" style="padding-top: 13px;">
							<table style="border-collapse:separate; border-spacing:10px;width: 100%;padding-left: 1%">
								<tbody>
								<tr>
									<td style="width:6%;text-align: right;">
										<label>订单编号<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input id="FORDERNUM" name="FORDERNUM" type="text" value="${pd.FORDERNUM}" readonly style="width: 100%;" class="input-text">
									</td>

									<td style="width:6%;text-align: right;">
										<label>客户名称<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input id="FCLIENTNAME" value="${pd.FCLIENTNAME}" type="text" onclick="toClient()" style="width: 100%;cursor: pointer;
													background: url(static/images/search.png) no-repeat;background-size: 20px 20px;
													background-position:right;background-color: #FFFFFF;" class="input-text">
									</td>

									<td style="width:6%;text-align: right;">
										<label>订单日期<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input id="FORDERDATE" name="FORDERDATE" type="date" value="${pd.FORDERDATE}" style="width: 100%;" class="input-text">
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>订单类型<span style="color:red;">*</span>:</label>
									</td>
									<td>
										<select id="FORDERTYPE" name="FORDERTYPE" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FORDERTYPEID}">${pd.FORDERTYPENAME}</option>
											<c:forEach items="${orderTypeList}" var="var" varStatus="vs">
												<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</td>

									<td style="width:6%;text-align: right;">
										<label>业务代表<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input id="FSALESNAME" type="text" onclick="toSales()" style="width: 100%;cursor: pointer;
													background: url(static/images/search.png) no-repeat;background-size: 20px 20px;
													background-position:right;background-color: #FFFFFF;" class="input-text">
									</td>

									<td style="width:6%;text-align: right;">
										<label>提货日期<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input id="FDELIVERYDATE" name="FDELIVERYDATE" value="${pd.FDELIVERYDATE}" type="date" style="width: 100%;" class="input-text">
									</td>
								</tr>
								<tr>
									<td style="width:6%;text-align: right;">
										<label>订单金额<span style="color: red;">*</span>:</label>
									</td>
									<td>
										<input id="FORDERAMOUNT" name="FORDERAMOUNT" value="${pd.FORDERAMOUNT}" type="number" min="0" step="0.01" style="width: 100%;" class="input-text">
									</td>

									<td style="width:6%;text-align: right;">
										<label>订单备注:</label>
									</td>
									<td colspan="3">
										<textarea id="FNOTE" name="FNOTE" style="width: 100%;resize: none;" class="input-text" type="text">${pd.FNOTE}</textarea>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>包装:</label>
									</td>
									<td>
										<select id="FPACK" name="FPACK" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FPACKID}">${pd.FPACKNAME}</option>
												<c:forEach items="${packList}" varStatus="vs" var="var">
													<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
												</c:forEach>
										</select>
									</td>

									<td style="width:6%;text-align: right;">
										<label>喷码:</label>
									</td>
									<td>
										<select id="FCODESPURTING" name="FCODESPURTING" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FCODESPURTINGID}">${pd.FCODESPURTINGNAME}</option>
											<c:forEach items="${codeSpurtingList}" varStatus="vs" var="var">
												<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</td>

									<td rowspan="2" style="width:6%;text-align: center;">
										<label>其它特殊要求:</label>
									</td>
									<td rowspan="2">
										<textarea id="FSPECIALREQUIREMENTS" name="FSPECIALREQUIREMENTS" style="width: 100%;height:100%;resize: none;" class="input-text" type="text">${pd.FSPECIALREQUIREMENTS}</textarea>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>镜面抛:</label>
									</td>
									<td>
										<select id="FMIRRORBEHIND" name="FMIRRORBEHIND" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FMIRRORBEHINDID}">${pd.FMIRRORBEHINDNAME}</option>
											<c:forEach items="${mirrorbehindList}" varStatus="vs" var="var">
												<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</td>

									<td style="width:6%;text-align: right;">
										<label>客户验货:</label>
									</td>
									<td>
										<select id="FCLIENTINSPECTION" name="FCLIENTINSPECTION" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FCLIENTINSPECTIONID}">${pd.FCLIENTINSPECTIONNAME}</option>
											<c:forEach items="${customerinspectionList}" varStatus="vs" var="var">
												<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>胶水:</label>
									</td>
									<td>
										<select id="FGLUE" name="FGLUE" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FGLUEID}">${pd.FGLUENAME}</option>
											<c:forEach items="${glueList}" varStatus="vs" var="var">
												<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</td>

									<td style="width:6%;text-align: right;">
										<label>跟柜物品:</label>
									</td>
									<td>
										<select id="FARTICLE" name="FARTICLE" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FARTICLEID}">${pd.FARTICLENAME}</option>
											<c:forEach items="${articleList}" varStatus="vs" var="var">
												<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</td>

									<td rowspan="2" style="width:6%;text-align: center;">
										<label>付款计划:</label>
									</td>
									<td rowspan="2">
										<textarea id="FPAYMENTSCHEDULE" name="FPAYMENTSCHEDULE" style="width: 100%;height:100%;resize: none;" class="input-text" type="text">${pd.FPAYMENTSCHEDULE}</textarea>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>标识要求:</label>
									</td>
									<td>
										<select id="FIDENTIFICATIONREQUIREMENTS" name="FIDENTIFICATIONREQUIREMENTS" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FIDENTIFICATIONREQUIREMENTSID}">${pd.FIDENTIFICATIONREQUIREMENTSNAME}</option>
											<c:forEach items="${identificationrequirementsList}" varStatus="vs" var="var">
												<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</td>

									<td style="width:6%;text-align: right;">
										<label>物流:</label>
									</td>
									<td>
										<select id="FLOGISTICS" name="FLOGISTICS" class="input-text"
												style="vertical-align:top;width: 100%;">
											<option value="${pd.FLOGISTICSID}">${pd.FLOGISTICSNAME}</option>
											<c:forEach items="${logisticsList}" varStatus="vs" var="var">
												<option value="${var.DICTIONARIES_ID}">${var.FNAME}</option>
											</c:forEach>
										</select>
									</td>
								</tr>

								<tr>
									<td style="width:6%;text-align: right;">
										<label>制单人:</label>
									</td>
									<td>
										<input id="FORDERPERSONNAME" type="text" readonly style="width: 100%;" class="input-text" >
									</td>

									<td style="width:6%;text-align: right;">
										<label>制单日期:</label>
									</td>
									<td>
										<input id="FORDERTIME" name="FORDERTIME" value="${pd.FORDERTIME}" type="text" readonly style="width: 100%;" class="input-text"/>
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

	<c:if test="${msg == 'edit'}">
		<a style="margin-top: 10px;" onclick="approve('您确定审批该订单吗?')" class="btn btn-light btn-xs">
			<i class="ace-icon glyphicon glyphicon-ok bigger-110 nav-search-icon green"></i>审批
		</a>
	</c:if>

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
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
		<script type="text/javascript">
		$(top.hangge());
		//保存
		function save(){
            if($("#FCLIENTID").val()==""){
                $("#FCLIENTNAME").tips({
                    side:3,
                    msg:'请选择客户',
                    bg:'#AE81FF',
                    time:2
                });
                $("#FCLIENTNAME").focus();
                return false;
            }

            if($("#FORDERDATE").val()==""){
                $("#FORDERDATE").tips({
                    side:3,
                    msg:'请选择订单日期',
                    bg:'#AE81FF',
                    time:2
                });
                $("#FORDERDATE").focus();
                return false;
            }

            if($("#FORDERTYPE").val()==""){
                $("#FORDERTYPE").tips({
                    side:3,
                    msg:'请选择订单类型',
                    bg:'#AE81FF',
                    time:2
                });
                $("#FORDERTYPE").focus();
                return false;
            }

            /*if($("#FSALESID").val()==""){
                $("#FSALESNAME").tips({
                    side:3,
                    msg:'请选择业务员',
                    bg:'#AE81FF',
                    time:2
                });
                $("#FSALESNAME").focus();
                return false;
            }*/

            if($("#FDELIVERYDATE").val()==""){
                $("#FDELIVERYDATE").tips({
                    side:3,
                    msg:'请选择提货日期',
                    bg:'#AE81FF',
                    time:2
                });
                $("#FDELIVERYDATE").focus();
                return false;
            }

            if($("#FORDERAMOUNT").val()==""){
                $("#FORDERAMOUNT").tips({
                    side:3,
                    msg:'请输入订单金额',
                    bg:'#AE81FF',
                    time:2
                });
                $("#FORDERAMOUNT").focus();
                return false;
            }
			$("#Form").submit();
			$("#zhongxin").hide();
			$("#zhongxin2").show();
		}
		
		$(function() {
            week_init();
            if(${msg == 'save'}){
                if($("#FORDERTIME").val() == null || $("#FORDERTIME").val() == ""){
                    var myDate = new Date();
                    var year = myDate.getFullYear();
                    var month = myDate.getMonth()+1;
                    month = month < 10 ? '0' + month : month
                    var day = myDate.getDate();
                    day = day < 10 ? ('0' + day) : day;
                    var hour = myDate.getHours() < 10 ? "0" + myDate.getHours() : myDate.getHours();
                    var minute = myDate.getMinutes() < 10 ? "0" + myDate.getMinutes() : myDate.getMinutes();
                    var second = myDate.getSeconds() < 10 ? "0" + myDate.getSeconds() : myDate.getSeconds();
                    $("#FORDERTIME").val(year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second);
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

        function toClient(){
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="选择客户";
            diag.URL = '<%=basePath%>client/listTree_select.do';
            diag.Width = window.innerWidth * 1.2;
            diag.Height = window.innerHeight * 1.2;
            diag.Modal = true;				//有无遮罩窗口
            diag.CancelEvent = function(){ //关闭事件
                var iframe = diag.innerFrame.contentWindow.document.getElementById('treeFrame').contentWindow;
                var msg = iframe.document.getElementById('msg').value;
                var CLIENT_ID = iframe.document.getElementById('CLIENT_ID').value;
                if(msg == "save"){
                    $("#FCLIENTID").val(CLIENT_ID);
                    $.ajax({
                        async: false,
                        cache: false,
                        type: 'POST',
                        data : {
                            CLIENT_ID : CLIENT_ID
                        },
                        url: '<%=basePath%>client/findClientByID',
                        success: function (data) {
                            var pd = data.pd;
                            $("#FCLIENTNAME").val(pd.FNAME);
                        },
                        error: function () {
                            alert("请求失败");
                        }
                    });
                }
                diag.close();
            };
            diag.show();
		}

        function approve(msg){
            bootbox.confirm(msg, function(result) {
                if(result) {
                    var Id = $("#SALESORDERBILL_ID").val();
					$.ajax({
						async:false,
						cache:false,
						url:'<%=basePath%>salesorderbill/approve.do',
						type:'POST',
						data:{
							SALESORDERBILL_ID:Id
						},
						datatype:'JSON',
						success:function (obj) {
							if(obj.msg == '1'){
								bootbox.alert({
									size: "small",
									title: "成功",
									message: "该订单已成功审批!"

								});
                                return false;
							} else {
								bootbox.alert({
									size: "small",
									title:"失败",
									message: "该订单已通过审批,无法重复操作!"
								});
								return false;
							}
						}
					});
                }
            });
        }
		</script>
</body>
</html>