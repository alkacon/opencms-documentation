<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>

<cms:secureparams />
<cms:formatter var="content" val="value">
<c:set var="hasScript" value="${cms.isEditMode and fn:contains(fn:toLowerCase(value.Code), 'script')}" />
<mercury:init-messages reload="${value.RequireReload.toBoolean or hasScript}">

<mercury:setting-defaults>

<c:set var="hsize"                  value="${setting.hsize.toInteger}" />
<c:set var="cssVisibility"          value="${setCssVisibility}" />

<mercury:nl />
<div class="element type-flexible type-flexible-code pivot${setCssWrapper123}${cssVisibility}"><%----%>
<mercury:nl />

    <mercury:heading level="${hsize}" text="${value.Title}" css="heading" />

    <pre><code><c:out value="${content.value.Code}" escapeXml="true" /></code></pre>

</div><%----%>
<mercury:nl />

</mercury:setting-defaults>

</mercury:init-messages>
</cms:formatter>
