<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:navigation type="breadCrumb" startLevel="1" endLevel="-1" var="nav" param="true" />
<c:set var="wikiLink"></c:set>
<c:forEach items="${nav.items}" var="elem" varStatus="status">
	<c:set var="navText">${elem.navText}</c:set>
	<c:if test="${empty navText or fn:contains(navText, '??? NavText')}">
		<c:set var="navText">${elem.title}</c:set>
	</c:if>
	<c:set var="navText">${fn:replace(navText," ","_")}</c:set>
	<c:set var="wikiLink">${wikiLink}/${navText}</c:set>
</c:forEach>
<div class="tag-box tag-box-v4">
    <a type="submit" class="btn btn-block btn-info" title="Go to the wiki page for this topic." href="http://www.opencms-wiki.org/wiki${wikiLink}" target="_blank">Discuss this topic</a>
</div>