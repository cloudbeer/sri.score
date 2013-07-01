<%@ page import="sri.score.TUser" %>


<div class="fieldcontain ${hasErrors(bean: TUserInstance, field: 'nick', 'error')} ">
    <label for="nick">
        <g:message code="TUser.nick.label" default="Nick"/>

    </label>
    <g:textField name="nick" value="${TUserInstance?.nick}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TUserInstance, field: 'email', 'error')} ">
    <label for="email">
        <g:message code="TUser.email.label" default="Email"/>

    </label>
    <g:textField name="email" value="${TUserInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TUserInstance, field: 'user_code', 'error')} ">
    <label for="user_code">
        <g:message code="TUser.user_code.label" default="Usercode"/>

    </label>
    <g:textField name="user_code" value="${TUserInstance?.user_code}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: TUserInstance, field: 'xtype', 'error')} ">
    <label for="user_code">
        <g:message code="TUser.xtype.label" default="用户类型"/>

    </label>
    <g:radioGroup values="[1, 2, 4]" name="xtype" value="${TUserInstance?.xtype}" labels="['普通用户', '审批经理', '系统管理员']" class="fancy">
        <label class="radio">${it.radio} ${it.label}</label>
    </g:radioGroup>

</div>



