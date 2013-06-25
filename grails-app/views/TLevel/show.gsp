
<%@ page import="sri.score.TLevel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TLevel.label', default: 'TLevel')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-TLevel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-TLevel" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list TLevel">
			
				<g:if test="${TLevelInstance?.coefficient}">
				<li class="fieldcontain">
					<span id="coefficient-label" class="property-label"><g:message code="TLevel.coefficient.label" default="Coefficient" /></span>
					
						<span class="property-value" aria-labelledby="coefficient-label"><g:fieldValue bean="${TLevelInstance}" field="coefficient"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.create_date}">
				<li class="fieldcontain">
					<span id="create_date-label" class="property-label"><g:message code="TLevel.create_date.label" default="Createdate" /></span>
					
						<span class="property-value" aria-labelledby="create_date-label"><g:formatDate date="${TLevelInstance?.create_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="TLevel.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${TLevelInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.method}">
				<li class="fieldcontain">
					<span id="method-label" class="property-label"><g:message code="TLevel.method.label" default="Method" /></span>
					
						<span class="property-value" aria-labelledby="method-label"><g:fieldValue bean="${TLevelInstance}" field="method"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.min_score}">
				<li class="fieldcontain">
					<span id="min_score-label" class="property-label"><g:message code="TLevel.min_score.label" default="Minscore" /></span>
					
						<span class="property-value" aria-labelledby="min_score-label"><g:fieldValue bean="${TLevelInstance}" field="min_score"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.score_config}">
				<li class="fieldcontain">
					<span id="score_config-label" class="property-label"><g:message code="TLevel.score_config.label" default="Scoreconfig" /></span>
					
						<span class="property-value" aria-labelledby="score_config-label"><g:fieldValue bean="${TLevelInstance}" field="score_config"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="TLevel.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${TLevelInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.update_date}">
				<li class="fieldcontain">
					<span id="update_date-label" class="property-label"><g:message code="TLevel.update_date.label" default="Updatedate" /></span>
					
						<span class="property-value" aria-labelledby="update_date-label"><g:formatDate date="${TLevelInstance?.update_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.updater}">
				<li class="fieldcontain">
					<span id="updater-label" class="property-label"><g:message code="TLevel.updater.label" default="Updater" /></span>
					
						<span class="property-value" aria-labelledby="updater-label"><g:fieldValue bean="${TLevelInstance}" field="updater"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.xstatus}">
				<li class="fieldcontain">
					<span id="xstatus-label" class="property-label"><g:message code="TLevel.xstatus.label" default="Xstatus" /></span>
					
						<span class="property-value" aria-labelledby="xstatus-label"><g:fieldValue bean="${TLevelInstance}" field="xstatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TLevelInstance?.xtype}">
				<li class="fieldcontain">
					<span id="xtype-label" class="property-label"><g:message code="TLevel.xtype.label" default="Xtype" /></span>
					
						<span class="property-value" aria-labelledby="xtype-label"><g:fieldValue bean="${TLevelInstance}" field="xtype"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${TLevelInstance?.id}" />
					<g:link class="edit" action="edit" id="${TLevelInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
