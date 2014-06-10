<%@ page import="sri.score.TUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'TUser.label', default: 'TUser')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-user"></i>
        <g:message code="default.list.label" args="[entityName]"/>
    </h2>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        ${message(code: 'TUser.label', default: 'TUser')}
    </li>
</ul>

<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title"><g:message code="default.list.label" args="[entityName]"/></h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li><g:link class="btn btn-flat btn-mini" action="create"><g:message
                                code="default.create.label"
                                args="[entityName]"/></g:link></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">

                <div class="fieldcontain required">
                    <label>
                        输入关键字查询(email 或 姓名)：
                    </label>
                    <g:form name="qForm" method="post" action="list">
                        <div class="input-append">
                            <g:textField name="key"></g:textField>
                            <span id='btnQuery' class="add-on btn"><i class="icon-search"></i></span>
                        </div>
                    </g:form>
                </div>
                <script type="text/javascript">
                    $(function () {
                        $("#btnQuery").click(function () {
                            $("#qForm").submit();
                        })
                    });
                </script>



                <table class="table">
                    <thead>
                    <tr>
                        <th>${message(code: 'TUser.nick.label', default: '昵称')}</th>
                        <th>${message(code: 'TUser.email.label', default: 'Email')}</th>
                        <th>${message(code: 'TUser.user_code.label', default: '工号')}</th>
                        <th>部门</th>
                        <th>${message(code: 'TUser.score.label', default: '得分')}</th>
                        <th style="text-align: center;">${message(code: 'TUser.level_id.label', default: '等级')}</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${TUserInstanceList}" status="i" var="TUserInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:link action="show"
                                        id="${TUserInstance.id}">${fieldValue(bean: TUserInstance, field: "nick")}</g:link></td>
                            <td>${fieldValue(bean: TUserInstance, field: "email")}</td>
                            <td>${fieldValue(bean: TUserInstance, field: "user_code")}</td>
                            <td>
                                <a class="btn btn-small btnSetGroup" href="#group_panel" role="button" data-id="${TUserInstance.id}"
                                   data-toggle="modal">设</a>
                                <g:if test="${TUserInstance.group_id}">
                                    <g:group_name group_id="${TUserInstance.group_id}"  groups="${groups}"></g:group_name>

                                </g:if>
                            </td>
                            <td style="text-align: right;">${fieldValue(bean: TUserInstance, field: "score")}</td>
                            <td style="text-align: center;">
                                <g:levelname
                                        level_id="${fieldValue(bean: TUserInstance, field: "level_id")}"></g:levelname>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${TUserInstanceTotal}" params="${params}"/>
                </div>

            </div>

        </div>
    </div>
</div>

<div id="group_panel" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="n_taskLabel"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icon-remove-circle"></i>
        </button>

        <h3 id="myModalLabel">选择组</h3>
    </div>

    <div class="modal-body">
        ${groupHTML}
    </div>
</div>

<script type="text/javascript">
    $(function () {
        var cur_user_id = 0;
        $(".grp_name").click(function () {
           var group_id = $(this).attr("data-id");
            $.post("<g:createLink action="set_group" />",{group_id:group_id, user_id:cur_user_id},function(res){
                if (res=="1"){
                    alert("设定成功，请刷新后看结果。");
                    $('#group_panel').modal('hide');
                }

            });
        });
        $(".btnSetGroup").click(function(){
            cur_user_id = $(this).attr("data-id");
        });
    });
</script>

<div id="list-TUser" class="content scaffold-list" role="main">

    <g:if test="${flash.message}">
        <div class="alert alert-block alert-error">
            <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
            <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
            ${flash.message}
        </div>
    </g:if>

</div>
</body>
</html>
