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
    def canScore = TProjectInstance.xstatus == Constants.PROJECTSTATUS_FINISHED && (session.user.is_admin() || TProjectInstance.is_approver(session.user))
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

<g:form action="give_score_save" name="form1" id="${TProjectInstance?.id}">
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
                                <td class="key">实际完成</td>
                                <td class="value">
                                    <g:if test="${TProjectInstance?.end_date2}">
                                        <g:formatDate date="${TProjectInstance.end_date2}"
                                                      format="yyyy-MM-dd"></g:formatDate>
                                    </g:if>
                                </td>
                            </tr>
                        </table>



                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th style="text-align: center">任务名称</th>
                                <th style="text-align: center">用户</th>
                                <th style="text-align: center">预计</th>
                                <th style="text-align: center;width:100px">得分</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${tasks}" status="i" var="tasksInstance">
                                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                                    <td>${fieldValue(bean: tasksInstance, field: "title")}</td>


                                    <td><g:usernick
                                            user_id="${fieldValue(bean: tasksInstance, field: "user_id")}"></g:usernick></td>

                                    <td style="text-align: right;font-weight: bold;font-size: 16px;">${fieldValue(bean: tasksInstance, field: "pre_score")}</td>

                                    <td>
                                        <g:hiddenField name="a_task_id" value="${tasksInstance.id}"></g:hiddenField>
                                        <g:hiddenField name="a_pre_score" value="${tasksInstance.pre_score}"></g:hiddenField>
                                        <g:textField class="input-small xscore" name="r_${tasksInstance.id}"
                                                     value="${tasksInstance.pre_score}"></g:textField></td>

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
                    <g:if test="${canScore}">

                        <div class="fieldcontain required">
                            <h3>
                                审批意见
                            </h3>
                            <label>
                            <input type="button" class='btn btn-small btn-danger' id="add_sub" value="加/扣 切换" /> </label>
                            <g:textArea name="a_comment"></g:textArea>
                            <br/>
                            请核准左侧列表中的分值后，进行分值结算。
                        </div>

                        <div class="button-action">
                            <a href="#" class="btn btn-large btn-cl" id="btnGiveScore"
                               role="button" data-toggle="modal">
                                <span><i class="icon-large micon-pencil-2"></i></span>
                                结算分值
                            </a>
                        </div>

                        <div>
                            <h3>审批历史</h3>
                            ${TProjectInstance?.comment}
                        </div>
                    </g:if>
                    <g:if test="${flash.message}">
                        <div class="alert alert-block alert-error">
                            <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i>
                            </a>
                            <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
                            ${flash.message}
                        </div>
                    </g:if>
                </div>
            </div>
        </div>

    </div>
</g:form>
<script type="text/javascript">
    $(function () {
        $("#btnGiveScore").click(function () {
            if (!confirm("请确认是否发分？")) return;
            $("#form1").submit();
        });

        $("#add_sub").click(function(){
            $(".xscore").each(function(){
                var mm = $(this).val();
                mm = parseFloat(mm)*-1;
                $(this).val(mm);

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
