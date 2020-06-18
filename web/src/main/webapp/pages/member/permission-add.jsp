<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>添加权限</title>
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
            <a><cite>权限列表</cite></a>
            <a><cite>添加权限</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <!--form表单-->
    <form class="layui-form layui-form-pane ok-form">
        <div class="layui-form-item">
            <label class="layui-form-label">权限名称</label>
            <div class="layui-input-block">
                <input type="text" name="name" placeholder="请输入权限名称" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">资源路径</label>
            <div class="layui-input-block">
                <input type="text" name="location" placeholder="请输入资源路径" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">父级权限ID</label>
            <div class="layui-input-block">
                <input type="text" name="parentId" placeholder="请输入父级权限ID,0为顶级目录" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">类型</label>
            <div class="layui-input-block">
                <select name="type">
                    <option value="0">目录</option>
                    <option value="-1">菜单</option>
                    <option value="1">按钮</option>
                </select>
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


    layui.use(["element", "form", "okLayer", "okUtils"], function () {
        var $ = layui.jquery;
        var form = layui.form;
        var okUtils = layui.okUtils;

        form.on("submit(add)", function (data) {

            $.ajax({
                url: okUtils.mockApi.permission.isExistParent,
                type: "post",
                data: data.field,
                dataType: "json",
                success:function (data1) {
                    if(data1.code==0){
                        okUtils.ajax(okUtils.mockApi.permission.add, "post", data.field).done(function (response) {
                            console.log(response)
                            layer.msg("添加成功",{icon: 6, time: 1000, anim: 4}, function () {
                                parent.layer.close(parent.layer.getFrameIndex(window.name),function(){
                                    location.reload();
                                });
                            });
                        }).fail(function (error) {
                            console.log(error)
                        });
                    }else{
                        layer.msg(data1.msg, {icon: 7, time: 2000});
                    }
                }
            });
            return false;
        });
    })
</script>
</body>
</html>
