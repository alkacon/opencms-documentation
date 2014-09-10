<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="margin-bottom-30">
    <div class="headline">
        <h3>Container page information</h3>
    </div>
	<h4>About the current container</h4>
    <ul>
    <li><b>Name:</b> ${cms.container.name}</li>
    <li><b>Type:</b> ${cms.container.type}</li>
    <li><b>Width:</b> ${cms.container.width}</li>
    <li><b>Max Elements:</b> ${cms.container.maxElements}</li>
    </ul>
    
    <h4>Container page</h4>
    <ul>
        <li><b>Container Names:</b>
            <ul>
                <c:forEach var="con" items="${cms.page.names}">
                    <li>${con}</li>
                </c:forEach>
            </ul>
        </li>
        <li><b>Container Types:</b>
            <ul>
                <c:forEach var="con" items="${cms.page.types}">
                    <li>${con}</li>
                </c:forEach>
            </ul>
        </li>
    </ul>
    
    <h4>Element Mode:</h4>
    <p><b>Mode:</b> ${cms.edited}</p>
    <c:if test="${cms.edited}">
        <p>Please reload the current page.</p>
        <p>The element mode is <strong>true</strong>, if the element have been moved or edited, but the page have not been reloaded yet.<br/>
        The element mode is <strong>false</strong>, if the element have not been changed since the last reload of the page.</p>
    </c:if>
    <c:if test="${!cms.edited}">
        <p>The element mode is <strong>true</strong>, if the element have been moved or edited, but the page have not been reloaded yet.<br/>
        The element mode is <strong>false</strong>, if the element have not been changed since the last reload of the page.</p>
    </c:if>
    <c:if test="${cms.container.type == 'demo-content' }">
    	<hr />
    	<em>The content is in a container of type "demo-content", if you are offline, move it and see how values change.</em>
    	<hr />
    </c:if>
</div>
