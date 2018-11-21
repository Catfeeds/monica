<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <!-- 下拉框 -->
    <link rel="stylesheet" href="static/ace/css/chosen.css"/>
    <!-- jsp文件头和头部 -->
    <%@ include file="../../system/index/top.jsp" %>
    <!-- 日期框 -->
    <link rel="stylesheet" href="static/ace/css/datepicker.css"/>
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
                        <!-- 检索  -->
                        <form action="commodity/toCommodityBy_tree.do?treeKey=${pd.treeKey }" method="post" name="Form" id="Form">
                            <input type="hidden" id="msg"/>
                            <input type="hidden" id="FCOMMODITYIDS"/>
                            <table style="margin-top:5px;">
                                <tr>
                                    <td>
                                        <div class="nav-search">
                                            商品代码： <span class="input-icon">
											<input type="text" placeholder="按商品代码进行搜索" class="nav-search-input"
                                                   id="nav1-input" autocomplete="off" name="keywords"
                                                   value="${pd.keywords }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
                                        </div>
                                    </td>
                                    <td width="15px"></td>
                                    <td>
                                        <div class="nav-search">
                                            商品名称：  <span class="input-icon">
											<input type="text" placeholder="按商品名称进行搜索" class="nav-search-input"
                                                   id="nav-search-input" autocomplete="off" name="keywords1"
                                                   value="${pd.keywords1 }" placeholder="这里输入关键词"/>
											<i class="ace-icon fa fa-search nav-search-icon"></i>
										</span>
                                        </div>
                                    </td>
                                    <c:if test="${QX.cha == 1 }">
                                        <td style="vertical-align:top;padding-left:2px">
                                            <a class="btn btn-light btn-xs" onclick="tosearch();" title="查询"><i
                                                id="nav-search-icon"
                                                class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i>查询
                                            </a>
                                            <a class="btn btn-light btn-xs" onclick="Form_reset()"  title="重置">
                                                <i id="nav-repeat-icon" class="ace-icon fa fa-repeat bigger-120"></i>重置
                                            </a>
                                        </td>
                                    </c:if>
                                    
                                    <td style="vertical-align:top;padding-left:2px">
                                        <a class="btn btn-light btn-xs" onclick="submitCommodities();" data-rel="tooltip" title="提交">
                                          <i class="ace-icon fa fa-pencil-square-o bigger-120 orange"></i>提交
                                        </a>

                                        <a class="btn btn-light btn-xs" onclick="top.Dialog.close();" data-rel="tooltip" title="取消">
                                            <i class="ace-icon fa fa-pencil-square-o bigger-120 orange"></i>取消
                                        </a>
                                    </td>
                                </tr>
                            </table>
                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover"
                                   style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width:35px;">
                                        <label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox"/><span
                                                class="lbl"></span></label>
                                    </th>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">商品代码</th>
                                    <th class="center">商品名称</th>
                                    <th class="center">规格</th>
                                    <th class="center">数量</th>
                                    <th class="center">库存</th>
                                    <th class="center">上下架</th>
                                    <th class="center">商品主图片</th>
                                    <th class="center">商品描述</th>
                                    <th class="center">商品价格</th>
                                    <th class="center">优惠折扣</th>
                                    <th class="center">状态</th>
                                </tr>
                                </thead>

                                <tbody>
                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty varList}">
                                        <c:if test="${QX.cha == 1 }">
                                            <c:forEach items="${varList}" var="var" varStatus="vs">
                                                <tr id="tr${var.COMMODITY_ID}" name="listBeen" onclick="toCheck('${var.COMMODITY_ID}')" style="cursor: pointer;">
                                                    <td class='center'>
                                                        <label class="pos-rel"><input id="${var.COMMODITY_ID}" type='checkbox' name='ids'
                                                                                      value="${var.COMMODITY_ID}"
                                                                                      class="ace"/><span
                                                                class="lbl"></span></label>
                                                    </td>
                                                    <td class='center' style="width: 30px;">${vs.index+1}</td>
                                                        <%-- <td class='center'>${var.FITEMID}</td>
                                                        <td class='center'>${var.FPARENTID}</td> --%>
                                                    <td class='center'>${var.FNUMBER}</td>
                                                    <td class='center'>${var.FNAME}</td>
                                                    <td class='center'>${var.FMODEL}</td>
                                                    <td class='center'>${var.FQTY}</td>
                                                    <td class='center'>${var.INVENTORY}</td>
                                                    <td class='center'
                                                            <c:choose>
                                                                <c:when test="${var.ISPUTAWAY == '未上架'}">
                                                                    style="color: #990000"
                                                                </c:when>
                                                                <c:otherwise>
                                                                    style="color:#3333FF"
                                                                </c:otherwise>
                                                            </c:choose>
                                                    >
                                                            ${var.ISPUTAWAY}
                                                    </td>
                                                    <td class='center'><a class='btn btn-xs btn-info'
                                                                          onclick="previewPic('${var.COMMODITY_ID}');event.cancelBubble=true">预览封面图片</a>
                                                    </td>
                                                    <td class='center'>无法预览</td>
                                                    <td class='center'>${var.PRICE}</td>
                                                    <td class='center'>${var.DISCOUNT}折</td>
                                                    <td class='center'>${var.STATE}</td>
                                                </tr>

                                            </c:forEach>
                                        </c:if>
                                        <c:if test="${QX.cha == 0 }">
                                            <tr>
                                                <td colspan="100" class="center">您无权查看</td>
                                            </tr>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="100" class="center">没有相关数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;">
                                            <div class="pagination"
                                                 style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div>
                                        </td>
                                    </tr>
                                </table>
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
    <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
        <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
    </a>

