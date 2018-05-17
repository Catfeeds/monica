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
<style>
	select {
		/*Chrome和Firefox里面的边框是不一样的，所以复写了一下*/
		border: solid 2px #006699;
		border-radius: 3px;
		/*很关键：将默认的select选择框样式清除*/
		appearance:none;
		-moz-appearance:none;
		-webkit-appearance:none;

		/*在选择框的最右侧中间显示小箭头图片*/
		background: url("http://ourjs.github.io/static/2015/arrow.png") no-repeat scroll right center transparent;
		/*为下拉小箭头留出一点位置，避免被文字覆盖*/
		padding-right: 16px;
		padding-top: 5px;
		padding-bottom: 5px;
		padding-left: 5px;
	}
	option{
		padding: 3px;
	}

	/*清除ie的默认选择框样式清除，隐藏下拉箭头*/
	select::-ms-expand { display: none; }
</style>
</head>
<body class="no-skin">
						<div class="header">
										数据分析
										<div class="header_left" onclick="window.history.go(-1)">
											<img src="static/images/store/return.png">
										</div>
									</div>
							<!-- -------------------------------------------- -->
							<div id="main" style="width: 100%;height:40%;"></div>
							<div style="width: 100%;height:40%;">
								<table style="width: 100%;height: 100%">
									<tr>
										<td style="width: 90%;">
											<div id="main1" style="width: 100%;height:100%;"></div>
										</td>
										<td style="width: 10%">
											<div id="" style="width: 100%;height:100%;margin-top: 0px;margin-right: 20px">
												<select id="month">
													<option value ="">按月搜索</option>
													<option value ="01">一月</option>
													<option value="02">二月</option>
													<option value="03">三月</option>
													<option value="04">四月</option>
													<option value="05">五月</option>
													<option value="06">六月</option>
													<option value="07">七月</option>
													<option value="08">八月</option>
													<option value="09">九月</option>
													<option value="10">十月</option>
													<option value="11">十一月</option>
													<option value="12">十二月</option>
												</select>
											</div>
										</td>
									</tr>

								</table>
							</div>

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
		var date = new Date();
        var option = {
            title: {
                text: '年份:'+date.getFullYear()+"年",
				textStyle:{
					fontSize:15
				}
            },
            tooltip: {},
            legend: {
                data:['每月订单量','每月提交订单量']
            },
            xAxis: {
                data: ["一","二","三","四","五","六","七","八","九","十","十一","十二"]
            },
            yAxis: {},
            series: [
				{
                name: '每月订单量',
                type: 'bar',
                data: []
				//data: [0, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0]
           		 },
				{
					name: '每月提交订单量',
					type: 'bar',
					data: []
				}
			]
        };

		$("#month").change(function () {
			$.get('<%=basePath%>dataAnalysis/loadforClient?month='+this.value).done(function (data) {
				// 填入数据
				myChart1.setOption({
					legend:[{
						data: data.jsonarrdataOfClient
					}],
					series: [{
						// 根据名字对应到相应的系列
						name: '客户订单',
						data: data.jsonData1
					}]
				});
			});
		});
		// 异步加载数据
		/*$.ajax({
			url: "http://192.168.1.132:8080/ssww/erp_Get/load",
			type: "GET",
			dataType: "jsonp",
			jsonp:"callback",
			jsonpCallback:"success_jsonpCallback",
			data: {
			},
			success: function(data){
				myChart.setOption({
					xAxis: {
						data: ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
					},
					series: [
						{
							// 根据名字对应到相应的系列
							name: '每月订单量',
							data: data.data1
						},
						{
							// 根据名字对应到相应的系列
							name: '每月提交订单量',
							data: data.data2
						},
					]
				});
			},
			error: function(){
				alert("失败，请稍后重试！！");
			},
		});*/
		$.get('<%=basePath%>dataAnalysis/load').done(function (data) {
			// 填入数据
			myChart.setOption({
				xAxis: {
					data: ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
				},
				series: [
					{
					// 根据名字对应到相应的系列
					name: '每月订单量',
					data: data.data2
					},
					{
						// 根据名字对应到相应的系列
						name: '每月提交订单量',
						data: data.data1
					},
				]
			});
			myChart1.setOption(option1);
		});

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);


		option1 = {
		    title : {
		        text: '客户订单数据比例分析',
				textStyle:{
					fontSize:15
				},
		        subtext: '当月订单比例数据',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: [/*'测试一','测试二','测试三','测试四','测试五'*/]
		    },
		    series : [
		        {
		            name: '访问来源',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		               /* {value:335, name:'测试一'},
		                {value:310, name:'测试二'},
		                {value:234, name:'测试三'},
		                {value:135, name:'测试四'},
		                {value:1548, name:'测试五'}*/
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

		// 异步加载数据
		$.get('<%=basePath%>dataAnalysis/loadforClient').done(function (data) {
			// 填入数据
			myChart1.setOption({
				legend:[{
					data: data.jsonarrdataOfClient
				}],
				series: [{
					// 根据名字对应到相应的系列
					name: '客户订单',
					data: data.jsonData1
				}]
			});
		});
		myChart1.setOption(option1);


	</script>


</body>
</html>