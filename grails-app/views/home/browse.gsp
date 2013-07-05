<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>系统首页</title>
</head>

<body>
<div class="page-heading">

    <h2 class="page-title muted">
        <i class="micon-home-3"></i>
        首页
    </h2>

    <div class="page-info hidden-phone">
        <ul class="stats">
            <li>
            </li>
        </ul>
    </div>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="#">首页</a></li>
</ul>

<div class="row-fluid">
    <div class="span8">
        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">项目公示</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li><g:link class="btn btn-flat"  controller="Home" action="create">更多...</g:link></li>
                    </ul>
                </div>
            </div>

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
                        <th style="text-align: center;width:40px">禅道</th>
                    </tr>
                    </thead>
                    <tbody>

                    <g:each in="${projects}" status="i" var="TProjectInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"  controller="TProject"
                                        id="${TProjectInstance.id}">${fieldValue(bean: TProjectInstance, field: "title")}</g:link></td>
                            <td style="text-align: right">${fieldValue(bean: TProjectInstance, field: "pre_score")}</td>
                            <td style="text-align: center"><g:usernick user_id="${fieldValue(bean: TProjectInstance, field: "manager")}" ></g:usernick>
                                </td>
                            <td style="text-align: center">
                                <g:usernick user_id="${fieldValue(bean: TProjectInstance, field: "approver")}" ></g:usernick>
                            </td>
                            <td><g:formatDate date="${TProjectInstance.end_date1}" format="yyyy-MM-dd"></g:formatDate></td>
                            <td><g:formatDate date="${TProjectInstance.end_date2}" format="yyyy-MM-dd"></g:formatDate></td>
                            <td style="text-align: center">
                                <a href="http://srt.skyworth.com/bugs/www/index.php?m=project&f=task&t=html&projectID=${TProjectInstance?.id}&type=all"
                                   target="_blank">查看</a>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <div class="span4">
        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">本周得分Top10</h3>

                %{--<div class="widget-nav">--}%
                    %{--<ul class="nav nav-pills">--}%
                        %{--<li><g:link class="btn btn-flat"  controller="Home" action="create">更多...</g:link></li>--}%
                    %{--</ul>--}%
                %{--</div>--}%
            </div>

            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th style="width:30px"></th>
                        <th>姓名</th>
                        <th style="width:100px;text-align: center">得分</th>
                    </tr>
                    </thead>
                <tbody>
                    <g:each in="${top10Users}" var="u" status="i" >
                        <tr>
                            <td style="text-align: right;font-weight: bold">${i+1}</td>
                            <td>${u.nick}</td>
                            <td  style="text-align: right">${u.score}</td>
                        </tr>
                        </tbody>
                    </g:each>
                </table>
            </div>
        </div>
        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">本月得分 Top10</h3>

                %{--<div class="widget-nav">--}%
                    %{--<ul class="nav nav-pills">--}%
                        %{--<li><g:link class="btn btn-flat"  controller="Home" action="create">更多...</g:link></li>--}%
                    %{--</ul>--}%
                %{--</div>--}%
            </div>

            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th style="width:30px"></th>
                        <th>姓名</th>
                        <th style="width:100px;text-align: center">得分</th>
                    </tr>
                    </thead>
                <tbody>
                    <g:each in="${top10Users}" var="u" status="i" >
                        <tr>
                            <td style="text-align: right;font-weight: bold">${i+1}</td>
                            <td>${u.nick}</td>
                            <td  style="text-align: right">${u.score}</td>
                        </tr>
                        </tbody>
                    </g:each>
                </table>
            </div>
        </div>
        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">总分 Top10</h3>

                %{--<div class="widget-nav">--}%
                    %{--<ul class="nav nav-pills">--}%
                        %{--<li><g:link class="btn btn-flat"  controller="Home" action="create">更多...</g:link></li>--}%
                    %{--</ul>--}%
                %{--</div>--}%
            </div>

            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th style="width:30px"></th>
                        <th>姓名</th>
                        <th style="width:100px;text-align: center">总分</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${top10Users}" var="u" status="i" >
                    <tr>
                        <td style="text-align: right;font-weight: bold">${i+1}</td>
                        <td>${u.nick}</td>
                        <td  style="text-align: right">${u.score}</td>
                    </tr>
                    </tbody>
                    </g:each>
                </table>
            </div>
        </div>

    </div>
</div>

</body>
</html>
