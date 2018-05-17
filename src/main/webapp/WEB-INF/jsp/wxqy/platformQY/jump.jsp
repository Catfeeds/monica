<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>正在跳转，到工作台</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script src="static/js/store/jquery-2.1.4.js"></script>
  </head>
  
  <body>
    	正在跳转，到工作台。。。 <br>
  </body>
  
  <script type="text/javascript">
  		$(function(){
			  jump();
			});
			function jump(){
			  window.location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=ww49c384af1f4dac63&redirect_uri=http://jittest.s1.natapp.cc/ssww/platformQY/index&response_type=code&scope=snsapi_base&agentid=1000003&state=STATE#wechat_redirect";
			};
  
  </script>
</html>
