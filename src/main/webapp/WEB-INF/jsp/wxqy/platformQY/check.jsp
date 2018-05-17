<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<title>采购收货</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta name="format-detection" content="telephone=no" />
<link rel="stylesheet" href="static/css/cb.css" />
<script src="static/js/store/jquery-2.1.4.js"></script>
<script src="static/js/ajaxfileupload.js"></script>
<!-- head 中 -->
<!-- <link href="static/css/indent.css" rel="stylesheet" type="text/css"> -->
<link rel="stylesheet"
	href="https://cdn.bootcss.com/weui/1.1.2/style/weui.min.css">
<link rel="stylesheet"
	href="https://cdn.bootcss.com/jquery-weui/1.2.0/css/jquery-weui.min.css">
<link rel="stylesheet" type="text/css" href="static/themes/css/home.css">
<!-- body 最后 -->
<script
	src="https://cdn.bootcss.com/jquery-weui/1.2.0/js/jquery-weui.min.js"></script>

</head>
<style>
/*订单状态*/
.state_box {
	height: 43px;
	position: relative
}

.withdrawals-panel {
	border: solid 1px #ccc;
	border-radius: 5px;
	/* background-color: #fff; */
	background-image: url(static/images/synergy/blue.jpg);
	padding: 0.8rem 0.6rem;
	margin-bottom: 0.3rem;
	overflow: hidden
}

.btn-primary {
	background-color: #428bca !important;
	border-color: #428bca;
	border-radius: 5px;
	width: 90%;
	height: 100%;
	border: 1px;
}

.btn1 { /*  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.55); */
	touch-action: manipulation;
	border: 1px solid transparent;
	padding: 6px 12px;
	font-size: 14px;
	line-height: 1.42857143;
	border-radius: 0 5px 5px 0;
}

.a-upload {
	padding: 4px 10px;
	height: 20px;
	line-height: 20px;
	position: relative;
	cursor: pointer;
	color: #888;
	background: #fafafa;
	border: 1px solid #ddd;
	border-radius: 4px;
	overflow: hidden;
	display: inline-block;
	*display: inline;
	*zoom: 1
}

.a-upload  input {
	position: absolute;
	font-size: 100px;
	right: 0;
	top: 0;
	opacity: 0;
	filter: alpha(opacity = 0);
	cursor: pointer
}

.a-upload:hover {
	color: #444;
	background: #eee;
	border-color: #ccc;
	text-decoration: none
}

li {
	font: left;
	list-style: none;
}

