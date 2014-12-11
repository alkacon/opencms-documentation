<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="cms,c,fmt,fn" %>

<fmt:setLocale value="${cms.locale}" />

<!DOCTYPE html>

<html lang="en">
<head>
	<title>OpenCms Documentation | ${cms.title}</title>
	
	<meta charset="${cms.requestContext.encoding}">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<meta name="description" content="<cms:property name="Description" file="search" default="" />">
	<meta name="keywords" content="<cms:property name="Keywords" file="search" default="" />">
	<meta name="robots" content="index, follow">
	<meta name="revisit-after" content="7 days">

	<link rel="apple-touch-icon" sizes="120x120" href="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/img/favicon_120.png)</cms:link>"/>
	<link rel="shortcut icon" href="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/img/favicon_16.png)</cms:link>" type="image/png"/>

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
    	<script src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/theme-unify/plugins/respond.js)</cms:link>"></script>
	<![endif]-->
</head>

<c:set var="isEditor">
	<cms:property name="opencms.documentation.editor" file="search" default="false" />
</c:set>

<body data-documentation-editor="${isEditor}">
	<div class="page-wrap">
		<c:if test="${cms.isEditMode}">
			<!--=== Placeholder for OpenCms toolbar in edit mode ===-->
			<div style="background: lightgray; height: 35px">&nbsp;</div>
		</c:if>

	<!--=== Header ===-->
	<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/header.jsp:54d313a9-17c6-11e4-a3fa-b7bfd6088c56)" />

	<!--=== Content Part ===-->
	<div class="container-fluid container-main">
		
				<!-- Here goes all the documentation topic's content -->
				<cms:container name="documentation-search-container" type="documentation-search" width="1350">
						<div class="jumbotron"><h2>Put search results function here.</h2></div>
				</cms:container>
	</div><!--/container-->		
	<!--=== End Content Part ===-->

	<!--=== Foot ===-->
	<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/footer.jsp:fdb085dd-17d3-11e4-a3fa-b7bfd6088c56)" />
	<!--=== End Foot ===-->

	</div><!--/page-wrap-->
</body>
</html>
