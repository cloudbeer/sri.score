<div id="choose_user_form" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="n_taskLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icon-remove-circle"></i>
        </button>

        <h3 id="myModalLabel">选择用户</h3>
    </div>

    <div class="modal-body">
        <form>

            <div class="fieldcontain required">
                <label for="cm_user_query">
                    <g:message code="TIssue.user_id.label" default="User"/>
                    <span class="required-indicator">*</span>
                </label>
                <div class="input-append">
                    <g:textField name="cm_user_query"/>
                    <span id='btnCMQUser' class="add-on btn"><i class="icon-search"></i></span>
                </div>
            </div>
        </form>

        <div class="alert alert-block" id='dcm_user'>
            <ul id='cm_users' class="c_users"></ul>
        </div>
    </div>
</div>
<script type="text/javascript">
    var chosen_user_id = 0;
    var chosen_user_nick = "";
    var xtype=0;
    var chosenUserCallBack=null;
    $(function () {
        $("#d_user").hide();

        $("#btnCMQUser").click(function () {
            var cm_user_query = $("#cm_user_query").val();
            $.post("<g:createLink controller="Mine" action="query_user" />",
                    {q: cm_user_query, tp: xtype},
                    function (res) {
                        $("#cm_users").html(res);
                        $("#dcm_user").show('fast');
                    });

        });
        $(document).on("click", "#cm_users li", function () {
            chosen_user_id = $(this).attr("rel");
            chosen_user_nick = $(this).text();
            if (chosenUserCallBack)
                chosenUserCallBack();
        });

    });
</script>
<style>
.c_users {
    padding: 0;
    margin: 0;
}

.c_users li:hover {
    color: #00ee00;
}

.c_users li {
    list-style: none;
    display: inline-block;
    padding: 2px 4px;
    cursor: pointer;
}
</style>