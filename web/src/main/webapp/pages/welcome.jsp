<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.oa.utils.GetUserIp"%>
<%@ page import="java.util.StringTokenizer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>ok-admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="../imgs/favicon.ico"/>
    <link rel="stylesheet" href="../css/okadmin.css">
</head>
<body>
<div class="ok-body">
    <blockquote class="layui-elem-quote">
        欢迎：<span class="x-red">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.accountName}</span>！当前时间: <span id="nowTime"></span> <span id="weekday"></span>
    </blockquote>
    <fieldset class="layui-elem-field">
        <legend>数据统计</legend>
        <div class="layui-row layui-col-space10 layui-row-margin">
            <div class="layui-col-md2">
                <div class="layui-bg-green md2-sub1">
                    <i class="iconfont icon-dianliyonghuzongshu"></i>
                </div>
                <div class="md2-sub2">
                    <span>5761</span>
                    <cite>用户总数</cite>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="layui-bg-blue md2-sub1">
                    <i class="iconfont icon-wenzhang2"></i>
                </div>
                <div class="md2-sub2">
                    <span>9134</span>
                    <cite>文章总数</cite>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="layui-bg-black md2-sub1">
                    <i class="iconfont icon-pinglun"></i>
                </div>
                <div class="md2-sub2">
                    <span>2w</span>
                    <cite>评论总数</cite>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="layui-bg-orange md2-sub1">
                    <i class="iconfont icon-goods"></i>
                </div>
                <div class="md2-sub2">
                    <span>378</span>
                    <cite>商品总数</cite>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="layui-bg-red md2-sub1">
                    <i class="iconfont icon-jiaose"></i>
                </div>
                <div class="md2-sub2">
                    <span>5</span>
                    <cite>角色总数</cite>
                </div>
            </div>
            <div class="layui-col-md2">
                <div class="layui-bg-cyan md2-sub1">
                    <i class="iconfont icon-webpage"></i>
                </div>
                <div class="md2-sub2">
                    <span>4w</span>
                    <cite>页面总数</cite>
                </div>
            </div>
        </div>
    </fieldset>

    <blockquote class="layui-elem-quote">
        系统基本参数
    </blockquote>
    <table class="layui-table">
        <colgroup>
            <col width="300">
            <col>
        </colgroup>
        <tbody>
        <tr>
            <td>本机IP地址</td>
            <td><%=GetUserIp.getLocalIPForCMD()%></td>
        </tr>
        <tr>
            <td>操作系统</td>
            <td><%=System.getProperty("os.name")%></td>
        </tr>
        <tr>
            <td>服务器运行环境</td>
            <td>JDK 1.8.0_171</td>
        </tr>
        <tr>
            <td>服务器数据库版本</td>
            <td>SQLServer 2008 R2</td>
        </tr>
        <tr>
            <td>服务器最大上传限制</td>
            <td>5M</td>
        </tr>
        <tr>
            <td>当前用户权限</td>
            <td>${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.roles[0].name}</td>
        </tr>
        </tbody>
    </table>

    <blockquote class="layui-elem-quote">
        作者信息
    </blockquote>
    <table class="layui-table">
        <colgroup>
            <col width="300">
            <col>
        </colgroup>
        <tbody>
        <tr>
            <td>项目原作者</td>
            <td>bobi - <a href="mailto:bobi1234@foxmail.com">bobi1234@foxmail.com</a></td>
        </tr>
        <tr>
            <td>二次开发作者</td>
            <td>magic - <a href="mailto:bobi1234@foxmail.com">2531812112@qq.com</a></td>
        </tr>
        </tbody>
    </table>

    <blockquote class="layui-elem-quote">
        更新日志
    </blockquote>
    <ul class="layui-timeline">
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis">&#xe756;</i>
            <div class="layui-timeline-content layui-text">
                <h3 class="layui-timeline-title">2020年6月18日</h3>
                <p>
                    JAVA的坑真的是太多了，记录一下遇到的坑
                    <br>
                    如果导入了fastjson依赖包又使用了security的User
                    <br>
                    返回的时候无法将User中的Authorities给序列化
                    <br>
                    需要在 <em> Authorities </em> 上加上  <em> @JSONField(serialize = false) </em>
                    <br>
                    还有使用security时，如果用户登录的情况下修改自己用户的信息，
                    security的保持Session域中的用户信息无法更新，
                    若手动更新Session域中的用户信息则会将用户退出登录
                </p>
            </div>
        </li>
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis">&#xe756;</i>
            <div class="layui-timeline-content layui-text">
                <h3 class="layui-timeline-title">2020年6月16日</h3>
                <p>
                    会员管理整体大致完成
                    <br>
                    会员管理的权限操作已开发完，接下来就是登录的用户信息页面操作开发了.
                </p>
            </div>
        </li>
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis">&#xe756;</i>
            <div class="layui-timeline-content layui-text">
                <h3 class="layui-timeline-title">2020年6月8日</h3>
                <p>
                    <span style="color: lightpink;font-family: 粗体;font-weight: bolder">Magic</span>接手ok-admin1.0
                    <br>
                    编写数据库，持久层，业务层，控制层
                </p>
            </div>
        </li>

        <!-- 原作者的更新日志 -->
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis">&#xe756;</i>
            <div class="layui-timeline-content layui-text">
                <h3 class="layui-timeline-title">6月15日</h3>
                <p>
                   ok-admin大体架构成型。
                    <br>不枉近半个月日日夜夜与之为伴。
                    <br>无论它能走多远，抑或如何支撑？至少我曾倾注全心，无怨无悔 <i class="layui-icon">&#xe6af;</i>
                </p>
            </div>
        </li>
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
            <div class="layui-timeline-content layui-text">
                <h3 class="layui-timeline-title">5月13日</h3>
                <p>毕业答辩结束，至此感觉<em>大学，就这样结束了。</em>送两句话给自己：</p>
                <ul>
                    <li>但行好事 莫问前程</li>
                    <li>纵有疾风起 人生不言弃</li>
                </ul>
            </div>
        </li>
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
            <div class="layui-timeline-content layui-text">
                <h3 class="layui-timeline-title">5月4日</h3>
                <p>
                    正在准备毕业答辩
                    <br>常常在想，要是有一个满足我项目所有基础页面的CMS该多好
                    <br>今天，初始化项目
                </p>
            </div>
        </li>
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis layui-anim layui-anim-rotate layui-anim-loop">&#xe63e;</i>
            <div class="layui-timeline-content layui-text">
                <div class="layui-timeline-title">过去</div>
            </div>
        </li>
    </ul>
