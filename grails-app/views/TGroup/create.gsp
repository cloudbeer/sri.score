<%@ page import="sri.score.TGroup" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TGroup.label', default: 'TGroup')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
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
    <li><g:link action="list"><g:message code="TGroup.label"/></g:link>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        <g:message code="default.create.label" args="[entityName]"/>
    </li>
</ul>

<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title"><g:message code="default.new.label" args="[entityName]"/></h3>

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

                <div id="create-TGroup" class="content scaffold-create" role="main">
                    <g:if test="${flash.message}">
                        <div class="alert alert-block alert-error">
                            <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
                            <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
                            ${flash.message}
                        </div>
                    </g:if>
                    <g:hasErrors bean="${TGroupInstance}">
                        <ul class="errors" role="alert">
                            <g:eachError bean="${TGroupInstance}" var="error">
                                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                        error="${error}"/></li>
                            </g:eachError>
                        </ul>
                    </g:hasErrors>
                    <g:form action="save">
                        <fieldset class="form">
                            <g:render template="form"/>
                        </fieldset>

                        <div class="buttons">
                            <g:submitButton name="create" class="btn btn-primary"
                                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                        </div>
                    </g:form>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>
