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
            <a><cite>个人中心</cite></a>
        </span>
        <a class="layui-btn layui-btn-sm" href="javascript:location.replace(location.href);" title="刷新">
            <i class="layui-icon layui-icon-refresh"></i>
        </a>
    </div>
    <fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
        <legend>个人中心</legend>
    </fieldset>
    <!--form表单-->
    <form class="layui-form ok-form" lay-filter="filter">
        <input name="id" id="id" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.id}" type="hidden"/>

        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">头像</label>
            <img id="portrait" class="layui-nav-img" src="${pageContext.request.contextPath}/"/>
        </div>
        <div class="layui-form-item layui-form-text">
            <label class="layui-form-label">个性签名:</label>
            <div class="layui-input-block">
                <textarea name="statement" style="color: #999;border:0px;min-height: 50px;" class="layui-textarea" maxlength="300" readonly></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">用户名:</label>
            <div class="layui-input-inline">
                <input type="text" style="color: #999;border:0px;" name="accountName" autocomplete="off" class="layui-input" lay-verify="required"  readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">真实姓名:</label>
            <div class="layui-input-inline">
                <input type="text" style="color: #999;border:0px;" name="name"  autocomplete="off" class="layui-input" lay-verify="required" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">邮箱:</label>
            <div class="layui-input-inline">
                <input type="text" style="color: #999;border:0px;" name="email"  autocomplete="off" class="layui-input" lay-verify="email" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">性别:</label>
            <div class="layui-input-inline">
                <input type="text" id="sex" name="birthday" style="color: #999;border:0px;"  autocomplete="off" class="layui-input"readonly >
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">出生日期:</label>
            <div class="layui-input-inline">
                <input type="text" id="birthday" name="birthday" style="color: #999;border:0px;" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">角色:</label>
            <div class="layui-input-inline">
                <input type="text" id="roleIdAndName" style="color: #999;border:0px;" autocomplete="off" class="layui-input" lay-verify="required" readonly>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">注册时间:</label>
            <div class="layui-input-inline">
                <input type="text" name="createTime" style="color: #999;border:0px;" autocomplete="off" class="layui-input" readonly/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">最后登录时间:</label>
            <div class="layui-input-inline">
                <input type="text" name="loginTime" style="color: #999;border:0px;" autocomplete="off" class="layui-input" readonly/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">最后登录时间:</label>
            <div class="layui-input-inline">
                <input type="text" name="loginTime" style="color: #999;border:0px;" autocomplete="off" class="layui-input" readonly/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label"style="min-width: 100px">登录次数:</label>
            <div class="layui-input-inline">
                <input type="text" name="loginSum" style="color: #999;border:0px;" autocomplete="off" class="layui-input" readonly/>
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
        var util = layui.util;
        var okUtils = layui.okUtils;

        util.fixbar({});


        $(function(){
            var uid = $("#id").val();
            okUtils.ajax(okUtils.mockApi.user.myUser,"get","uid="+uid).done(function (response) {
                console.log(response[0])
                form.val("filter", response[0]);
                $("#portrait").attr("src","/oa/"+response[0].portrait);
                // $("#birthday").val(response[0].birthday);
                $("#roleIdAndName").val(response[0].roles[0].name);
                if(response[0].sex==1){
                    $("#sex").val("男");
                }else if(response[0].sex==0){
                    $("#sex").val("女");
                }
            }).fail(function (error) {
                console.log(error)
            });
        });
    });
</script>
</body>
</html>
