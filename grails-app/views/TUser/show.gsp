<%@ page import="sri.score.TUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TUser.label', default: 'TUser')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-user"></i>
        <g:message code="default.show.label" args="[entityName]"/>
    </h2>

</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li><g:link action="list"><g:message code="TUser.label"/></g:link>
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

                <div id="show-TUser" class="content scaffold-show" role="main">

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
                            <td class="key"><g:message code="TUser.nick.label" default="Nick"/></td>
                            <td class="value">
                                <g:if test="${TUserInstance?.nick}">
                                    <g:fieldValue bean="${TUserInstance}" field="nick"/>
                                </g:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="key"><g:message code="TUser.email.label" default="Email"/></td>
                            <td class="value">
                                <g:if test="${TUserInstance?.email}">
                                    <g:fieldValue bean="${TUserInstance}" field="email"/>
                                </g:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="key"><g:message code="TUser.user_code.label" default="User code"/></td>
                            <td class="value">
                                <g:if test="${TUserInstance?.user_code}">
                                    <g:fieldValue bean="${TUserInstance}" field="user_code"/>
                                </g:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="key"><g:message code="TUser.score.label" default="Score"/></td>
                            <td class="value">
                                <g:if test="${TUserInstance?.score}">
                                    <g:fieldValue bean="${TUserInstance}" field="score"/>
                                </g:if>
                            </td>
                        </tr>
                        <tr>
                            <td class="key"><g:message code="TUser.xtype.label" default="xtype"/></td>
                            <td class="value">
                                <g:usertype type="${TUserInstance?.xtype}" ></g:usertype>
                            </td>
                        </tr>
                        <tr>
                            <td class="key"><g:message code="TUser.create_date.label" default="create_date"/></td>
                            <td class="value">
                                <g:if test="${TUserInstance?.create_date}">
                                    <g:fieldValue bean="${TUserInstance}" field="create_date"/>
                                </g:if>
                            </td>
                        </tr>
                    </table>

                    <g:form>
                        <fieldset class="buttons">
                            <g:hiddenField name="id" value="${TUserInstance?.id}"/>
                            <g:link class="edit btn btn-primary" action="edit" id="${TUserInstance?.id}"><g:message
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
