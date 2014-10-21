<%@page import="org.opencms.jsp.util.CmsJspStandardContextBean
			   ,com.alkacon.opencms.documentation.navigation.PageNavBuilder
			   ,com.alkacon.opencms.documentation.navigation.PageNavElement" %>
<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="c,cms" %>

<%	CmsJspStandardContextBean cmsBean = CmsJspStandardContextBean.getInstance(request);
	PageNavBuilder pageNav = new PageNavBuilder(cmsBean,"documentation-content-container");
	pageContext.setAttribute("pageNav", pageNav);
%>

<c:if test="${cms:getListSize(pageNav.navElements) > 0}">
	<i class="page-nav-btn fa fa-reorder hidden-xs"></i>
	<div class="page-nav hidden-xs">
		<h4 class="heading">
			Page Navigation
			<button type="button" class="close">&times;</button>
		</h4>
		<div class="page-nav-content">
			<ul class="nav-side list-group sidebar-nav-v1">			
				<c:forEach items="${pageNav.navElements}" var="elem">
					<li class="nav-side-level-${elem.navLevel} list-group-item"><a href="#${elem.link}">${elem.title}</a></li>
				</c:forEach>
			</ul>
		</div>
	</div>
	<div class="row visible-xs-block hidden-sm hidden-md hidden-lg">
		<div class="col-xs-12">
			<div class="page-nav-content">
				<ul class="nav-side list-group sidebar-nav-v1">			
					<c:forEach items="${pageNav.navElements}" var="elem">
						<li class="nav-side-level-${elem.navLevel} list-group-item"><a href="#${elem.link}">${elem.title}</a></li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</c:if>
