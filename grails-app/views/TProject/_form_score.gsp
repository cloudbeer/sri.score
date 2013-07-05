<%@ page import="sri.score.TProject" %>
<%@ page import="sri.score.common.Constants" %>
<div id="give_score_form" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="n_taskLabel"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icon-remove-circle"></i>
        </button>

        <h3 id="myModalLabel">任务包分值结算</h3>
    </div>

    <div class="modal-body">
        <form>

            <div class="fieldcontain">
                ${TProjectInstance?.title}
            </div>

            <div class="fieldcontain required">
                <label class="radio">
                   <input type="radio" name="give_score" value="1" class="fancy" />加分
                </label>
                <label class="radio">
                    <input type="radio" name="give_score" value="0" class="fancy" />扣分
                </label>
            </div>
            <div class="fieldcontain required">
                <label >
                    情况说明
                </label>
                <g:textArea name="a_comment"></g:textArea>
            </div>
            <div>
                ${TProjectInstance?.comment}
            </div>
        </form>
    </div>

    <div class="modal-footer">
        <button class="btn btn-primary" id="btnSaveScore">审批</button>
    </div>

</div>
<script type="text/javascript">
    $(function () {
        $("#btnSaveScore").click(function () {
            var a_status = $("input[name='give_score']:checked").val()
            var a_comment = $("#a_comment").val();

            if ($.trim(a_status) == "") {
                alert("必须选择加分还是减分");
                return;
            }
            $.post("<g:createLink controller="TProject" action="save_score" />",
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