
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>.</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="keywords" content="ok-admin v1.0,ok-admin网站后台模版,后台模版下载,后台管理系统模版,HTML后台模版下载">
    <meta name="description" content="ok-admin v1.0，顾名思义，很赞的后台模版，它是一款基于Layui框架的轻量级扁平化且完全免费开源的网站后台管理系统模板，适合中小型CMS后台系统。">
    <link rel="shortcut icon" href="imgs/favicon.ico"/>
    <link rel="stylesheet" href="css/okadmin.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <!--头部导航-->
    <div class="layui-header">
        <div class="layui-logo">😀😀😀😀😀</div>
        <div class="menu-switch">
            <i class="iconfont icon-caidan"></i>
        </div>
        <ul class="layui-nav layui-layout-left">
            <li class="weather">
                <div id="tp-weather-widget"></div>
            </li>
        </ul>
        <ul class="layui-nav layui-layout-right" lay-filter="navFilter">
			<li class="textMarquee">
				<marquee>通知：欢迎回来
                    ${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}
                </marquee>
			</li>
            <li class="layui-nav-item">
                <input name="id" id="id" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.id}" type="hidden"/>
                <a href="javascript:;">
                    <img src="" id="portrait" class="layui-nav-img">
                    ${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}
                </a>
                <dl class="layui-nav-child">
                    <dd lay-unselect><a href="javascript:;" path="pages/member/user-info.jsp">个人中心</a></dd>
                    <dd lay-unselect><a href="javascript:;" path="pages/member/user-notify.jsp">消息<span class="layui-badge-dot"></span></a><hr></dd>
                    <dd lay-unselect><a href="javascript:;" path="pages/member/user-center.jsp">基本资料</a></dd>
					<dd lay-unselect><a href="javascript:;" path="pages/member/user-pwd.jsp">修改密码</a><hr></dd>
                    <dd lay-unselect><a href="javascript:;" id="lock">锁定账户</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="javascript:void(0)" id="logout">退出</a></li>
        </ul>
    </div>
    <!--左侧导航区域-->
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">
            <!--可自定义选择展开收缩图标: 默认|arrow1|arrow2-->
            <ul class="layui-nav layui-nav-tree arrow2" lay-shrink="all" lay-filter="navFilter">
            </ul>
        </div>
    </div>
    <!-- 内容主体区域 -->
    <div class="content-body">
        <div class="layui-tab layui-tab-brief" lay-filter="ok-tab" lay-allowClose="true">
            <ul class="layui-tab-title">
                <li class="layui-this"><i class="iconfont icon-home" style="font-size:15px;"></i> 控制台</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe src="pages/welcome.jsp" frameborder="0" scrolling="yes" width="100%" height="100%"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="yy"></div>
<!--js逻辑-->
<script src="lib/layui/layui.js"></script>
<script src="js/okadmin.js"></script>
<script src="js/weather.js"></script>
<script src="js/baidu.js"></script>
<script>
    var fileName;
    layui.use(["element", "form", "laydate", "upload", "util", "okLayer", "okUtils"], function () {
        var $ = layui.jquery;
        var form = layui.form;
        var okUtils = layui.okUtils;
        $(function () {
            var uid = $("#id").val();
            okUtils.ajax(okUtils.mockApi.user.myUser, "get", "uid=" + uid).done(function (response) {
                console.log(response[0])
                $("#portrait").attr("src", "/oa/" + response[0].portrait);
            }).fail(function (error) {
                console.log(error)
            });
        });
    });
</script>
</body>
</html>
