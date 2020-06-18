<%@ page contentType="text/html;charset=GBK" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>登录</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="../../imgs/favicon.ico"/>
    <link rel="stylesheet" href="../../css/okadmin.css"/>
</head>
<body class="login-body">
<div class="login-box animated rotateIn">
    <div class="head"></div>
    <div class="input-box">
        <form class="layui-form">
            <input type="text" name="username" required lay-verify="required" placeholder="邮箱/手机号/平台账号" autocomplete="off" class="layui-input">
            <input type="password" name="password" required lay-verify="required" placeholder="密码" autocomplete="off" class="layui-input">
            <div class="remember-me">
                <span>记住我：</span>
                <input type="checkbox" name="zzz" lay-skin="switch" lay-text="是|否">
            </div>
            <input type="submit" value="登 录" lay-submit lay-filter="login">
        </form>
        <div class="oauth">
            <i class="iconfont icon-WechatIMG" style="font-size: 25px;"></i>
            <i class="iconfont icon-github"></i>
            <i class="iconfont icon-logo-weibo"></i>
            <i class="iconfont icon-qq"></i>
            <i class="iconfont icon-weixin"></i>
            <i class="iconfont icon-zhifubao"></i>
        </div>
    </div>
    <div class="copyright">
        © 2018-<span id="endYear"></span> magicLianYu. All rights reserved.
    </div>

</div>
<!--js逻辑-->
<script src="../../lib/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(["form", "okLayer", "okUtils", "okProgress"], function () {
        var form = layui.form;
        var $ = layui.jquery;
        var okLayer = layui.okLayer;
        var okUtils = layui.okUtils;

        // 修改copyright结束时间
        var data = new Date();
        var year = data.getFullYear();
        $("#endYear").text(year);

        // 登陆逻辑
        form.on('submit(login)', function (data) {
            $.ajax({
                url:okUtils.mockApi.login,
                type:"post",
                data:data.field,
                success:function(response){
                    if(response.code==200){
                        okLayer.msg.greenTick(response.msg, function () {
                            window.location = "../../index.jsp";
                        })
                    }else if(response.code==401){
                        okLayer.msg.redCross(response.msg, function () {
                        })
                    }
                }
            });
            // okUtils.ajax(okUtils.mockApi.login, "post", data.field).done(function (response) {
            //     console.log(response)
            //     // okLayer.msg.greenTick("登陆成功", function () {
            //     //     window.location = "../index.jsp";
            //     // })
            // }).fail(function (error) {
            //     console.log(error)
            // });
            return false;
        });

        // oauth三方登陆逻辑
        $(".oauth .icon-WechatIMG").click(function () {
            layer.msg('正在打开Gitee登陆页面，请稍后...');
        });

        $(".oauth .icon-github").click(function () {
            layer.msg('正在打开Github登陆页面，请稍后...');
        });

        $(".oauth .icon-logo-weibo").click(function () {
            layer.msg('正在打开微博登陆页面，请稍后...');
        });

        $(".oauth .icon-qq").click(function () {
            layer.msg('正在打开QQ登陆页面，请稍后...');
        });

        $(".oauth .icon-weixin").click(function () {
            layer.msg('正在打开微信登陆页面，请稍后...');
        });

        $(".oauth .icon-zhifubao").click(function () {
            layer.msg('正在打开支付宝登陆页面，请稍后...');
        });
    });
</script>
</body>
</html>
