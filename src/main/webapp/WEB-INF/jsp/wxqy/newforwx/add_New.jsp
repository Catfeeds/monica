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
					<div class="hr hr-18 dotted hr-double"></div>
					<div class="row">
						<div class="col-xs-12">
							<!-- ------------------------------------------------------------------------------- -->
							<form action="newforwx/${msg }.do" name="Form" id="Form" method="post">
							<input type="hidden" name="NEWFORWX_ID" id="NEWFORWX_ID" value="${pd.NEWFORWX_ID}"/>
							<input type="hidden" name="ISPUBLIC" id="ISPUBLIC" value="${pd.ISPUBLIC}"/>
							<input type="hidden" name="ISHEADLINE" id="ISHEADLINE" value="${pd.ISHEADLINE}"/>
							<table class="table table-border table-bg table-bordered">
								<tbody>
									<tr class="warning">
										<th width="20%"><label>文章标题：</label></th>
										<th><input type="text" style="width: 250px" value="${pd.TITLE}"
											class="input-text" placeholder="填写文章标题...（必填）" name="TITLE"
											id="TITLE"></th>
									</tr>
									<tr class="active">
										<th><label>描述内容：</label></th>
										<td><textarea style="width: 400px" cols="" rows=""
												class="textarea" name="DESCRIBE" id="DESCRIBE" value="${pd.DESCRIBE}"
												placeholder="填写文章描述...（可选填）">${pd.DESCRIBE}</textarea></td>
									</tr>
									<tr>
										<td style="width:70px;text-align: left;padding-top: 13px;">是否发布该新闻：</td>
										<td>
											<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio" id="form-field-radio1" onclick="isPublic('1');" <c:if test="${pd.ISPUBLIC == 'true' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">发布</span></label>
											<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio" id="form-field-radio2" onclick="isPublic('0');" <c:if test="${pd.ISPUBLIC == 'false' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">不发布</span></label>
										</td>
									</tr>
									<tr>
										<td style="width:70px;text-align: left;padding-top: 13px;">是否为头条：</td>
										<td>
											<label style="float:left;padding-left: 12px;"><input class="ace" name="form-field-radio" id="form-field-radio1" onclick="isHeadLine('1');" <c:if test="${pd.ISHEADLINE == 'true' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">是</span></label>
											<label style="float:left;padding-left: 5px;"><input class="ace" name="form-field-radio" id="form-field-radio2" onclick="isHeadLine('0');" <c:if test="${pd.ISHEADLINE == 'false' }">checked="checked"</c:if> type="radio" value="icon-edit"><span class="lbl">否</span></label>
										</td>
									</tr>
									<!-- <tr class="warning">
										<th width="20%"><label>是否发布该新闻：</label></th>
										<th><select class="input-md form-control"
											style="width: 65px" name="ISPUBLIC" id="ISPUBLIC">
												<option value="是">是</option>
												<option value="否" selected="selected">否</option>
										</select>
										</th>
									</tr> -->
									<tr class="success">
										<th><label>作者：</label></th>
										<td><input type="text" style="width: 250px"  value="${pd.AUTHOR}"
											class="input-text" placeholder="填写文章作者...（可选填）" name="AUTHOR"
											id="AUTHOR"></td>
									</tr>
									<!-- <tr class="active">
										<th><label>原文跳转网址：</label></th>
										<td><input type="text" style="width: 300px"
											class="input-text" placeholder="填写原文跳转网址...（可选填）" name="content_source_url"
											id="content_source_url"></td>
									</tr> -->
									<tr class="active" style="display: none">
										<th><label>图片网址：</label></th>
										<td><input type="text" style="width: 300px"
											class="input-text" placeholder="" name="picUrl"
											id="picUrl"></td>
									</tr>
									<tr class="active" style="display: none">
										<th><label>内容：</label></th>
										<td><input type="text" style="width: 300px"
											class="input-text" placeholder="" name="NEW_CONTENT" id="NEW_CONTENT" value="${pd.NEW_CONTENT}"></td>
									</tr>
									<tr class="success">
										<th><label>封面图片：</label></th>
										<td><input type="text" style="width: 250px" 
											class="input-text" name="MAIN_PIC" id="MAIN_PIC"  value="${pd.MAIN_PIC}" readonly="readonly"> <input
											class="btn btn-warning radius" style="margin-left: 20px"
											onclick="updatePic()" type="button" value="选择上传图片"></td>
									</tr>
								</tbody>
							</table>
							<div>
								<label style="margin-left: 7px">文章内容：</label>
							</div>
							<div style="margin-top: 5px;border-color: #FFDAC8;width:100%;">

								<div class="col-sm-9">
									<script id="editor" type="text/plain"
										style="width:100%;height:400px;">${pd.NEW_CONTENT}</script>
								</div>
								</br>

								<!-- <button onclick="getContent()">获得内容</button> -->
							</div>
							<br>
							<table style="width:100%;height: 10px">
								
							</table>
							<table style="width:100%;margin-left: 10px">
								<tr>
									<td ><a class="btn btn-success"
										onclick="saveInfo();">保存</a></td>
								</tr>
							</table>
							<br />
							</form>
							
							

							<!-- ------------------------------------------------------------------------------- -->
							
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
			 diag.URL = '<%=basePath%>newforwx/toUpdatePic';
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
		
		function isPublic(value){
			$("#ISPUBLIC").val(value);
		}
		
		function isHeadLine(value){
			$("#ISHEADLINE").val(value);
		}
		
		function saveInfo(){
			
			var context = getContent();
			//alert(context);
			$("#NEW_CONTENT").val(context);
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
	</script>


</body>
</html>