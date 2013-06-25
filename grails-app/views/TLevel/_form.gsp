<%@ page import="sri.score.TLevel" %>



<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'coefficient', 'error')} required">
	<label for="coefficient">
		<g:message code="TLevel.coefficient.label" default="Coefficient" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="coefficient" value="${fieldValue(bean: TLevelInstance, field: 'coefficient')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'create_date', 'error')} required">
	<label for="create_date">
		<g:message code="TLevel.create_date.label" default="Createdate" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="create_date" precision="day"  value="${TLevelInstance?.create_date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'creator', 'error')} required">
	<label for="creator">
		<g:message code="TLevel.creator.label" default="Creator" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="creator" type="number" value="${TLevelInstance.creator}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'method', 'error')} ">
	<label for="method">
		<g:message code="TLevel.method.label" default="Method" />
		
	</label>
	<g:textField name="method" value="${TLevelInstance?.method}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'min_score', 'error')} required">
	<label for="min_score">
		<g:message code="TLevel.min_score.label" default="Minscore" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="min_score" type="number" value="${TLevelInstance.min_score}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'score_config', 'error')} ">
	<label for="score_config">
		<g:message code="TLevel.score_config.label" default="Scoreconfig" />
		
	</label>
	<g:textField name="score_config" value="${TLevelInstance?.score_config}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="TLevel.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${TLevelInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'update_date', 'error')} required">
	<label for="update_date">
		<g:message code="TLevel.update_date.label" default="Updatedate" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="update_date" precision="day"  value="${TLevelInstance?.update_date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'updater', 'error')} required">
	<label for="updater">
		<g:message code="TLevel.updater.label" default="Updater" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="updater" type="number" value="${TLevelInstance.updater}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'xstatus', 'error')} required">
	<label for="xstatus">
		<g:message code="TLevel.xstatus.label" default="Xstatus" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="xstatus" type="number" value="${TLevelInstance.xstatus}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: TLevelInstance, field: 'xtype', 'error')} required">
	<label for="xtype">
		<g:message code="TLevel.xtype.label" default="Xtype" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="xtype" type="number" value="${TLevelInstance.xtype}" required=""/>
</div>

