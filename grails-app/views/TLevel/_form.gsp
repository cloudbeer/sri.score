<%@ page import="sri.score.TLevel" %>


<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="TLevel.title.label" default="标题" />
        <span class="required-indicator">*</span>

    </label>
    <g:textField name="title" value="${TLevelInstance?.title}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'min_score', 'error')} required">
    <label for="min_score">
        <g:message code="TLevel.min_score.label" default="最小分值" />
        <span class="required-indicator">*</span>
    </label>
    <g:field name="min_score" type="number" value="${TLevelInstance.min_score}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'coefficient', 'error')} required">
	<label for="coefficient">
		<g:message code="TLevel.coefficient.label" default="Coefficient" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="coefficient" value="${fieldValue(bean: TLevelInstance, field: 'coefficient')}" required=""/>
</div>



