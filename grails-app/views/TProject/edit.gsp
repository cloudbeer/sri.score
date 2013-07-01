<%@ page import="sri.score.TProject" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TProject.label', default: 'TProject')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-dashboard"></i>
        <g:message code="default.create.label" args="[entityName]"/>
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
    <li><g:link action="list"><g:message code="TProject.label"/></g:link>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        <g:message code="default.edit.label" args="[entityName]"/>
    </li>
</ul>

<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title"><g:message code="default.edit.label" args="[entityName]"/></h3>

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



                <div id="edit-TProject" class="content scaffold-edit" role="main">

                    <g:if test="${flash.message}">
                        <div class="alert alert-block alert-error">
                            <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
                            <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
                            ${flash.message}
                        </div>
                    </g:if>
                    <g:hasErrors bean="${TProjectInstance}">
                        <ul class="errors" role="alert">
                            <g:eachError bean="${TProjectInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                        error="${error}"/></li>
                            </g:eachError>
                        </ul>
                    </g:hasErrors>
                    <g:form method="post">
                        <g:hiddenField name="id" value="${TProjectInstance?.id}"/>
                        <g:hiddenField name="version" value="${TProjectInstance?.version}"/>
                        <fieldset class="form">
                            <g:render template="form_apply"/>
                        </fieldset>
                        <fieldset class="buttons">
                            <g:actionSubmit class="save btn btn-primary" action="update"
                                            value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                            <g:actionSubmit class="delete btn btn-cg" action="delete"
                                            value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                            formnovalidate=""
                                            onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                        </fieldset>
                    </g:form>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>
