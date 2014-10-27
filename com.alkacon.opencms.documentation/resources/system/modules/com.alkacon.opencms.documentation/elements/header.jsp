<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="cms" %>
<!--=== Header ===-->

<!--=== Top ===-->
<div class="topbar">

    <div class="container-fluid container-main">
        <ul class="loginbar pull-right">
            <li><a href="/opencms/opencms/">Welcome</a></li>
            <li class="topbar-devider"></li>
            <li><a href="/opencms/opencms/tutorial/">Tutorial</a></li>
            <li class="topbar-devider"></li>
            <li><a href="/opencms/opencms/release/">Release notes</a></li>
            <li class="topbar-devider"></li>
            <li><a href="/opencms/opencms/grid-demo/search-demo/">Search</a></li>
            <li class="topbar-devider"></li>
            <li><a href="/opencms/opencms/login/">Login</a></li>
		</ul>
    </div> 

</div><!--/top-->
<!--=== End Top ===-->

<div class="header">
	<div class="navbar navbar-default" role="navigation">
        <div class="container-fluid container-main">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<cms:link>http://www.opencms.org</cms:link>">
                    <cms:img scaleType="2" scaleColor="transparent" height="40" id="logo-header" src="%(link.weak:/system/modules/com.alkacon.opencms.documentation/images/OpenCms_Logo_800_transparent_24bit.png:f43050fa-17c9-11e4-a3fa-b7bfd6088c56)" alt="OpenCms Logo"/>
                </a>
            </div>
			<!-- Menu -->       
			<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-main.jsp:f6dcd82c-1a24-11e3-9358-000c29f9a2ec)">
				<cms:param name="startlevel">0</cms:param>
			</cms:include>
		</div><!-- /container -->
	</div><!-- /navbar -->
</div><!--/header -->
<!--=== End Header ===-->

<!--=== Breadcrumbs ===-->
<div class="breadcrumbs margin-bottom-30">
	<div class="container-fluid container-main">
        <h1 class="pull-left"><cms:info property="opencms.title" /></h1>
        <cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/elements/nav-breadcrumb.jsp:6f6f2ea3-1bb3-11e3-a120-000c29f9a2ec)">
			<cms:param name="startlevel">0</cms:param>
		</cms:include>
    </div><!--/container-->
</div><!--/breadcrumbs-->
<!--=== End Breadcrumbs ===-->
