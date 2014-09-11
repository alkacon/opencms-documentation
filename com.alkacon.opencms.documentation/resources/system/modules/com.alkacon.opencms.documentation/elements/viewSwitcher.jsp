<%@page taglibs="c,cms" %>
<c:set var="editorToolsLink" value="/opencms-documentation-editor-tools/" />
<c:set var="changeViewLink" value="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/changeView.jsp:a6fdeaa0-38d7-11e4-9c91-578a14069906)" />
<c:if test="${cms.vfs.exists[editorToolsLink]}">
	<div class="tag-box tag-box-v4">
	<c:choose>
		<c:when test="${cms.vfs.property['/opencms-documentation/']['opencms.documentation.editor'] eq 'true'}">
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
