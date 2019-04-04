<%@page
    pageEncoding="UTF-8"
    buffer="none"
    session="false"
    trimDirectiveWhitespaces="true"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="mercury" tagdir="/WEB-INF/tags/mercury" %>

<nav class="nav-main-group ${logoImage.value.Image.isSet ? 'has-sidelogo' : ''}"><%----%>

	<c:set var="navStartFolder" value="/" />
	<c:set var="navStartLevel" value="0" />
	<c:set var="endLevel" value="6" />

    <cms:navigation
        type="forSite"
        resource="${navStartFolder}"
        startLevel="${navStartLevel}"
        endLevel="${endLevel}"
        locale="${cms.locale}"
        param="true"
        var="nav" />

        <mercury:nl />
        <ul class="nav-main-items"><%----%>
        <mercury:nl />

        <c:set var="navLength" value="${fn:length(nav.items) - 1}" />
        <c:forEach var="i" begin="0" end="${navLength}" >

            <c:set var="navElem" value="${nav.items[i]}" />
            <c:set var="nextLevel" value="${i < navLength ? nav.items[i+1].navTreeLevel : navStartLevel}" />
            <c:set var="startSubMenu" value="${nextLevel > navElem.navTreeLevel}" />
            <c:set var="isTopLevel" value="${navElem.navTreeLevel eq navStartLevel}" />
            <c:set var="nextIsTopLevel" value="${nextLevel eq navStartLevel}" />
            <c:set var="navTarget" value="${fn:trim(navElem.info)eq 'extern' ? ' target=\"_blank\"' : ''}" />

            <c:set var="isCurrentPage" value="${navElem.navigationLevel ?
                fn:startsWith(cms.requestContext.uri, navElem.parentFolderName) :
                fn:startsWith(cms.requestContext.uri, navElem.resourceName)}" />

            <c:set var="menuType">
                ${isCurrentPage ? ' active' : ''}
            </c:set>

            <c:if test="${navElem.navigationLevel}">
                <c:set var="lastNavLevel" value="${navElem}" />
            </c:if>

            <c:choose>
                <c:when test="${(not empty lastNavLevel) and fn:startsWith(navElem.info, '#')}">
                    <c:set var="navLink"><cms:link>${lastNavLevel.resourceName}${navElem.info}</cms:link></c:set>
                </c:when>
                <c:otherwise>
                    <c:set var="navLink"><cms:link>${navElem.resourceName}</cms:link></c:set>
                </c:otherwise>
            </c:choose>

            <c:if test="${startSubMenu}">
                <c:set var="instanceId"><mercury:idgen prefix="" uuid="${cms.element.instanceId}" /></c:set>
                <c:set var="parentLabelId">label${instanceId}_${i}</c:set>
                <c:set var="targetMenuId">nav${instanceId}_${i}</c:set>
            </c:if>

            <c:set var="menuType" value="${empty menuType ? '' : ' class=\"'.concat(menuType).concat('\"')}" />
            <c:set var="menuType" value="${startSubMenu ? menuType.concat(' aria-expanded=\"false\"') : menuType}" />

            <c:out value='<li${menuType}${megaMenu}>${empty menuType ? "" : nl}' escapeXml="false" />

            <c:set var="navText" value="${(empty navElem.navText or fn:startsWith(navElem.navText, '???'))
                ? navElem.title : navElem.navText}" />

            <c:choose>
                <c:when test="${startSubMenu and navElem.navigationLevel}">
                    <%-- Navigation item with sub-menu but without direct child pages --%>
                    <a href="${navLink}"${navTarget}${' '}<%--
                    --%>id="${parentLabelId}"${' '}<%--
                    --%>aria-controls="${targetMenuId}">${navText}</a><%--
            --%></c:when>

                <c:when test="${startSubMenu}">
                    <%-- Navigation item with sub-menu and direct child pages --%>
                    <a href="${navLink}"${navTarget} class="nav-label" id="${parentLabelId}">${navText}</a><%--
                --%><a href="${navLink}"${navTarget} aria-controls="${targetMenuId}">&nbsp;</a><%--
            --%></c:when>

                <c:otherwise>
                    <%--Navigation item without sub-menu --%>
                    <a href="${navLink}"${navTarget}>${navText}</a><%--
            --%></c:otherwise>
            </c:choose>

            <c:if test="${startSubMenu}">
               <c:out value='${nl}<ul class="nav-menu" id="${targetMenuId}" aria-labelledby="${parentLabelId}">${nl}' escapeXml="false" />
            </c:if>

            <c:if test="${nextLevel < navElem.navTreeLevel}">
                <c:forEach begin="1" end="${navElem.navTreeLevel - nextLevel}" >
                    <c:out value='</li>${nl}</ul>${nl}' escapeXml="false" />
                </c:forEach>
            </c:if>

            <c:if test="${not startSubMenu}"><c:out value='</li>${nl}' escapeXml="false" /></c:if>

        </c:forEach>

        <mercury:nl />
        </ul><%----%>
        <mercury:nl />
</nav><%----%>
