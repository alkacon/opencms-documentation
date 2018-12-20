<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<cms:formatter var="content" val="value">

<c:set var="settings" value="${cms.element.settings}" />
<c:set var="textLength"   value="${settings.textLength}" />

<div style="border:solid; border-color: ${settings.borderColour}; padding:10px">

	<c:if test="${!settings.hideTitle}">
		<h2>${value.Title}</h2>
	</c:if>
	<div style="float: ${settings.logoPosition}; margin: 10px">
	<cms:img   src="${value.Image}" width="200" height="50"/>
	</div>
	<p>
	${cms:trimToSize(value.Text, textLength)}</p>
	

</div>


</cms:formatter>

