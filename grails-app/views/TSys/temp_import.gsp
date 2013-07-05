<%@ page import="sri.score.TIssue" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="各种导入"/>
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


        <div class="alert alert-block alert-error">
            <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>

            &nbsp;
            请注意，必须首先导入等级数据。
        </div>

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">导入等级</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">

                <g:uploadForm name="form1" controller="TSys" action="save_level_excel">
                    <fieldset>
                        <label>等级Excel：</label>
                        <input type="file" name="xlsFile" accept="application/vnd.ms-excel" class="span6 fancy"
                        />
                    </fieldset>
                    <g:submitButton name="btnImportAttendence" value="上载并分析" class="btn btn-primary"></g:submitButton>
                </g:uploadForm>

            </div>

        </div>
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">导入用户</h3>

            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">

                <g:uploadForm name="form1" controller="TSys" action="save_user_excel">
                    <fieldset>
                        <label>用户 Excel 文件：</label>
                        <input type="file" name="xlsFile" accept="application/vnd.ms-excel" class="span6 fancy"
                               />
                    </fieldset>
                    <g:submitButton name="btnSaveUser" value="上载并分析" class="btn btn-primary"></g:submitButton>
                </g:uploadForm>

            </div>

        </div>
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">导入事物积分设置</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">

                <g:uploadForm name="form1" controller="TSys" action="save_event_score">
                    <fieldset>
                        <label>Excel 文件：</label>
                        <input type="file" name="xlsFile" accept="application/vnd.ms-excel" class="span6 fancy"
                               id="upl"/>
                    </fieldset>
                    <g:submitButton name="btnImportAttendence" value="上载并分析" class="btn btn-primary"></g:submitButton>
                </g:uploadForm>

            </div>

        </div>
    </div>
</div>

<div id="list-TIssue" class="content scaffold-list" role="main">

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
