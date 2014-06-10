<%@ page import="sri.score.TSiteConfig" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="系统配置"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-user"></i>
        ${entityName}
    </h2>

    <div class="page-info hidden-phone">
        <ul class="stats">
            <li>
            </li>
        </ul>

    </div>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        ${entityName}
    </li>
</ul>

<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">${entityName}</h3>

            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <g:form action="save_config">
                    <label>
                        SMTP 发送服务器：
                    </label>
                    <input type="text" name="CFG_SMTPServer" value='${configs.find { s -> s.xkey == "SMTPServer" }?.xvalue}'/>
                    <label>
                        SMTP 端口：
                    </label>
                    <input type="text" name="CFG_SMTPPort"
                           value='${configs.find { s -> s.xkey == "SMTPPort" }?.xvalue ?: '110'}'/>
                    <label>
                        SMTP 帐号：
                    </label>
                    <input type="text" name="CFG_SMTPUser"
                           value='${configs.find { s -> s.xkey == "SMTPUser" }?.xvalue}'/>
                    <label>
                        SMTP 密码：
                    </label>
                    <input type="text" name="CFG_SMTPPwd"
                           value='${configs.find { s -> s.xkey == "SMTPPwd" }?.xvalue}'/>
                    <div>
                    <g:submitButton name="btnSubmit" class="btn btn-primary" value="保存"></g:submitButton>
                    </div>
                </g:form>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $(".btnChooseLevel").change(function () {
            var xthis = $(this);
            if (xthis.val() == "0") return
            $.post("<g:createLink controller="TSys" action="set_level"></g:createLink>",
                    {level_id: xthis.val(), user_id: xthis.attr("rel")}, function (res) {
                        if (res == "1") {
                            xthis.parent().parent().remove();
                        }
                    });
        });
    });
</script>

<div id="list-TUser" class="content scaffold-list" role="main">

    <g:if test="${flash.message}">
        <div class="alert alert-block alert-error">
            <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
            <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
            ${flash.message}
        </div>
    </g:if>

</div>
</body>
</html>
