<%@ page import="sri.score.TLevel" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TLevel.label', default: 'TLevel')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-dashboard"></i>
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
        ${message(code: 'TLevel.label', default: 'TLevel')}
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
                        <li><g:link class="btn" action="create"><g:message
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
                        <th>${message(code: 'TLevel.title.label', default: '名称')}</th>
                        <th>${message(code: 'TLevel.min_score.label', default: '最小分值')}</th>
                        <th>${message(code: 'TLevel.coefficient.label', default: '系数')}</th>

                        %{--<g:sortableColumn property="coefficient"--}%
                        %{--title="${message(code: 'TLevel.coefficient.label', default: 'Coefficient')}"/>--}%

                        %{--<g:sortableColumn property="create_date"--}%
                        %{--title="${message(code: 'TLevel.create_date.label', default: 'Createdate')}"/>--}%

                        %{--<g:sortableColumn property="creator"--}%
                        %{--title="${message(code: 'TLevel.creator.label', default: 'Creator')}"/>--}%

                        %{--<g:sortableColumn property="method"--}%
                        %{--title="${message(code: 'TLevel.method.label', default: 'Method')}"/>--}%

                        %{--<g:sortableColumn property="min_score"--}%
                        %{--title="${message(code: 'TLevel.min_score.label', default: 'Minscore')}"/>--}%

                        %{--<g:sortableColumn property="score_config"--}%
                        %{--title="${message(code: 'TLevel.score_config.label', default: 'Scoreconfig')}"/>--}%

                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${TLevelInstanceList}" status="i" var="TLevelInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${TLevelInstance.id}">${fieldValue(bean: TLevelInstance, field: "title")}</g:link></td>


                            <td>${fieldValue(bean: TLevelInstance, field: "min_score")}</td>

                            <td>${fieldValue(bean: TLevelInstance, field: "coefficient")}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${TLevelInstanceTotal}"/>
                </div>

            </div>

        </div>
    </div>
</div>


<div id="list-TLevel" class="content scaffold-list" role="main">
    <h1></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

</div>
</body>
</html>
