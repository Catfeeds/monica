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
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%>
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
<link rel="stylesheet" href="static/css/fo.css" />
<link rel="stylesheet" href="static/cehua/css/style.css"> <!-- Resource style -->
<script src="static/cehua/js/modernizr.js"></script> <!-- Modernizr -->
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
						<!-- 检索  -->
						<form action="salesorderbill/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<a style="margin-left: 3px" class="btn btn-light btn-mini" data-rel="tooltip" title="同步">
									<i class="ace-icon glyphicon glyphicon-retweet bigger-110 nav-search-icon blue"></i>同步
								</a>
								<c:if test="${QX.add == 1 }">
									<a style="margin-left: 3px" class="btn btn-light btn-mini" onclick="add();">
										<i class="ace-icon fa fa-pencil-square-o bigger-110 nav-search-icon yellow"></i>新增
									</a>
								</c:if>
								<a style="margin-left: 3px" class="btn btn-light btn-mini" onclick="edit();"  data-rel="tooltip" title="修改">
									<i class="ace-icon fa fa-cogs bigger-110 nav-search-icon green"></i>修改
								</a>
								<a style="margin-left: 3px" class="btn btn-light btn-mini" data-rel="tooltip" title="变更">
									<i class="ace-icon glyphicon glyphicon-edit bigger-110 nav-search-icon blue"></i>变更
								</a>
								<c:if test="${QX.del == 1 }">
									<a style="margin-left: 3px" class="btn btn-light btn-mini" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120 nav-search-icon red'></i>删除</a>
								</c:if>
									<a style="margin-left: 3px" class="btn btn-light btn-mini" data-rel="tooltip" title="审批">
										<i class="ace-icon glyphicon glyphicon-ok bigger-110 nav-search-icon green"></i>审批
									</a>
								<c:if test="${QX.toExcel == 1 }"><a style="margin-left: 3px" class="btn btn-light btn-mini" onclick="toExcel();" title="导出到EXCEL"><i id="nav-search-icon" class="ace-icon fa fa-download bigger-110 nav-search-icon blue"></i>导出到EXCEL</a></c:if>
								<label style="float: right;margin-top: 5px;margin-right: 15px">
									<input id="isDetail" <c:if test="${pd.isDetail == 'true'}">checked</c:if>
										   name="isDetail" class="ace ace-switch ace-switch-5" type="checkbox">
									<span class="lbl"></span>
								</label>
							</tr>

							<tr>
								<td>
									<div class="nav-search">
										客户:<span class="input-icon">
												<input type="text" placeholder="这里输入关键词" class="nav-search-input"
													   autocomplete="off" name="FNAME" id="FNAME" value="${pd.FNAME }" placeholder="这里输入关键词"/>
												<i class="ace-icon fa fa-search nav-search-icon"></i>
											</span>

										销售员:<span class="input-icon">
										<input type="text" placeholder="这里输入关键词" class="nav-search-input"
											   autocomplete="off" name="salesName" id="salesName" value="${pd.salesName }" placeholder="这里输入关键词"/>
										<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>

										订单编号:<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" class="nav-search-input"
												   autocomplete="off" name="FMOBILE" id="FMOBILE" value="${pd.FMOBILE }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
											</span>

										状态:<span class="input-icon">
											<select style="width: 90px;" name="FSTATUSID" id="FSTATUSID" data-placeholder="" class="nav-search-input"
													style="vertical-align:top;width: 150px;">
												<option value="${pd.FSTATUSID}" name="${pd.FSTATUSID}">${pd.GNAME}</option>
												<c:forEach items="${listDicsSta}" var="var" varStatus="vs">
													<option value="${var.DICTIONARIES_ID}" name="${var.NAME}">${var.NAME}</option>
												</c:forEach>
											</select>
										  </span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px;">
									<div style="margin-top: 1px;"><a id="globelSearch" class="btn btn-light btn-mini" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>查询</a></div></td>
								<td style="vertical-align:top;padding-left:2px;margin-top: 2px;">
									<div style="margin-top: 1px;"><a class="btn btn-light btn-mini" onclick="reset();"  title="重置"><i id="nav-search-icon" class="ace-icon glyphicon glyphicon-repeat bigger-110 nav-search-icon blue"></i>重置</a></div></td>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">客户</th>
									<th class="center">订单编号</th>
									<th class="center">订单日期</th>
									<th class="center">业务员</th>
									<th class="center">订单类型</th>
									<th class="center">状态</th>
									<th class="center">同步状态</th>
									<th class="center">版本</th>
									<th class="center">备注</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr id="tr${var.SALESORDERBILL_ID}" name="listBeen" onclick="toCheck('${var.SALESORDERBILL_ID}')" ondblclick="editByID('${var.SALESORDERBILL_ID}')" style="cursor: pointer;">
											<td class='center'>
												<label class="pos-rel"><input id="${var.SALESORDERBILL_ID}" type='checkbox' name='ids' value="${var.SALESORDERBILL_ID}" class="ace" /><span class="lbl"></span></label>
											</td>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class='center'>${var.FCUSTOMERNAME}</td>
											<td class='center'>${var.FORDERNUM}</td>
											<td class='center'>${var.FORDERDATE}</td>
											<td class='center'>${var.FSALESNAME}</td>
											<td class='center'>${var.FORDERTYPENAME}</td>
											<td class='center'>
												<c:if test="${var.FORDERSTATUS == 0}">
													草稿
												</c:if>

												<c:if test="${var.FORDERSTATUS == 1}">
													审核
												</c:if>
											</td>
											<td class='center'>
												<c:if test="${var.FISSYNCHRONIZATION == 0}">
													未同步
												</c:if>

												<c:if test="${var.FISSYNCHRONIZATION == 1}">
													已同步
												</c:if>
											</td>
											<td class='center'>${var.FVERSIONS}</td>
											<td class='center'>${var.FNOTE}</td>
										</tr>
									
									</c:forEach>
									</c:if>
									<c:if test="${QX.cha == 0 }">
										<tr>
											<td colspan="100" class="center">您无权查看</td>
										</tr>
									</c:if>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
							</tr>
						</table>
						</div>
						</form>
					
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>
	</div>

	<nav class="cd-nav-container" id="cd-nav">
		<div style="margin-bottom: 0px;/*height: 30%*/" class="weeks">
			<ul style="margin-left: 0px;margin-bottom: 0px" class="weekItem" id="weektab">
				<a onclick="back();" style="position:absolute;right: 0px" class="cd-close-nav"></a>
			</ul>
			<div class="box01_c" id="lxr">
				<table id="talxr" class="table table-striped table-bordered table-hover"
					   style="margin-top:5px;">
					<tr>
						<th style="width: 50px;" class="center">序号</th>
						<th class="center">商品编码</th>
						<th class="center">商品名称</th>
						<th class="center">规格型号</th>
						<th class="center">单位</th>
						<th class="center">订单数量</th>
						<th class="center">单价</th>
						<th class="center">金额</th>
						<th class="center">要求到货日</th>
						<th class="center">备注</th>
					</tr>
					<tr id="trlxr">
					</tr>
				</table>
			</div>
		</div>
	</nav>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}

        $(function() {
            week_init();
            //alert($(window).height());
            $("body").height($(window).height());
            //日期框
            $('.date-picker').datepicker({
                autoclose: true,
                todayHighlight: true
            });

            //下拉框
            if(!ace.vars['touch']) {
                $('.chosen-select').chosen({allow_single_deselect:true});
                $(window)
                    .off('resize.chosen')
                    .on('resize.chosen', function() {
                        $('.chosen-select').each(function() {
                            var $this = $(this);
                            $this.next().css({'width': $this.parent().width()});
                        });
                    }).trigger('resize.chosen');
                $(document).on('settings.ace.chosen', function(e, event_name, event_val) {
                    if(event_name != 'sidebar_collapsed') return;
                    $('.chosen-select').each(function() {
                        var $this = $(this);
                        $this.next().css({'width': $this.parent().width()});
                    });
                });
                $('#chosen-multiple-style .btn').on('click', function(e){
                    var target = $(this).find('input[type=radio]');
                    var which = parseInt(target.val());
                    if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
                    else $('#form-field-select-4').removeClass('tag-input-style');
                });
            }


            //复选框全选控制
            var active_class = 'active';
            $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
                var th_checked = this.checked;//checkbox inside "TH" table header
                $(this).closest('table').find('tbody > tr').each(function(){
                    var row = this;
                    if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                    else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
                });
            });
        });
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>salesorderbill/goAdd.do';
             diag.Width = window.innerWidth;
             diag.Height = window.innerHeight;
			 diag.Modal = true;				//有无遮罩窗口
			 diag.CancelEvent = function(){ //关闭事件
				 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
					 if('${page.currentPage}' == '0'){
						 tosearch();
					 }else{
						 tosearch();
					 }
				}
				diag.close();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>salesorderbill/delete.do?SALESORDERBILL_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						tosearch();
					});
				}
			});
		}
		
		//修改
		function edit(){
			var str = [];
				for(var i=0;i < document.getElementsByName('ids').length;i++){
				  if(document.getElementsByName('ids')[i].checked){
				  	str.push(document.getElementsByName('ids')[i].value);
				  }
				}
				if(str.length < 1){
                    bootbox.dialog({
                        message: "<span class='bigger-110'>您没有选择任何内容!</span>",
                        buttons:
                            { "button":{ "label":"确定", "className":"btn-sm btn-success"}}
                    });
                    return false;
				}else if(str.length > 1){
                    bootbox.dialog({
                        message: "<span class='bigger-110'>您的选择内容必须要单项!</span>",
                        buttons:
                            { "button":{ "label":"确定", "className":"btn-sm btn-success"}}
                    });
                    return false;
				}else{
					var Id = str[0];
					 top.jzts();
					 var diag = new top.Dialog();
					 diag.Drag=true;
					 diag.Title ="编辑";
					 diag.URL = '<%=basePath%>salesorderbill/goEdit.do?SALESORDERBILL_ID='+Id;
                     diag.Width = window.innerWidth;
                     diag.Height = window.innerHeight;
					 diag.Modal = true;				//有无遮罩窗口
					 diag.CancelEvent = function(){ //关闭事件
						 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
							 tosearch();
						}
						diag.close();
					 };
					 diag.show();
				}
		}
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++){
					  if(document.getElementsByName('ids')[i].checked){
					  	if(str=='') str += document.getElementsByName('ids')[i].value;
					  	else str += ',' + document.getElementsByName('ids')[i].value;
					  }
					}
					if(str==''){
						bootbox.dialog({
							message: "<span class='bigger-110'>您没有选择任何内容!</span>",
							buttons: 			
							{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
						});
						$("#zcheckbox").tips({
							side:1,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>salesorderbill/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											tosearch();
									 });
								}
							});
						}
					}
				}
			});
		};
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>salesorderbill/excel.do';
		}

        function toCheck(Id){
            $("#simple-table").find("tr[name='listBeen']").css("background-color", "");
            $("#tr" + Id).css("background-color", "#CCCC99");
            if($("#"+Id).prop("checked")){
                $("#"+Id).removeAttr("checked");
            }else {
                $("#"+Id).prop("checked",true);
            }

            if($("#isDetail").prop("checked")){
                back();
                setTimeout("changecss()",300);
            }

            //changecss();
        }

        function changecss(){
            $("#cd-nav").attr("class", "cd-nav-container is-visible");
        }

        function back(){
            $("#cd-nav").attr("class", "cd-nav-container");
        }

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
                $("#lxr").css("display", "");
                $("#gjjl").css("display", "none");
                $("#xsjl").css("display", "none");
                $("#tpjl").css("display", "none");
                $("#zdjl").css("display", "none");
            } else if (num == "1") {
                $("#lxr").css("display", "none");
                $("#gjjl").css("display", "");
                $("#xsjl").css("display", "none");
                $("#tpjl").css("display", "none");
                $("#zdjl").css("display", "none");
            } else if (num == "2") {
                $("#lxr").css("display", "none");
                $("#gjjl").css("display", "none");
                $("#xsjl").css("display", "");
                $("#tpjl").css("display", "none");
                $("#zdjl").css("display", "none");
            } else if (num == "3") {
                $("#lxr").css("display", "none");
                $("#gjjl").css("display", "none");
                $("#xsjl").css("display", "none");
                $("#tpjl").css("display", "");
                $("#zdjl").css("display", "none");
            } else if (num == "4") {
                $("#lxr").css("display", "none");
                $("#gjjl").css("display", "none");
                $("#xsjl").css("display", "none");
                $("#tpjl").css("display", "none");
                $("#zdjl").css("display", "");
            }
            $("#weektab li").removeClass('on').eq(num).addClass('on');
        }

        function editByID(Id) {
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="编辑";
            diag.URL = '<%=basePath%>salesorderbill/goEdit.do?SALESORDERBILL_ID='+Id;
            diag.Width = window.innerWidth;
            diag.Height = window.innerHeight;
            diag.Modal = true;				//有无遮罩窗口
            diag.CancelEvent = function(){ //关闭事件
                if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                    tosearch();
                }
                diag.close();
            };
            diag.show();
        }
	</script>


</body>
</html>