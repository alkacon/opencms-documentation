<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
	<div>
		<c:if test="${content.value.Heading.exists}">
			<h5 class="heading" ${content.rdfa.Heading}>${content.value.Heading}</h5>
		</c:if>
		<dl>
			<c:set var="isPropertyDef" value="${content.value.PropertyDef == 'true'}" />
			<c:forEach var="entry" items="${content.valueList.Entry}">
				<dt>
					<c:set var="term">
						<c:choose>
							<c:when test="${isPropertyDef}">
								<code ${entry.rdfa.Term}>${entry.value.Term}</code>
							</c:when>
							<c:otherwise>
								<span ${entry.rdfa.Term}>${entry.value.Term}</span>
							</c:otherwise>
						</c:choose>
					</c:set>
					<c:if test="${entry.value.Icon.exists}"><cms:img src="${entry.value.Icon}" height="16" />&nbsp;</c:if>
							<c:choose>
								<c:when test="${entry.value.Link.exists}">
									<a href="<cms:link>${entry.value.Link}</cms:link>">${term}</a>
								</c:when>
								<c:otherwise>
									${term}
								</c:otherwise>
							</c:choose>
				</dt>
				<dd ${entry.rdfa.Description}>${entry.value.Description}</dd>
			</c:forEach>
		</dl>
	</div>
</cms:formatter>