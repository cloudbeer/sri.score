<%@ page import="sri.score.TProject" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TProject.label', default: 'TProject')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-tasks"></i>
        <g:message code="default.list.label" args="[entityName]"/>
    </h2>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        ${message(code: 'TProject.label', default: 'TProject')}
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
                        <th>${message(code: 'TProject.title.label', default: '名称')}</th>
                        <th>${message(code: 'TProject.pre_score.label', default: '预估分值')}</th>
                        <th>${message(code: 'TProject.manager.label', default: '经理')}</th>
                        <th>${message(code: 'TProject.xstatus.label', default: 'Status')}</th>
                        <th>禅道</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${TProjectInstanceList}" status="i" var="TProjectInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show" controller="TProject"
                                        id="${TProjectInstance.id}">${fieldValue(bean: TProjectInstance, field: "title")}</g:link></td>
                            <td>${fieldValue(bean: TProjectInstance, field: "pre_score")}</td>
                            <td>
                                <g:usernick
                                        user_id="${fieldValue(bean: TProjectInstance, field: "manager")}"></g:usernick>
                            </td>
                            <td>
                            <g:projectstatus
                                    status="${fieldValue(bean: TProjectInstance, field: "xstatus")}"></g:projectstatus>
                        </td>
                            <td>点击查看</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>


            </div>

        </div>
    </div>
</div>


<div id="list-TProject" class="content scaffold-list" role="main">

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
