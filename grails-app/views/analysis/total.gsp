<%@ page import="sri.score.common.Constants" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>系统首页</title>
</head>

<body>
<div class="page-heading">

    <h2 class="page-title muted">
        <i class="micon-home-3"></i>
        积分统计
    </h2>

    <div class="page-info hidden-phone">
        <ul class="stats">
            <li>
            </li>
        </ul>
    </div>
</div>

<div id="group_panel" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="n_taskLabel"
     aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="icon-remove-circle"></i>
        </button>

        <h3 id="myModalLabel">选择部门</h3>
    </div>

    <div class="modal-body">
        ${groupHTML}
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $(".grp_name").click(function () {
            $("#cm_group_query").val($(this).text());
            $("#group_id").val($(this).attr("data-id"));
            $('#group_panel').modal('hide');
        });
        $(".btnClear").click(function () {
            $(this).prev().val("");
        });
        $("#btnClearGroup").click(function () {
            $("#group_id").val("");
        });

    });
</script>

<div class="row-fluid">
    <div class="span12">
        <div>
            <g:form action="total" method="post" class="form-inline">
                <label>
                    类型：
                    <select name="xtype">
                        <option value="0">全部</option>
                        <option value="${Constants.PROJECTTYPES_TASK}"
                            <g:if test="${Constants.PROJECTTYPES_TASK.toString() == params.xtype}">
                                selected='selected'
                            </g:if>>任务</option>
                        <option value="${Constants.PROJECTTYPES_STATIC}"
                            <g:if test="${Constants.PROJECTTYPES_STATIC.toString() == params.xtype}">
                                selected='selected'
                            </g:if>>事务</option>
                        <option value="${Constants.PROJECTTYPES_ATTENDANCE}"
                            <g:if test="${Constants.PROJECTTYPES_ATTENDANCE.toString() == params.xtype}">
                                selected='selected'
                            </g:if>>考勤</option>
                        <option value="${Constants.PROJECTTYPES_LEVEL}"
                            <g:if test="${Constants.PROJECTTYPES_LEVEL.toString() == params.xtype}">
                                selected='selected'
                            </g:if>>定级</option>
                        <option value="${Constants.PROJECTTYPES_CUSTOM}"
                            <g:if test="${Constants.PROJECTTYPES_CUSTOM.toString() == params.xtype}">
                                selected='selected'
                            </g:if>>自定义</option>
                    </select>
                </label>
                <label>
                    部门：
                    <div class="input-append">
                        <g:textField name="cm_group_query" readonly="true" value="${params.cm_group_query}"/>
                        <span class="add-on btn btnClear" id="btnClearGroup"><i class="icon-remove"></i></span>
                        <span id='btnCMQGroup' class="add-on btn" href="#group_panel" role="button"
                              data-toggle="modal"><i class="icon-search"></i></span>
                        <g:hiddenField name="group_id" value="${params.group_id}"></g:hiddenField>
                    </div>
                </label>
                <label>
                    开始日期：
                    <div class="input-append">
                        <g:textField name="q_from_date" class="datepicker input-small" value="${params.q_from_date}"/>
                        <span class="add-on btn btnClear"><i class="icon-remove"></i></span>
                    </div>
                </label>
                <label>
                    结束日期：
                    <div class="input-append">
                        <g:textField name="q_to_date" class="datepicker input-small" value="${params.q_to_date}"/>
                        <span class="add-on btn btnClear"><i class="icon-remove"></i></span>
                    </div>
                </label>
                <input type="submit" value="查询" class="btn btn-primary" id="btnQuery"/>
            </g:form>
        </div>

        <div class="well widget">
            <div class="widget-header">
                <h3 class="title">积分统计</h3>

                %{--<div class="widget-nav">--}%
                %{--<ul class="nav nav-pills">--}%
                %{--<li><g:link class="btn btn-flat" controller="home" action="rank">更多...</g:link></li>--}%
                %{--</ul>--}%
                %{--</div>--}%
            </div>

            <div class="widget-content">
                从日志中得到的积分：${xsum}   <br/>
                从用户中得到的积分：${xuser_sum}
            </div>
        </div>
    </div>
    <link type="text/css" rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
    <script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#q_from_date").datepicker({
                dateFormat: 'yy-mm-dd',
                dayNamesMin: [ "日", "一", "二", "三", "四", "五", "六" ],
                firstDay: 1
            })
            $("#q_to_date").datepicker({
                dateFormat: 'yy-mm-dd',
                dayNamesMin: [ "日", "一", "二", "三", "四", "五", "六" ],
                firstDay: 1
            })
        });
    </script>
</div>

</body>
</html>
