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

<div>

	<c:if test="${!settings.hideTitle}">
		<h2>${value.Title}</h2>
	</c:if>
	
	<c:if test="${!value.Image.isEmpty}">
	<div style="float: ${settings.logoPosition}; margin: 10px">
		<cms:img   src="${value.Image}" width="200" height="50"/>
	</div>
	</c:if>
	
	<p>${cms:trimToSize(value.Text, textLength)}</p>
	
	<c:if test="${!(settings.dateFormat eq 'none')}">
		<p>
			<fmt:formatDate value="${cms:convertDate(value.Date)}" type="${settings.dateFormat}"/>
		</p>
	</c:if>

</div>


</cms:formatter>

