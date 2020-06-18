<%@ page contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>okUtils使用</title>
    <link rel="stylesheet" href="../../css/okadmin.css">
</head>
<body>
<div class="ok-body">
    <!--面包屑导航区域-->
    <div class="ok-body-breadcrumb">
        <span class="layui-breadcrumb">
            <a><cite>首页</cite></a>
            <a><cite>框架使用</cite></a>
            <a><cite>okUtils使用</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <br>
    <!--代码块1-->
    <blockquote class="layui-elem-quote">
        okUtils.ajax()
    </blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
/**
 * 弹窗打开窗口页面
 * @param url 请求url
 * @param type 请求类型
 * @param param 请求参数
 */
okUtils.ajax("/user/batchDel", "post", {idsStr: idsStr}).done(function (response) {
    console.log(response)
    okLayer.tableOperationMsg("批量删除成功");
}).fail(function (error) {
    console.log(error)
});
</pre>

    <!--代码块2-->
    <blockquote class="layui-elem-quote">
        okUtils.table.xxx()
    </blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
// 做批量操作时，table行数据检查
okUtils.table.batchCheck(table)
// table页面操作执行成功后的提示
okUtils.table.successMsg()
</pre>

    <!--代码块3-->
    <blockquote class="layui-elem-quote">
        okUtils.isNum()
    </blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
// 判断是否为一个正常的数字
okUtils.isNum()
// 判断一个数字是否包括在某个范围
okUtils.isNum(num, begin, end)
</pre>

    <!--代码块3-->
    <blockquote class="layui-elem-quote">
        okUtils.date.xxx()
    </blockquote>

<pre class="layui-code" lay-title="JavaScript" lay-encode="true">
// 格式化日期时间
okUtils.dateFormat(date, fmt)
</pre>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script src="../../js/okadmin.js"></script>
<script>
    layui.use(["element", "code"], function () {
        layui.code({about: false});
    });
</script>
</body>
</html>
