<%@page taglibs="c,cms" import="org.opencms.file.CmsObject, org.opencms.xml.containerpage.CmsADESessionCache, org.opencms.util.CmsUUID" %>
<c:set var="cmsObject" value="${cms.vfs.cmsObject}" />
<c:set var="editorToolsLink" value="/documentation-editor-tools/" />
<c:set var="changeViewLink" value="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/changeView.jsp:a6fdeaa0-38d7-11e4-9c91-578a14069906)" />
<c:if test="${cms.vfs.exists[editorToolsLink]}">
	<div class="tag-box tag-box-v4">
	<c:choose>
		<c:when test="${cms.vfs.property['/documentation/']['opencms.documentation.editor'] eq 'true'}">
			<c:set var="editorViewLink">%(link.strong:/system/modules/com.alkacon.opencms.documentation/elementviews/editor-view.xml:4af2879d-47d2-11e4-9d1c-336f7b60f7b1)</c:set>
			<%  CmsObject cmsObject = (CmsObject) pageContext.getAttribute("cmsObject");
				CmsADESessionCache sessionCache = CmsADESessionCache.getCache(request, cmsObject);
				String editorViewLink = (String) pageContext.getAttribute("editorViewLink");
				CmsUUID uuid = cmsObject.readResource(editorViewLink).getStructureId();
				if(!sessionCache.getElementView().equals(uuid)) {
			%>
				<div class="alert alert-warning">
					<strong>You can't edit things?</strong><br />
					Switch to the "Editor element view".
				</div>
			<%	}
			%>
			<c:set var="alternativeView">user view</c:set>
			<a class="btn-u btn-u-default btn-block" style="text-align:center;" href="<cms:link>${editorToolsLink}</cms:link>">Editor Tools</a>
		</c:when>
		<c:otherwise>
			<c:set var="alternativeView">editor view</c:set>
		</c:otherwise>
	</c:choose>	
	<a class="btn btn-info btn-block documentation-change-view" href="#" data-documentation-change-view-url="<cms:link>${changeViewLink}</cms:link>">Switch to ${alternativeView}</a>
	</div>
</c:if>
