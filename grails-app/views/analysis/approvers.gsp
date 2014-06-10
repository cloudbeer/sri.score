<%@ page import="sri.score.TUser" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="审批人查询"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-user"></i>
        审批人查询
    </h2>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        审批人查询
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
                    <g:form name="qForm" method="post" action="list" class="form-inline">
                        <label>
                            输入起始时间段：
                            <g:textField name="q_from_date" class="input-small"></g:textField></label> -
                        <g:textField name="q_to_date" class="input-small"></g:textField>
                        <button class="btn btn-primary" type="button" id="btnQuery">查询</button>
                        请点击查询，之后可以点击姓名查看详情列表。
                    </g:form>
                </div>
                <script type="text/javascript">
                    $(function () {
                        var x_start;
                        var x_end;
                        $("#btnQuery").click(function () {
                            x_start = $("#q_from_date").val();
                            x_end = $("#q_to_date").val();
                            if (x_start == "" || x_end == "") {
                                alert("必须选择时间。");
                                return;
                            }
                            var url = "<g:createLink controller="analysis" action="approved_total"></g:createLink>";
                            $(".xapprover").each(function () {
                                var xid = $(this).attr("data-id");
                                $("#tr_approver" + xid + " .user_count").html("查询...");
                                $("#tr_approver" + xid + " .sum_score").html("查询...");
                                $.post(url, {q_from_date: x_start, q_to_date: x_end, approver:xid}, function (res) {
                                    $("#tr_approver" + xid + " .user_count").html(res.user_count);
                                    $("#tr_approver" + xid + " .sum_score").html(res.sum_score);
                                }, 'json')
                            });
                        });
                        $(".xapprover").click(function () {
                            if (x_start === undefined || x_end === undefined) {
                                alert("必须选择时间。");
                                return;
                            }
                            var xid = $(this).attr("data-id");
                            var url = "<g:createLink controller="analysis" action="approved_list"></g:createLink>";
                            window.location = url+"?from=" +  x_start + "&to=" + x_end + "&approver="+xid;

                        })
                    });
                </script>


                <link type="text/css" rel="stylesheet"
                      href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css"/>
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

                <table class="table">
                    <thead>
                    <tr>
                        <th>姓名</th>
                        <th>部门</th>
                        <th style="text-align: right;">相关人数</th>
                        <th style="text-align: right;">已发总分</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${approvers}" status="i" var="TUserInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'} xapprover" data-id="${TUserInstance.id}"
                            id="tr_approver${TUserInstance.id}">
                            <td><a href="#" class='link_approver'>${fieldValue(bean: TUserInstance, field: "nick")}</a></td>
                            <td>
                                <g:if test="${TUserInstance.group_id}">
                                    <g:group_name group_id="${TUserInstance.group_id}"
                                                  groups="${groups}"></g:group_name>
                                </g:if>
                            </td>
                            <td style="text-align: right;" class="user_count"></td>
                            <td style="text-align: right;" class="sum_score">
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

            </div>

        </div>
    </div>
</div>


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
