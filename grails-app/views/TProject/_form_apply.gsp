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
	<g:textArea name="description" class="" maxlength="20000" value="${TProjectInstance?.description}"/>
</div>

%{--<script type="text/javascript">--}%
    %{--$(function(){--}%
         %{--$("#description").redactor();--}%
    %{--});--}%
%{--</script>--}%