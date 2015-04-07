<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
	<div class="margin-bottom-30">
		<c:if test="${cms.element.settings['heading'] eq 'true'}">
			<div class="headline">
				<h3 ${content.rdfa.Title}>${content.value.Title}</h3>
			</div>
		</c:if>
		<c:choose>
		<c:when test="${content.value.EntryFolder.isEmptyOrWhitespaceOnly}">
			Please edit the content and set an entry folder.
		</c:when>
		<c:otherwise>
			<c:set var="absolutePath" value="${cms.vfs.resource[content.value.EntryFolder].rootPath}" />
			<cms:contentload collector="byContext" 
			                 param='fq=parent-folders:"${absolutePath}"&fq=type:documentation-glossar-entry&sort=term_en_sort asc&rows=10000000|createPath=${content.value.EntryFolder}oc10-ge_%(number).xml'
			                 preload="true" 
			                 editEmpty="true"			                 
			>
				<cms:contentinfo var="info" />
				<c:choose>
				<c:when test="${info.resultSize > 0}">
					<dl>
					<cms:contentload editable="true">
						<cms:contentaccess var="entry" />
						<a name="${entry.value.RefId.exists?entry.value.RefId:entry.value.Term}"></a>
						<dt>${entry.value.Term}</dt>
						<dd>${entry.value.Description}</dd>
					</cms:contentload>
					</dl>
				</c:when>
				<c:otherwise>
					<div>
					<cms:editable editEmpty="true" />
					</div>
				</c:otherwise>
				</c:choose>
			</cms:contentload>
		</c:otherwise>
		</c:choose>
	</div>
</cms:formatter>