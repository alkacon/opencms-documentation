<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
<div>
	<div class="tag-box tag-box-v4">
		
		<c:set var="docuBranch"><cms:property name="opencms.documentation.branch" file="search"/></c:set>
		<c:if test="${not empty docuBranch}">
			<a href="https://github.com/alkacon/opencms-documentation/blob/${docuBranch}/com.alkacon.opencms.documentation.content/resources/${content.filename}" target="_blank" title="Edit figure content on GitHub" class="glyphicon glyphicon-edit pull-right github-link"></a>
		</c:if>
		
		<a name="fig_${fn:replace(fn:toLowerCase(content.value.Identifier)," ","_")}"></a>
	
		<div ${content.imageDnd[content.value.Image.path]}>
			<cms:img src="${content.value.Image}" cssclass="img-responsive center-block" />
		</div>
		<c:if test="${cms.element.settings['inline'] eq 'false'}">	
			<div>
				<c:if test="${content.value.Description.exists}">
					<hr />
					<span ${content.rdfa.Description}>${content.value.Description}</span>
					<hr />
				</c:if>
				<b>Fig. [<span ${content.rdfa.Identifier}>${content.value.Identifier}</span>]:</b> <span ${content.rdfa.Title}>${content.value.Title}</span>
			</div>
		</c:if>
	</div>
</div>
</cms:formatter>