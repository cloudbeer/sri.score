<%@ page import="sri.score.TGroup" %>



<div class="fieldcontain ${hasErrors(bean: TGroupInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="TGroup.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${TGroupInstance?.title}"/>
    <g:hiddenField name="parent_id" value="${TGroupInstance?.parent_id}"></g:hiddenField>
</div>