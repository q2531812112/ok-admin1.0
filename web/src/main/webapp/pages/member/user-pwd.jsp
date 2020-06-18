<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../../css/okadmin.css">
</head>
<body>
<div class="ok-body">
    <!--面包屑导航区域-->
    <div class="ok-body-breadcrumb">
        <span class="layui-breadcrumb">
            <a><cite>首页</cite></a>
            <a><cite>顶部导航</cite></a>
            <a><cite>修改密码</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
		<legend>修改我的密码</legend>
	</fieldset>
	<!--form表单-->
	<form class="layui-form ok-form" lay-filter="filter">
	    <div class="layui-form-item">
			<input name="id" id="id" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.id}" type="hidden"/>
	        <label class="layui-form-label">当前密码</label>
	        <div class="layui-input-inline">
	            <input type="password" name="currentPassword" placeholder="请输入当前密码" autocomplete="off" class="layui-input" lay-verify="required">
	        </div>
	    </div>
		<div class="layui-form-item">
		    <label class="layui-form-label">新密码</label>
		    <div class="layui-input-inline">
		        <input type="password" name="password" placeholder="请输入新密码" autocomplete="off" class="layui-input" lay-verify="password">
		    </div>
			<div class="layui-form-mid layui-word-aux">6到16个字符</div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">确认新密码</label>
		    <div class="layui-input-inline">
		        <input type="password" name="repassword" placeholder="请确认新密码" autocomplete="off" class="layui-input" lay-verify="repassword">
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
<script>
    layui.use(["element", "form", "okLayer", "okUtils"], function () {
        var form = layui.form;
		var $ = layui.jquery;
        var okLayer = layui.okLayer;
        var okUtils = layui.okUtils;
		
		form.verify({
			password: [/^[\S]{6,16}$/, "密码必须6到16位，且不能出现空格"],
			repassword: function (value, item) {
				var passwordVal = $("input[name='password']").val();
				if (!value) {
					return "请输入确认密码";
				}
				console.log(value, passwordVal)
				if (value != passwordVal) {
					return "两次输入的密码不一致";
				}
			}
		});

		form.on("submit(edit)", function (data) {
		    okUtils.ajax(okUtils.mockApi.user.myUpdatePassword, "put", data.field).done(function (response) {
		        console.log(response)
		        okLayer.msg.greenTick("修改成功，需要重新登录", function () {
		            parent.layer.close(parent.layer.getFrameIndex(window.name));
		            $.ajax({
						url:okUtils.mockApi.logout,
						success:function(res){
							if(res.code==200){
								parent.location.reload();
							}
						}
					});
		        });
		    }).fail(function (error) {
		        console.log(error)
		    });
		    return false;
		});
    });
</script>
</body>
</html>
