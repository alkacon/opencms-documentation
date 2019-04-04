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

<fmt:setLocale value="${cms.locale}" />

<c:set var="templateType">
    <cms:property name="opencms.documentation.template.type" file="search" default="default" />
</c:set>

<c:choose>
<c:when test="${templateType eq 'overview'}">
	<c:set var="containerName" value="overview" />
	<c:set var="isOverview" value="${true}" />
</c:when>
<c:when test="${templateType eq 'search'}">
	<c:set var="containerName" value="search" />
	<c:set var="isSearch" value="${true}" />
</c:when>
<c:otherwise>
	<c:if test="${templateType eq 'tools'}">
		<c:set var="isTools" value="${true}" />
	</c:if>
	<jsp:useBean id="sectionIndexer" class="com.alkacon.opencms.documentation.sectionindexer.SectionIndexer" scope="request" />
	<c:set var="containerName" value="content" />
</c:otherwise>
</c:choose>

<c:set var="isEditor">
    <cms:property name="opencms.documentation.editor" file="search" default="false" />
</c:set>
<c:set var="cmsstatus">${cms.isEditMode ? 'opencms-page-editor ' : ''}${cms.isEditMode and cms.modelGroupPage ? 'opencms-group-editor ' : ''}</c:set>

<!DOCTYPE html>
<html lang="${cms.locale}" class="noscript ${cmsstatus}">

<head>
	<noscript>
	    <style>html.noscript .hide-noscript { display: none; }</style>
	</noscript>

    <c:set var="jsThemeRes" value="${cms.vfs.readResource['%(link.weak:/system/modules/alkacon.mercury.theme/js/mercury.js:2cf5d884-fea8-11e8-aee0-0242ac11002b)']}" />
    <%-- This has to be loaded as early as possible. --%>
	<script src="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/js/anchor.min.js:eb29ba9d-4a45-11e9-b182-0242ac11002b)</cms:link>"></script>
	<script>
	document.addEventListener("DOMContentLoaded", function(event) {
		anchors.add('.anchored');
	});

	mercury=function(){var n=function(){var n=[];return{ready:function(t){n.push(t)},load:function(t){n.push(t)},getInitFunctions:function(){return n}}}(),t=function(t){if("function"!=typeof t)return n;n.ready(t)};return t.getInitFunctions=function(){return n.getInitFunctions()},t.load=function(n){this(n)},t.ready=function(n){this(n)},t}();
	var __isOnline=${cms.isOnlineProject},
	__scriptPath="<cms:link>%(link.weak:/system/modules/alkacon.mercury.theme/js/mercury.js:2cf5d884-fea8-11e8-aee0-0242ac11002b)</cms:link>"
	</script>
	<script async src="<cms:link>${jsThemeRes.sitePath}?ver=${jsThemeRes.dateLastModified}</cms:link>"></script>
	<script async src="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/js/documentation.js:93c9d506-17cd-11e4-a3fa-b7bfd6088c56)</cms:link>"></script>
	<c:if test="${not cms.isOnlineProject}">
		<script async src="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/js/documentation-offline.js:ef5ad321-23bf-11e4-a9de-49dbf0abad32)</cms:link>"></script>
	</c:if>

	<mercury:meta-info/>

	<link rel="apple-touch-icon" sizes="120x120" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/images/favicon_120.png:b278b977-ac43-11e4-b80e-f9d322068617)</cms:link>"/>
	<link rel="icon" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/images/favicon_16.png:b27cb11a-ac43-11e4-b80e-f9d322068617)</cms:link>" type="image/png"/>

	<cms:enable-ade />

	<cms:headincludes type="css" />

	<c:set var="cssTheme"><cms:property name="template.theme" file="search" default="%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/css/theme-documentation-default.min.css:bcc84b17-4fc7-11e9-8a3e-0242ac11002b)" /></c:set>
	<c:set var="cssCommonRes" value="${cms.vfs.readResource['%(link.weak:/system/modules/alkacon.mercury.theme/css/base.min.css:bf8f6ace-feab-11e8-aee0-0242ac11002b)']}" />
	<c:set var="cssThemeRes" value="${cms.vfs.readResource[cssTheme]}" />
	<link rel="stylesheet" href="<cms:link>${cssCommonRes.sitePath}?ver=${cssCommonRes.dateLastModified}</cms:link>">
	<link rel="stylesheet" href="<cms:link>${cssThemeRes.sitePath}?ver=${cssThemeRes.dateLastModified}</cms:link>">

