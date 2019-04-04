<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
	<div>
		<c:set var="docuBranch"><cms:property name="opencms.documentation.branch" file="search"/></c:set>
		<c:if test="${not empty docuBranch}">
			<a href="https://github.com/alkacon/opencms-documentation/blob/${docuBranch}/com.alkacon.opencms.documentation.content/resources/${content.filename}" target="_blank" title="Edit definition list content on GitHub" class="fa fa-edit pull-right github-link"></a>
		</c:if>
		<c:if test="${not content.value.Anchor.isEmptyOrWhitespaceOnly}">
			<c:set var="anchor">${content.value.Anchor}</c:set>
			<a name="${anchor}"></a>
		</c:if>
		<c:if test="${content.value.Heading.exists}">
			<h5 class="heading" ${content.rdfa.Heading}>${content.value.Heading}</h5>
		</c:if>
		<table class="documentation-dl-table">
			<c:set var="isPropertyDef" value="${content.value.PropertyDef == 'true'}" />
			<c:forEach var="entry" items="${content.valueList.Entry}">
				<tr>
					<td>
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
					</td>
					<td ${entry.rdfa.Description}>${entry.value.Description}</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</cms:formatter>