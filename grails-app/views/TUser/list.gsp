<%@ page import="sri.score.TUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TUser.label', default: 'TUser')}"/>
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
                <span><g:link class="create" action="create" class="large text-warning"><g:message
                        code="default.new.label"
                        args="[entityName]"/></g:link></span>
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

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li><g:link class="btn btn-flat btn-mini" action="create"><g:message
                                code="default.create.label"
                                args="[entityName]"/></g:link></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th>${message(code: 'TUser.nick.label', default: '昵称')}</th>
                        <th>${message(code: 'TUser.email.label', default: 'Email')}</th>
                        <th>${message(code: 'TUser.user_code.label', default: '工号')}</th>
                        <th>${message(code: 'TUser.score.label', default: '得分')}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${TUserInstanceList}" status="i" var="TUserInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${TUserInstance.id}">${fieldValue(bean: TUserInstance, field: "nick")}</g:link></td>
                            <td>${fieldValue(bean: TUserInstance, field: "email")}</td>
                            <td>${fieldValue(bean: TUserInstance, field: "user_code")}</td>
                            <td>${fieldValue(bean: TUserInstance, field: "score")}</td>

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
