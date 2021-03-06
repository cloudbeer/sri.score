<%@ page import="sri.score.TProject" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
<g:set var="entityName" value="${message(code: 'TProject_Static.label', default: 'TProject')}"/>
<title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-tasks"></i>
<g:message code="default.list.label" args="[entityName]"/>
</h2>

<div class="page-info hidden-phone">
    <ul class="stats">
        <li>
            <span></span>
        </li>
    </ul>

</div>
</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        ${message(code: 'TProject_Static.label', default: 'TProject')}
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
                        <li><g:link class="btn btn-flat btn-mini" action="create_project"><g:message
                                code="default.create.label"
                                args="[entityName]"/></g:link></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <table class="table">
                    <thead>
                    <tr>
                        <th>${message(code: 'TProject.code.label', default: 'Code')}</th>
                        <th>${message(code: 'TProject.title.label', default: '名称')}</th>
                        <th>分值</th>
                        <th style="width:170px;text-align:center">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${TProjectInstanceList}" status="i" var="TProjectInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>${fieldValue(bean: TProjectInstance, field: "code")}</td>
                            <td>${fieldValue(bean: TProjectInstance, field: "title")}</td>
                            <td>
                                <%

                                    def xlevels = []
                                    def myScores = allScores.findAll { obj ->
                                        obj.project_id == TProjectInstance.id
                                    }
                                    myScores.each { obj ->
                                        xlevels.add(obj.score)
                                    }


                                %>
                                <g:each in="${xlevels}" var="xscore" status="ists">
                                    <g:if test="${ists % 5 == 0}">
                                        [
                                    </g:if>
                                    ${xscore}
                                    <g:if test="${ists % 5 == 4}">
                                        ]
                                    </g:if>
                                </g:each>
                            </td>
                            <td>
                                <g:link action="project_score" class='btn min btn-primary'
                                        id="${fieldValue(bean: TProjectInstance, field: "id")}">
                                    设定分值
                                </g:link>
                                <g:link action="create_project" class='btn min btn-primary'
                                        id="${fieldValue(bean: TProjectInstance, field: "id")}">
                                    改
                                </g:link>
                                <a href="#" class='btn min btn-primary btnDelete'
                                   rel="${fieldValue(bean: TProjectInstance, field: "id")}">
                                    删
                                </a>
                            </td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${TProjectInstanceTotal}"/>
                </div>

            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $(".btnDelete").click(function () {
            if (!confirm("此操作将会删除所有的对应分值，请确认！"))
                return;
            var xthis = $(this);
            $.post( "<g:createLink action="delete_project" />", {id:xthis.attr("rel")}, function(res){
                if (res=="1"){
                    xthis.parent().parent().remove();
                }else{
                    alert(res);
                }
            });

        });
    });
</script>

    <div id="list-TProject" class="content scaffold-list" role="main">

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
