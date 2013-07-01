
<%@ page import="sri.score.TIssue" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TIssue.label', default: 'TIssue')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-TIssue" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-TIssue" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>

            <g:if test="${flash.message}">
                <div class="alert alert-block alert-error">
                    <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
                    <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
                    ${flash.message}
                </div>
            </g:if>
			<ol class="property-list TIssue">
			
				<g:if test="${TIssueInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="TIssue.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${TIssueInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.xtype}">
				<li class="fieldcontain">
					<span id="xtype-label" class="property-label"><g:message code="TIssue.xtype.label" default="Xtype" /></span>
					
						<span class="property-value" aria-labelledby="xtype-label"><g:fieldValue bean="${TIssueInstance}" field="xtype"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.xstatus}">
				<li class="fieldcontain">
					<span id="xstatus-label" class="property-label"><g:message code="TIssue.xstatus.label" default="Xstatus" /></span>
					
						<span class="property-value" aria-labelledby="xstatus-label"><g:fieldValue bean="${TIssueInstance}" field="xstatus"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.create_date}">
				<li class="fieldcontain">
					<span id="create_date-label" class="property-label"><g:message code="TIssue.create_date.label" default="Createdate" /></span>
					
						<span class="property-value" aria-labelledby="create_date-label"><g:formatDate date="${TIssueInstance?.create_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="TIssue.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${TIssueInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.update_date}">
				<li class="fieldcontain">
					<span id="update_date-label" class="property-label"><g:message code="TIssue.update_date.label" default="Updatedate" /></span>
					
						<span class="property-value" aria-labelledby="update_date-label"><g:formatDate date="${TIssueInstance?.update_date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.updater}">
				<li class="fieldcontain">
					<span id="updater-label" class="property-label"><g:message code="TIssue.updater.label" default="Updater" /></span>
					
						<span class="property-value" aria-labelledby="updater-label"><g:fieldValue bean="${TIssueInstance}" field="updater"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.project_id}">
				<li class="fieldcontain">
					<span id="project_id-label" class="property-label"><g:message code="TIssue.project_id.label" default="Projectid" /></span>
					
						<span class="property-value" aria-labelledby="project_id-label"><g:fieldValue bean="${TIssueInstance}" field="project_id"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.ref_user}">
				<li class="fieldcontain">
					<span id="ref_user-label" class="property-label"><g:message code="TIssue.ref_user.label" default="Refuser" /></span>
					
						<span class="property-value" aria-labelledby="ref_user-label"><g:fieldValue bean="${TIssueInstance}" field="ref_user"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.ref_issue}">
				<li class="fieldcontain">
					<span id="ref_issue-label" class="property-label"><g:message code="TIssue.ref_issue.label" default="Refissue" /></span>
					
						<span class="property-value" aria-labelledby="ref_issue-label"><g:fieldValue bean="${TIssueInstance}" field="ref_issue"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.score}">
				<li class="fieldcontain">
					<span id="score-label" class="property-label"><g:message code="TIssue.score.label" default="Score" /></span>
					
						<span class="property-value" aria-labelledby="score-label"><g:fieldValue bean="${TIssueInstance}" field="score"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="TIssue.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${TIssueInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.pre_score}">
				<li class="fieldcontain">
					<span id="pre_score-label" class="property-label"><g:message code="TIssue.pre_score.label" default="Prescore" /></span>
					
						<span class="property-value" aria-labelledby="pre_score-label"><g:fieldValue bean="${TIssueInstance}" field="pre_score"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${TIssueInstance?.user_id}">
				<li class="fieldcontain">
					<span id="user_id-label" class="property-label"><g:message code="TIssue.user_id.label" default="Userid" /></span>
					
						<span class="property-value" aria-labelledby="user_id-label"><g:fieldValue bean="${TIssueInstance}" field="user_id"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${TIssueInstance?.id}" />
					<g:link class="edit" action="edit" id="${TIssueInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
