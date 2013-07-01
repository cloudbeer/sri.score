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
                    <g:levelname level_id="${session.user?.level_id?:0}"></g:levelname>
                </span>
                <span class="mini muted">当前等级</span>
            </li>
            <li>
                <span class="large text-warning">${session.user?.score?:0}</span>
                <span class="mini muted">总积分</span>
            </li>
            <li>
                <span class="large text-info">523</span>
                <span class="mini muted">本月总计</span>
            </li>
            %{--<li>--}%
                %{--<span class="large text-success">5673</span>--}%
                %{--<span class="mini muted">到下一级</span>--}%
            %{--</li>--}%
            <li>
                <span class="large text-error">-15</span>
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
                        <th>${message(code: 'TIssue.title.label', default: '名称')}</th>
                        <th>${message(code: 'TIssue.score.label', default: '预估分值')}</th>
                        <th>所属${message(code: 'TProject.label', default: '任务包')}</th>
                        <th>状态</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${mytasks}" status="i" var="TIssueInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td>${fieldValue(bean: TIssueInstance, field: "title")}</td>
                            <td>${fieldValue(bean: TIssueInstance, field: "score")}</td>
                            <td>
                                <g:link controller="TProject" action="show" id="${TIssueInstance.project_id}">
                                    <g:projectname
                                            project_id="${fieldValue(bean: TIssueInstance, field: "project_id")}"></g:projectname>
                                </g:link>
                            </td>
                            <td>
                                <g:projectstatus status="${TIssueInstance.xstatus}"></g:projectstatus>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">我管理的${message(code: 'TProject.label', default: '任务包')}</h3>

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
                        <th>${message(code: 'TProject.title.label', default: '名称')}</th>
                        <th>${message(code: 'TProject.pre_score.label', default: '预估分值')}</th>
                        <th>${message(code: 'TProject.manager.label', default: '负责人')}</th>
                        <th>${message(code: 'TProject.xstatus.label', default: 'Status')}</th>
                        <th>禅道</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${myprojects}" status="i" var="TProjectInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
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

        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">我的得分记录</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li><g:link class="btn btn-flat" action="create">更多...</g:link></li>
                    </ul>
                </div>
            </div>
            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th>${message(code: 'TIssue.title.label', default: '名称')}</th>
                        <th>${message(code: 'TIssue.score.label', default: '分值')}</th>
                        <th>${message(code: 'TIssue.description.label', default: '说明')}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${myissues}" status="i" var="issue">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td>${fieldValue(bean: issue, field: "title")}</td>
                            <td>${fieldValue(bean: issue, field: "score")}</td>
                            <td>${fieldValue(bean: issue, field: "description")}</td>


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
                        <li><g:link class="btn btn-flat" action="create">更多...</g:link></li>
                    </ul>
                </div>
            </div>
            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th>${message(code: 'TIssue.title.label', default: '名称')}</th>
                        <th>${message(code: 'TIssue.score.label', default: '分值')}</th>
                        <th>${message(code: 'TIssue.description.label', default: '说明')}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${myissues_minus}" status="i" var="issue">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td>${fieldValue(bean: issue, field: "title")}</td>
                            <td>${fieldValue(bean: issue, field: "score")}</td>
                            <td>${fieldValue(bean: issue, field: "description")}</td>


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
                    <a href="<g:createLinkTo dir="home/browse"/>" class="btn btn-large btn-aj"><span><i
                            class="icon-large micon-home-3"></i>
                    </span>研究院</a>
                    <a href="${createLink(controller: "mine", action: "approve_list")}"
                       class="btn btn-large btn-aj"><span><i class="icon-large micon-dribbble"></i>
                    </span>(${approve_count})个项目等待审批</a>
                    <a href="#" class="btn btn-large btn-aj"><span><i class="icon-large micon-seven-segment-9"></i>
                    </span>(8)个项目等待算分</a>
                    <a href="#" class="btn btn-large btn-primary"><span><i class="icon-large micon-dribbble"></i>
                    </span>项目申请</a>
                    <a href="#" class="btn btn-large btn-bi"><span><i class="icon-large micon-seven-segment-9"></i>
                    </span>送分</a>
                    <a href="#" class="btn btn-large btn-aj"><span><i class="icon-large icon-volume-up"></i>
                    </span>申诉</a>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
