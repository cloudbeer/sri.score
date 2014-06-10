<%@ page import="sri.score.TGroup" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TGroup.label', default: 'TGroup')}"/>
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
        ${message(code: 'TGroup.label', default: '部门')}
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
                ${groupHTML}
                %{--<table class="table">--}%
                %{--<thead>--}%
                %{--<tr>--}%
                %{--<th>部门名称</th>--}%
                %{--<th style="width:200px">操作</th>--}%
                %{--</tr>--}%
                %{--</thead>--}%
                %{--<tbody>--}%
                %{--<g:each in="${TGroupInstanceList}" status="i" var="TGroupInstance">--}%
                %{--<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">--}%

                %{--<td><g:link action="show"--}%
                %{--id="${TGroupInstance.id}">${TGroupInstance?.title}</g:link></td>--}%
                %{--<td>--}%
                %{--<g:link action="create" id="${TGroupInstance?.id}" class="btn btn-small">新增子部门</g:link>--}%
                %{--<g:link action="edit" id="${TGroupInstance?.id}" class="btn btn-small">修改</g:link>--}%
                %{--<g:link action="create" id="${TGroupInstance?.id}" class="btn btn-small btn-danger">删除</g:link>--}%
                %{--</td>--}%

                %{--</tr>--}%
                %{--</g:each>--}%
                %{--</tbody>--}%
                %{--</table>--}%

            </div>

        </div>
    </div>
</div>
<style>
    .grp_name{
        display: inline-block;
        padding: 4px;
    }
</style>

<div id="list-TLevel" class="content scaffold-list" role="main">

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
