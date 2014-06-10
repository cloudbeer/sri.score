<%@ page import="sri.score.common.Constants" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>系统首页</title>
</head>

<body>
<div class="page-heading">

    <h2 class="page-title muted">
        <i class="micon-dashboard"></i>
        我的仪表盘
    </h2>

    <div class="page-info hidden-phone">
        <ul class="stats">
            <li>
                <span class="large text-warning">
                    <g:levelname level_id="${session.user?.level_id ?: 0}"></g:levelname>
                </span>
                <span class="mini muted">当前等级</span>
            </li>
            <li>
                <span class="large text-warning">${session.user?.score ?: 0}</span>
                <span class="mini muted">总积分</span>
            </li>
            <li>
                <span class="large text-info">${score_month ?: 0}</span>
                <span class="mini muted">本月总计</span>
            </li>
            %{--<li>--}%
            %{--<span class="large text-success">5673</span>--}%
            %{--<span class="mini muted">到下一级</span>--}%
            %{--</li>--}%
            <li>
                <span class="large text-error">${score_month_minus ?: 0}</span>
                <span class="mini muted">本月扣分</span>
            </li>
        </ul>
    </div>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>我的仪表盘</li>
</ul>

<div class="row-fluid">
<div class="span9">
    <div class="well widget">
        <div class="widget-header">
            <h3 class="title">我的任务列表</h3>

            <div class="widget-nav">
                <ul class="nav nav-pills">
                    <li><g:link class="btn btn-flat" action="tasks">更多...</g:link></li>
                </ul>
            </div>
        </div>

        <div class="widget-content">
            <table class="table">
                <thead>
                <tr>
                    <th>所属任务包</th>
                    <th>子任务</th>
                    <th>状态</th>
                    <th style="width:100px;text-align: right">预估</th>
                    <th style="width:100px;text-align: right">得分</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${mytasks}" status="i" var="TIssueInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>
                            <g:link controller="TProject" action="show" id="${TIssueInstance.project_id}">
                                <g:projectname
                                        project_id="${fieldValue(bean: TIssueInstance, field: "project_id")}"></g:projectname>
                            </g:link>
                        </td>
                        <td>${fieldValue(bean: TIssueInstance, field: "title")}</td>
                        <td>
                            <g:projectstatus status="${TIssueInstance.xstatus}"></g:projectstatus>
                        </td>
                        <td style="text-align: right">${fieldValue(bean: TIssueInstance, field: "pre_score")}</td>
                        <td style="text-align: right">${fieldValue(bean: TIssueInstance, field: "score")}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>

    <div class="well widget">
        <div class="widget-header">
            <h3 class="title">我负责的任务包</h3>

            <div class="widget-nav">
                <ul class="nav nav-pills">
                    <li><g:link class="btn btn-flat" controller="TProject" action="list">更多...</g:link></li>
                </ul>
            </div>
        </div>

        <div class="widget-content">
            <table class="table">
                <thead>
                <tr>
                    <th>所属任务包</th>
                    <th>${message(code: 'TProject.manager.label', default: '负责人')}</th>
                    <th style="text-align: center">审批人</th>
                    <th style="text-align: center">创建人</th>
                    <th>${message(code: 'TProject.xstatus.label', default: 'Status')}</th>
                    <th style="text-align: center">预计日期</th>
                    <th style="text-align: center">完成日期</th>
                    <th style="width:100px;text-align: right">预估</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${myprojects}" status="i" var="TProjectInstance">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                        <td><g:link action="show" controller="TProject"
                                    id="${TProjectInstance.id}">${fieldValue(bean: TProjectInstance, field: "title")}</g:link></td>
                        <td>
                            <g:usernick
                                    user_id="${fieldValue(bean: TProjectInstance, field: "manager")}"></g:usernick>
                        </td>
                        <td style="text-align: center">
                            <g:usernick user_id="${fieldValue(bean: TProjectInstance, field: "approver")}"></g:usernick>
                        </td>
                        <td style="text-align: center">
                            <g:usernick user_id="${fieldValue(bean: TProjectInstance, field: "creator")}"></g:usernick>
                        </td>
                        <td>
                            <g:projectstatus
                                    status="${fieldValue(bean: TProjectInstance, field: "xstatus")}"></g:projectstatus>
                        </td>
                        <td style="text-align: center"><g:formatDate date="${TProjectInstance.end_date1}" format="yyyy-MM-dd"></g:formatDate></td>
                        <td style="text-align: center"><g:formatDate date="${TProjectInstance.end_date2}" format="yyyy-MM-dd"></g:formatDate></td>
                        <td style="text-align: right">${fieldValue(bean: TProjectInstance, field: "pre_score")}</td>
                        %{--<td>--}%
                            %{--<a href="http://srt.skyworth.com/bugs/www/index.php?m=project&f=task&t=html&projectID=${TProjectInstance?.id}&type=all"--}%
                               %{--target="_blank">点击查看</a>--}%
                        %{--</td>--}%

                    </tr>
                </g:each>
                </tbody>
            </table>

        </div>
    </div>


