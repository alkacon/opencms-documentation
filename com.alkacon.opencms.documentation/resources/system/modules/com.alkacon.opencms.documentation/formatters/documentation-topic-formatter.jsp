<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
<div>
	<c:if test="${not cms.isOnlineProject}">
		<div class="alert alert-info">
			Edit me to change the topics meta-data.
		</div>
		<c:set var="todoList" value="${content.value.StatusMetaData.value.Todos.valueList.Todo}" />
		<c:if test="${not empty todoList}">
			<div class="alert alert-block alert-info">
				<h4>TODOs</h4>
				<ul>
					<c:forEach var="todo" items="${todoList}">
						<li>${todo}</li>
					</c:forEach>
				</ul>
			</div>
		</c:if>
	</c:if>
	<div class="tag-box tag-box-v6" ${content.rdfa.Overview}>${content.value.Overview}</div>
</div>
</cms:formatter>