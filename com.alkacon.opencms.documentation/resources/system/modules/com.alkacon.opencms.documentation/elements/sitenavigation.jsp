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
<c:set var="maxNavLevels" value='<%= toInt(request.getParameter("maxNavLevels"), 5)%>' />
<c:set var="resource" value='${param.resource != null?param.resource:"/opencms-documentation"}' />
<cms:navigation type="forSite" endLevel="${navStartLevel+maxNavLevels-1}" resource="${resource}" var="nav"/>
<c:set var="enterSubLevel" value="${false}" />
<c:set var="exitSubLevel" value="${false}" />
<ul class="list-group nav-side sidebar-nav-v1">
	<c:forEach items="${nav.items}" var="elem">
		<c:if test="${not empty lastItem}">
			<c:if test="${enterSubLevel}">
				<c:set var="lastParentFolder" value="${lastItem.parentFolderName}" />
				<c:if test="${lastItem.navigationLevel}">
					<c:set var="folders" value="${fn:split(lastParentFolder,'/')}" />
					<c:set var="correctedParentFolder">/</c:set>
					<c:forEach var="folder" items="${folders}" varStatus="status">
						<c:if test="${status.index < (fn:length(folders)-1)}">
							<c:set var="correctedParentFolder">${correctedParentFolder}${folder}/</c:set>
						</c:if>
					</c:forEach>
					<c:set var="lastParentFolder" value="${correctedParentFolder}" />
				</c:if>
				<ul class="list-group list-group-inner nav-side sidebar-nav-v1" ${fn:startsWith(cms.requestContext.uri,lastParentFolder)?"":"style='display:none;'"}></c:if>
			<c:if test="${exitSubLevel}"></ul></c:if>
			
			<li class="list-group-item nav-side-level-${lastItem.navTreeLevel - navStartLevel}<c:if test="${!lastItem.navigationLevel && nav.isActive[lastItem.resourceName]}"> active</c:if>">
				<a href="<cms:link>${lastItem.resourceName}</cms:link>">
					<span class='nav-side-toggle-sublevel glyphicon
					             ${elem.navTreeLevel > lastItem.navTreeLevel?(fn:startsWith(cms.requestContext.uri,lastItem.resourceName)?"glyphicon-collapse-down data-nav-collapse":"glyphicon-expand data-nav-expand"):""}'>&nbsp;</span><c:out value="${lastItem.navText}"/></a>
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
		<c:if test="${enterSubLevel}">
			<c:set var="lastParentFolder" value="${lastItem.parentFolderName}" />
			<c:if test="${lastItem.navigationLevel}">
				<c:set var="folders" value="${fn:split(lastParentFolder,'/')}" />
				<c:set var="correctedParentFolder">/</c:set>
				<c:forEach var="folder" items="${folders}" varStatus="status">
					<c:if test="${status.index < (fn:length(folders)-1)}">
						<c:set var="correctedParentFolder">${correctedParentFolder}${folder}/</c:set>
					</c:if>
				</c:forEach>
				<c:set var="lastParentFolder" value="${correctedParentFolder}" />
			</c:if>
			<ul class="list-group nav-side sidebar-nav-v1" ${fn:startsWith(cms.requestContext.uri,lastParentFolder)?"":"style='display:none;'"}></c:if>
		<c:if test="${exitSubLevel}"></ul></c:if>
		
		<li class="list-group-item nav-side-level-${lastItem.navTreeLevel - navStartLevel}<c:if test="${!lastItem.navigationLevel && nav.isActive[lastItem.resourceName]}"> active</c:if>">
			<a href="<cms:link>${lastItem.resourceName}</cms:link>">
				<span class='nav-side-toggle-sublevel'>&nbsp;</span>${lastItem.navText}</a>
		</li>
		<c:if test="${navStartLevel < lastItem.navTreeLevel}">
			<c:forEach begin="${navStartLevel}" end="${lastItem.navTreeLevel-1}" >
				</ul>
			</c:forEach>
		</c:if>
	</c:if>
	<li class="list-group-item nav-side-level-0">
		<a href="http://documentation.opencms.org/central/impressum/"><span class='nav-side-toggle-sublevel'>&nbsp;</span>Impressum</a>
	</li>
</ul>