<%@ page import="sri.score.TIssue" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TIssue.label', default: 'TIssue')}"/>
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
        ${message(code: 'TIssue.label', default: 'TIssue')}
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
                        <li></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th>${message(code: 'TIssue.title.label', default: '名称')}</th>
                        <th>${message(code: 'TIssue.score.label', default: '预估分值')}</th>
                        <th>用户</th>
                        <th>所属项目</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${TIssueInstanceList}" status="i" var="TIssueInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td>${fieldValue(bean: TIssueInstance, field: "title")}</td>
                            <td>${fieldValue(bean: TIssueInstance, field: "score")}</td>
                            <td>
                                <g:usernick
                                        user_id="${fieldValue(bean: TIssueInstance, field: "user_id")}"></g:usernick>
                            </td>
                            <td>
                                <g:link controller="TProject" action="show" id="${TIssueInstance.project_id}">
                                    <g:projectname
                                            project_id="${fieldValue(bean: TIssueInstance, field: "project_id")}"></g:projectname>
                                </g:link>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${TIssueInstanceTotal}"/>
                </div>

            </div>

        </div>
    </div>
</div>


<div id="list-TIssue" class="content scaffold-list" role="main">

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
