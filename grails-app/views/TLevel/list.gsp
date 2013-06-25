
<%@ page import="sri.score.TLevel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'TLevel.label', default: 'TLevel')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-TLevel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-TLevel" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="coefficient" title="${message(code: 'TLevel.coefficient.label', default: 'Coefficient')}" />
					
						<g:sortableColumn property="create_date" title="${message(code: 'TLevel.create_date.label', default: 'Createdate')}" />
					
						<g:sortableColumn property="creator" title="${message(code: 'TLevel.creator.label', default: 'Creator')}" />
					
						<g:sortableColumn property="method" title="${message(code: 'TLevel.method.label', default: 'Method')}" />
					
						<g:sortableColumn property="min_score" title="${message(code: 'TLevel.min_score.label', default: 'Minscore')}" />
					
						<g:sortableColumn property="score_config" title="${message(code: 'TLevel.score_config.label', default: 'Scoreconfig')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${TLevelInstanceList}" status="i" var="TLevelInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${TLevelInstance.id}">${fieldValue(bean: TLevelInstance, field: "coefficient")}</g:link></td>
					
						<td><g:formatDate date="${TLevelInstance.create_date}" /></td>
					
						<td>${fieldValue(bean: TLevelInstance, field: "creator")}</td>
					
						<td>${fieldValue(bean: TLevelInstance, field: "method")}</td>
					
						<td>${fieldValue(bean: TLevelInstance, field: "min_score")}</td>
					
						<td>${fieldValue(bean: TLevelInstance, field: "score_config")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${TLevelInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
