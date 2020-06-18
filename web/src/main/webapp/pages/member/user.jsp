
<%@ page contentType="text/html;charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户列表</title>
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
        </span>

        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <!--模糊搜索区域-->
    <div class="layui-row">
        <form class="layui-form layui-col-md12 ok-search">
            <input class="layui-input" placeholder="请输入用户名" autocomplete="off" name="username">
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
    var userTable;
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
        userTable = table.render({
            elem: "#tableId",
            url: okUtils.mockApi.user.list,
            method: "get",
			toolbar: true,
			toolbar: "#toolbarTpl",
            page: true,
            limit: 10,
            limits:[3,5,10],
            cols: [[
                {type: "checkbox"},
                {field: "id", title: "ID", width: 80, sort: true},
                {field: "accountName", title: "用户名", width: 100},
                {field: "name", title: "姓名", width: 100},
                // {field: "accountPassword", title: "密码", width: 100},
                {field: "role", title: "角色", width: 100 ,templet:'<div>{{d.roles?d.roles[0].name:""}}</div>'},
				{field: "email", title: "邮箱", width: 200},
                {field: "createTime", title: "创建时间", width: 200},
                {field: "loginTime", title: "最后登录时间", width: 200},
				{field: "status", title: "状态", width: 100, templet: "#statusTpl"},
                {field: "loginSum", title: "登陆次数", width: 100},
                {title: "操作", width: 100, align: 'center', templet: "#operationTpl", fixed: "right"}
            ]],
            done: function (res, curr, count) {
                console.log(res, curr, count)
            } ,parseData: function(res) { //将原始数据解析成 table 组件所规定的数据，res为从url中get到的数据
                var result;
                console.log(this);
                console.log(JSON.stringify(res));
                if (this.page.curr) {
                    result = res.data.slice(this.limit * (this.page.curr - 1), this.limit * this.page.curr);
                } else {
                    result = res.data.slice(0, this.limit);
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
            userTable.reload({
				where: data.field,
				page: {curr: 1}
			});
            return false;
        });

		table.on("toolbar(tableFilter)", function (obj) {
			switch (obj.event) {
				case "batchEnabled":
					batchEnabled();
					break;
				case "batchDisabled":
					batchDisabled();
					break;
				case "batchDel":
					batchDel();
					break;
				case "add":
					add();
					break;
			}
        });

        table.on("tool(tableFilter)", function (obj) {
            var data = obj.data;
			console.log(data);
			switch (obj.event) {
				case "edit":
					edit(data);
					break;
				case "del":
					del(data.id);
					break;
			}
        });

		function batchEnabled () {
			okLayer.confirm("确定要批量启用吗？", function (index) {
			    // TODO
			    layer.close(index);
			    var idsStr = okUtils.table.batchCheck(table);
			    if (idsStr) {
			        okUtils.ajax(okUtils.mockApi.user.batchNormal, "put", {idsStr: idsStr}).done(function (response) {
			            console.log(response);
			            okUtils.table.successMsg("批量启用成功");
			            userTable.reload({
                            where:{
                                aaaaa:Math.random()
                            }
                        });
			        }).fail(function (error) {
			            console.log(error)
			        });
			    }
			});
		}

		function batchDisabled () {
			okLayer.confirm("确定要批量停用吗？", function (index) {
			    layer.close(index);
			    var idsStr = okUtils.table.batchCheck(table);
			    if (idsStr) {
			        okUtils.ajax(okUtils.mockApi.user.batchStop, "put", {idsStr: idsStr}).done(function (response) {
			            console.log(response);
			            okUtils.table.successMsg("批量停用成功");
			            userTable.reload({
                           where:{
                               aaaaa:Math.random()
                           }
                        });
			        }).fail(function (error) {
			            console.log(error)
			        });
			    }
			});
		}

		function batchDel () {
			okLayer.confirm("确定要批量删除吗？", function (index) {
			    layer.close(index);
			    var idsStr = okUtils.table.batchCheck(table);
			    if (idsStr) {
			        okUtils.ajax(okUtils.mockApi.user.batchDel, "put", {idsStr: idsStr}).done(function (response) {
			            console.log(response)
			            okUtils.table.successMsg("批量删除成功");
                        userTable.reload({
                            where:{
                                aaaaa:Math.random()
                            }
                        });
			        }).fail(function (error) {
			            console.log(error)
			        });
			    }
			});
		}

		function add () {
			okLayer.open("添加用户", "user-add.jsp", "90%", "90%", null, function () {
                userTable.reload();
			})
		}

		function edit (id) {
			okLayer.open("编辑用户", "user-edit.jsp", "90%", "90%", function (layero) {
				var iframeWin = window[layero.find("iframe")[0]["name"]];
				iframeWin.initForm(id);
			}, function () {
				userTable.reload();
			})
		}

		function del (id) {
			okLayer.confirm("确定要删除吗？", function () {
			    okUtils.ajax(okUtils.mockApi.user.batchDel, "put", {idsStr: id}).done(function (response) {
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
		<button class="layui-btn layui-btn-sm layui-btn-normal" lay-event="batchEnabled"><i class="iconfont icon-shangsheng"></i>批量启用</button>
		<button class="layui-btn layui-btn-sm layui-btn-warm" lay-event="batchDisabled"><i class="iconfont icon-web-icon-"></i>批量停用</button>
		<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="batchDel"><i class="layui-icon layui-icon-delete"></i>批量删除</button>
		<button class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon">&#xe61f;</i>添加用户</button>
	</div>
</script>
<!-- 启用|停用模板
    <input type="checkbox" name="status" value="{{d.id}}" lay-skin="switch" lay-text="启用|停用" {{ d.status== 0 ? 'checked' : ''}}>
-->
<script type="text/html" id="statusTpl">
    {{#  if(d.status == 1){ }}
        <span class="layui-btn layui-btn-normal layui-btn-xs">已启用</span>
    {{#  } else if(d.status == 0) { }}
        <span class="layui-btn layui-btn-warm layui-btn-xs">已停用</span>
    {{#  } }}
</script>
<!-- 角色模板 -->
<script type="text/html" id="roleTpl">
</script>
<!-- 行工具栏模板 -->
<script type="text/html" id="operationTpl">
    <a href="javascript:;" title="编辑" lay-event="edit"><i class="layui-icon">&#xe642;</i></a>
    <a href="javascript:;" title="删除" lay-event="del"><i class="layui-icon">&#xe640;</i></a>
</script>
</body>
</html>
