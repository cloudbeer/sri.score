<%@ page import="sri.score.TProject" %>
<%@ page import="sri.score.common.Constants" %>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="TProject.title.label" default="Title"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="title" required="" value="${TProjectInstance?.title}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'zentao_id', 'error')} ">
    <label for="description">
        <g:message code="TProject.zentao_id.label" default="Zentao ID"/>
    </label>
    <g:textField name="zentao_id" class="input-small" value="${TProjectInstance?.zentao_id}" />
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'description', 'error')} ">
    <label for="description">
        <g:message code="TProject.description.label" default="Description"/>
    </label>
    <g:textArea name="description" class="" maxlength="20000" value="${TProjectInstance?.description}"/>
</div>
<g:hiddenField name="xtype" value="${Constants.PROJECTTYPES_TASK}"></g:hiddenField>


<g:javascript src="ueditor/ueditor.config.js"></g:javascript>
<g:javascript src="ueditor/ueditor.all.min.js"></g:javascript>

<script type="text/javascript">
    $(function () {
        var editor = new UE.ui.Editor({toolbars: [
            ["bold", "italic", 'paragraph', 'fontfamily', 'fontsize', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
                'link', 'unlink', 'anchor', '|']
        ]});
        editor.render("description");
    });
</script>