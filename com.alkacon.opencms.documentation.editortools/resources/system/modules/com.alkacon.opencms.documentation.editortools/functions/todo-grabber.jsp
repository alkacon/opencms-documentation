<%@page taglibs="c,cms" %>
<jsp:useBean id="todoCollector" class="com.alkacon.opencms.documentation.editortools.TodoCollector">
	<% todoCollector.init(pageContext, request, response);%>
</jsp:useBean>
<div>
	<h3>
	TODOs
	</h3>
	<c:forEach var="page" items="${todoCollector.todos}">
		<h4><a href="<cms:link>${page.pageInfo.link}</cms:link>">${page.pageInfo.title}</a></h4>
		<ul>
			<c:forEach var="todo" items="${page.topic.todos}">
				<li>${todo}</li>
			</c:forEach>
		</ul>
		<ul>
		<c:forEach var="section" items="${page.sectionList}">
			<li>
				<h5><a href="<cms:link>${page.pageInfo.link}#${section.refId}</cms:link>">${section.headline}</a></h5>
				<ul>
					<c:forEach var="todo" items="${section.todos}">
						<li>${todo}</li>
					</c:forEach>
				</ul>
			</li>
		</c:forEach>
		</ul>
	</c:forEach>
</div>