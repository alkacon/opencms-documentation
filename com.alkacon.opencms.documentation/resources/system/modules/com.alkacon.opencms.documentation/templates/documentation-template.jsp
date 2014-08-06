<%@page import="org.opencms.xml.containerpage.CmsContainerElementBean
			   ,org.opencms.jsp.util.CmsJspStandardContextBean
			   ,org.opencms.jsp.util.CmsJspContentAccessBean
			   ,org.opencms.xml.containerpage.CmsContainerPageBean
			   ,org.opencms.xml.containerpage.CmsContainerBean
			   ,org.opencms.file.CmsResource" %>
<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %><%--
--%><%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %><%--
--%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %><%--
--%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%--
--%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%--
--%><fmt:setLocale value="${cms.locale}" />
<jsp:useBean id="sectionIndexer" class="com.alkacon.opencms.documentation.sectionindexer.SectionIndexer" scope="request" />
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

	<link rel="apple-touch-icon" sizes="120x120" href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/img/favicon_120.png</cms:link>"/>
	<link rel="shortcut icon" href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/img/favicon_16.png</cms:link>" type="image/png"/>

	<cms:enable-ade/>
	
	<%-- CSS includes --%>
	<c:choose>
	<c:when test="${cms.isOnlineProject}">
		<cms:headincludes type="css" closetags="false" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/css/bootstrap.min.css:a383301a-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/responsive.css:0f8c217f-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/style.css:0f8fcb02-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.css:1264956e-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/font-awesome/css/font-awesome.css:127bc6fe-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/headers/header1.css:0f415ca7-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/search.css:2e634695-0cb8-11e2-b19e-2b1b08a6835d)" />
	</c:when>
	<c:otherwise>
		<cms:headincludes type="css" closetags="false" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/css/bootstrap.css:a37af2b8-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/responsive.css:0f8c217f-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/style.css:0f8fcb02-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.css:1264956e-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/font-awesome/css/font-awesome.css:127bc6fe-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/headers/header1.css:0f415ca7-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/search.css:2e634695-0cb8-11e2-b19e-2b1b08a6835d)" />
	</c:otherwise>
	</c:choose>
			
	<c:set var="colortheme"><cms:property name="bs.page.color" file="search" default="red" /></c:set>
	<c:set var="pagelayout"><cms:property name="bs.page.layout" file="search" default="9" /></c:set>
	<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/themes/${colortheme}.css</cms:link>">
	<link rel="stylesheet" href="<cms:link>/system/modules/com.alkacon.bootstrap.formatters/resources/css/themes/headers/header1-${colortheme}.css</cms:link>">
	<link rel="stylesheet" href="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/css/page.css:52f716c6-20f8-11e3-b4d8-000c297c001d)</cms:link>">
	<link rel="stylesheet" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/stylesheets/page-extra.css:406f322d-0cf4-11e4-a7cb-b7bfd6088c56)</cms:link>">
	<link rel="stylesheet" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/stylesheets/app-extra.css:442a2c72-0cf6-11e4-a7cb-b7bfd6088c56)</cms:link>">

	<link rel="stylesheet" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/stylesheets/documentation.css:9a48a74e-010e-11e4-aa3f-1305b26fecac)</cms:link>">

	<%-- JavaScript includes --%>
	<c:choose>
	<c:when test="${cms.isOnlineProject}">
		<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/hover-dropdown.min.js:1903fd25-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-1.10.2.min.js:0d41801c-8834-11e3-8675-3b52e9337fb8)
		    |%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-migrate-1.2.1.min.js:4986e200-8834-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/js/bootstrap.min.js:a35b35b0-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.js:12686601-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/back-to-top.js:1908df28-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/js/app.js:11fe5a44-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/js/app-extra.js:05df8f47-0cf7-11e4-a7cb-b7bfd6088c56)" />
	</c:when>
	<c:otherwise>
		<cms:headincludes type="javascript" defaults="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/hover-dropdown.min.js:1903fd25-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-1.10.2.js:127808be-8834-11e3-8675-3b52e9337fb8)
		    |%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/jquery/jquery-migrate-1.2.1.min.js:4986e200-8834-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.basics/resources/bootstrap/js/bootstrap.min.js:a35b35b0-8833-11e3-8675-3b52e9337fb8)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/bxslider/jquery.bxslider.js:12686601-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/back-to-top.js:1908df28-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/js/app.js:11fe5a44-3a3b-11e3-a584-000c2943a707)
			|%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/js/app-extra.js:05df8f47-0cf7-11e4-a7cb-b7bfd6088c56)" />
	</c:otherwise>
	</c:choose>

	<script type="text/javascript" src="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.documentation/resources/js/documentation.js:93c9d506-17cd-11e4-a3fa-b7bfd6088c56)</cms:link>"></script>
		
	<script type="text/javascript">
		jQuery(document).ready(function() {
			App.init();
		});
	</script>
	<!--[if lt IE 9]>
    	<script src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/resources/plugins/respond.js:192037c7-3a3b-11e3-a584-000c2943a707)</cms:link>"></script>
	<![endif]-->
	<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/search/config.jsp:b4a9ffc9-416c-11e3-81ba-000c297c001d)" />	
</head>
<body>
<%	CmsJspStandardContextBean cmsBean = CmsJspStandardContextBean.getInstance(request);
	CmsContainerPageBean containerpage = cmsBean.getPage();
	//check if a topic is placed in the documentation-topic-container
	CmsContainerBean container = containerpage.getContainers().get("documentation-topic-container");
	CmsJspContentAccessBean topicContent = null;
	if (container != null) {
		CmsContainerElementBean topicElement = container.getElements().isEmpty() ? null : container.getElements().get(0);
		if (topicElement != null) {
			topicElement.initResource(cmsBean.getVfs().getCmsObject());
			CmsResource topicResource = topicElement.getResource();
			if (topicResource != null) topicContent = new CmsJspContentAccessBean(cmsBean.getVfs().getCmsObject(), topicResource);
		}
	}
	pageContext.setAttribute("topicContent", topicContent);
%>
<div class="page-wrap">
<c:if test="${cms.isEditMode}">
<!--=== Placeholder for OpenCms toolbar in edit mode ===-->
<div style="background: lightgray; height: 35px">&nbsp;</div>
</c:if>

<!--=== Header ===-->
<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/header.jsp:54d313a9-17c6-11e4-a3fa-b7bfd6088c56)" />

<!--=== Content Part ===-->
<div class="container">
	<div class="row">
		<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12">
		
			<!-- BEGIN: Site Navigation -->
			<cms:include file="%(link.strong:/system/modules/com.alkacon.opencms.documentation/elements/sitenavigation.jsp:9907934b-1d35-11e4-a450-d9f74955ba1b)" />
			<!-- END: Site Navigation -->
				
		</div>
		<div class="col-lg-9 col-md-9 col-sm-3 col-xs-12">
			
			<!-- BEGIN: Topic Container -->
			<c:if test="${not cms.isOnlineProject}">
				<c:if test="${empty topicContent}">
					<div class="alert alert-danger">Please add a topic in the container below.</div>
		    	</c:if>
		    </c:if>
	   		<cms:container name="documentation-topic-container" type="documentation-topic" width="1200" maxElements="1" />
		    <!-- END: Topic Container -->

			<!-- BEGIN: Page Navigation -->
			<cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/pagenavigation.jsp:d4a5195a-05d5-11e4-a74d-1305b26fecac)" />
			<!-- END: Page Navigation -->

			<!-- Here goes all the documentation topic's content -->
			<cms:container name="documentation-content-container" type="documentation-content" width="1200" />
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
