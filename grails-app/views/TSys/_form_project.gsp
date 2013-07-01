<%@ page import="sri.score.TProject" %>
<%@ page import="sri.score.common.Constants" %>

<g:hiddenField name="id" value="${TProjectInstance?.id ?: 0}"></g:hiddenField>
<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'code', 'error')} required">
    <label for="title">
        <g:message code="TProject.code.label" default="Code"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="code" required="" value="${TProjectInstance?.code}"/>
</div>
<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="TProject.title.label" default="Title"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="title" required="" value="${TProjectInstance?.title}"/>
</div>


<div class="fieldcontain">
    <label for="title">
        <g:message code="TProject.base_score.label" default="Base Score"/>(参考，具体分值按照等级确定)
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="base_score" required="" value="${TProjectInstance?.base_score}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'description', 'error')} ">
    <label for="description">
        <g:message code="TProject.description.label" default="Description"/>
    </label>
    <g:textArea name="description" class="" maxlength="20000" value="${TProjectInstance?.description}"/>
</div>
<g:hiddenField name="xtype" value="${Constants.PROJECTTYPES_STATIC}"></g:hiddenField>


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