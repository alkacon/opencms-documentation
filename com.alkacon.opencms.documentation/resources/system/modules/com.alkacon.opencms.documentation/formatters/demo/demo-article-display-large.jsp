<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content">
<div>
	<h3><a href="<cms:link>${content.filename}</cms:link>">${content.value.Title}</a></h3>
	<p>${cms:trimToSize(content.value.Text, 200)}</p>
</div>
</cms:formatter>