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

<%
    def canModi = TProjectInstance.xstatus == Constants.PROJECTSTATUS_OUTSTANDING && (session.user.is_admin() || TProjectInstance.is_manager(session.user) || TProjectInstance.is_approver(session.user))
    def canApprove = TProjectInstance.xstatus == Constants.PROJECTSTATUS_OUTSTANDING && (session.user.is_admin() || TProjectInstance.is_approver(session.user))
    def canScore = TProjectInstance.xstatus == Constants.PROJECTSTATUS_APPROVED && (session.user.is_admin() || TProjectInstance.is_approver(session.user)) && TProjectInstance.end_date2
    def canFinish = TProjectInstance.xstatus == Constants.PROJECTSTATUS_APPROVED && (session.user.is_admin() || TProjectInstance.is_manager(session.user)) && !TProjectInstance.end_date2
%>


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
<div class="span9">

    <!-- widget -->
    <div class="well widget">
        <!-- widget header -->
        <div class="widget-header">
            <h3 class="title"><g:message code="default.show.label" args="[entityName]"/></h3>

            <div class="widget-nav">
                <ul class="nav nav-pills">
                    <li></li>
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
                        <td class="key">负责人</td>
                        <td class="value">
                            <g:usernick user_id="${TProjectInstance?.manager}"></g:usernick>
                        </td>
                    </tr>
                    <tr>
                        <td class="key">审批经理</td>
                        <td class="value">
                            <g:usernick user_id="${TProjectInstance?.approver}"></g:usernick>
                        </td>
                    </tr>
                    <tr>
                        <td class="key">任务包状态</td>
                        <td class="value"><g:projectstatus status="${TProjectInstance?.xstatus}"></g:projectstatus></td>
                    </tr>
                    <tr>
                        <td class="key">预计完成</td>
                        <td class="value">
                            <g:if test="${TProjectInstance?.end_date1}">
                                <g:formatDate date="${TProjectInstance.end_date1}" format="yyyy-MM-dd"></g:formatDate>
                            </g:if>
                        </td>
                    </tr>
                    <tr>
                        <td class="key">实际完成</td>
                        <td class="value">
                            <g:if test="${TProjectInstance?.end_date2}">
                                <g:formatDate date="${TProjectInstance.end_date2}" format="yyyy-MM-dd"></g:formatDate>
                            </g:if>
                        </td>
                    </tr>
                    <tr>
                        <td class="key"><g:message code="TProject.create_date.label" default="create_date"/></td>
                        <td class="value">
                            <g:if test="${TProjectInstance?.create_date}">
                                <g:formatDate date="${TProjectInstance.create_date}" format="yyyy-MM-dd"></g:formatDate>
                            </g:if>
                        </td>
                    </tr>
                    <tr>
                        <td class="key">备注</td>
                        <td class="value">
                            ${TProjectInstance?.comment}
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
                        <g:if test="${canModi}">
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

                            <g:if test="${canModi}">
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

<div class="span3">
    <!-- widget -->
    <div class="well widget">
        <!-- widget header -->
        <div class="widget-header">
            <h3 class="title">
                操作
            </h3>

        </div>
        <!-- ./ widget header -->

        <!-- widget content -->
        <div class="widget-content">
            <g:if test="${canModi}">
                <g:render template="task_form"></g:render>
                <g:render template="choose_user"></g:render>

                <div class="button-action">
                    <a href="#n_task" class="btn btn-large btn-primary" role="button"
                       data-toggle="modal">
                        <span><i class="icon-large icon-tasks"></i></span>
                        任务分解</a>
                </div>

                <div class="button-action">
                    <a href="#choose_user_form" class="btn btn-large btn-bp" id="btnChooseManager"
                       role="button" data-toggle="modal"><span><i class="icon-large micon-user-2"></i>
                    </span>指定负责人
                    </a>
                </div>

                <div class="button-action">
                    <a href="#choose_user_form" class="btn btn-large btn-warning" id="btnChooseApprover"
                       role="button" data-toggle="modal">
                        <span><i class="icon-large  micon-user-3"></i></span>
                        指定审批人
                    </a>
                </div>
            </g:if>
            <g:if test="${canApprove}">
                <div class="button-action">
                    <a href="#approve_form" class="btn btn-large btn-cl" id="btnApprove"
                       role="button" data-toggle="modal">
                        <span><i class="icon-large micon-pencil-2"></i></span>
                        审批
                    </a>
                </div>
                <g:render template="form_approve"></g:render>
            </g:if>
            <g:if test="${canFinish}">
                <div class="button-action">
                    <a href="#approve_form" class="btn btn-large btn-danger" id="btnFinish">
                        <span><i class="icon-large icon-pencil"></i></span>
                        完成
                    </a>
                </div>
            </g:if>
            <g:if test="${canScore}">
                <div class="button-action">
                    <a href="#give_score_form" class="btn btn-large btn-danger" id="btnGiveScore"
                       role="button" data-toggle="modal"><span><i
                            class="icon-large icon-pencil"></i>
                    </span>分值结算
                    </a>
                </div>
                <g:render template="form_score"></g:render>
            </g:if>
            <g:if test="${canModi}">
                <g:hiddenField name="id" value="${TProjectInstance?.id}"/>

                <div class="button-action">
                    <g:link class="edit btn btn-large btn-success" action="edit"
                            id="${TProjectInstance?.id}"><span><i class="icon-large icon-pencil"></i></span>
                        修改
                    </g:link>
                </div>

                <div class="button-action">
                    <g:link class="edit btn btn-large btn-danger" action="delete"
                            id="${TProjectInstance?.id}" onclick="return confirm('是否确认删除？')">
                        <span><i class="icon-large icon-remove"></i></span>
                        删除
                    </g:link>
                </div>
            </g:if>

            <div class="button-action">
                <g:link class="btn btn-large btn-info" action="create">
                    <span><i class="icon-large micon-droplet"></i></span>
                    创建任务包
                </g:link>
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
        $(".btn_modi_task").click(function () {
            var xthis = $(this);
            cur_task_id = xthis.attr("rel");
            $("#n_task").modal("show");
            $.post("<g:createLink controller="TIssue" action="get_task" />",
                    {task_id: cur_task_id}, function (res) {
                        $("#is_title").val(res.title);
                        $("#is_score").val(res.score);
                        $("#is_user_id").val(res.user_id);
                        $("#is_user_query").val(res.nick);

                    }, "json");
            return false;
        });
        $("#btnFinish").click(function () {
            if (!confirm("是否确定完成此任务包？您的完成时间将设置为今天。"))
                return;
            $.post("${createLink(action: 'set_finish', id: TProjectInstance.id)}", null,
                    function (res) {
                        if (res == "1") {
                            window.location.reload();
                        }
                    });

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
