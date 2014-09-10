<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="c,cms" %> 
<c:set var="navStartLevel">1</c:set>
<cms:navigation type="treeForFolder" startLevel="${navStartLevel}" endLevel="4" var="nav"/>
<ul class="nav-side list-group sidebar-nav-v1">		
	<c:forEach items="${nav.items}" var="elem">
		<li class='nav-side-level-${elem.navTreeLevel - navStartLevel} 
		           list-group-item 
		           ${!elem.navigationLevel && nav.isActive[elem.resourceName]?"active":""}'>
			<a href="<cms:link>${elem.resourceName}</cms:link>">${elem.navText}</a>
		</li>
	</c:forEach>
</ul>