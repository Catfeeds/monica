<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
    <title>提交申请</title>
	<base href="<%=basePath%>">
    <meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<meta name="description" content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.
">
<link rel="stylesheet" href="static/jquery-weui-build/css/jquery-weui.css">
<link rel="stylesheet" href="static/jquery-weui-build/lib/weui.css">

  </head>

  <body ontouchstart>

    <div class="bd">
      <div class="page__bd">
        <div class="weui-cells__title"></div>
        <div class="weui-cells">
          <div class="weui-cell">
            <div class="weui-cell__hd"></div>
            <div class="weui-cell__bd">
              <p><strong> 请假申请单 </strong></p>
            </div>
            <div class="weui-cell__ft"></div>
          </div>
        </div>

        <div class="weui-cells__title"></div>
		<div class="weui-cells">
			<div class="weui-cell">
	            <div class="weui-cell__bd">
	              <p>申请人</p>
	            </div>
	            <div class="weui-cell__ft">123123</div>
	        </div>
			<div class="weui-cell">
	            <div class="weui-cell__bd">
	              <p>部门</p>
	            </div>
	            <div class="weui-cell__ft">捷特科技</div>
	        </div>
			<div class="weui-cell">
	            <div class="weui-cell__bd">
	              <p>日期</p>
	            </div>
	            <div class="weui-cell__ft" id="date"></div>
	        </div>
		</div>
		<div class="weui-cells weui-cells_form">
	       <div class="weui-cell">
		        <div class="weui-cell__hd"><label for="name" class="weui-label">请假类型  <a style="color: red">*</a></label></div>
		        <div class="weui-cell__bd">
		          <input class="weui-input" id="name" type="text" value="">
		        </div>
		      </div>
	    </div>
	    <div class="weui-cells">
          <div class="weui-cell">
	         <div class="weui-cell__hd"><label for="time-format" class="weui-label">开始时间</label></div>
	        <div class="weui-cell__bd">
	          <input class="weui-input" id="time-format" type="text" value="">
	        </div>
	      </div>
	      <div class="weui-cell">
	         <div class="weui-cell__hd"><label for="time-format1" class="weui-label">截止时间</label></div>
	        <div class="weui-cell__bd">
	          <input class="weui-input" id="time-format1" type="text" value="">
	        </div>
	      </div>
        </div>
        <br>
        <div class="weui-cells__title"><label for="name" class="weui-label">请假原因  <a style="color: red">*</a></label></div>
	    <div class="weui-cells weui-cells_form">
	      <div class="weui-cell">
	        <div class="weui-cell__bd">
	          <textarea class="weui-textarea" placeholder="请输入文本" rows="3"></textarea>
	          <div class="weui-textarea-counter"><span>0</span>/200</div>
	        </div>
	      </div>
	    </div>
      </div>
    </div>
    <div class="weui-btn-area">
      <a class="weui-btn weui-btn_primary" href="javascript:" id="showTooltips">提交</a>
    </div>
    <script src="static/js/jquery-2.1.1.js">
    </script>
<script>
  $(function() {
    FastClick.attach(document.body);
  });
</script>
<script src="static/jquery-weui-build/js/jquery-weui.js">
</script>
<script src="static/jquery-weui-build/lib/fastclick.js"></script>


    <script>
      $('.delete-swipeout').click(function () {
        $(this).parents('.weui-cell').remove()
      });
      
      $('.close-swipeout').click(function () {
        $(this).parents('.weui-cell').swipeout('close')
      });
      
      $("#name").picker({
        title: "--选择请假类型--",
        cols: [
          {
            textAlign: 'center',
            values: ['事假', '年假', '病假', '调休', '婚假', '产假', '丧假', '哺乳假']
          }
        ]
      });
		
      var mydate = new Date();
      function date(){
    	  var year = mydate.getFullYear();
    	  if((mydate.getMonth()+1)<10){
    		  var month = "0" + (mydate.getMonth()+1);
    	  }else{
    		  var month = mydate.getMonth()+1;
    	  }
    	  if(mydate.getDate()<10){
    		  var ri = "0" + mydate.getDate();
    	  }else{
    		  var ri = mydate.getDate();
    	  }
    	  if(mydate.getHours()<10){
    		  var hours = "0" + mydate.getHours();
    	  }else{
    		  var hours = mydate.getHours();
    	  }
    	  if(mydate.getMinutes()<10){
    		  var minutes = "0" + mydate.getMinutes();
    	  }else{
    		  var minutes = mydate.getMinutes();
    	  }
    	  var datestr = year+"年"+month+"月"+ri+"日"+" "+hours+"时"+minutes+"分";
    	  return datestr;
      }
      
      $("#date").text(date().substring(0, date().length - 7));
      $("#time-format").val(date());
      $("#time-format1").val(date());
      
      $("#time-format").datetimePicker({
          title: '开始时间',
          yearSplit: '年',
          monthSplit: '月',
          dateSplit: '日',
          times: function () {
            return [  // 自定义的时间
              {
                values: (function () {
                  var hours = [];
                  for (var i=0; i<24; i++) hours.push(i > 9 ? i : '0'+i);
                  return hours;
                })()
              },
              {
                divider: true,  // 这是一个分隔符
                content: '时'
              },
              {
                values: (function () {
                  var minutes = [];
                  for (var i=0; i<59; i++) minutes.push(i > 9 ? i : '0'+i);
                  return minutes;
                })()
              },
              {
                divider: true,  // 这是一个分隔符
                content: '分'
              }
            ];
          },
          onChange: function (picker, values, displayValues) {
            console.log(values);
            $("#time-format1").val( values[0]+"年"+values[1]+"月"+values[2]+"日"+" "+values[3]+"时"+values[4]+"分");
          }
        });
      
      
      $("#time-format1").datetimePicker({
          title: '截止时间',
          yearSplit: '年',
          monthSplit: '月',
          dateSplit: '日',
          times: function () {
            return [  // 自定义的时间
              {
                values: (function () {
                  var hours = [];
                  for (var i=0; i<24; i++) hours.push(i > 9 ? i : '0'+i);
                  return hours;
                })()
              },
              {
                divider: true,  // 这是一个分隔符
                content: '时'
              },
              {
                values: (function () {
                  var minutes = [];
                  for (var i=0; i<59; i++) minutes.push(i > 9 ? i : '0'+i);
                  return minutes;
                })()
              },
              {
                divider: true,  // 这是一个分隔符
                content: '分'
              }
            ];
          },
          onChange: function (picker, values, displayValues) {
            console.log(values);
          }
        });
    </script>
	
  </body>
</html>
