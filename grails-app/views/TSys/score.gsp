<%@ page import="sri.score.TIssue" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="事物积分"/>
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
    <div class="span12">

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
</div>


<script type="text/javascript">

    function setUser() {
        $("#nick_ref").val(chosen_user_nick);
        $("#user_id").val(chosen_user_id);
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