</div>
<!-- /.main-container -->

<!-- basic scripts -->
<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp" %>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
<!-- ace scripts -->
<script src="static/ace/js/ace/ace.js"></script>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">
    $(top.hangge());//关闭加载状态
    //检索
    function tosearch() {
        top.jzts();
        $("#Form").submit();
    }
    //重置
    function Form_reset(){
        document.getElementById("Form").reset();
    }
    $(function () {

        //日期框
        $('.date-picker').datepicker({
            autoclose: true,
            todayHighlight: true
        });

        //下拉框
        if (!ace.vars['touch']) {
            $('.chosen-select').chosen({allow_single_deselect: true});
            $(window)
                    .off('resize.chosen')
                    .on('resize.chosen', function () {
                        $('.chosen-select').each(function () {
                            var $this = $(this);
                            $this.next().css({'width': $this.parent().width()});
                        });
                    }).trigger('resize.chosen');
            $(document).on('settings.ace.chosen', function (e, event_name, event_val) {
                if (event_name != 'sidebar_collapsed') return;
                $('.chosen-select').each(function () {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                });
            });
            $('#chosen-multiple-style .btn').on('click', function (e) {
                var target = $(this).find('input[type=radio]');
                var which = parseInt(target.val());
                if (which == 2) $('#form-field-select-4').addClass('tag-input-style');
                else $('#form-field-select-4').removeClass('tag-input-style');
            });
        }


        //复选框全选控制
        var active_class = 'active';
        $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
            var th_checked = this.checked;//checkbox inside "TH" table header
            $(this).closest('table').find('tbody > tr').each(function () {
                var row = this;
                if (th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
            });
        });
    });

    function previewPic(cid) {
        var diag = new top.Dialog();
        diag.Drag = true;
        diag.Title = "封面预览图片";
        diag.URL = "<%=basePath%>commodity/toPreview?cid=" + cid;
        diag.Width = 800;
        diag.Height = 550;
        diag.Modal = true; //有无遮罩窗口
        diag.ShowMaxButton = true; //最大化按钮
        diag.ShowMinButton = true; //最小化按钮
        /* diag.CancelEvent = function(){ //关闭事件
         if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
         if('
        ${page.currentPage}' == '0'){
         top.jzts();
         setTimeout("self.location=self.location",100);
         }else{
         nextPage(
        ${page.currentPage});
         }
         }
         diag.close();
         }; */
        diag.show();
    }

    function toCheck(Id){
        $("#simple-table").find("tr[name='listBeen']").css("background-color", "");
        $("#tr" + Id).css("background-color", "#CCCC99");
        if($("#"+Id).prop("checked")){
            $("#"+Id).removeAttr("checked");
        }else {
            $("#"+Id).prop("checked",true);
        }
    }

    function submitCommodities() {
        $("#msg").val("save");
        var vals = [];
        var checkBoxs = document.getElementsByName('ids');
        for (var i=0; i<checkBoxs.length; i++){
            if (checkBoxs[i].checked == true){
                vals.push(checkBoxs[i].value);
            }
        }
        if(vals == null || vals.length == 0){
            bootbox.alert({
                size: "small",
                title:"失败",
                message: "请至少选择一个商品!"
            });
            return false;
        }
        $("#FCOMMODITYIDS").val(vals);
        top.Dialog.close();
    }
</script>


</body>
</html>