</head>

<body data-documentation-editor="${isEditor}">
	<!--=== Header ===-->
	<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/header.jsp:54d313a9-17c6-11e4-a3fa-b7bfd6088c56)" />

	<!--=== Content Part ===-->
	<main class="container-fluid container-main">
		<c:choose>
		<c:when test="${isSearch}">
			<cms:container name="documentation-search-container" type="documentation-search" width="1350">
					<div class="jumbotron"><h2>Put search results function here.</h2></div>
			</cms:container>
		</c:when>
		<c:otherwise>
			<div class="row">
				<aside class="col-lg-3 hidden-md hidden-sm hidden-xs">
						<cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/search.jsp:913527e3-811a-11e4-8c93-bfc0090a1084)" />
					<%-- Menu for view switching (editor vs. user) --%>
					<c:if test="${!cms.isOnlineProject}">
						<cms:container name="documentation-view-switcher-container" type="documentation-view-switcher" maxElements="1">
							<div class="jumbotron">Place the view switcher here.</div>
						</cms:container>
					</c:if>

					<!-- BEGIN: Site Navigation -->
					<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/sitenavigation.jsp:8d667ace-2930-11e4-b03d-d144f6bb3566)">
						<cms:param name="resource">${isTools ? "documentation-editor-tools" : "opencms-documentation"}</cms:param>
					</cms:include>
					<!-- END: Site Navigation -->

				</aside>
				<div class="col-lg-9">
					<h1>${cms.title}</h1>
					<c:if test="${not isTools}">
						<!-- BEGIN: Topic Container -->
				   		<cms:container name="documentation-topic-container" type="documentation-topic" width="1350" maxElements="1">
								<div class="jumbotron"><h2>Add a topic here!</h2></div>
				   		</cms:container>
				    <!-- END: Topic Container -->
			   		</c:if>

					<c:if test="${not empty sectionIndexer}">
						<!-- BEGIN: Page Navigation -->
						<cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/pagenavigation.jsp:d4a5195a-05d5-11e4-a74d-1305b26fecac)" />
						<!-- END: Page Navigation -->
					</c:if>

					<!-- Here goes all the documentation topic's content -->
					<cms:container name="documentation-${containerName}-container" type="documentation-${containerName}" width="1350" detailview="true">
							<div class="jumbotron"><h2>${isOverview ? 'Put overview rows here.' : 'Put section contents here.'}</h2></div>
					</cms:container>

					<!-- Link to wiki for comments and suggestions plus hint to mailing list -->
					<cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/wiki-link.jsp:74887459-814e-11e5-93bb-0242ac11002b)" />

				</div>
			</div>
		</c:otherwise>
		</c:choose>
	</main><!--/container-->
	<!--=== End Content Part ===-->

	<!--=== Foot ===-->
	<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/footer.jsp:fdb085dd-17d3-11e4-a3fa-b7bfd6088c56)" />
	<!--=== End Foot ===-->

	<%-- Page information transfers OpenCms state information to JavaScript --%>
	<mercury:pageinfo />

	<%-- JavaScript blocking files placed at the end of the document so the pages load faster --%>
	<cms:headincludes type="javascript" />

	<%-- Privacy policy markup is inserted last --%>
	<mercury:privacy-policy-banner />

</body>
</html>