<div class="well widget">
    <div class="widget-header">
        <h3 class="title">我创建的任务包</h3>

        <div class="widget-nav">
            <ul class="nav nav-pills">
                <li><g:link class="btn btn-flat" controller="TProject" action="list">更多...</g:link></li>
            </ul>
        </div>
    </div>

    <div class="widget-content">
        <table class="table">
            <thead>
            <tr>
                <th>所属任务包</th>
                <th>${message(code: 'TProject.manager.label', default: '负责人')}</th>
                <th style="text-align: center">审批人</th>
                <th style="text-align: center">创建人</th>
                <th>${message(code: 'TProject.xstatus.label', default: 'Status')}</th>
                <th style="text-align: center">预计日期</th>
                <th style="text-align: center">完成日期</th>
                <th style="width:100px;text-align: right">预估</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${my_created_projects}" status="i" var="TProjectInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td><g:link action="show" controller="TProject"
                                id="${TProjectInstance.id}">${fieldValue(bean: TProjectInstance, field: "title")}</g:link></td>
                    <td>
                        <g:usernick
                                user_id="${fieldValue(bean: TProjectInstance, field: "manager")}"></g:usernick>
                    </td>
                    <td style="text-align: center">
                        <g:usernick user_id="${fieldValue(bean: TProjectInstance, field: "approver")}"></g:usernick>
                    </td>
                    <td style="text-align: center">
                        <g:usernick user_id="${fieldValue(bean: TProjectInstance, field: "creator")}"></g:usernick>
                    </td>
                    <td>
                        <g:projectstatus
                                status="${fieldValue(bean: TProjectInstance, field: "xstatus")}"></g:projectstatus>
                    </td>
                    <td style="text-align: center"><g:formatDate date="${TProjectInstance.end_date1}" format="yyyy-MM-dd"></g:formatDate></td>
                    <td style="text-align: center"><g:formatDate date="${TProjectInstance.end_date2}" format="yyyy-MM-dd"></g:formatDate></td>
                    <td style="text-align: right">${fieldValue(bean: TProjectInstance, field: "pre_score")}</td>
                    %{--<td>--}%
                    %{--<a href="http://srt.skyworth.com/bugs/www/index.php?m=project&f=task&t=html&projectID=${TProjectInstance?.id}&type=all"--}%
                    %{--target="_blank">点击查看</a>--}%
                    %{--</td>--}%

                </tr>
            </g:each>
            </tbody>
        </table>

    </div>
