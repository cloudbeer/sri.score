<%--
  Created by IntelliJ IDEA.
  User: Cloudbeer
  Date: 13-6-28
  Time: 下午1:59
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>提示信息</title>
</head>

<body>

<div class="page-heading">
    <h2 class="page-title muted">
        <i class="icon-tasks"></i>
        提示信息
    </h2>

</div>
<ul class="breadcrumb breadcrumb-main">
    <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a>
        <span class="divider"><i class="icon-caret-right"></i></span>
    </li>
    <li>
        提示信息
    </li>
</ul>


<div class="row-fluid">
    <div class="span12">

        <!-- widget -->
        <div class="well widget">
            <!-- widget header -->
            <div class="widget-header">
                <h3 class="title">
                    ${flash.tips_title}
                </h3>

            </div>
            <!-- ./ widget header -->

            <!-- widget content -->
            <div class="widget-content">
                <div class="alert alert-block alert-error">
                    <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>

                                &nbsp;
                    ${flash.message}
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>