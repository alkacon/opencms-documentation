<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
	<div>
		<c:set var="docuBranch"><cms:property name="opencms.documentation.branch" file="search"/></c:set>
		<c:if test="${not empty docuBranch}">
			<a href="https://github.com/alkacon/opencms-documentation/blob/${docuBranch}/com.alkacon.opencms.documentation.content/resources/${content.filename}" target="_blank" title="Edit code block content on GitHub" class="fa fa-edit pull-right github-link"></a>
		</c:if>
		<c:choose>
		<c:when test="${content.value.ProgrammingLanguage.exists}">
			<c:set var="language">${content.value.ProgrammingLanguage}</c:set>
		</c:when>
		<c:otherwise><c:set var="language"></c:set></c:otherwise>
		</c:choose>
		<pre class="${cms.element.settings['linenumbers'] eq 'true'?'show-linenumbers':''}"><code class="${language}"><c:out value="${content.value.Code}" escapeXml="true" /></code></pre>
	</div>
</cms:formatter>