<%@ page import="sri.score.TIssue" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="导入用户"/>
    <title>${entityName}</title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-tasks"></i>
       ${entityName}
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
        ${entityName}
    </li>
</ul>

<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">${entityName}</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">

                <g:uploadForm name="form1" action="save_users">
                    <fieldset>
                        <label>请选择 Excel 文件：</label>

                        <input type="file" name="xlsFile" accept="application/vnd.ms-excel" class="span6 fancy"
                               id="upl"/>

                    </fieldset>
                    <g:submitButton name="btnImportAttendence" value="上载并保存" class="btn btn-primary"></g:submitButton>

                </g:uploadForm>

                <g:if test="${flash.message}">
                    <div class="alert alert-block alert-error">
                        <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
                        <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
                        ${flash.message}
                    </div>
                </g:if>
            </div>

        </div>
    </div>
</div>

<div id="list-TIssue" class="content scaffold-list" role="main">

</div>
</body>
</html>
