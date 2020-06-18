
<%@ page contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色列表</title>
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
            <a><cite>角色列表</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <!--模糊搜索区域-->
    <div class="layui-row">
        <form class="layui-form layui-col-md12 ok-search">
<%--            <input class="layui-input" placeholder="开始日期" autocomplete="off" id="startTime" name="startTime">--%>
<%--            <input class="layui-input" placeholder="截止日期" autocomplete="off" id="endTime" name="endTime">--%>
            <input class="layui-input" placeholder="请输入角色名" autocomplete="off" name="name">
            <button class="layui-btn" lay-submit="" lay-filter="search">
                <i class="layui-icon layui-icon-search"></i>
            </button>
        </form>
    </div>
    <!--数据表格-->
    <table class="layui-hide" id="tableId" lay-filter="tableFilter"></table>
</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script>
    var roleTable;
    layui.use(["element", "table", "form", "laydate", "okLayer", "okUtils"], function () {
        var table = layui.table;
        var form = layui.form;
        var laydate = layui.laydate;
        var util = layui.util;
		var okLayer = layui.okLayer;
		var okUtils = layui.okUtils;
        util.fixbar({});

        laydate.render({elem: "#startTime", type: "datetime"});
        laydate.render({elem: "#endTime", type: "datetime"});

        roleTable = table.render({
            elem: "#tableId",
            url: okUtils.mockApi.role.list,
			toolbar: "#toolbarTpl",
            method: "get",
            page: true,
            limit: 10,
            limits:[3,5,10],
            cols: [[
                {type: "checkbox"},
                {field: "id", title: "ID", width: 80, sort: true},
                {field: "name", title: "角色名", width: 100},
                {field: "statement", title: "备注", width: 100},
                {field: "createUserName", title: "创建者", width: 85},
                {field: "createTime", title: "创建时间", width: 200},
                {title: "操作", width: 200, align: "center", templet: "#operationTpl"}
            ]],
            done: function (res, curr, count) {
                console.log(res, curr, count);
            }
            //用于分页
            ,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
                var result;
                console.log(this);
                console.log(JSON.stringify(res));
                if(this.page.curr){
                    result = res.data.slice(this.limit*(this.page.curr-1),this.limit*this.page.curr);
                }
                else{
                    result=res.data.slice(0,this.limit);
                }
                return {
                    "code": res.code, //解析接口状态
                    "msg": res.msg, //解析提示文本
                    "count": res.count, //解析数据长度
                    "data": result //解析数据列表
                };
            }
        });

        form.on("submit(search)", function (data) {
            roleTable.reload({
                where: data.field,
                page: {curr: 1}
            });
            return false;
        });

		table.on("toolbar(tableFilter)", function (obj) {
			switch (obj.event) {
				case "add":
					add();
					break;
				case "batchDel":
					batchDel();
					break;
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

		function add () {
			okLayer.open("添加角色", "role-add.jsp", "90%", "90%", null, function () {
                roleTable.reload();
			})
		}

		function batchDel () {
			okLayer.confirm("确定要批量删除吗？", function (index) {
			    layer.close(index);
			    var idsStr = okUtils.table.batchCheck(table);
			    if (idsStr) {
			        okUtils.ajax(okUtils.mockApi.role.batchDel, "put", {idsStr: idsStr}).done(function (response) {
			            console.log(response)
			            okUtils.table.successMsg("批量删除成功");
			        }).fail(function (error) {
			            console.log(error)
			        });
			    }
			});
		}

		function edit (id) {
			okLayer.open("编辑角色", "role-edit.jsp", "90%", "90%", function (layero) {
                var iframeWin = window[layero.find("iframe")[0]["name"]];
                iframeWin.initForm(id);
            }, function () {
                roleTable.reload();
			})
		}

		function del (id) {
			okLayer.confirm("确定要删除吗？", function () {
			    okUtils.ajax(okUtils.mockApi.role.batchDel, "post", {idsStr: id}).done(function (response) {
			        console.log(response)
			        okUtils.table.successMsg("删除成功");
			    }).fail(function (error) {
			        console.log(error)
			    });
			})
		}
    })
</script>
<!-- 头工具栏模板 -->
<script type="text/html" id="toolbarTpl">
	<div class="layui-btn-container">
		<div class="layui-inline" lay-event="add"><i class="layui-icon layui-icon-add-1"></i></div>
		<div class="layui-inline" lay-event="batchDel"><i class="layui-icon layui-icon-delete"></i></div>
	</div>
</script>
<!-- 行工具栏模板 -->
<script type="text/html" id="operationTpl">
    <a href="javascript:;" title="编辑" lay-event="edit"><i class="layui-icon">&#xe642;</i></a>
    <a href="javascript:;" title="删除" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
</script>
</body>
</html>