</div>

    <div class="well widget">
        <div class="widget-header">
            <h3 class="title">我的得分记录</h3>

            <div class="widget-nav">
                <ul class="nav nav-pills">
                    <li><g:link class="btn btn-flat" action="issues" id="up">更多...</g:link></li>
                </ul>
            </div>
        </div>

        <div class="widget-content">
            <table class="table">
                <thead>
                <tr>
                    <th>所属任务包</th>
                    <th>子任务</th>
                    <th>${message(code: 'TIssue.description.label', default: '说明')}</th>
                    <th style="width:100px;text-align: right">${message(code: 'TIssue.score.label', default: '分值')}</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${myissues}" status="i" var="issue">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>
                            <g:if test="${issue.xtype == Constants.PROJECTTYPES_TASK}">
                                <g:link controller="TProject" action="show" id="${issue.project_id}">
                                    <g:projectname project_id="${issue.project_id}"></g:projectname>
                                </g:link>
                            </g:if>
                        </td>
                        <td>${fieldValue(bean: issue, field: "title")}</td>
                        <td>${fieldValue(bean: issue, field: "description")}</td>
                        <td style="text-align: right">${fieldValue(bean: issue, field: "score")}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>

    <div class="well widget">
        <div class="widget-header">
            <h3 class="title">我的扣分记录</h3>

            <div class="widget-nav">
                <ul class="nav nav-pills">
                    <li><g:link class="btn btn-flat" action="issues" id="down">更多...</g:link></li>
                </ul>
            </div>
        </div>

        <div class="widget-content">
            <table class="table">
                <thead>
                <tr>
                    <th>所属任务包</th>
                    <th>子任务</th>
                    <th>${message(code: 'TIssue.description.label', default: '说明')}</th>
                    <th style="width:100px;text-align: right">${message(code: 'TIssue.score.label', default: '分值')}</th>
                </tr>
                </thead>
                <tbody>
                <g:each in="${myissues_minus}" status="i" var="issue">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>
                            <g:if test="${issue.xtype == Constants.PROJECTTYPES_TASK}">
                                <g:link controller="TProject" action="show" id="${issue.project_id}">
                                    <g:projectname project_id="${issue.project_id}"></g:projectname>
                                </g:link>
                            </g:if>
                        </td>
                        <td>${fieldValue(bean: issue, field: "title")}</td>
                        <td>${fieldValue(bean: issue, field: "description")}</td>
                        <td style="text-align: right">${fieldValue(bean: issue, field: "score")}</td>

                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>

<div class="span3">
    <div class="well widget">
        <div class="widget-header">
            <h3 class="title">快捷工具栏</h3>
        </div>

        <div class="widget-content">

            <div class="button-action">

                <a href="<g:createLink controller="home" action="browse"/>" class="btn btn-large btn-aj"><span><i
                        class="icon-large micon-home-3"></i>
                </span>总览</a>
                <g:if test="${session.user?.is_approver() || session.user?.is_admin()}">
                    <a href="${createLink(controller: "mine", action: "approve_list")}"
                       class="btn btn-large btn-bi"><span><i class="icon-large micon-dribbble"></i>
                    </span>(${approve_count})待审批</a>
                    <a href="${createLink(controller: "mine", action: "approved_list")}"
                       class="btn btn-large btn-bi"><span><i class="icon-large micon-dribbble"></i>
                    </span>(${approved_count})已审批</a>
                    <a href="${createLink(controller: "mine", action: "score_project_list")}"
                       class="btn btn-large btn-bf"><span><i class="icon-large micon-seven-segment-9"></i>
                    </span>(${score_count})待算分</a>
                </g:if>
                <a href="${createLink(controller: "TProject", action: "apply")}"
                   class="btn btn-large btn-primary"><span><i class="icon-large micon-dribbble"></i>
                </span>创建任务包</a>
                %{--<a href="#" class="btn btn-large btn-bi"><span><i class="icon-large micon-seven-segment-9"></i>--}%
                %{--</span>送分</a>--}%
                %{--<a href="#" class="btn btn-large btn-aj"><span><i class="icon-large icon-volume-up"></i>--}%
                %{--</span>申诉</a>--}%
            </div>
        </div>
    </div>

</div>
</div>
</body>
</html>
