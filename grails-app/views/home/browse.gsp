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
    <div class="span6">
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
                        <th style="text-align: center">${message(code: 'TProject.manager.label', default: '经理')}</th>
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
                            <td style="text-align: center">查看</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <div class="span6">
        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">本周得分 Top20</h3>

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
                        <th>名称</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1111</td>
                        <td></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">本月得分 Top20</h3>

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
                        <th>名称</th>
                        <th></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>1111</td>
                        <td></td>
                        <td></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

</body>
</html>
