
<%@ page import="sri.score.TGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TGroup.label', default: 'TGroup')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-TGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-TGroup" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="title" title="${message(code: 'TGroup.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="xtype" title="${message(code: 'TGroup.xtype.label', default: '类型')}" />
					
						<g:sortableColumn property="xstatus" title="${message(code: 'TGroup.xstatus.label', default: 'Xstatus')}" />
					
						<g:sortableColumn property="create_date" title="${message(code: 'TGroup.create_date.label', default: 'Createdate')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'TGroup.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="update_date" title="${message(code: 'TGroup.update_date.label', default: 'Updatedate')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${TGroupInstanceList}" status="i" var="TGroupInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${TGroupInstance.id}">${fieldValue(bean: TGroupInstance, field: "title")}</g:link></td>
					
						<td>${fieldValue(bean: TGroupInstance, field: "xtype")}</td>
					
						<td>${fieldValue(bean: TGroupInstance, field: "xstatus")}</td>
					
						<td><g:formatDate date="${TGroupInstance.create_date}" /></td>
					
						<td>${fieldValue(bean: TGroupInstance, field: "creator")}</td>
					
						<td><g:formatDate date="${TGroupInstance.update_date}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${TGroupInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
