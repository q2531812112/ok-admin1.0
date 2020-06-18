<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加用户</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/okadmin.css">
</head>
<body>
<div class="ok-body">
    <!--面包屑导航区域-->
    <div class="ok-body-breadcrumb">
        <span class="layui-breadcrumb">
            <a><cite>首页</cite></a>
            <a><cite>会员管理</cite></a>
            <a><cite>用户列表</cite></a>
            <a><cite>添加用户</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <!--form表单-->
    <form class="layui-form layui-form-pane ok-form">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="accountName" placeholder="请输入用户名" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">真实姓名</label>
            <div class="layui-input-block">
                <input type="text" name="name" placeholder="请输入真实姓名" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">邮箱</label>
            <div class="layui-input-block">
                <input type="text" name="email" placeholder="请输入邮箱" autocomplete="off" class="layui-input" lay-verify="email">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-block">
                <input type="password" name="accountPassword" placeholder="请输入密码" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">角色</label>
            <div class="layui-input-block">
                <select name="roleId" id="xm">

                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-block">
                <input type="checkbox" name="status" lay-skin="switch" lay-text="启用|停用" checked value="0">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="add">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    layui.use(["element", "form", "laydate", "okLayer", "okUtils"], function () {
        var form = layui.form;
        var laydate = layui.laydate;
		var okLayer = layui.okLayer;
		var okUtils = layui.okUtils;

		//初始化下拉框,获取所有角色的信息
        var $ = layui.jquery;
        $.ajax({
            url: okUtils.mockApi.role.list,
            dataType: 'json',
            type: 'get',
            success: function (data) {
                $.each(data.data, function (index, item) {
                    $('#xm').append(new Option(item.name, item.id));// 下拉菜单里添加元素
                });
                layui.form.render("select");
            }
        });

        form.on("submit(add)", function (data) {
			okUtils.ajax(okUtils.mockApi.user.add, "post", data.field).done(function (response) {
			    console.log(response)
                okLayer.msg.greenTick("添加成功", function () {
                    parent.layer.close(parent.layer.getFrameIndex(window.name),function(){
                        location.reload();
                    });
                });
			}).fail(function (error) {
			    console.log(error)
			});
            return false;
        });
    })
</script>
</body>
</html>
