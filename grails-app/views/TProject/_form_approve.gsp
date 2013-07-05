<%@ page import="sri.score.TProject" %>
<%@ page import="sri.score.common.Constants" %>
<div id="approve_form" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="n_taskLabel"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icon-remove-circle"></i>
        </button>

        <h3 id="myModalLabel">审批任务包</h3>
    </div>

    <div class="modal-body">
        <form>

            <div class="fieldcontain">
                ${TProjectInstance?.title}
            </div>

            <div class="fieldcontain required">
                <label>
                    <g:checkBox name="a_status"
                                value="${sri.score.common.Constants.PROJECTSTATUS_APPROVED}"></g:checkBox> 审批通过

                </label>

            </div>

            <div class="fieldcontain required">
                <label>
                    审批意见
                </label>

                <div>
                    ${TProjectInstance?.comment}
                </div>
                <g:textArea name="a_comment"></g:textArea>
            </div>
        </form>
    </div>

    <div class="modal-footer">
        <button class="btn btn-primary" id="btnSaveApprove">审批</button>
    </div>

</div>
<script type="text/javascript">
    $(function () {
        $("#btnSaveApprove").click(function () {
            var a_status = $("#a_status").prop("checked") ? $("#a_status").val() : 0;
            var a_comment = $("#a_comment").val();

            if ($.trim(a_status) == "") {
                alert("必须输入审批意见");
                return;
            }
            $.post("<g:createLink controller="TProject" action="save_approve" />",
                    {a_status: a_status, a_comment: a_comment,
                        project_id: ${TProjectInstance?.id}},
                    function (res) {
                        if (res == "1") {
                            window.location.reload();
                        } else {
                            alert(res);
                        }
                    });
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