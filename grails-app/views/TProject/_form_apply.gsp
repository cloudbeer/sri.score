<%@ page import="sri.score.TProject" %>
<%@ page import="sri.score.common.Constants" %>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'title', 'error')} required">
    <label for="title">
        <g:message code="TProject.title.label" default="Title"/>
        <span class="required-indicator">*</span>
    </label>
    <g:textField class="span9" name="title" required="" value="${TProjectInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'zentao_id', 'error')} ">
    <label for="description">
        预计完成时间
    </label>
    <g:textField name="end_date_temp1" class="datepicker" value="${TProjectInstance?.end_date1}" readonly="true"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TProjectInstance, field: 'zentao_id', 'error')} ">
    <label for="description">
        <g:message code="TProject.zentao_id.label" default="Zentao ID"/>
    </label>
    <g:textField name="zentao_id" class="input-small" value="${TProjectInstance?.zentao_id}"/>
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
<link type="text/css" rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>

<script type="text/javascript">
    $(function () {
        var editor = new UE.ui.Editor({toolbars: [
            ["bold", "italic", 'paragraph', 'fontfamily', 'fontsize', '|',
                'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
                'link', 'unlink', 'anchor', '|']
        ]});
        editor.render("description");
        $("#end_date_temp1").datepicker({
            dateFormat: 'yy-mm-dd',
            dayNamesMin: [ "日", "一", "二", "三", "四", "五", "六" ],
            firstDay: 1
        })
    });
</script>