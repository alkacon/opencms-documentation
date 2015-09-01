<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="autoplay">${cms.element.settings.autoplay ? 1 : 0}</c:set>
<c:set var="loop">${cms.element.settings.loop ? 1 : 0}</c:set>
<c:set var="fs">${cms.element.settings.fs ? 1 : 0}</c:set>
<c:set var="showinfo">${cms.element.settings.showinfo ? 1 : 0}</c:set>
<c:set var="width">${cms.element.settings.width}</c:set>
<c:set var="height">${cms.element.settings.height}</c:set>
<c:set var="centered">${cms.element.settings.centered ? 'style="text-align:center;"' : ''}</c:set>

<cms:formatter var="content">
<div ${centered}>
${cms.enableReload}
	<div>
		<div class="tag-box tag-box-v4">
			
			<a name="vid_${fn:replace(fn:toLowerCase(content.value.Identifier)," ","_")}"></a>
		
			<c:choose>
				<c:when test="${content.value.VideoID.isSet}">
					<iframe type="text/html" width="${width}" height="${height}" 
						src="http://www.youtube.com/embed/${content.value.VideoID}?autoplay=${autoplay}&loop=${loop}&fs=${fs}&showinfo=${showinfo}&rel=0&modestbranding=1" frameborder="0" ></iframe>
				</c:when>
				
				<c:otherwise>
					<div class="alert alert-danger" style="width: ${width}px; height: ${height}px;">
						<h2>
							Please enter the VideoID for the video you want to show here.
						</h2>
					</div>
				</c:otherwise>
			</c:choose>
		
			<div>
				<b>Fig. [<span ${content.rdfa.Identifier}>${content.value.Identifier}</span>]:</b> <span ${content.rdfa.Title}>${content.value.Title}</span>
			</div>
		</div>
	</div>
</div>
</cms:formatter>