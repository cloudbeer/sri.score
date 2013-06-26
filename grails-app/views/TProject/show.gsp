
<%@ page import="sri.score.TProject" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TProject.label', default: 'TProject')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-TProject" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-TProject" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list TProject">
			
				<g:if test="${TProjectInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="TProject.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${TProjectInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="TProject.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${TProjectInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.xtype}">
				<li class="fieldcontain">
					<span id="xtype-label" class="property-label"><g:message code="TProject.xtype.label" default="Xtype" /></span>
					
						<span class="property-value" aria-labelledby="xtype-label"><g:fieldValue bean="${TProjectInstance}" field="xtype"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.xstatus}">
				<li class="fieldcontain">
					<span id="xstatus-label" class="property-label"><g:message code="TProject.xstatus.label" default="Xstatus" /></span>
					
						<span class="property-value" aria-labelledby="xstatus-label"><g:fieldValue bean="${TProjectInstance}" field="xstatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.create_date}">
				<li class="fieldcontain">
					<span id="create_date-label" class="property-label"><g:message code="TProject.create_date.label" default="Createdate" /></span>
					
						<span class="property-value" aria-labelledby="create_date-label"><g:formatDate date="${TProjectInstance?.create_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="TProject.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${TProjectInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.update_date}">
				<li class="fieldcontain">
					<span id="update_date-label" class="property-label"><g:message code="TProject.update_date.label" default="Updatedate" /></span>
					
						<span class="property-value" aria-labelledby="update_date-label"><g:formatDate date="${TProjectInstance?.update_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.updater}">
				<li class="fieldcontain">
					<span id="updater-label" class="property-label"><g:message code="TProject.updater.label" default="Updater" /></span>
					
						<span class="property-value" aria-labelledby="updater-label"><g:fieldValue bean="${TProjectInstance}" field="updater"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.approver}">
				<li class="fieldcontain">
					<span id="approver-label" class="property-label"><g:message code="TProject.approver.label" default="Approver" /></span>
					
						<span class="property-value" aria-labelledby="approver-label"><g:fieldValue bean="${TProjectInstance}" field="approver"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.base_score}">
				<li class="fieldcontain">
					<span id="base_score-label" class="property-label"><g:message code="TProject.base_score.label" default="Basescore" /></span>
					
						<span class="property-value" aria-labelledby="base_score-label"><g:fieldValue bean="${TProjectInstance}" field="base_score"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.category_id}">
				<li class="fieldcontain">
					<span id="category_id-label" class="property-label"><g:message code="TProject.category_id.label" default="Categoryid" /></span>
					
						<span class="property-value" aria-labelledby="category_id-label"><g:fieldValue bean="${TProjectInstance}" field="category_id"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.code}">
				<li class="fieldcontain">
					<span id="code-label" class="property-label"><g:message code="TProject.code.label" default="Code" /></span>
					
						<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${TProjectInstance}" field="code"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.comment}">
				<li class="fieldcontain">
					<span id="comment-label" class="property-label"><g:message code="TProject.comment.label" default="Comment" /></span>
					
						<span class="property-value" aria-labelledby="comment-label"><g:fieldValue bean="${TProjectInstance}" field="comment"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.manager}">
				<li class="fieldcontain">
					<span id="manager-label" class="property-label"><g:message code="TProject.manager.label" default="Manager" /></span>
					
						<span class="property-value" aria-labelledby="manager-label"><g:fieldValue bean="${TProjectInstance}" field="manager"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.pre_score}">
				<li class="fieldcontain">
					<span id="pre_score-label" class="property-label"><g:message code="TProject.pre_score.label" default="Prescore" /></span>
					
						<span class="property-value" aria-labelledby="pre_score-label"><g:fieldValue bean="${TProjectInstance}" field="pre_score"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.total}">
				<li class="fieldcontain">
					<span id="total-label" class="property-label"><g:message code="TProject.total.label" default="Total" /></span>
					
						<span class="property-value" aria-labelledby="total-label"><g:fieldValue bean="${TProjectInstance}" field="total"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TProjectInstance?.zentao_id}">
				<li class="fieldcontain">
					<span id="zentao_id-label" class="property-label"><g:message code="TProject.zentao_id.label" default="Zentaoid" /></span>
					
						<span class="property-value" aria-labelledby="zentao_id-label"><g:fieldValue bean="${TProjectInstance}" field="zentao_id"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${TProjectInstance?.id}" />
					<g:link class="edit" action="edit" id="${TProjectInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
