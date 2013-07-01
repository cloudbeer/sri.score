<%@ page import="sri.score.TProject" %>
<%@ page import="sri.score.common.Constants" %>
<div id="n_task" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="n_taskLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icon-remove-circle"></i>
        </button>

        <h3 id="myModalLabel">任务编辑</h3>
    </div>

    <div class="modal-body">
        <form>

            <div class="fieldcontain required">
                <label for="is_title">
                    <g:message code="TIssue.title.label" default="Title"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:textField name="is_title" required="" class="input-large"/>
            </div>

            <div class="fieldcontain required">
                <label for="is_score">
                    <g:message code="TIssue.score.label" default="Score"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:field type="number" name="is_score" required="" class="input-small"/>
            </div>

            <div class="fieldcontain required">
                <label for="is_user_query">
                    <g:message code="TIssue.user_id.label" default="User"/>
                    <span class="required-indicator">*</span>
                </label>
                <g:hiddenField name="is_user_id" value="0"/>
                <div class="input-append">
                    <g:textField name="is_user_query"/>
                    <span id='btnQUser' class="add-on btn"><i class="icon-search"></i></span>
                </div>
            </div>
        </form>

        <div class="alert alert-block" id='d_user'>
            <a class="close" href="#" onclick="$('#d_user').hide('slow');"><i class="icon-large icon-remove-circle"></i>
            </a>
            <span id='c_users'></span>
        </div>
    </div>

    <div class="modal-footer">
        <button class="btn btn-primary" id="btnSaveTask">保存</button>
    </div>

</div>
<script type="text/javascript">
    $(function () {
        $("#d_user").hide();
        $("#btnSaveTask").click(function () {
            var is_title = $("#is_title").val();
            var is_score = parseInt($("#is_score").val());
            var is_user_id = parseInt($("#is_user_id").val());
            if ($.trim(is_title) == "") {
                alert("必须输入任务标题");
                return;
            }
            if (!is_score || is_score <= 0) {
                alert("分值不能小于0");
                return;
            }
            if (is_user_id <= 0) {
                alert("必须选择一个合法用户");
                return;
            }
            $.post("<g:createLink controller="TIssue" action="save_task" />",
                    {title: is_title, score: is_score, user_id: is_user_id,
                        project_id: ${TProjectInstance?.id}, xtype: ${Constants.PROJECTTYPES_TASK}},
                    function (res) {
                        if (res=="1"){
                            window.location.reload();
                        }else{
                            alert(res);
                        }
                    });
        });

        $("#btnQUser").click(function () {
            var is_user_query = $("#is_user_query").val();
            $.post("<g:createLink controller="Mine" action="query_user" />",
                    {q: is_user_query},
                    function (res) {
                        $("#c_users").html(res);
                        $("#d_user").show('fast');
                    });

        });
        $(document).on("click", "#c_users span", function () {
            var myID = $(this).attr("rel");
            $("#is_user_query").val( $(this).html());
            $("#is_user_id").val(myID);

            $("#d_user").hide("fast");
        });

    });
</script>
<style>
#c_users span:hover {
    color: #00ee00;
}

#c_users span {
    padding: 2px 4px;
    cursor: pointer;
    white-space: nowrap;
}
</style>