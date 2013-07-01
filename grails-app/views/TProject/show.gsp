<%@ page import="sri.score.TProject" %>
<%@ page import="sri.score.TUser" %>
<%@ page import="sri.score.common.Constants" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TProject.label', default: 'TProject')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-tasks"></i>
        ${TProjectInstance?.title}
    </h2>

</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li><g:link action="list"><g:message code="TProject.label"/></g:link>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        <g:message code="default.show.label" args="[entityName]"/>

    </li>
</ul>


<div class="row-fluid">
<div class="span12">

<!-- widget -->
<div class="well widget">
<!-- widget header -->
<div class="widget-header">
    <h3 class="title"><g:message code="default.show.label" args="[entityName]"/></h3>

    <div class="widget-nav">
        <ul class="nav nav-pills">
            <li><g:link class="btn" action="create"><g:message
                    code="default.create.label"
                    args="[entityName]"/></g:link></li>
        </ul>
    </div>
</div>
<!-- ./ widget header -->

<!-- widget content -->
<div class="widget-content">

    <div id="show-TProject" class="content scaffold-show" role="main">
        <g:if test="${flash.message}">
            <div class="alert alert-block alert-error">
                <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i>
                </a>
                <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
                ${flash.message}
            </div>
        </g:if>
        <table class="show">
            <tr>
                <td class="key"><g:message code="TProject.title.label" default="title"/></td>
                <td class="value">
                    <g:if test="${TProjectInstance?.title}">
                        <g:fieldValue bean="${TProjectInstance}" field="title"/>
                    </g:if>
                </td>
            </tr>
            <tr>
                <td class="key"><g:message code="TProject.pre_score.label" default="Score"/></td>
                <td class="value">
                    <g:if test="${TProjectInstance?.pre_score}">
                        <g:fieldValue bean="${TProjectInstance}" field="pre_score"/>
                    </g:if>
                </td>
            </tr>
            <tr>
                <td class="key"><g:message code="TProject.create_date.label" default="create_date"/></td>
                <td class="value">
                    <g:if test="${TProjectInstance?.create_date}">
                        <g:fieldValue bean="${TProjectInstance}" field="create_date"/>
                    </g:if>
                </td>
            </tr>
            <tr>
                <td class="key" onclick="$('#descBlock').toggle()" style="cursor: pointer;"><g:message
                        code="TProject.description.label" default="Content"/> <i
                        class="icon icon-circle-arrow-right"></i></td>
                <td class="value">
                    <g:if test="${TProjectInstance?.description}">
                        <div id="descBlock" style="display: none">
                            ${TProjectInstance?.description}
                        </div>
                    </g:if>
                </td>
            </tr>
        </table>

        <g:if test="${TProjectInstance.is_manager(session.user)}">
            <g:form>
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${TProjectInstance?.id}"/>
                    <g:link class="edit btn btn-primary" action="edit"
                            id="${TProjectInstance?.id}"><g:message
                            code="default.button.edit.label" default="Edit"/></g:link>

                    <g:actionSubmit class="btn btn-cg" action="delete"
                                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                </fieldset>
            </g:form>
        </g:if>

        <div class="row-fluid">
            <g:if test="${TProjectInstance.is_manager(session.user)}">
                <g:render template="task_form"></g:render>
                <g:render template="choose_user"></g:render>
                <div class="span2">
                    <div class="button-action">
                        <a href="#n_task" class="btn btn-large btn-primary" role="button"
                           data-toggle="modal"><span><i class="icon-large icon-tasks"></i>
                        </span>新任务</a>
                    </div>
                </div>

                <div class="span3">
                    <div class="button-action">
                        <a href="#choose_user_form" class="btn btn-large btn-bp" id="btnChooseManager"
                           role="button" data-toggle="modal"><span><i class="icon-large micon-user-2"></i>
                        </span>负责人：
                        <g:usernick
                                user_id="${fieldValue(bean: TProjectInstance, field: "manager")}"></g:usernick>
                        </a>
                    </div>
                </div>

                <div class="span3">
                    <div class="button-action">
                        <a href="#choose_user_form" class="btn btn-large btn-warning" id="btnChooseApprover"
                           role="button" data-toggle="modal"><span><i
                                class="icon-large  micon-user-3"></i>
                        </span>审批：
                        <g:usernick
                                user_id="${fieldValue(bean: TProjectInstance, field: "approver")}"></g:usernick>
                        </a>
                    </div>
                </div>
            </g:if>
            <g:if test="${TProjectInstance.is_approver(session.user)}">
                <div class="span3">
                    <div class="button-action">
                        <a href="#choose_user_form" class="btn btn-large btn-warning" id="btnApprove"
                           role="button" data-toggle="modal"><span><i
                                class="icon-large  micon-user-3"></i>
                        </span>审批
                        </a>
                    </div>
                </div>
            </g:if>
        </div>

        <script type="text/javascript">
            function saveManager() {
                $.post("<g:createLink controller="TProject" action="save_manager" />",
                        {col: "manager", user_id: chosen_user_id, id: ${TProjectInstance?.id}}, function (res) {
                            if (res == "1") {
                                window.location.reload();
                            }
                            else {
                                alert("Error");
                            }
                        });
            }
            function saveApprover() {
                $.post("<g:createLink controller="TProject" action="save_manager" />",
                        {col: "approver", user_id: chosen_user_id, id: ${TProjectInstance?.id}}, function (res) {
                            if (res == "1") {
                                window.location.reload();
                            }
                            else {
                                alert("Error");
                            }
                        });
            }
            $(function () {
                $("#btnChooseManager").click(function () {
                    xtype = 0;
                    chosenUserCallBack = saveManager;
                });
                $("#btnChooseApprover").click(function () {
                    xtype =${Constants.USERTYPES_APPROVER};
                    chosenUserCallBack = saveApprover;
                });
            });
        </script>
        <table class="table table-bordered">
            <thead>
            <tr>
                <th style="text-align: center">任务名称</th>
                <th style="text-align: center">分值</th>
                <th style="text-align: center">用户</th>
                <g:if test="${TProjectInstance.is_manager(session.user)}">
                    <th style="width: 80px;text-align: center">管理</th>
                </g:if>
            </tr>
            </thead>
            <tbody>
            <g:each in="${tasks}" status="i" var="tasksInstance">
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                    <td>${fieldValue(bean: tasksInstance, field: "title")}</td>


                    <td style="text-align: right;font-weight: bold;font-size: 16px;">${fieldValue(bean: tasksInstance, field: "score")}</td>

                    <td><g:usernick
                            user_id="${fieldValue(bean: tasksInstance, field: "user_id")}"></g:usernick></td>

                    <g:if test="${TProjectInstance.is_manager(session.user)}">
                        <td style="text-align: center">
                            <a class="btn square-item small btn-danger btn_delete_task" href="#" title='删除'
                               rel="${fieldValue(bean: tasksInstance, field: "id")}"><i
                                    class="micon-remove"></i></a>
                            <a class="btn square-item small btn-success btn_modi_task" href="#" title='修改'
                               rel="${fieldValue(bean: tasksInstance, field: "id")}"><i
                                    class="icon-edit"></i></a>
                        </td>
                    </g:if>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>
</div>
</div>
</div>
</div>
<script type="text/javascript">
    $(function () {
        $(".btn_delete_task").click(function () {
            if (!confirm("是否确定删除？"))
                return false;
            var xthis = $(this);
            var task_id = xthis.attr("rel");
            $.post("<g:createLink controller="TIssue" action="remove_task" />",
                    {task_id: task_id}, function (res) {
                        if (res == "1") {
                            xthis.parent().parent().remove();
                        }
                        else {
                            alert("移除失败:" + res);
                        }
                    });
            return false;
        });
    })
</script>
<style>
.table tr th {
    background: #ccc;
    font-weight: bold;
    line-height: 40px;
}

.table tr td {
    line-height: 40px;
}

.table tr:hover td {
    background: #eee;
}
</style>
</body>
</html>
