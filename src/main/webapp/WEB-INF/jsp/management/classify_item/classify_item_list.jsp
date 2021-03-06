﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
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
						<form action="classify_item/list.do" method="post" name="Form" id="Form">
							<div class="row" style="margin-top:5px;">
								<div class="col-xs-12">
									<p>
										<%--<c:if test="${QX.add == 1 }">
											<a class="btn btn-light btn-xs" onclick="add();" title="新增">
												<i id="nav-save-icon" class="ace-icon fa fa-plus bigger-120 green"></i>新增
											</a>
										</c:if>
										<c:if test="${QX.edit == 1 }">
											<a class="btn btn-light btn-xs" onclick="edit('');" data-rel="tooltip" title="修改">
												<i class="ace-icon fa fa-pencil-square-o bigger-120 orange"></i>修改
											</a>
										</c:if>
										<c:if test="${QX.del == 1 }">
											<a class="btn btn-light btn-xs" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除">
												<i class="ace-icon fa fa-trash-o bigger-125 red"></i>删除
											</a>
										</c:if>--%>

										<a class="btn btn-light btn-xs" onclick="updateItem()" title="同步">
											<i id="nav-refresh-icon" class="ace-icon fa fa-refresh bigger-120 blue"></i>同步
										</a>

										<c:if test="${QX.toExcel == 1 }">
											<a class="btn btn-light btn-xs" onclick="toExcel();" title="导出到EXCEL">
												<i id="nav-download-icon" class="ace-icon fa fa-download bigger-120 purple"></i>导出Excel
											</a>
										</c:if>
									</p>
								</div>
							</div>
						<table style="margin-top:3px;">
							<tr>
								<td>
									<div class="nav-search">
                                        商品名称：<span class="input-icon">
											    <input type="text" placeholder="按商品名称进行搜索" class="nav-search-input"
                                                       id="nav-input" autocomplete="off" name="FNAME" value="${pd.FNAME }"/>
                                                <i class="ace-icon fa fa-search nav-search-icon"></i>
                                            </span>
										<%--<span class="input-icon">
											<input type="text" placeholder="这里输入关键词" id="nav-search-input" autocomplete="off" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon blue"></i>
										</span>--%>
									</div>
								</td>
								<%--<td style="padding-left:2px;">
									<input class="span10 date-picker" name="lastStart" id="lastStart"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期"/>
								</td>
								<td style="padding-left:2px;">
									<input class="span10 date-picker" name="lastEnd" name="lastEnd"  value="" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期"/>
								</td>--%>
								<c:if test="${QX.cha == 1 }">
									<td style="vertical-align:top;padding-left:2px">
										<a class="btn btn-light btn-xs" onclick="tosearch();" id="btn_search"  title="查询">
											<i id="nav-search-icon" class="ace-icon fa fa-search bigger-120 nav-search-icon blue"></i>查询
										</a>
									</td>
									<td style="vertical-align:top;padding-left:2px">
										<a class="btn btn-light btn-xs" onclick="Form_reset()"  title="重置">
											<i id="nav-repeat-icon" class="ace-icon fa fa-repeat bigger-120"></i>重置
										</a>
									</td>
								</c:if>
							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<%--<th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th>--%>
									<th class="center" style="width:50px;">序号</th>
									<%--<th class="center">FItemID</th>--%>
									<th class="center">编号</th>
									<th class="center">名称</th>
									<%--<th class="center">父ID</th>--%>
									<%--<th class="center">更新时间</th>--%>
									<%--<th class="center">操作</th>--%>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:if test="${QX.cha == 1 }">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr id="ItemId_${var.CLASSIFY_ITEM_ID}" name='listBeen' onclick="toCheck('${var.CLASSIFY_ITEM_ID}')" ondblclick="editByID('${var.CLASSIFY_ITEM_ID}')" style="cursor: pointer;">
											<%--<td class='center'>--%>
												<%--<label class="pos-rel"><input type='checkbox' name='ids' id="${var.CLASSIFY_ITEM_ID}" value="${var.CLASSIFY_ITEM_ID}" class="ace" /><span class="lbl"></span></label>--%>
											<%--</td>--%>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<%--<td class='center'>${var.FITEMID}</td>--%>
											<td class='center'>${var.FNUMBER}</td>
											<td class='center'>${var.FNAME}</td>
											<%--<td class='center'>${var.FPARENTID}</td>--%>
											<%--<td class='center'>${var.FMODIFYTIME}</td>--%>
											<%--<td class="center">
												<c:if test="${QX.edit != 1 && QX.del != 1 }">
												<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
												</c:if>
												<div class="hidden-sm hidden-xs btn-group">
													<c:if test="${QX.edit == 1 }">
													<a class="btn btn-xs btn-success" title="编辑" onclick="edit('${var.CLASSIFY_ITEM_ID}');">
														<i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
													</a>
													</c:if>
													<c:if test="${QX.del == 1 }">
													<a class="btn btn-xs btn-danger" onclick="del('${var.CLASSIFY_ITEM_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>
													</c:if>
												</div>
												<div class="hidden-md hidden-lg">
													<div class="inline pos-rel">
														<button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto">
															<i class="ace-icon fa fa-cog icon-only bigger-110"></i>
														</button>

														<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
															<c:if test="${QX.edit == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="edit('${var.CLASSIFY_ITEM_ID}');" class="tooltip-success" data-rel="tooltip" title="修改">
																	<span class="green">
																		<i class="ace-icon fa fa-pencil-square-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
															<c:if test="${QX.del == 1 }">
															<li>
																<a style="cursor:pointer;" onclick="del('${var.CLASSIFY_ITEM_ID}');" class="tooltip-error" data-rel="tooltip" title="删除">
																	<span class="red">
																		<i class="ace-icon fa fa-trash-o bigger-120"></i>
																	</span>
																</a>
															</li>
															</c:if>
														</ul>
													</div>
												</div>
											</td>--%>
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
								<%--<td style="vertical-align:top;">
									<c:if test="${QX.add == 1 }">
									<a class="btn btn-mini btn-success" onclick="add();">新增</a>
									</c:if>
									<c:if test="${QX.del == 1 }">
									<a class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" title="批量删除" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
									</c:if>
								</td>--%>
								<td style="vertical-align:top;">
									<div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
								</td>
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
		</div>
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
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
        //重置
        function Form_reset(){
			$("[name=\"FNAME\"]").val("");
        }
        $(function() {
		
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

            //回车搜索
            $("body").keydown(function() {
                if (event.keyCode == "13") {//keyCode=13是回车键
                    $('#btn_search').click();
                }
            });
		});

		//同步数据
		function updateItem(){
            bootbox.confirm("同步需要一定的时间是否确认同步吗?", function(result) {
                if(result) {
                    top.jzts();
                    var url = "<%=basePath%>rematoget/batchInsert.do";
                    $.ajax({
                        type: "POST",
                        url: url,
                        //data: {DATA_IDS:str},
                        dataType:'json',
                        //beforeSend: validateData,
                        cache: false,
                        success: function(data){
                            alert(data.Data);
                            tosearch();
                        }
                    });
                }
            });
		}
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>classify_item/goAdd.do';
			 diag.Width = 750;
			 diag.Height = 355;
			 diag.Modal = true;				//有无遮罩窗口
			 diag. ShowMaxButton = false;	//最大化按钮
		     diag.ShowMinButton = false;		//最小化按钮
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
					var url = "<%=basePath%>classify_item/delete.do?CLASSIFY_ITEM_ID="+Id+"&tm="+new Date().getTime();
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
            }else {
                var Id = str[0];
                top.jzts();
                var diag = new top.Dialog();
                diag.Drag = true;
                diag.Title = "编辑";
                diag.URL = '<%=basePath%>classify_item/goEdit.do?CLASSIFY_ITEM_ID=' + Id;
                diag.Width = 750;
                diag.Height = 355;
                diag.Modal = true;				//有无遮罩窗口
                diag.ShowMaxButton = false;	//最大化按钮
                diag.ShowMinButton = false;		//最小化按钮
                diag.CancelEvent = function () { //关闭事件
                    if (diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none') {
                        tosearch();
                    }
                    diag.close();
                };
                diag.show();
            }
		}
        //双击列表一行数据
        function editByID(Id) {
            top.jzts();
            var diag = new top.Dialog();
            diag.Drag=true;
            diag.Title ="查看详情";
            diag.URL = '<%=basePath%>classify_item/goEdit.do?CLASSIFY_ITEM_ID='+Id;
            diag.Width = 600;
            diag.Height = 320;
            diag.Modal = true;				//有无遮罩窗口
            diag.CancelEvent = function(){ //关闭事件
                if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                    tosearch();
                }
                diag.close();
            };
            diag.show();
        }

        //单击列表一行，选中复选框
        function toCheck(Id){
            $("#simple-table").find("tr[name='listBeen']").css("background-color", "");
            $("#ItemId_" + Id).css("background-color", "#CCCC99");
            if($("#"+Id).prop("checked")){
                $("#"+Id).removeAttr("checked");
            }else {
                $("#"+Id).prop("checked",true);
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
								url: '<%=basePath%>classify_item/deleteAll.do?tm='+new Date().getTime(),
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
			window.location.href='<%=basePath%>classify_item/excel.do';
		}
	</script>


</body>
</html>