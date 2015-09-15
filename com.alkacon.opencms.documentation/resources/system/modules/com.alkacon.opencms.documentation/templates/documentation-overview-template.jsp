<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="cms,c,fmt,fn" %>
<%@page import="org.opencms.main.OpenCms" %>
<fmt:setLocale value="${cms.locale}" />

<jsp:useBean id="topicGrabber" class="com.alkacon.opencms.documentation.topics.TopicGrabber">
 <% topicGrabber.init(pageContext, request, response); %>
 </jsp:useBean>
 <c:set var="topic" value="${topicGrabber.topicContent[cms.requestContext.uri]}" />
 
<!DOCTYPE html>
<html lang="en">
<head>
	<title>OpenCms Documentation | <c:out value="${cms.title}"/></title>
	
	<meta charset="${cms.requestContext.encoding}">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<meta name="description" content="${fn:replace(cms:stripHtml(topic.value.Teaser),'\"','')}">
	<meta name="keywords" content="${topic.value.Keywords}">
	<meta name="robots" content="index, follow">
	<meta name="revisit-after" content="7 days">

	<link rel="apple-touch-icon" sizes="120x120" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/images/favicon_120.png:b278b977-ac43-11e4-b80e-f9d322068617)</cms:link>"/>
	<link rel="shortcut icon" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/images/favicon_16.png:b27cb11a-ac43-11e4-b80e-f9d322068617)</cms:link>" type="image/png"/>

	<cms:enable-ade/>
	
	<c:set var="colortheme"><cms:property name="bs.page.color" file="search" default="red" /></c:set>
	<c:set var="pagelayout"><cms:property name="bs.page.layout" file="search" default="9" /></c:set>

	<c:set var="project">${cms.isOnlineProject?"online":"offline"}</c:set>

	<%-- CSS includes --%>
	<cms:include file="/system/modules/com.alkacon.opencms.documentation/elements/default-headincludes-css-${project}.jsp">
		<cms:param name="colortheme" value="red" />
	</cms:include>

	<%-- JavaScript includes --%>
	<cms:include file="/system/modules/com.alkacon.opencms.documentation/elements/default-headincludes-javascript-${project}.jsp" />

	<script type="text/javascript">
		jQuery(document).ready(function() {
			App.init();
		});
	</script>
	<!--[if lt IE 9]>
    	<script src="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/js/respond.js:b9e9ac60-ac44-11e4-b80e-f9d322068617)</cms:link>"></script>
	<![endif]-->
</head>

<c:set var="isEditor">
	<cms:property name="opencms.documentation.editor" file="search" default="false" />
</c:set>

<body data-documentation-editor="${isEditor}">
	<div class="page-wrap">
		<c:if test="${cms.isEditMode}">
			<c:set var="height" value="35px" />
			<c:if test='${not fn:startsWith(cms.systemInfo.versionNumber, "9.")}'>
				<c:set var="height" value="51px" />
			</c:if>
			<!--=== Placeholder for OpenCms toolbar in edit mode ===-->
			<div style="background: lightgray; height: ${height}">&nbsp;</div>
		</c:if>

		<!--=== Header ===-->
		<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/header.jsp:54d313a9-17c6-11e4-a3fa-b7bfd6088c56)" />

		<!--=== Content Part ===-->
		<div class="container-fluid container-main">
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">

					<c:choose>
					<c:when test='<%=OpenCms.getModuleManager().getModule("com.alkacon.opencms.documentation.searchform") != null %>'>
						<cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation.searchform/elements/search.jsp)" />
					</c:when>
					<c:otherwise>
						<cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/search-google.jsp:407a975a-68b6-11e4-9296-005056b61161)" />
					</c:otherwise>
					</c:choose>
					<%-- Menu for view switching (editor vs. user) --%>
					<c:if test="${!cms.isOnlineProject}">
						<cms:container name="documentation-view-switcher-container" type="documentation-view-switcher" maxElements="1">
							<div class="jumbotron">Place the view switcher here.</div>
						</cms:container>
					</c:if>

					<!-- BEGIN: Site Navigation -->
					<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/sitenavigation.jsp:8d667ace-2930-11e4-b03d-d144f6bb3566)" />
					<!-- END: Site Navigation -->

				</div>
				<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12">

					<!-- BEGIN: Topic Container -->
		   		<cms:container name="documentation-topic-container" type="documentation-topic" width="1350" maxElements="1">
						<div class="jumbotron"><h2>Add a topic here!</h2></div>
		   		</cms:container>
			    <!-- END: Topic Container -->

				<!-- Here goes all the documentation topic's content -->
				<cms:container name="documentation-overview-container" type="documentation-overview" width="1350" detailview="true">
						<div class="jumbotron"><h2>Put section contents here.</h2></div>
				</cms:container>
				</div>
			</div>
		</div><!--/container-->		
		<!--=== End Content Part ===-->

		<!--=== Foot ===-->
		<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/footer.jsp:fdb085dd-17d3-11e4-a3fa-b7bfd6088c56)" />
		<!--=== End Foot ===-->

	</div><!--/page-wrap-->
</body>
</html>
