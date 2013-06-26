
<%@ page import="sri.score.TProject" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TProject.label', default: 'TProject')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-TProject" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-TProject" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="title" title="${message(code: 'TProject.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'TProject.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="xtype" title="${message(code: 'TProject.xtype.label', default: 'Xtype')}" />
					
						<g:sortableColumn property="xstatus" title="${message(code: 'TProject.xstatus.label', default: 'Xstatus')}" />
					
						<g:sortableColumn property="create_date" title="${message(code: 'TProject.create_date.label', default: 'Createdate')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'TProject.creator.label', default: 'Creator')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${TProjectInstanceList}" status="i" var="TProjectInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${TProjectInstance.id}">${fieldValue(bean: TProjectInstance, field: "title")}</g:link></td>
					
						<td>${fieldValue(bean: TProjectInstance, field: "description")}</td>
					
						<td>${fieldValue(bean: TProjectInstance, field: "xtype")}</td>
					
						<td>${fieldValue(bean: TProjectInstance, field: "xstatus")}</td>
					
						<td><g:formatDate date="${TProjectInstance.create_date}" /></td>
					
						<td>${fieldValue(bean: TProjectInstance, field: "creator")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${TProjectInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
