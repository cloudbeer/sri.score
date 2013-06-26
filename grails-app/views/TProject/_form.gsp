<%@ page import="sri.score.TProject" %>



<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'title', 'error')} required">
	<label for="title">
		<g:message code="TProject.title.label" default="Title" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="title" required="" value="${TProjectInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="TProject.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="20000" value="${TProjectInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'approver', 'error')} required">
	<label for="approver">
		<g:message code="TProject.approver.label" default="Approver" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="approver" type="number" value="${TProjectInstance.approver}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'base_score', 'error')} required">
	<label for="base_score">
		<g:message code="TProject.base_score.label" default="Basescore" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="base_score" value="${fieldValue(bean: TProjectInstance, field: 'base_score')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'category_id', 'error')} required">
	<label for="category_id">
		<g:message code="TProject.category_id.label" default="Categoryid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="category_id" type="number" value="${TProjectInstance.category_id}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'code', 'error')} ">
	<label for="code">
		<g:message code="TProject.code.label" default="Code" />
		
	</label>
	<g:textField name="code" value="${TProjectInstance?.code}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'comment', 'error')} ">
	<label for="comment">
		<g:message code="TProject.comment.label" default="Comment" />
		
	</label>
	<g:textField name="comment" value="${TProjectInstance?.comment}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'manager', 'error')} required">
	<label for="manager">
		<g:message code="TProject.manager.label" default="Manager" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="manager" type="number" value="${TProjectInstance.manager}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'pre_score', 'error')} required">
	<label for="pre_score">
		<g:message code="TProject.pre_score.label" default="Prescore" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="pre_score" value="${fieldValue(bean: TProjectInstance, field: 'pre_score')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'total', 'error')} required">
	<label for="total">
		<g:message code="TProject.total.label" default="Total" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="total" value="${fieldValue(bean: TProjectInstance, field: 'total')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'zentao_id', 'error')} required">
	<label for="zentao_id">
		<g:message code="TProject.zentao_id.label" default="Zentaoid" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="zentao_id" type="number" value="${TProjectInstance.zentao_id}" required=""/>
</div>

