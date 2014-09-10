<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="c,cms,fn" %>
<%!
int toInt(String val, int default_val) {
	try {
		return Integer.parseInt(val);
	} catch (Exception e) {
		return default_val;
	}
}
%>
<c:set var="navStartLevel" value='<%= toInt(request.getParameter("navStartLevel"), 1)%>' />
<c:set var="maxNavLevels" value='<%= toInt(request.getParameter("maxNavLevels"), 4)%>' />
<c:set var="resource" value='${param.resource != null?param.resource:"/opencms-documentation/"}' />
<cms:navigation type="forSite" endLevel="${navStartLevel+maxNavLevels-1}" resource="${resource}" var="nav"/>
<c:set var="enterSubLevel" value="${false}" />
<c:set var="exitSubLevel" value="${false}" />
<ul class="nav-side list-group sidebar-nav-v1">
	<c:forEach items="${nav.items}" var="elem">
		<c:if test="${not empty lastItem}">
			<c:if test="${enterSubLevel}"><ul class="nav-side list-group list-group-inner sidebar-nav-v1" ${fn:startsWith(cms.requestContext.uri,lastItem.parentFolderName)?"":"style='display:none;'"}></c:if>
			<c:if test="${exitSubLevel}"></ul></c:if>
			
			<li class="nav-side-level-${lastItem.navTreeLevel - navStartLevel} list-group-item<c:if test="${!lastItem.navigationLevel && nav.isActive[lastItem.resourceName]}"> active</c:if>">
				<a href="<cms:link>${lastItem.resourceName}</cms:link>">
					<span class='nav-side-toggle-sublevel 
					             ${elem.navTreeLevel > lastItem.navTreeLevel?(fn:startsWith(cms.requestContext.uri,lastItem.resourceName)?"icon-collapse":"icon-expand"):""}'>&nbsp;</span>${lastItem.navText}</a>
			</li>			
			
			<c:set var="enterSubLevel" value="${elem.navTreeLevel > lastItem.navTreeLevel?true:false}" />
			<c:set var="exitLevelCounter" value="${lastItem.navTreeLevel-elem.navTreeLevel}" />
		</c:if>

		<c:set var="lastItem" value="${elem}" />
		<c:if test="${exitLevelCounter > 0}">
			<c:forEach begin="${1}" end="${exitLevelCounter}">
				</ul>
			</c:forEach>
		</c:if> 
	</c:forEach>
	<c:if test="${not empty lastItem}">
		<c:if test="${enterSubLevel}"><ul class="nav-side list-group sidebar-nav-v1" ${fn:startsWith(cms.requestContext.uri,lastItem.resourceName)?"":"style='display:none;'"}></c:if>
		<c:if test="${exitSubLevel}"></ul></c:if>
		
		<li class="nav-side-level-${lastItem.navTreeLevel - navStartLevel} list-group-item<c:if test="${!lastItem.navigationLevel && nav.isActive[lastItem.resourceName]}"> active</c:if>">
			<a href="<cms:link>${lastItem.resourceName}</cms:link>">
				<span class='nav-side-toggle-sublevel'>&nbsp;</span>${lastItem.navText}</a>
		</li>			
		<c:forEach begin="${navStartLevel}" end="${lastItem.navTreeLevel}" >
			</ul>
		</c:forEach>
	</c:if>
</ul>