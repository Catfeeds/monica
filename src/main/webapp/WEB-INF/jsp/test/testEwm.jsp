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

    <title>正在跳转，到工作台</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="format-detection" content="telephone=no" />
    <!--
        <link rel="stylesheet" type="text/css" href="styles.css">
        -->
    <script src="static/js/store/jquery-2.1.4.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
</head>

<body>
<button class="btn btn_primary" id="uploadImage" onclick="ewm()">二维码</button>
</body>

<script type="text/javascript">
    wx.config({
        //beta: true,// 必须这么写，否则在微信插件有些jsapi会有问题
        //debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
        appId : 'ww49c384af1f4dac63', // 必填，企业微信的cropID
        timestamp : parseInt('${timestamp}'), // 必填，生成签名的时间戳
        nonceStr : '${nonceStr}', // 必填，生成签名的随机串
        signature : '${signature}',// 必填，签名，见[附录1](#11974)
        jsApiList : [ 'chooseImage', 'uploadImage',//上传图片接口
            'downloadImage'//下载图片接口

        ]
        // 必填，需要使用的JS接口列表，所有JS接口列表见附录2
    });
    wx.getLocation({
        type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
        success: function (res) {
            var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
            var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
            var speed = res.speed; // 速度，以米/每秒计
            var accuracy = res.accuracy; // 位置精度
            alert(accuracy);
        }
    });
    wx.ready(function() {

        var images = {
            localId : [],
            serverId : []
        };
        document.querySelector('#chooseImage').onclick = function() {
            wx.chooseImage({
                sizeType : [ 'compressed' ], // 可以指定是原图还是压缩图，默认二者都有
                success : function(res) {
                    images.localId = res.localIds;
                    //  alert(res);
                    //alert('已选择 ' + res.localIds.length + ' 张图片');

                }
            });
        };
        document.querySelector('#uploadImage').onclick = function() {
            if (images.localId.length == 0) {
                alert('请先使用 chooseImage 接口选择图片');
                return;
            }
            var i = 0, length = images.localId.length;
            images.serverId = [];
            function upload() {
                wx.uploadImage({
                    localId : images.localId[i],
                    success : function(res) {
                        i++;
                        alert('已上传：' + i + '/' + length);
                        images.serverId.push(res.serverId);
                        if (i < length) {
                            upload();
                        }
                    },
                    fail : function(res) {
                        alert(JSON.stringify(res));
                    }
                });
            }
            upload();
        };

        // 5.4 下载图片
        document.querySelector('#downloadImage').onclick = function() {
            if (images.serverId.length === 0) {
                alert('请先使用 uploadImage 上传图片');
                return;
            }
            var i = 0, length = images.serverId.length;
            images.localId = [];
            function download() {
                wx.downloadImage({
                    serverId : images.serverId[i],
                    success : function(res) {
                        alert(JSON.stringify(res));
                        i++;
                        alert('已下载：' + i + '/' + length);
                        images.localId.push(res.localId);
                        if (i < length) {
                            download();
                        }
                    }
                });
            }
            download();
        };
    });

    function ewm() {
        wx.scanQRCode({
            needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
            scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
            success: function (res) {
                var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
                alert(result);
            }
        });
    }
    <%-- $(function(){
              jump();
            });
            function jump(){
              window.location.href="<%=basePath%>check.html";
            }; --%>
</script>
</html>
