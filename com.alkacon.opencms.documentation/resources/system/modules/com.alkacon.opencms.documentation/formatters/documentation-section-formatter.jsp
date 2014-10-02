<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content">
<div class="documentation-section">
	<c:set var="level" value="${cms.element.settings['level']}" />
	<c:set var="headingLevel">${level + 1}</c:set>
	<c:set var="headingTag">h${headingLevel}</c:set>
	<c:set var="sectionIndex">
		<c:choose>
		<c:when test="${level == 1}">${requestScope.sectionIndexer.sectionIndex1}</c:when>
		<c:when test="${level == 2}">${requestScope.sectionIndexer.sectionIndex2}</c:when>
		<c:when test="${level == 3}">${requestScope.sectionIndexer.sectionIndex3}</c:when>
		<c:when test="${level == 4}">${requestScope.sectionIndexer.sectionIndex4}</c:when>
		</c:choose>
	</c:set>
	<c:if test="${content.value.RefId.exists}">
		<a name="${content.value.RefId}"></a>
	</c:if>
	<a name="${sectionIndex}"></a>
	<${headingTag} class="headline">
		${sectionIndex}&nbsp;<span ${content.rdfa.Headline}>${content.value.Headline}</span>
	</${headingTag}>

	<c:set var="isEditor">
		<cms:property name="opencms.documentation.editor" file="search" default="false" />
	</c:set>
	<c:if test="${not cms.isOnlineProject and isEditor}">
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
	<cms:container type="documentation-section" name="documentation-section-container" />
	
</div>
</cms:formatter>