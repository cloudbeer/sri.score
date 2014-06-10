<%@ page import="sri.score.TUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="审批人  [${approver.nick}] 发分详情"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-user"></i>
        审批人 [${approver.nick}] 发分详情
    </h2>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        审批人 [${approver.nick}] 发分详情
    </li>
</ul>

<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">${entityName}</h3>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">

                <div class="fieldcontain required">
                    起始时间段：${params.from} - ${params.to}
                </div>

                <table class="table">
                    <thead>
                    <tr>
                        <th>姓名</th>
                        <th>部门</th>
                        <th style="text-align: right;">加分</th>
                        <th style="text-align: right;">减分</th>
                        <th style="text-align: right;">合计</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${groupedIssues}" status="i" var="TUserIssues">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:usernick user_id="${TUserIssues.key}" users="${users}"></g:usernick>
                            </td>
                            <td>
                                <g:if test="${TUserIssues.key}">
                                    <g:group_name user_id="${TUserIssues.key}" users="${users}"
                                                  groups="${groups}"></g:group_name>
                                </g:if>
                            </td>
                            <td style="text-align: right;">
                                ${TUserIssues.value.findAll { s -> s.score >= 0 }.sum { s -> s.score } ?: 0}
                            </td>
                            <td style="text-align: right;">
                                ${TUserIssues.value.findAll { s -> s.score < 0 }.sum { s -> s.score } ?: 0}
                            </td>
                            <td style="text-align: right;">
                                ${TUserIssues.value.sum { s -> s.score } ?: 0}
                            </td>
                        </tr>
                    </g:each>
                    <tr>
                        <td></td>
                        <td></td>
                        <td style="text-align: right;">${total_up}</td>
                        <td style="text-align: right;">${total_down}</td>
                        <td style="text-align: right;">${total}</td>
                    </tr>
                    </tbody>
                </table>

            </div>

        </div>
    </div>
</div>


<div id="list-TUser" class="content scaffold-list" role="main">

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