.header{ height:46px; line-height:46px; background-color:#01aff0; color:white; font-size:18px; text-align:center; position:relative}
.header_left{ height:46px; line-height:46px; color:white; text-align:left; font-size:14px; position:absolute; left:4%; top:0}
.header_left img{ float:left; margin-top:14px; width:11px; height:auto}
</style>
<body>
	<!--header顶部标题-->
		<div class="header">
			验收收料
			<div class="header_left" onclick="window.history.go(-1)">
				<img src="static/images/store/return.png">
			</div>
		</div>
	<input type="hidden" name="FENTRYID" id="FENTRYID"
		value="${pd_one.FENTRYID}" />
	<input type="hidden" name="FINTERID" id="FINTERID" value="${FINTERID}" />
	<div class="move_box" id="move_box">
		<div class="move">
			<div id="listNotReceive" class="order_box" style="padding: 10px">
				<div class="withdrawals-panel">
					<div class="order"">
						<div class="border_top"></div>
						<div class="order_title">
							商品名称：<em style="margin-left: 3%">${pd_one.FNAME}</em>
						</div>
						<div class="order_title">
							规格型号：<em style="margin-left: 3%">${pd_one.FMODEL}</em>
						</div>
						<div class="order_title">
							订单数量：<em style="margin-left: 3%">${fn:replace(pd_one.FORDERQTY,
								".00", "")}</em><span style="margin-left: 30%">单位：<em
								style="margin-left: 3%">${pd_one.FUNIT}</em>
							</span>
						</div>
						<div class="order_title">
							发货时间：<em style="margin-left: 3%">${fn:substring(pd_one.FSHIPPINGDATE,0,10)}</em>
						</div>
						<div class="order_title">
							验收数量：<em style="margin-left: 3%">${fn:replace(pd_one.FDELIVERQTY,
								".00", "")}</em>
						</div>
						<div class="order_title">
							验收意见：
							<textarea style="width: 95%;height: 50px;font-size: 16px" cols=""
								rows="" name="FMODEL" id="FMODEL" value="${pd.FMODEL}"
								placeholder="">${pd.FMODEL}</textarea>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	
	
	<div class="weui-cells weui-cells_form">
		<div class="weui-cell">
			<div class="weui-cell__bd">
				<div class="weui-uploader">
					<div class="weui-uploader__hd">
						<p class="weui-uploader__title">验收图片：</p>
					</div>
					<div class="weui-uploader__bd">
						<ul class="weui-uploader__files" id="uploaderFiles">
							<c:choose>
								<c:when test="${listPic !=  null}">
									<li><c:forEach var="list_Pics" items="${listPic}"
											varStatus="num">
											<img width="80" height="80" alt=""
												src="${httpUrl }/ssww${list_Pics.FPICPATH}"  onclick="deletePic('${list_Pics.ICPOORDERPICPATH_ID}')"/>
											<!-- <input id="" type="button" value="删除图片" onclick="deletePic()"> -->
										</c:forEach>
									</li>
								</c:when>
								<c:otherwise>
									<div class="form-group" align="center">
										<p>${nullpicurl}</p>
									</div>
								</c:otherwise>
							</c:choose>
						</ul>
						<div class="weui-uploader__input-box">
							<input class="weui-uploader__input" type="file" accept="image/*"
								capture="camera" name="myFile" id="myFile"
								onchange="javascript:setImagePreview();">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div>
		
		<div data-role="fieldcontain" align="center">
			
			<div id="localImag">
				<img id="preview" width="-1" height="-1" style="display: none" /><br>
					<input type="button" onclick="btnUp()" id="DivUp" style="display: none"
						class="weui-btn weui-btn_primary"  data-inline="true"
						id="BtnUp" value="确认上传" data-mini="true" />
			</div>
		</div>

	</div>
	<br><br><br>
	<div class="aui-invitation-footer">
				<a onclick="confirm('${pd_one.FENTRYID}','${FINTERID}')" style="background:#009999">验收确认</a>
				<a onclick="window.history.go(-1)" >退出</a>
			</div>
	<script type="text/javascript">  
        function setImagePreview() {  
            var preview, img_txt, localImag, file_head = document.getElementById("myFile"),  
            picture = file_head.value;  
            if (!picture.match(/.jpg|.gif|.png|.bmp/i))
            // return alert("您上传的图片格式不正确，请重新选择！"),  
            return;
            !1;  
            if (preview = document.getElementById("preview"), file_head.files && file_head.files[0]) preview.style.display = "block",  
                preview.style.width = "120px",  
                preview.style.height = "120px", 
                preview.src = window.navigator.userAgent.indexOf("Chrome") >= 1 || window.navigator.userAgent.indexOf("Safari") >= 1 ? window.webkitURL.createObjectURL(file_head.files[0]) : window.URL.createObjectURL(file_head.files[0]);  

            else {  
                file_head.select(),  
                file_head.blur(),  
                img_txt = document.selection.createRange().text,  
                localImag = document.getElementById("localImag"),  
                localImag.style.width = "63px",  
                localImag.style.height = "63px";  
                try {  
                    localImag.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)",  
                    localImag.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = img_txt  
                } catch(f) {  
                    //return alert("您上传的图片格式不正确，请重新选择！"),  
                    return;
                    !1  
                }  
                preview.style.display = "none",  
                document.selection.empty();
            }  
            return document.getElementById("DivUp").style.display = "block",  
            !0  
        }  
        
        
       function btnUp(){
       			var FINTERID = $("#FINTERID").val();
                var FENTRYID = $("#FENTRYID").val();
	       		 $.ajaxFileUpload({  
					    type: "post",  
					    url: "<%=basePath%>checkUp/upload",
				data : {
					FINTERID : FINTERID,
					FENTRYID : FENTRYID,
				},//要传到后台的参数
				secureuri : false,//是否启用安全提交，默认为false  
				fileElementId : "myFile",//文件选择框的id属性  
				dataType : 'json',//服务器返回的格式  
				async : false,
				success : function(data) {
					alert(data.success);
					location.reload();
				},
				error : function(data, status, e) {

				}
			});
		}
		
		function confirm(FENTRYID,FINTERID){
			$.confirm("确定要验收吗?", function() {
					$.ajax({
						type: "POST",
						url: "<%=basePath%>platformQY/passCheck",
						data : {
								FENTRYID : FENTRYID,
								FINTERID : FINTERID,
							},			
							dataType : 'json',
							cache : false,
							success : function(data) {
								window.history.go(-1);
							},
							error : function() {
								alert("异常！");
							}
						});
					//点击确认后的回调函数
			  }, function() {
			  //点击取消后的回调函数
			  });
		}
		
		function deletePic(ICPOORDERPICPATH_ID){
				$.confirm("确定要删除该验收图片吗?", function() {
					$.ajax({
						type: "POST",
						url: "<%=basePath%>platformQY/delCheckPic",
						data : {
								ICPOORDERPICPATH_ID : ICPOORDERPICPATH_ID,
							},			
							dataType : 'json',
							cache : false,
							success : function(data) {
								//window.history.go(-1);
								alert(data.success);
								window.location.reload();
							},
							error : function() {
								alert("异常！");
							}
						});
					//点击确认后的回调函数
			  }, function() {
			  //点击取消后的回调函数
			  });
		
		}
	</script>
</body>
</html>
