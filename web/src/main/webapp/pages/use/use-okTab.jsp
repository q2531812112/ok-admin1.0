<%@ page contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>okTab使用</title>
    <link rel="stylesheet" href="../../css/okadmin.css">
</head>
<body>
<div class="ok-body">
    <!--面包屑导航区域-->
    <div class="ok-body-breadcrumb">
        <span class="layui-breadcrumb">
            <a><cite>首页</cite></a>
            <a><cite>框架使用</cite></a>
            <a><cite>okTab使用</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <br>
    <!--代码块1-->
    <blockquote class="layui-elem-quote">
        使用方法1：在index.html左侧中添加
    </blockquote>

<pre class="layui-code" lay-title="HTML" lay-encode="true">
<li class="layui-nav-item">
    <a class="" href="javascript:;">
        <i class="iconfont icon-ai-new"></i> XX管理
    </a>
    <dl class="layui-nav-child">
        <dd><a href="javascript:;" path="xx.html"><i class="iconfont icon-xx"></i> xx列表</a></dd>
    </dl>
</li>
</pre>

    <!--代码块2-->
    <blockquote class="layui-elem-quote">
        使用方法2：在index.html顶部中添加
    </blockquote>

<pre class="layui-code" lay-title="HTML" lay-encode="true">
<dl class="layui-nav-child">
    <dd><a href="javascript:;" path="user-center.html">个人中心<span class="layui-badge-dot"></span></a></dd>
    <dd><a href="javascript:;" path="user-info.html">基本资料</a></dd>
    <dd><a href="javascript:;" path="user-security.html">安全设置</a></dd>
    <dd><a href="javascript:;" id="lock">锁定账户</a></dd>
</dl>
</pre>

    <!--代码块3-->
    <blockquote class="layui-elem-quote">
        使用方法3：用按钮点击打开
    </blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
/**
 * 添加tab
 * @param title 标题
 * @param path 路径
 */
okTab.tabAdd("ok-tool", "http://www.xlbweb.cn")
</pre>

    <button class="layui-btn" id="addTab1">打开一个新的Tab1</button>
	<button class="layui-btn" id="addTab2">打开一个新的Tab2</button>
	<button class="layui-btn" id="addTab3">参数填写错误的Tab2</button>
	<button class="layui-btn" id="addTab4">在子页面打开一个新的Tab3</button>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    layui.use(["element", "code", "okTab", "okLayer"], function () {
        var $ = layui.jquery;
		var okTab = layui.okTab;
		var okLayer = layui.okLayer;

        layui.code({about: false});

        $("#addTab1").click(function () {
            okTab.add("okLayer", "pages/use/use-okLayer.html");
        });

		$("#addTab2").click(function () {
		    okTab.add("ok-tool", "http://tool.xlbweb.cn");
		});

		$("#addTab3").click(function () {
		    // 参数漏写或为空
            // okTab.add("test");
            okTab.add("test", "");
		});

        $("#addTab4").click(function () {
            okLayer.open("子页面", "use-okTab-sub.jsp", "90%", "90%", function() {})
        });
    })
</script>
</body>
</html>
