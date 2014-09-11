<%@page taglibs="c" import="org.opencms.file.CmsProperty, org.opencms.file.CmsObject" %>
<c:set var="cmsObject" value="${cms.vfs.cmsObject}" />
<%  CmsObject cmsObject = (CmsObject) pageContext.getAttribute("cmsObject");
	CmsProperty editorProperty = null;
	String resource = "/opencms-documentation/";
	String editorPropertyName = "opencms.documentation.editor";

	if (cmsObject.readPropertyObject(resource, editorPropertyName, false).getValue().equals("true"))
		editorProperty = new CmsProperty(editorPropertyName,"false",null,true);
	else
		editorProperty = new CmsProperty(editorPropertyName,"true",null,true);
	cmsObject.lockResource(resource);
	cmsObject.writePropertyObject(resource,editorProperty);
	cmsObject.unlockResource(resource);
%>
