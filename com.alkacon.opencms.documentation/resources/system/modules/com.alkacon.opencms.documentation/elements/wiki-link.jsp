<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:navigation type="breadCrumb" startLevel="1" endLevel="-1" var="nav" param="true" />
<c:set var="wikiLink"><cms:property name="opencms.documentation.wikilink" file="uri" /></c:set>
<c:if test="${empty wikiLink}">
	<c:forEach items="${nav.items}" var="elem" varStatus="status">
		<c:set var="navText">${elem.navText}</c:set>
		<c:if test="${empty navText or fn:contains(navText, '??? NavText')}">
			<c:set var="navText">${elem.title}</c:set>
		</c:if>
		<c:set var="navText">${fn:replace(navText," ","_")}</c:set>
		<c:set var="wikiLink">${wikiLink}/${navText}</c:set>
	</c:forEach>
</c:if>
<div class="alert alert-info">
	<h3>You can improve this page</h3>
	<div class="row">
		<div class="col-xs-12 col-md-8">
			<p>
				Please contribute your suggestions or comments regarding this topic on our wiki.
				For support questions, please use the <a href="http://www.opencms.org/en/development/mailinglist.html" target="_blank">OpenCms mailing list</a> or go for <a href="http://www.alkacon.com/en/products/support/index.html" target="_blank">professional support</a>.
			</p>
		</div>
		<div class="col-xs-12 col-md-4">
			<p><a class="btn btn-block btn-info" title="Go to the wiki page for this topic." href="http://www.opencms-wiki.org/wiki${wikiLink}" target="_blank">To the wiki</a></p>
		</div>
	</div>
</div>