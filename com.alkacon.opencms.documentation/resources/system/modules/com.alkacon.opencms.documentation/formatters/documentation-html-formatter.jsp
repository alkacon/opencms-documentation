<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
<div>
	<c:set var="docuBranch"><cms:property name="opencms.documentation.branch" file="search"/></c:set>
	<c:set var="isEditor">
		<cms:property name="opencms.documentation.editor" file="search" default="false" />
	</c:set>
	<c:if test="${not (empty docuBranch or cms.isEditMode)}">
		<a href="https://github.com/alkacon/opencms-documentation/blob/${docuBranch}/com.alkacon.opencms.documentation.content/resources/${content.filename}" target="_blank" title="Edit Html content on GitHub" class="fa fa-edit pull-right github-link"></a>
	</c:if>
	<c:choose>
	<c:when test="${isEditor && not cms.isOnlineProject}">
		<div ${content.rdfa.Html}>${content.value.Html}</div>
	</c:when>
	<c:otherwise>
		<cms:decorate file="/system/modules/com.alkacon.opencms.documentation/decoration/configuration.xml">
			<div>${content.value.Html}</div>
		</cms:decorate>
	</c:otherwise></c:choose>
</div>
</cms:formatter>