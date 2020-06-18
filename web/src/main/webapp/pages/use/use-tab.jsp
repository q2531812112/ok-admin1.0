<%@ page contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tab使用</title>
    <link rel="stylesheet" href="../../css/okadmin.css">
</head>
<body>
<div class="ok-body">
    <!--面包屑导航区域-->
    <div class="ok-body-breadcrumb">
        <span class="layui-breadcrumb">
            <a><cite>首页</cite></a>
            <a><cite>框架使用</cite></a>
            <a><cite>Tab使用</cite></a>
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
        // tab-id不可和其它菜单重复
        <dd><a href="javascript:;" path="xx.html" tab-id="xx-1"><i class="iconfont icon-xx"></i> xx列表</a></dd>
    </dl>
</li>
    </pre>

    <!--代码块2-->
    <blockquote class="layui-elem-quote">
        使用方法2：在index.html顶部中添加
    </blockquote>
    <pre class="layui-code" lay-title="HTML" lay-encode="true">
<dl class="layui-nav-child">
    <dd><a href="javascript:;" path="user-center.html" tab-id="0-1">个人中心<span class="layui-badge-dot"></span></a></dd>
    <dd><a href="javascript:;" path="user-info.html" tab-id="0-2">基本资料</a></dd>
    <dd><a href="javascript:;" path="user-security.html" tab-id="0-3">安全设置</a></dd>
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
 * @param tabId tabId必须唯一
 */
tabAdd("百度", "http://www.xlbweb.cn", "11-1")
    </pre>
    <button class="layui-btn" id="addTab">打开一个新的Tab</button>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script src="../../js/okadmin.js"></script>
<script>
    layui.use(["element", "code"], function () {
        layui.code({about: false});
        var $ = layui.jquery;

        $("#addTab").click(function () {
            tabAdd("ok-tool", "http://tool.xlbweb.cn", "11-1")
        });
    })
</script>
</body>
</html>
