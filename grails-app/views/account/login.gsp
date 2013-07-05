<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

<body>

登录


<g:if test="${flash.message}">
    <div class="alert alert-block alert-error">
        <a class="close" data-dismiss="alert" href="#"><i class="icon-large icon-remove-circle"></i></a>
        <h4 class="alert-heading"><g:message code="default.tip.label" default="出错了"/></h4>
        ${flash.message}
    </div>
</g:if>
<g:form action="logon" controller="account">
    Email: <g:textField name="email" value="xie@coocaa.com"></g:textField>
    <g:submitButton name="btnSubmit" value="登录"></g:submitButton>
</g:form>

<g:link action="create_data">创建数据</g:link>

</body>
</html>