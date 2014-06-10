<%@ page import="sri.score.TIssue" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="事务积分"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-tasks"></i>
        ${entityName}
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
        ${entityName}
    </li>
</ul>

<div class="row-fluid">
    <div class="span7">
        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">${entityName}</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <g:render template="choose_user"></g:render>
                <g:form action="score_save">
                    <fieldset class="form">

                        <div class="fieldcontain">
                            <label>
                                用户
                            </label>
                            <g:hiddenField name="user_id"></g:hiddenField>
                            <div class="input-append">
                                <g:textField name="nick_ref" readonly="true"></g:textField>
                                <a href="#choose_user_form" class="btn add-on" id="btnChooseUser"
                                   role="button"
                                   data-toggle="modal"><i class="icon-search"></i></a>
                            </div>
                        </div>

                        <div class="fieldcontain">
                            <label>
                                事物
                            </label>
                            <select id="project_id" name="project_id">
                                <option value="0">请选择</option>
                                <g:each in="${projects}" status="i" var="project">
                                    <option value="${project.id}">${project.code} - ${project.title}</option>
                                </g:each>
                            </select>
                        </div>

                        <div class="fieldcontain">
                            <label>
                                备注
                            </label>
                            <g:textArea name="remark"></g:textArea>
                        </div>
                    </fieldset>

                    <div class="buttons">
                        <g:submitButton name="save" class="btn btn-primary"
                                        value="${message(code: 'default.button.save.label', default: 'Save')}"/>
                    </div>
                </g:form>

            </div>

        </div>
    </div>

    <div class="span5">

        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">查看概况</h3>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <div id='xpre_score'></div>
            </div>
        </div>
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">批量导入</h3>

            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">

            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    function setUser() {
        $("#nick_ref").val(chosen_user_nick);
        $("#user_id").val(chosen_user_id);
        $("#choose_user_form").modal('hide');
        getPreScore();
    }
    $(function () {
        $("#btnChooseUser").click(function () {
            chosenUserCallBack = setUser;
        });

        $("#project_id").change(function () {
            getPreScore();
        });
        getPreScore();
    });

    function getPreScore() {
        var pid = parseInt($("#project_id").val())
        if (chosen_user_id > 0 && pid > 0) {
            $.post("${createLink(controller: "TSys", action: "query_pre_score")}",
                    {pid: pid, uid: chosen_user_id},
                    function (res) {
                        $("#xpre_score").html(res);
                    });
        }

    }
</script>
</body>
</html>
