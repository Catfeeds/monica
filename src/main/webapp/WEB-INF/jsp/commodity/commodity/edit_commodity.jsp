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
								<div id="zhongxin" style="padding-top:30px;">
									<%--<table style="border-collapse:separate; border-spacing:10px;width: 100%">
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
													<c:set var="theString" value="${pd.STATE}"/>
														<label style="">
															<input name="STATE" type="checkbox"
																<c:if test="${fn:contains(theString,'普通商品')}"> checked="checked"
																</c:if>  class="ace" id="checkbox1" value="普通商品">
															<span class="lbl">普通商品</span>
														</label>
														<label style="">
															<input name="STATE" type="checkbox"
																<c:if test="${fn:contains(theString,'热销商品')}">  checked="checked"
																</c:if> class="ace" id="checkbox2" value="热销商品">
															<span class="lbl">热销商品</span>
														</label>
														<label style="">
															<input name="STATE" type="checkbox"
																<c:if test="${fn:contains(theString,'上新商品')}">  checked="checked"
																</c:if> class="ace" id="checkbox3" value="上新商品">
															<span class="lbl">上新商品</span>
														</label>
														<label style="">
															<input name="STATE" type="checkbox"
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
													<input type="text" style="width: 415px;" value="${pd1.PIC_URL}"
														   class="input-text" name="INVENTORY"
														   id="INVENTORY">
												</td>
											</tr>
										</tbody>
									</table>--%>
									<table id="table_report" style="border-collapse:separate; border-spacing:10px;width: 100%;padding-left: 1%">
										<tr>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;"> 商品编号: </td>
											<td colspan="2">
												<input type="text" name="FITEMID" id="FITEMID" value="${pd.FITEMID}" maxlength="255"  title="商品编号" style="width:98%;" disabled/>
											</td>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;"> 商品代码: </td>
											<td colspan="2">
												<input type="text" name="FNUMBER" id="FNUMBER" value="${pd.FNUMBER}" maxlength="255"  title="商品代码" style="width:98%;" disabled/>
											</td>
										</tr>
										<tr>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">商品名称:</td>
											<td colspan="2">
												<input type="text" name="FNAME" id="FNAME" value="${pd.FNAME }" maxlength="255" title="商品名称" style="width:98%;" />
											</td>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">规格型号:</td>
											<td colspan="2">
												<input type="text" name="FMODEL" id="FMODEL" value="${pd.FMODEL}" maxlength="255" title="规格型号" style="width:98%;" />
											</td>
										</tr>
										<tr>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">数&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;量:</td>
											<td colspan="2">
												<input type="number" name="FQTY" id="FQTY" value="${pd.FQTY}" maxlength="255" title="数量" style="width:98%;" />
											</td>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">库&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存:</td>
											<td colspan="2">
												<input type="number" name="INVENTORY" id="INVENTORY" value="${pd.INVENTORY}" maxlength="255" title="库存" style="width:98%;" />
											</td>
										</tr>
										<tr>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">商品状态:</td>
											<td colspan="2">
												<c:set var="theString" value="${pd.STATE}"/>
												<label style="">
													<input name="STATE" type="radio"
													<c:if test="${fn:contains(theString,'普通商品')}"> checked="checked"
													</c:if>  class="ace" id="checkbox1" value="普通商品">
													<span class="lbl">普通商品</span>
												</label>
												<label style="">
													<input name="STATE" type="radio"
													<c:if test="${fn:contains(theString,'热销商品')}">  checked="checked"
													</c:if> class="ace" id="checkbox2" value="热销商品">
													<span class="lbl">热销商品</span>
												</label>
												<label style="">
													<input name="STATE" type="radio"
													<c:if test="${fn:contains(theString,'上新商品')}">  checked="checked"
													</c:if> class="ace" id="checkbox3" value="上新商品">
													<span class="lbl">上新商品</span>
												</label>
												<label style="">
													<input name="STATE" type="radio"
													<c:if test="${fn:contains(theString,'折扣商品')}">  checked="checked"
													</c:if> class="ace" id="checkbox4" value="折扣商品">
													<span class="lbl">折扣商品</span>
												</label>
											</td>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">商品上下架:</td>
											<td colspan="2">
												<label style="float:left;padding-left:20px;">
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
										</tr>
										<tr>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">商品价格:</td>
											<td width="198">
												<input type="number" name="PRICE" id="PRICE" value="${pd.PRICE}" maxlength="32"  title="商品价格" style="width:98%;" />
											</td>
											<td>元</td>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">优惠折扣:</td>
											<td width="198">
												<input type="number" name="DISCOUNT" id="DISCOUNT" value="${pd.DISCOUNT}" maxlength="32" title="优惠折扣" style="width:98%;" />
											</td>
											<td>折</td>
										</tr>
										<tr>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">商品描述:</td>
											<td colspan="2">
												<input type="number" name="FUNITID" id="FUNITID" value="${pd}" maxlength="32" title="商品描述" style="width:98%;" />
											</td>
											<td class="center" style="width:75px;text-align: right;padding-top: 7px;">商品预览图:</td>
											<td class="center" colspan="2">
												<input type="text" name="FSALEUNITID" id="FSALEUNITID" value="${pd}" maxlength="32"  title="商品预览图" style="width:98%;" />
											</td>
										</tr>
									</table>
                                    <%--<table style="width:100%;margin-left: 10px">
                                        <tr>
                                            <td style="text-align: center;" colspan="11">
                                                <a class="btn btn-mini btn-primary" onclick="saveInfo();">保存</a>
                                                <a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
                                            </td>
                                        </tr>
                                    </table>--%>
                                </div>
                                <div id="zhongxin2" class="center" style="display:none">
                                    <br/>
                                    <br/>
                                    <br/>
                                    <br/>
                                    <br/>
                                    <img src="static/images/jiazai.gif" />
                                    <br/>
                                    <h4 class="lighter block green">提交中...</h4>
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
		<a href="#" id="btn-scroll-up"
			class="btn-scroll-up btn btn-sm btn-inverse"> <i
			class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i> </a>

	</div>
	<!-- /.main-container -->

	<br><br>

	<div style="text-align: right;height:45px;
		background: url(static/login/images/topbg.png) repeat-x; position:fixed;width: 100%;z-index:10000000;bottom: 0px;";>

		<a style="margin-top: 10px;" class="btn btn-light btn-xs" onclick="saveInfo()">
			<i class="ace-icon fa fa-credit-card bigger-110 nav-search-icon green"></i>保存
		</a>

		<a style="margin-top: 10px;margin-right: 10px;" class="btn btn-light btn-xs" onclick="top.Dialog.close();">
			<i class="ace-icon fa  fa-external-link bigger-110 nav-search-icon red"></i>取消
		</a>
	</div>

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
			//var context = getContent();
			//alert(context);
			//$("#FNOTE").val(context);
			//jqchk();
			$("#Form").submit();
            $("#zhongxin").hide();
            $("#zhongxin2").show();
			//alert("gg");
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