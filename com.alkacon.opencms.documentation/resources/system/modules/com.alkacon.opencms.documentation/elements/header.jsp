<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="cms,c" %>
<!--=== Header ===-->

<!--=== Top ===-->
<div class="topbar">

    <div class="container-fluid container-main">
        
    </div> 

</div><!--/top-->
<!--=== End Top ===-->

<div class="header">
	<div class="navbar navbar-default" role="navigation">
        <div class="container-fluid container-main">
        	<div class="headline">
                <a href="<cms:link>http://www.opencms.org</cms:link>" title="OpenCms homepage">
					<span class="docu-logo logo-opencms"></span>
                </a>
				<h1 class="pull-right">OpenCms Documentation</h1>
			</div>       
		</div><!-- /container -->
	</div><!-- /navbar -->
</div><!--/header -->
<!--=== End Header ===-->

<!--=== Breadcrumbs ===-->
<div class="breadcrumbs margin-bottom-30">
	<div class="container-fluid container-main">
        <h1 class="pull-left">
        	<c:out value="${cms.title}" />
        	<c:if test="${cms.isEditMode}">
            	<span class="badge superscript">${cms.requestContext.currentUser.name}</span>
            </c:if>
        </h1>
        <cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/nav-breadcrumb.jsp:90ca36ae-68b8-11e4-9296-005056b61161)">
			<cms:param name="startlevel">0</cms:param>
		</cms:include>
    </div><!--/container-->
</div><!--/breadcrumbs-->
<!--=== End Breadcrumbs ===-->
