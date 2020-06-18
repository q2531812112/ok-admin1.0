
<%@ page contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>okLayer使用</title>
    <link rel="stylesheet" href="../../css/okadmin.css">
</head>
<body>
<div class="ok-body">
    <!--面包屑导航区域-->
    <div class="ok-body-breadcrumb">
        <span class="layui-breadcrumb">
            <a><cite>首页</cite></a>
            <a><cite>框架使用</cite></a>
            <a><cite>okLayer使用</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <br>
    <!--代码块1-->
    <blockquote class="layui-elem-quote">
        okLayer.tableCheck()
    </blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
// 对表格进行批量操作时的预检查
okLayer.tableCheck(table)
</pre>

    <!--代码块2-->
    <blockquote class="layui-elem-quote">
        okLayer.tableOperationMsg()
    </blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
// 对表格操作后的提示信息
okLayer.tableOperationMsg("批量启用成功");
okLayer.tableOperationMsg("批量停用成功");
</pre>

    <!--代码块3-->
    <blockquote class="layui-elem-quote">
        okLayer.confirm()
    </blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
okLayer.confirm("确定要批量删除吗？", function (index) {
    layer.close(index);
    // 代码逻辑
});
</pre>

	<!--代码块4-->
	<blockquote class="layui-elem-quote">
		okLayer.open()
	</blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
/**
 * 弹窗打开窗口页面
 * @param title 标题
 * @param content 内容url
 * @param width 弹窗宽度
 * @param height 弹窗高度
 * @param successFunction 弹出后回调函数
 * @param endFunction 销毁后回调函数
 */
okLayer.open("添加用户", "user-add.html", "90%", "90%", function(layero, index) {}, function() {})
</pre>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    layui.use(["element", "code"], function () {
        layui.code({about: false});
    });
</script>
</body>
</html>
