<%@ page import="sri.score.TGroup" %>



<div class="fieldcontain ${hasErrors(bean: TGroupInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="TGroup.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${TGroupInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TGroupInstance, field: 'parent_id', 'error')} required">
	<label for="parent_id">
		<g:message code="TGroup.parent_id.label" default="Parentid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="parent_id" type="number" value="${TGroupInstance.parent_id}" required=""/>
</div>

