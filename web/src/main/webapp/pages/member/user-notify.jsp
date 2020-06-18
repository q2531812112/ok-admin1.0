<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>消息中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/okadmin.css">
</head>
<body>
<div class="ok-body">
    <!--面包屑导航区域-->
    <div class="ok-body-breadcrumb">
        <span class="layui-breadcrumb">
            <a><cite>首页</cite></a>
            <a><cite>顶部导航</cite></a>
            <a><cite>消息中心</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
	<!-- Tab选项卡 -->
	<div class="layui-tab layui-tab-brief">
		<ul class="layui-tab-title">
			<li class="layui-this">全部消息</li>
			<li>通知<span class="layui-badge">6</span></li>
			<li>私信</li>
		</ul>
		<div class="layui-tab-content"></div>
	</div>  
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    layui.use(["element", "form", "okLayer", "okUtils"], function () {
        var form = layui.form;
		var $ = layui.jquery;
        var okLayer = layui.okLayer;
        var okUtils = layui.okUtils;
    });
</script>
</body>
</html>
