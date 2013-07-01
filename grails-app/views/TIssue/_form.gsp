<%@ page import="sri.score.TIssue" %>



<div class="fieldcontain ${hasErrors(bean: TIssueInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="TIssue.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${TIssueInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TIssueInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="TIssue.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${TIssueInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TIssueInstance, field: 'pre_score', 'error')} required">
	<label for="pre_score">
		<g:message code="TIssue.pre_score.label" default="Prescore" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pre_score" value="${fieldValue(bean: TIssueInstance, field: 'pre_score')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TIssueInstance, field: 'user_id', 'error')} required">
	<label for="user_id">
		<g:message code="TIssue.user_id.label" default="Userid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="user_id" type="number" value="${TIssueInstance.user_id}" required=""/>
</div>

