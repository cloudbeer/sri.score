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
                        <th style="text-align: center">${message(code: 'TProject.title.label', default: '名称')}</th>
                        <th style="width:120px;text-align: center">${message(code: 'TProject.pre_score.label', default: '分值')}</th>
                        <th style="text-align: center">${message(code: 'TProject.manager.label', default: '负责人')}</th>
                        <th style="text-align: center">${message(code: 'TProject.approver.label', default: '审批')}</th>
                        <th style="text-align: center">预计日期</th>
                        <th style="text-align: center">完成日期</th>
                        <th>禅道</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${TProjectInstanceList}" status="i" var="TProjectInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show" controller="TProject"
                                        id="${TProjectInstance.id}">${fieldValue(bean: TProjectInstance, field: "title")}</g:link></td>
                            <td style="text-align: right">${fieldValue(bean: TProjectInstance, field: "pre_score")}</td>
                            <td style="text-align: center"><g:usernick
                                    user_id="${fieldValue(bean: TProjectInstance, field: "manager")}"></g:usernick>
                            </td>
                            <td style="text-align: center">
                                <g:usernick
                                        user_id="${fieldValue(bean: TProjectInstance, field: "approver")}"></g:usernick>
                            </td>
                            <td><g:formatDate date="${TProjectInstance.end_date1}"
                                              format="yyyy-MM-dd"></g:formatDate></td>
                            <td><g:formatDate date="${TProjectInstance.end_date2}"
                                              format="yyyy-MM-dd"></g:formatDate></td>
                            <td>
                                <a href="http://srt.skyworth.com/bugs/www/index.php?m=project&f=task&t=html&projectID=${TProjectInstance?.id}&type=all"
                                   target="_blank">点击查看</a>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${TProjectInstanceTotal}"/>
                </div>

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
