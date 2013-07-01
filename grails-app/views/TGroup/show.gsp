
<%@ page import="sri.score.TGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TGroup.label', default: 'TGroup')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
    <div class="page-heading">
        <h2 class="page-title muted">
            <i class="icon-dashboard"></i>
            <g:message code="default.show.label" args="[entityName]"/>
        </h2>

        <div class="page-info hidden-phone">
            <ul class="stats">
                <li>
                    <span><g:link class="create" action="list" class="large text-warning"><g:message
                            code="default.list.label"
                            args="[entityName]"/></g:link></span>
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

                    <div id="show-TGroup" class="content scaffold-show" role="main">

                        <g:if test="${flash.message}">
                            <div class="alert alert-block alert-error">
                                <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
                                <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
                                ${flash.message}
                            </div>
                        </g:if>
                        <ul class="show">
                            <li>
                                <span class="key"><g:message code="TGroup.title.label" default="title"/></span>
                                <span class="value">
                                    <g:if test="${TGroupInstance?.title}">
                                        <g:fieldValue bean="${TGroupInstance}" field="title"/>
                                    </g:if>
                                </span>
                            </li>
                            <li>
                                <span class="key"><g:message code="TGroup.create_date.label" default="create_date"/></span>
                                <span class="value">
                                    <g:if test="${TGroupInstance?.create_date}">
                                        <g:fieldValue bean="${TGroupInstance}" field="create_date"/>
                                    </g:if>
                                </span>
                            </li>
                        </ul>

                        <g:form>
                            <fieldset class="buttons">
                                <g:hiddenField name="id" value="${TGroupInstance?.id}"/>
                                <g:link class="edit btn btn-primary" action="edit" id="${TGroupInstance?.id}"><g:message
                                        code="default.button.edit.label" default="Edit"/></g:link>

                                <g:actionSubmit class="btn btn-cg" action="delete"
                                                value="${message(code: 'default.button.delete.label', default: 'Delete')}"
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
