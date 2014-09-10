<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content" val="value">
<div style="margin-bottom:30px;">
    <div class="headline"><h3>${value.Title}</h3></div>
    <%-- The text field of the article with image --%>
    ${value.Text}
    <hr />
	<%-- Check if the script field is available. --%>
    <%-- ".isSet" checks if the Script node exists and not empty --%>
    <%-- ${cms.edited} marks that the element have been just edited --%>
    <c:choose>
    <c:when test="${!value.Script.isSet}">
		Please add a script.
	</c:when>
	<c:when test="${cms.edited}">
		<!-- enforce an automatical reload, when the content is edited or moved to another container -->
		${cms.enableReload}
        <p>Script result not available after edit or move operation. Page is automatically reloaded.</p>
    </c:when>
    <c:otherwise>
		${value.Script}
    </c:otherwise>
	</c:choose>
</div>
</cms:formatter>