<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@page import="org.opencms.jsp.util.CmsJspStandardContextBean
			   ,com.alkacon.opencms.documentation.navigation.PageNavBuilder
			   ,com.alkacon.opencms.documentation.navigation.PageNavElement" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>


<%	CmsJspStandardContextBean cmsBean = CmsJspStandardContextBean.getInstance(request);
	PageNavBuilder pageNav = new PageNavBuilder(cmsBean,"documentation-content-container");
	pageContext.setAttribute("pageNav", pageNav);
%>

<c:if test="${cms:getListSize(pageNav.navElements) > 0}">
	<i class="page-nav-btn icon-image fa fa-bars hidden-xs hidden-sm hidden-md"></i>
	<div class="page-nav hidden-xs hidden-sm hidden-md">
		<h4 class="heading">
			Page Navigation
			<%-- TODO: Style --%>
			<a class="close float-right icon-image fa fa-times"></a>
		</h4>
		<div class="page-nav-content" style="background-color: #ffffff;">
			<ul class="nav-side">
				<c:set var="lastLevel" value="${1}" />
				<c:forEach items="${pageNav.navElements}" var="elem" varStatus="status">
					<c:choose>
					<c:when test="${not status.first and lastLevel eq elem.navLevel}">
						</li>
					</c:when>
					<c:when test="${lastLevel lt elem.navLevel}">
						<ul>
					</c:when>
					<c:when test="${lastLevel gt elem.navLevel}">
						</li>
						<c:forEach var="i" begin="${elem.navLevel}" end="${lastLevel - 1}">
							</ul>
							</li>
						</c:forEach>
					</c:when>
					</c:choose>

					<li><a href="#${elem.link}">${elem.title}</a>

					<c:set var="lastLevel" value="${elem.navLevel}" />

				</c:forEach>

				<c:if test="${lastLevel gt 1}">
					<c:forEach var="i" begin="${1}" end="${lastLevel}">
						</li>
						</ul>
					</c:forEach>
				</c:if>
				</li>
			</ul>
		</div>
	</div>
</c:if>
