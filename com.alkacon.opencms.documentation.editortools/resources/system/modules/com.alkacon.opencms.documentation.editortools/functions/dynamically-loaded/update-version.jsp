<%@page taglibs="c,cms" %>
<jsp:useBean id="versionUpdater" class="com.alkacon.opencms.documentation.editortools.FigureVersionUpdater">
	<% versionUpdater.init(pageContext, request, response);
	   versionUpdater.setFileAndVersion(request.getParameter("uuid"),request.getParameter("version"));
	%>
</jsp:useBean>
<c:set var="updated" value="${versionUpdater.updateVersionNumber}" />
<c:choose>
<c:when test='${updated}'>
	<div class="btn btn-success btn-block" disabled="disabled" role="alert">Update successful.</div>
</c:when>
<c:otherwise>
	<div class="btn btn-danger btn-block" disabled="disabled" role="alert">Update failed.</div>
</c:otherwise>
</c:choose>