<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" name="viewport" />
    <title>上拉到底部加载更多</title>
</head>
<style>
    *{margin: 0;padding: 0;}
    img{width: 48%;;height: 150px;display: inline;border: 1px solid #ccc;}
    #more p{text-align: center;}
</style>
<body>
<div id="div">
    <div id="divImg">
    </div>
    <div id="more" onclick="startLoad()">
        <p>加载更多</p>
    </div>
</div>
<script>
    /* (function(){ */
    
    //滚动条到页面底部加载更多案例	
$(window).scroll(function(){
    var scrollTop = $(this).scrollTop();             	                //滚动条距离顶部的高度
    var scrollHeight = $(document).height();                  	//当前页面的总高度
    var clientHeight = $(this).height();                	        //当前可视的页面高度
   // console.log("top:"+scrollTop+",doc:"+scrollHeight+",client:"+clientHeight);
    if(scrollTop + clientHeight >= scrollHeight){                 //距离顶部+当前高度 >=文档总高度 即代表滑动到底部
    	count++;                                                                  //每次滑动count加1
    	alert (count);
    	filterData(serviceTypeId,industryId,cityId,count);    //调用筛选方法，count为当前分页数
	 }else if(scrollTop<=0){			
		 //滚动条距离顶部的高度小于等于0 TODO
		 //alert("下拉刷新，要在这调用啥方法？");
	 }
});
        var more = true;
        //开始进入页面调用
        function startLoad(){
            //显示到#more所需高度
            var moreHeight = document.getElementById('divImg').offsetHeight + 20;
            var clientHeight =  window.screen.availHeight;
            //如果直接显示出了#more
          //  alert(moreHeight<clientHeight);
            if (moreHeight<clientHeight){
                setTimeout(function(){
                    console.info('加载更多');
                    document.getElementById('divImg').innerHTML += "123";
                },1000);
                //没有更多，可在ajax返回时判断有没有更多
                //more = false;
            }
        }
        startLoad();
        window.onscroll = function(){
        	alert("123");
            loadMore();
        };
        function loadMore(){
            var moreHeight = document.getElementById('divImg').offsetHeight + 20;
            var clientHeight =  window.screen.availHeight;
            var scrollHeight = document.body.scrollTop;
            //判断是否上拉到显示#more
            if (scrollHeight > moreHeight-clientHeight){
                //判断是否还有更多
                if (!more){
                    setTimeout(function() {
                        document.querySelector('#more p').innerHTML = '没有更多';
                    },500);
                    return false;
                }
                setTimeout(function(){
                    console.info('加载更多');
                   document.getElementById('divImg').innerHTML += "123";
                },1000);
                //没有更多，可在ajax返回时判断有没有更多
                more = false;
            }
        }
    /* })() */
</script>
</body>
</html>