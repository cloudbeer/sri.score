<%@ page import="sri.score.TUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="等级初始化"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-user"></i>
        <g:message code="default.list.label" args="[entityName]"/>
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
        ${message(code: 'TUser.label', default: 'TUser')}
    </li>
</ul>

<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title"><g:message code="default.list.label" args="[entityName]"/></h3>

            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th>${message(code: 'TUser.nick.label', default: '昵称')}</th>
                        <th>${message(code: 'TUser.email.label', default: 'Email')}</th>
                        <th style="text-align: center">${message(code: 'TUser.score.label', default: 'Score')}</th>
                        <th style="text-align: center">${message(code: 'TUser.level_id.label', default: 'Level')}</th>
                        <th style="text-align: center">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${TUserInstanceList}" status="i" var="TUserInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${TUserInstance.id}">${fieldValue(bean: TUserInstance, field: "nick")}</g:link></td>
                            <td>${fieldValue(bean: TUserInstance, field: "email")}</td>
                            <td style="text-align: right">${fieldValue(bean: TUserInstance, field: "score")}</td>
                            <td style="text-align: center"><g:levelname
                                    level_id="${fieldValue(bean: TUserInstance, field: "level_id")}"></g:levelname></td>
                            <td style="text-align: center">
                                <select name="btnChooseLevel1" class="btnChooseLevel" rel="${TUserInstance.id}">
                                    <option value="0">请选择</option>
                                    <g:each in="${levels}" var="level">
                                        <option value="${level.id}" ${level.id==TUserInstance.level_id?"selected='selected'": ""}>${level.title}</option>
                                    </g:each>
                                </select>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${TUserInstanceTotal}"/>
                </div>

            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $(".btnChooseLevel").change(function () {
            var xthis = $(this);
            if (xthis.val()=="0") return
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
