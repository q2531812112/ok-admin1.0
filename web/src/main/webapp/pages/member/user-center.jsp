<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
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
            <a><cite>基本资料</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
	<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
		<legend>设置我的资料</legend>
	</fieldset>
	<!--form表单-->
	<form class="layui-form ok-form" lay-filter="filter">
		<input name="id" id="id" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.id}" type="hidden"/>

	    <div class="layui-form-item">
	        <label class="layui-form-label"style="min-width: 100px">真实姓名</label>
	        <div class="layui-input-inline">
	            <input type="text" name="name" value="" placeholder="请输入真实姓名" autocomplete="off" class="layui-input" lay-verify="required">
	        </div>
	    </div>
	    <div class="layui-form-item">
	        <label class="layui-form-label"style="min-width: 100px">邮箱</label>
	        <div class="layui-input-inline">
	            <input type="text" name="email" value="" placeholder="请输入邮箱" autocomplete="off" class="layui-input" lay-verify="email">
	        </div>
	    </div>
		<div class="layui-form-item">
			<label class="layui-form-label"style="min-width: 100px">性别</label>
			<div class="layui-input-inline">
				<input type="radio" name="sex" value="1" title="男" checked>
				<input type="radio" name="sex" value="0" title="女">
			</div>
		</div>
	    <div class="layui-form-item">
	        <label class="layui-form-label"style="min-width: 100px">出生日期</label>
	        <div class="layui-input-inline">
	            <input type="text" name="birthday" value="" placeholder="请选择出生日期" autocomplete="off" class="layui-input" id="birthday" lay-verify="birthdayVerify">
	        </div>
	    </div>
		<div class="layui-form-item">
		    <label class="layui-form-label"style="min-width: 100px">头像</label>
			<input type="hidden" id="fileName" name="portrait" value="" readonly>
			<img id="portrait" class="layui-nav-img" src="${pageContext.request.contextPath}/"/>
			<button type="button" class="layui-btn" id="upload">
				<i class="layui-icon">&#xe67c;</i>上传图片
			</button>
			<div class="layui-inline layui-word-aux" id="showFileIsOk">图片最大为500KB</div>
		</div>
	    <div class="layui-form-item layui-form-text">
	        <label class="layui-form-label">个性签名</label>
	        <div class="layui-input-block">
	            <textarea name="statement" placeholder="请输入内容" class="layui-textarea" maxlength="300"></textarea>
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
	var fileName;
    layui.use(["element", "form", "laydate", "upload", "util", "okLayer", "okUtils"], function () {
    	var $ = layui.jquery;
        var form = layui.form;
        var laydate = layui.laydate;
		var upload = layui.upload;
        var util = layui.util;
        var okLayer = layui.okLayer;
        var okUtils = layui.okUtils;

        util.fixbar({});
		
		laydate.render({elem: "#birthday", type: "date"});

		upload.render({
			elem: "#upload",
			url: okUtils.mockApi.utils.uploadPicture,
			acceptMime:'images',
			size:500,
			done: function(res){
				if(res.code==0){
					fileName = res.msg;
					$("#fileName").val(fileName);
					var src = $("#portrait").attr("src");
					var s = src.substring(0,src.indexOf("imgs"));
					$("#portrait").attr("src",s+fileName);
					$("#showFileIsOk").html("上传成功!");
			  		console.log("上传完毕");
				}
			},
			error: function(){
				okUtils.table.successMsg("上传异常");
			  console.log("请求异常");
			}
		});
		form.verify({
		    birthdayVerify: [/^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))(\s(([01]\d{1})|(2[0123])):([0-5]\d):([0-5]\d))?$/, '日期格式不正确']
		});
		
		form.on("submit(edit)", function (data) {
		    okUtils.ajax(okUtils.mockApi.user.myUserUpdate, "put", data.field).done(function (response) {
		        okLayer.msg.greenTick("编辑成功", function () {
		            parent.layer.close(parent.layer.getFrameIndex(window.name));
		        });
		    }).fail(function (error) {
		        console.log(error)
		    });
		    return false;
		});

		$(function(){
			var uid = $("#id").val();
			okUtils.ajax(okUtils.mockApi.user.myUser,"get","uid="+uid).done(function (response) {
				console.log(response[0])
				form.val("filter", response[0]);
				$("#portrait").attr("src","/oa/"+response[0].portrait);
				$("#birthday").val(response[0].birthday);
			}).fail(function (error) {
				console.log(error)
			});
		});
    });
</script>
</body>
</html>