</div>
<!--js引入-->
<script src="../lib/layui/layui.js"></script>
<!--js逻辑-->
<script type="text/javascript">

    layui.use("util", function () {
        var util = layui.util;
        util.fixbar({});
    });

    /**
     * 初始化函数
     */
    setDate();

    /**
     * 获取当前时间
     */
    var nowDate1 = "";
    function setDate() {
        var date = new Date();
        var year = date.getFullYear();
        nowDate1 = year + "-" + addZero((date.getMonth() + 1)) + "-" + addZero(date.getDate()) + "  ";
        nowDate1 += addZero(date.getHours()) + ":" + addZero(date.getMinutes()) + ":" + addZero(date.getSeconds());
        document.getElementById("nowTime").innerHTML = nowDate1;
        setTimeout('setDate()', 1000);
    }

    /**
     * 年月日是分秒为10以下的数字则添加0字符串
     * @param time
     * @returns {number | *}
     */
    function addZero(time) {
        var i = parseInt(time);
        if (i / 10 < 1) {
            i = "0" + i;
        }
        return i;
    }

    /**
     * 初始化星期几
     * @type {string}
     */
    var weekday = "星期" + "日一二三四五六".charAt(new Date().getDay());
    document.getElementById("weekday").innerHTML = weekday;
</script>
</body>
</html>
