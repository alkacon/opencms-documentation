<%@page taglibs="c" import="org.opencms.file.CmsProperty, org.opencms.file.CmsObject, org.opencms.xml.containerpage.CmsADESessionCache, org.opencms.util.CmsUUID" %>
<c:set var="cmsObject" value="${cms.vfs.cmsObject}" />
<c:set var="editorViewLink">%(link.strong:/system/modules/com.alkacon.opencms.documentation/elementviews/editor-view.xml:4af2879d-47d2-11e4-9d1c-336f7b60f7b1)</c:set>
<%  CmsObject cmsObject = (CmsObject) pageContext.getAttribute("cmsObject");
	CmsProperty editorProperty = null;
	String resource = "/documentation/";
	String editorPropertyName = "opencms.documentation.editor";

	CmsADESessionCache sessionCache = CmsADESessionCache.getCache(request, cmsObject);
	if (cmsObject.readPropertyObject(resource, editorPropertyName, false).getValue().equals("true")) {
		editorProperty = new CmsProperty(editorPropertyName,"false",null,true);
		sessionCache.setElementView(CmsUUID.getNullUUID());
	} else {
		editorProperty = new CmsProperty(editorPropertyName,"true",null,true);
		String editorViewLink = (String) pageContext.getAttribute("editorViewLink");
		CmsUUID uuid = cmsObject.readResource(editorViewLink).getStructureId();
		sessionCache.setElementView(uuid);
	}
	cmsObject.lockResource(resource);
	cmsObject.writePropertyObject(resource,editorProperty);
	cmsObject.unlockResource(resource);
%>
