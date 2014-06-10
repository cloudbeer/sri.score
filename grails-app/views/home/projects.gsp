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
    <div class="span12">
        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">项目公示</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li><g:link class="btn btn-flat" controller="Home" action="projects">更多...</g:link></li>
                    </ul>
                </div>
            </div>

            <div class="widget-content">

                <g:render template="choose_user"></g:render>
                <div class="fieldcontain required">
                    <g:form name="qForm" method="post" action="projects" class="form-inline">
                        <label>
                            选择状态：
                            <select name="status">
                                <option value="0">全部</option>
                                <option value="${Constants.PROJECTSTATUS_OUTSTANDING}">未处理</option>
                                <option value="${Constants.PROJECTSTATUS_APPROVED}">已审批</option>
                                <option value="${Constants.PROJECTSTATUS_FINISHED}">已完成</option>
                                <option value="${Constants.PROJECTSTATUS_SCORED}">已发分</option>
                            </select>
                        </label>
                        <label>
                            选择负责人：
                        </label>
                        <g:hiddenField name="manager"></g:hiddenField>
                        <div class="input-append">
                            <g:textField name="nick_ref" readonly="true" class="input-small"></g:textField>
                            <a href="#choose_user_form" class="btn add-on" id="btnChooseUser"
                               role="button"
                               data-toggle="modal"><i class="icon-search"></i></a>
                        </div>
                        <label>
                            选择审批人：
                            <select name="approver">
                                <option value="0">全部</option>
                                <g:each in="${approvers}" var="approver">
                                    <option value="${approver.id}">${approver.nick}</option>
                                </g:each>
                            </select>
                            %{--<g:select name="approver" from="${approvers}" optionKey="id" optionValue="nick">--}%
                                %{--<option value="0">全部</option>--}%
                            %{--</g:select>--}%
                        </label>

                        <button class="btn btn-primary" type="submit" id="btnQuery">查询</button>

                    </g:form>
                </div>
                <table class="table">
                    <thead>
                    <tr>
                        <th style="text-align: center">任务包名称</th>
                        <th style="width:120px;text-align: center">${message(code: 'TProject.pre_score.label', default: '分值')}</th>
                        <th style="text-align: center">${message(code: 'TProject.manager.label', default: '负责人')}</th>
                        <th style="text-align: center">${message(code: 'TProject.approver.label', default: '审批人')}</th>
                        <th style="text-align: center">${message(code: 'TProject.approver.label', default: '创建人')}</th>
                        <th>${message(code: 'TProject.xstatus.label', default: 'Status')}</th>
                        <th style="text-align: center">预计日期</th>
                        <th style="text-align: center">完成日期</th>
                        <th style="text-align: center;width:40px">禅道</th>
                    </tr>
                    </thead>
                    <tbody>

                    <g:each in="${projects}" status="i" var="TProjectInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show" controller="TProject"
                                        id="${TProjectInstance.id}">${fieldValue(bean: TProjectInstance, field: "title")}</g:link></td>
                            <td style="text-align: right">${fieldValue(bean: TProjectInstance, field: "pre_score")}</td>
                            <td style="text-align: center"><g:usernick
                                    user_id="${fieldValue(bean: TProjectInstance, field: "manager")}"></g:usernick>
                            </td>
                            <td style="text-align: center">
                                <g:usernick
                                        user_id="${fieldValue(bean: TProjectInstance, field: "approver")}"></g:usernick>
                            </td>
                            <td style="text-align: center">
                                <g:usernick
                                        user_id="${fieldValue(bean: TProjectInstance, field: "creator")}"></g:usernick>
                            </td>
                            <td>
                                <g:projectstatus
                                        status="${fieldValue(bean: TProjectInstance, field: "xstatus")}"></g:projectstatus>
                            </td>
                            <td><g:formatDate date="${TProjectInstance.end_date1}"
                                              format="yyyy-MM-dd"></g:formatDate></td>
                            <td><g:formatDate date="${TProjectInstance.end_date2}"
                                              format="yyyy-MM-dd"></g:formatDate></td>
                            <td style="text-align: center">
                                <g:if test="${TProjectInstance?.zentao_id > 0}">
                                    <a href="http://srt.skyworth.com/bugs/www/index.php?m=project&f=task&t=html&projectID=${TProjectInstance?.zentao_id}&type=all"
                                       target="_blank">查看</a>
                                </g:if>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</div>
<script type="text/javascript">

    function setUser() {
        $("#nick_ref").val(chosen_user_nick);
        $("#manager").val(chosen_user_id);
        $("#choose_user_form").modal('hide');
    }
    $(function () {
        $("#btnChooseUser").click(function () {
            chosenUserCallBack = setUser;
        });
    });
    </script>

</body>
</html>
