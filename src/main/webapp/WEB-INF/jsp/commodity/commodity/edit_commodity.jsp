<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<%@ include file="../../system/index/top.jsp"%>
<script type="text/javascript" src="static/js/jquery-2.1.1.js"></script>
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="dotted"></div>
					<div class="row">
						<div class="col-xs-12">
							<!-- ------------------------------------------------------------------------------- -->
							<form action="commodity/${msg}.do" name="Form" id="Form" method="post" class="form-inline">
								<input type="hidden" name="COMMODITY_ID" id="COMMODITY_ID" value="${pd.COMMODITY_ID}"/>
								<input type="hidden" name="ISPUTAWAY" id="ISPUTAWAY" value="${pd.ISPUTAWAY}"/>
								<input type="hidden" name="COMMODITYPIC_ID" id="COMMODITYPIC_ID" value="${pd1.COMMODITYPIC_ID}"/>
								<input type="hidden"  value="${pd.STATE}" name="STATE" id="STATE"/>
								<%-- <input type="hidden" name="FITEMID" id="FITEMID" value="${pd.FITEMID}"/>
								<input type="hidden" name="FPARENTID" id="FPARENTID" value="${pd.FPARENTID}"/> --%>
								<div id="zhongxin" style="padding-top: 13px;">
									<table style="border-collapse:separate; border-spacing:10px;width: 100%">
										<tbody>
											<tr>
												<td style="width:8%;text-align: right;">
													<label>商品名称<span style="color: red;">*</span>:</label>
												</td>
												<td>
													<input id="FNAME" name="FNAME" type="text" value="${pd.FNAME}"
														   style="width: 100%;" class="input-text">
												</td>

												<td style="width:8%;text-align: right;">
													<label>商品代码<span style="color: red;">*</span>:</label>
												</td>
												<td>
													<input id="FNUMBER" value="${pd.FNUMBER}" type="text"
														    style="width: 100%;" name="FNUMBER" class="input-text">
												</td>
											</tr>

											<tr >
												<td style="width:8%;text-align: right;">
													<label>商品状态<span style="color:red;">*</span>:</label>
												</td>
												<td>
													<%--<c:set var="theString" value="${pd.STATE}"/>--%>
													<label style="">
														<input name="checkbox1" type="checkbox"
															<c:if test="${fn:contains(theString,'普通商品')}"> checked="checked"
															</c:if>  class="ace" id="checkbox1" value="普通商品">
														<span class="lbl">普通商品</span>
													</label>
													<label style="">
														<input name="checkbox1" type="checkbox"
															<c:if test="${fn:contains(theString,'热销商品')}">  checked="checked"
															</c:if> class="ace" id="checkbox2" value="热销商品">
														<span class="lbl">热销商品</span>
													</label>
													<label style="">
														<input name="checkbox1" type="checkbox"
															<c:if test="${fn:contains(theString,'上新商品')}">  checked="checked"
															</c:if> class="ace" id="checkbox3" value="上新商品">
														<span class="lbl">上新商品</span>
													</label>
													<label style="">
														<input name="checkbox1" type="checkbox"
															<c:if test="${fn:contains(theString,'折扣商品')}">  checked="checked"
															</c:if> class="ace" id="checkbox4" value="折扣商品">
														<span class="lbl">折扣商品</span>
													</label>
												</td>

												<td style="width:8%;text-align: right;">
													<label>商品规格<span style="color: red;">*</span>:</label>
												</td>
												<td>
													<textarea style="resize:none; width: 100%; " cols="" rows=""
															  class="textarea" name="FMODEL" id="FMODEL" value="${pd.FMODEL}"
															  placeholder="">${pd.FMODEL}</textarea>
												</td>
											</tr>

											<tr>
												<td style="width:8%;height: 40px;text-align: right;">
													<label>商品上下架:</label>
												</td>
												<td style="height: 40px;">
													<label style="float:left;padding-left:12px;">
														<input class="ace" name="form-field-radio" id="form-field-radio1" onclick="isPutaway('上架');"
															   <c:if test="${pd.ISPUTAWAY == '上架' }">checked="checked"</c:if> type="radio" value="icon-edit">
														<span class="lbl">上架</span>
													</label>
													<label style="float:left;padding-left:5px;">
														<input class="ace" name="form-field-radio" id="form-field-radio2" onclick="isPutaway('未上架');"
															   <c:if test="${pd.ISPUTAWAY == '未上架' }">checked="checked"</c:if> type="radio" value="icon-edit">
														<span class="lbl">未上架</span>
													</label>
												</td>
												<td style="width:8%;height: 40px;text-align: right;">
													<label>商品价格:</label>
												</td>
												<td style="height: 30px;">
													<div class="row" >
														<div class="col-xs-5">
															<input type="number" style="width:100%;"  value="${pd.PRICE}"
																   class="input-text" placeholder="" name="PRICE"
																   id="PRICE">
														</div>
														<div class="col-xs-1" style="margin-top:7px;">元</div>
													</div>
												</td>
											</tr>

											<tr>
												<td style="width:15%;text-align:right;">
													<label>商品价格优惠:</label>
												</td>
												<td style="">
													<div class="row">
														<div class="col-xs-6">
															<input type="number" style="width: 100%; margin: 0px;padding: 0px;"  value="${pd.DISCOUNT}"
																   class="input-text" placeholder="" name="DISCOUNT"
																   id="DISCOUNT">
														</div>
														<div class="col-xs-1" style="margin-top:7px;">折</div>
													</div>
												</td>

												<td style="width:8%;text-align: right;">
													<label>图片网址:</label>
												</td>
												<td>
													<input type="text" style="width: 415px;"
														   class="input-text" placeholder="" name="INVENTORY"
														   id="INVENTORY">
												</td>
											</tr>
										</tbody>
									</table>
							<table style="width:100%;margin-left: 10px">
								<tr>
									<td style="text-align: right;">
										<a class="btn btn-success"
										onclick="saveInfo();">保存</a>
									</td>
									<td style="width: 5%;">
									</td>
								</tr>
							</table>
							<br />
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
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i> </a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 百度富文本编辑框-->
	<!-- 配置img路径 -->
	<script type="text/javascript" charset="utf-8">window.UEDITOR_HOME_URL = "<%=basePath%>plugins/ueditor/";</script>
	<script type="text/javascript" charset="utf-8"
		src="plugins/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8"
		src="plugins/ueditor/ueditor.all.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<script type="text/javascript">
		$(top.hangge());
		var isGetId = 0;
		$(function() {
			//日期框
			$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
			
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
			//上传
			$('#tp').ace_file_input({
				no_file:'请选择文件 ...',
				btn_choose:'选择',
				btn_change:'更改',
				droppable:false,
				onchange:null,
				thumbnail:false, //| true | large
				whitelist:'*',
				//whitelist:'gif|png|jpg|jpeg',
				//blacklist:'gif|png|jpg|jpeg'
				//onchange:''
				//
			});
		});
		
		//百度富文本
		setTimeout("ueditor()",500);
		function ueditor(){
			UE.getEditor('editor',{
			initialFrameWidth :window.innerWidth*0.8,//设置编辑器宽度
			initialFrameHeight:window.innerHeight*0.7,//设置编辑器高度
			scaleEnabled:true//设置不自动调整高度
			//scaleEnabled {Boolean} [默认值：false]//是否可以拉伸长高，(设置true开启时，自动长高失效)
			});
		}
		
		function updatePic(){
			// top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>commodity/toUpdatePic';
			diag.Width = 900;
			diag.Height = 520;
			
			diag.OKEvent = function() {
				//alert(diag.innerFrame.contentWindow.document.getElementById("pf").innerHTML);
				/* if (diag.innerFrame.contentWindow.document.getElementById("pf").innerHTML == ""
						|| diag.innerFrame.contentWindow.document
								.getElementById("pf").innerHTML == null) {
					diag.close();
					return;
				} */
 				$("#MAIN_PIC").val( diag.innerFrame.contentWindow.document
 										.getElementById("pf").innerHTML);
				<%-- $("#picUrl").val(<%=basePath%>+ diag.innerFrame.contentWindow.document
				.getElementById("pf").innerHTML); --%>
				//a();
				diag.close();
			};
			diag.show();
		}
		
		function isPutaway(value){
			$("#ISPUTAWAY").val(value);
		}
		
		function isHeadLine(value){
			$("#ISHEADLINE").val(value);
		}
		
		function saveInfo(){
			
			var context = getContent();
			//alert(context);
			$("#FNOTE").val(context);
			jqchk();
			$("#Form").submit();
		}
		
	
    function getContent() {
        var arr = [];
        //arr.push("使用editor.getContent()方法可以获得编辑器的内容");
       // arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        //alert(arr.join("\n"));
        return arr.join("\n");
        
    } 
    
    function jqchk(){ //jquery获取复选框值 
		var chk_value =[]; 
		$('input[name="checkbox1"]:checked').each(function(){ 
		chk_value.push($(this).val()); 
		}); 
		$("#STATE").val(chk_value.length==0 ?'普通商品':chk_value);
		//alert(chk_value.length==0 ?'你还没有选择任何内容！':chk_value); 
		}
	</script>


</body>
</html>