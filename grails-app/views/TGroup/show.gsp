
<%@ page import="sri.score.TGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TGroup.label', default: 'TGroup')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-TGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-TGroup" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list TGroup">
			
				<g:if test="${TGroupInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="TGroup.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${TGroupInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TGroupInstance?.xtype}">
				<li class="fieldcontain">
					<span id="xtype-label" class="property-label"><g:message code="TGroup.xtype.label" default="Xtype" /></span>
					
						<span class="property-value" aria-labelledby="xtype-label"><g:fieldValue bean="${TGroupInstance}" field="xtype"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TGroupInstance?.xstatus}">
				<li class="fieldcontain">
					<span id="xstatus-label" class="property-label"><g:message code="TGroup.xstatus.label" default="Xstatus" /></span>
					
						<span class="property-value" aria-labelledby="xstatus-label"><g:fieldValue bean="${TGroupInstance}" field="xstatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TGroupInstance?.create_date}">
				<li class="fieldcontain">
					<span id="create_date-label" class="property-label"><g:message code="TGroup.create_date.label" default="Createdate" /></span>
					
						<span class="property-value" aria-labelledby="create_date-label"><g:formatDate date="${TGroupInstance?.create_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${TGroupInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="TGroup.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${TGroupInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TGroupInstance?.update_date}">
				<li class="fieldcontain">
					<span id="update_date-label" class="property-label"><g:message code="TGroup.update_date.label" default="Updatedate" /></span>
					
						<span class="property-value" aria-labelledby="update_date-label"><g:formatDate date="${TGroupInstance?.update_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${TGroupInstance?.updater}">
				<li class="fieldcontain">
					<span id="updater-label" class="property-label"><g:message code="TGroup.updater.label" default="Updater" /></span>
					
						<span class="property-value" aria-labelledby="updater-label"><g:fieldValue bean="${TGroupInstance}" field="updater"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TGroupInstance?.leader}">
				<li class="fieldcontain">
					<span id="leader-label" class="property-label"><g:message code="TGroup.leader.label" default="Leader" /></span>
					
						<span class="property-value" aria-labelledby="leader-label"><g:fieldValue bean="${TGroupInstance}" field="leader"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TGroupInstance?.parent_id}">
				<li class="fieldcontain">
					<span id="parent_id-label" class="property-label"><g:message code="TGroup.parent_id.label" default="Parentid" /></span>
					
						<span class="property-value" aria-labelledby="parent_id-label"><g:fieldValue bean="${TGroupInstance}" field="parent_id"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${TGroupInstance?.id}" />
					<g:link class="edit" action="edit" id="${TGroupInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
