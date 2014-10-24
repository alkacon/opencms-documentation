<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<cms:navigation type="forResource" var="nav" />
<c:set var="navLevel" value="${nav.items[0].navTreeLevel}" />
<cms:navigation type="forFolder" startLevel="${navLevel-1}" var="nav" />
<div class="margin-bottom-30">
	<div class="headline">
		<h3>A sample navigation</h3>
	</div>
	<div>
		<p>Cache properties: <b><cms:property name="cache" file="this" /></b></p>
		<hr />
		<p><strong>Pages on the current navigation level:</strong></p>
		<ul>
		<c:forEach items="${nav.items}" var="elem">
			<li><a href="<cms:link>${elem.resourceName}</cms:link>">${elem.navText}</a></li>
		</c:forEach>
		</ul>
	</div>
	<hr />
	<div><a href="<cms:link>/documentation/demos/flex-cache-settings/navigation-example-at-another-page/</cms:link>">See this example on a nested page.</a></div>
</div>