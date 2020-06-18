<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑角色</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/okadmin.css">
    <link rel="stylesheet" href="../../lib/zTree_v3/css/zTreeStyle/zTreeStyle.css">
</head>
<body>
<div class="ok-body">
    <!--面包屑导航区域-->
    <div class="ok-body-breadcrumb">
        <span class="layui-breadcrumb">
            <a><cite>首页</cite></a>
            <a><cite>会员管理</cite></a>
            <a><cite>角色列表</cite></a>
            <a><cite>编辑角色</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <!--form表单-->
    <form class="layui-form ok-form" lay-filter="filter">
        <input type="hidden" name="id" id="rid">
        <div class="layui-form-item">
            <label class="layui-form-label">角色名</label>
            <div class="layui-input-block">
                <input type="text" id="name" name="name" placeholder="请输入角色名" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <input type="text" id="statement" name="statement" placeholder="请输入备注" autocomplete="off" class="layui-input" lay-verify="required">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限</label>
            <div class="layui-input-block">
                <!--权限树-->
                <ul class="ztree" id="permissionTree"></ul>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" lay-submit lay-filter="edit">立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script src="../../lib/jquery/jquery-3.5.1.min.js"></script>
<script src="../../lib/zTree_v3/js/jquery.ztree.all.js"></script>
<script>

    var initData;
    function initForm(data) {
        var json = JSON.stringify(data);
        initData = JSON.parse(json);
        console.log("：：：：：initForm：：：：：：参数：：：：：");
        console.log(initData);
    }

    $(function() {
        layui.use(["element", "form", "okLayer", "okUtils"], function () {
            var $ = layui.jquery;
            var form = layui.form;
            var okLayer = layui.okLayer;
            var okUtils = layui.okUtils;


            //初始化表单的值
            var val = form.val("filter", initData);
            console.log("；；；；；初始化表单后参数；；；；；；参数；；；；；");
            console.log(val);
            ////////////权限树
            // zTree设置
            var setting = {
                data: {
                    simpleData: {enable: true, idKey: "id", pIdKey: "parentId", rootPId: 0}
                },
                check: {enable: true, chkStyle: "checkbox", radioType: "all"}
            };

            // 初始化所有权限树节点
            var treeObj;
            okUtils.ajax(okUtils.mockApi.role.findTree, "get", "rid=" + $("#rid").val()).done(function (response) {
                treeObj = $.fn.zTree.init($("#permissionTree"), setting, response);
                treeObj.expandAll(true);
            }).fail(function (error) {
                console.log("error:::获取权限树失败");
            });
            //////////////////


            form.on("submit(edit)", function (data) {
                // 权限节点校验
                var nodes = treeObj.getCheckedNodes(true);
                if (nodes.length == 0) {
                    okLayer.msg.redCross("请选择权限节点");
                    return false;
                }

                // 权限节点获取
                var permissionIds = "";
                for (var i = 0; i < nodes.length; i++) {
                    permissionIds = permissionIds + nodes[i].id + ",";
                }
                // 请求后台
                // "{id:"+data.id+",name:"+data.name+",statment:"+data.statement+",permissionIds:"+permissionIds+"}"
                okUtils.ajax(okUtils.mockApi.role.update, "post", "id=" + $("#rid").val() + "&name=" + $("#name").val() + "&statement=" + $("#statement").val() + "&permissionIds=" + permissionIds).done(function (response) {
                    okLayer.msg.greenTick("编辑成功", function () {
                        parent.layer.close(parent.layer.getFrameIndex(window.name));
                    });
                }).fail(function (error) {
                    console.log(error)
                });
                return false;
            });
        });
    });
</script>
</body>
</html>
