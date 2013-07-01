<%@ page import="sri.score.TProject" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TProject_Static.label', default: 'TProject')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-tasks"></i>
        分值设定 - ${TProjectInstance?.title}
    </h2>

    <div class="page-info hidden-phone">
        <ul class="stats">
            <li>
                <span></span>
            </li>
        </ul>

    </div>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        <g:link action="projects">${message(code: 'TProject_Static.label', default: 'TProject')}</g:link>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        分值设定
    </li>
</ul>

<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">分值设定 - ${TProjectInstance?.title}</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <g:form action="project_score_save" id="${TProjectInstance?.id}">
                    <table class="table">
                        <thead>
                        <tr>
                            <th>等级 ${message(code: 'TLevel.title.label', default: '名称')}</th>
                            <th style="text-align: center">${message(code: 'TLevel.min_score.label', default: '等级分')}</th>
                            <th style="width: 200px;text-align: center">分值</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${levels}" status="i" var="level">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                <td>${fieldValue(bean: level, field: "title")}</td>
                                <td style="text-align: right">${fieldValue(bean: level, field: "min_score")}</td>
                                <td style="text-align: center">
                                    <input type="text" class="input-small"
                                           value="<g:levelscore level_id="${fieldValue(bean: level, field: "id")}"
                                                                project_id="${TProjectInstance?.id}"
                                                                level_scores="${project_level_scores}"></g:levelscore>"
                                           name="xscore"/>
                                    <g:hiddenField name="xlevel_id"
                                                   value="${fieldValue(bean: level, field: "id")}"></g:hiddenField>
                                </td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>

                    <div class="pagination-centered">
                        <g:submitButton name="btnSaveScore" value="保存"
                                        class="btn btn-primary btn-large"></g:submitButton>
                    </div>
                </g:form>
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
