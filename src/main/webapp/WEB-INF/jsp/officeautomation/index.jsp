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
        <title>工作流</title>
        <base href="<%=basePath%>">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
        <meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
        <link rel="stylesheet" href="static/jquery-weui-build/css/jquery-weui.css">
		<link rel="stylesheet" href="static/jquery-weui-build/lib/weui.css">
    </head>
    <body ontouchstart>
    	<div style="" align="center">
	        <p class='demos-sub-title'>
	            	审批
	        </p>
		</div>
        <div class="weui-grids">
            <a onclick="alert('wu')" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="static/jquery-weui-build/images/icon_nav_toast.png" alt="">
                </div>
                <p class="weui-grid__label">
                   	 物品申领表
                </p>
            </a>
            <a onclick="alert('wu')" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="static/jquery-weui-build/images/icon_nav_dialog.png" alt="">
                </div>
                <p class="weui-grid__label">
                    	报销申请单
                </p>
            </a>
            <a onclick="alert('wu')" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="static/jquery-weui-build/images/icon_nav_progress.png" alt="">
                </div>
                <p class="weui-grid__label">
                    	外出申请单
                </p>
            </a>
            <a onclick="window.location.href='<%=basePath%>officeautomation/toLeave'" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="static/jquery-weui-build/images/icon_nav_msg.png" alt="">
                </div>
                <p class="weui-grid__label">
                    	请假申请单
                </p>
            </a>
            <a onclick="alert('wu')" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="static/jquery-weui-build/images/icon_nav_actionSheet.png" alt="">
                </div>
                <p class="weui-grid__label">
                   	 合同订单审批表
                </p>
            </a>
            <a onclick="alert('wu')" class="weui-grid js_grid">
                <div class="weui-grid__icon">
                    <img src="static/jquery-weui-build/images/icon_nav_icons.png" alt="">
                </div>
                <p class="weui-grid__label">
                    	加班申请表
                </p>
            </a>
        </div>
		
        <style>
            .weui-footer {
                margin: 25px 0 10px 0;
            }
        </style>
        <script src="static/js/jquery-2.1.1.js">
        </script>
        <script>
            $(function(){
                FastClick.attach(document.body);
            });
        </script>
        <script src="static/jquery-weui-build/js/jquery-weui.js">
        </script>
		<script src="static/jquery-weui-build/lib/fastclick.js"></script>
    </body>
</html>
