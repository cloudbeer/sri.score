<%@ page import="sri.score.TIssue" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="考勤"/>
    <title>${entityName}</title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-tasks"></i>
        ${entityName}   Excel示范文件中木有时间标记呢，如何不重复？
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
    <div class="span6">
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

                <g:uploadForm name="form1" controller="TSys" action="save_attendance_excel">
                    <fieldset>
                        <label>请选择考勤 Excel 文件：</label>

                        <input type="file" name="xlsFile" accept="application/vnd.ms-excel" class="span6 fancy"
                               id="upl"/>
                        <label>时间：</label>
                        <g:textField name="xyear" class="input-small"></g:textField>年
                        <g:textField name="xmonth" class="input-small"></g:textField>月

                    </fieldset>
                    <g:submitButton name="btnImportAttendence" value="上载并分析" class="btn btn-primary"></g:submitButton>

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

    <div class="span3">
        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">考勤记录 @${year}年</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <ul>
                    <g:each in="${12..1}" var="month">
                        <li>
                            <g:link action="listAttendance" params="${[key: '' + year + '-' + month]}">
                                ${year}年${month}月
                            </g:link>
                        </li>
                    </g:each>

                </ul>
            </div>
        </div>

    </div>

    <div class="span3">
        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">考勤记录@${year - 1}年</h3>

                <div class="widget-nav">
                    <ul class="nav nav-pills">
                        <li></li>
                    </ul>
                </div>
            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <ul>
                    <g:each in="${12..1}" var="month">
                        <li>
                            <g:link action="listAttendance" params="${[key: '' + (year - 1) + '-' + month]}">
                                ${year - 1}年${month}月
                            </g:link>
                        </li>
                    </g:each>

                </ul>
            </div>
        </div>

    </div>
</div>

<div id="list-TIssue" class="content scaffold-list" role="main">

</div>
</body>
</html>
