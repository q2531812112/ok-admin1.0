
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>权限列表</title>
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
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <!--模糊搜索区域-->
    <div class="layui-row">
        <form class="layui-form layui-col-md12 ok-search">
<%--            <input class="layui-input" placeholder="开始日期" autocomplete="off" id="startTime">--%>
<%--            <input class="layui-input" placeholder="截止日期" autocomplete="off" id="endTime">--%>
<%--            <input class="layui-input" placeholder="请输入权限名" autocomplete="off">--%>
<%--            <button class="layui-btn" lay-submit="" lay-filter="search">--%>
<%--                <i class="layui-icon layui-icon-search"></i>--%>
<%--            </button>--%>
        </form>
    </div>
    <!--工具栏-->
    <okToolbar>
		<button class="layui-btn" id="add">
		    <i class="layui-icon">&#xe61f;</i>添加权限
		</button>
        <span>共有数据：<i id="countNum"></i> 条</span>
    </okToolbar>
    <!--数据表格-->
    <table class="layui-hide" id="tableId" lay-filter="tableFilter"></table>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script charset="utf-8">

    var treetable1;
    layui.use(["element", "table", "form", "laydate", "treetable", "okLayer", "okUtils"], function () {
        var form = layui.form;
        var table = layui.table;
        var $ = layui.jquery;
        var laydate = layui.laydate;
        var treetable = layui.treetable;
		var okLayer = layui.okLayer;
		var okUtils = layui.okUtils;

        laydate.render({elem: "#startTime", type: "datetime"});
        laydate.render({elem: "#endTime", type: "datetime"});

        layer.load(2);
        treetable1 = treetable.render({
            treeColIndex: 1,
            treeSpid: 0,
            treeIdName: "id",
            treePidName: "parentId",
            elem: "#tableId",
            url: okUtils.mockApi.permission.list,////
            page: false,
            // size: "sm",
            cols: [[
                {type: "numbers",title:"编号"},
                {field: "name", title: "权限名称"},
                {field: "menuUrl", title: "资源菜单路径"},
                {field: "url", title: "资源访问路径"},
                {field: "id",width: 80, align: "center", title:"权限ID"},
                {
                    field: "type", width: 80, align: "center", templet: function (d) {
                        if (d.type == 1) {
                            return '<span class="layui-badge layui-bg-gray">按钮</span>';
                        }else if (d.type == 0) {
                            return '<span class="layui-badge layui-bg-blue">目录</span>';
                        }else if(d.type == -1){
                            return '<span class="layui-badge-rim">菜单</span>';
                        }
                    },
                    title: "类型"
                },
                {field: "createTime",minWidth: 160, title: "创建时间"},
                {width: 120, align: "center", title: "操作", templet: "#operationTpl"}
            ]],
            done: function (res, curr, count) {
                layer.closeAll("loading");
                // console.log(res, curr, count);
                $("#countNum").text(count);
            }
        });

        table.on("tool(tableFilter)", function (obj) {
            var data = obj.data;
            switch (obj.event) {
            	case "edit":
            		edit(data);
            		break;
            	case "del":
            		del(data.id);
            		break;
            }
        });

		$("#add").click(function () {
			okLayer.open("添加权限", "permission-add.jsp", "90%", "90%", function () {
				$(".layui-laypage-btn")[0].click();
			},function () {
                window.location.reload();
            })
		});

		function edit (id) {
            okLayer.open("编辑权限", "permission-edit.jsp", "90%", "90%", function (layero) {
                var iframeWin = window[layero.find("iframe")[0]["name"]];
                iframeWin.initForm(id);
            },function () {
                window.location.reload();
            })
		}

		function del (id) {
            okLayer.confirm("确定要删除吗？", function (index) {
                layer.close(index);
                okUtils.ajax(okUtils.mockApi.permission.delete, "put", "id="+id).done(function (response) {
                    console.log(response)
                    okUtils.table.successMsg("删除成功");
                    setTimeout("window.location.reload()",1000)
                }).fail(function (error) {
                    console.log(error)
                });

            });
		}
    })
</script>
<!--行工具栏模板-->
<script type="text/html" id="operationTpl">
    <a href="javascript:;" title="编辑" lay-event="edit"><i class="layui-icon">&#xe642;</i></a>
    <a href="javascript:;" title="删除" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
</script>
</body>
</html>
