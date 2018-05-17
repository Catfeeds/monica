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
<script src="static/js/store/jquery-2.1.4.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<!-- <link href="static/css/indent.css" rel="stylesheet" type="text/css"> -->
<link href="static/css/indent.css" rel="stylesheet" type="text/css">
<link href="iTunesArtwork@2x.png" sizes="114x114" rel="apple-touch-icon-precomposed">
<script type="text/javascript" src="static/js/echarts.min.js"></script>
<!-- jsp文件头和头部 -->
<%-- <%@ include file="../../system/index/top.jsp"%> --%>

</head>
<body class="no-skin">
						<div class="header">
										应收账款趋势分析
										<div class="header_left" onclick="window.history.go(-1)">
											<img src="static/images/store/return.png">
										</div>
									</div>
							<!-- -------------------------------------------- -->
							<div id="main" style="width: 100%;height:40%;"></div>
							<div id="main1" style="width: 100%;height:40%;"></div>
							<!-- -------------------------------------------- -->

	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<script type="text/javascript">
		//$(top.hangge());
		 // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
		var myChart1 = echarts.init(document.getElementById('main1'));
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '应收账款趋势分析'
            },
            tooltip: {},
            legend: {
                data:['销量']
            },
            xAxis: {
                data: ["浴缸","洗手盘","马桶","马桶盖","水龙头","花洒水龙头"]
            },
            yAxis: {},
            series: [{
                name: '销量',
                type: 'bar',
                data: [5, 18, 36, 10, 10, 20]
            }]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
		option1 = {
		    title : {
		        text: '应收账款趋势分析',
		        subtext: '测试数据',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: ['测试一','测试二','测试三','测试四','测试五']
		    },
		    series : [
		        {
		            name: '访问来源',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:335, name:'测试一'},
		                {value:310, name:'测试二'},
		                {value:234, name:'测试三'},
		                {value:135, name:'测试四'},
		                {value:1548, name:'测试五'}
		            ],
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
		};
		myChart1.setOption(option1);
		
	</script>


</body>
</html>