<%@ page contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>子页面</title>
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
			<a><cite>子页面</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <br>
    <!--代码块1-->
    <blockquote class="layui-elem-quote">
        使用方法1：用按钮点击打开
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
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    layui.use(["element", "code", "okTab"], function () {
        var $ = layui.jquery;
		var okTab = layui.okTab;

        layui.code({about: false});

        $("#addTab1").click(function () {
            okTab.add("瓜子二手车", "https://www.guazi.com");
        });

		$("#addTab2").click(function () {
		    okTab.add("国美电器", "https://www.gome.com.cn");
		});
    })
</script>
</body>
</html>
