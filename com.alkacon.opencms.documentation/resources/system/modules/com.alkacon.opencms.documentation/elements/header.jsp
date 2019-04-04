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

        <mercury:nl />
        <header class="area-header logo-left"><%----%>
            <mercury:nl />

            <input type="checkbox" id="nav-toggle-check"><%-- Must be here so it works even when JavaScript is disabled --%>
            <div id="nav-toggle-group"><%----%>
                <label for="nav-toggle-check" id="nav-toggle-label"><%----%>
                    <span class="nav-toggle"><%----%>
                        <span><fmt:message key="msg.page.navigation.toggle" /></span><%----%>
                    </span><%----%>
                </label><%----%>
                <div class="head-overlay"></div><%----%>
            </div><%----%>
            <mercury:nl />

            <div class="header-group sticky csssetting"><%----%>
                <div class="head notfixed"><%----%>

                    <mercury:nl />
                    <div class="container-fluid"><%----%>
                        <div class="row"><%----%>
                            <div class="col col-head-logo">
								<mercury:link link="/" css="imglink">
								    <mercury:image-simple  image="%(link.weak:/system/modules/com.alkacon.opencms.documentation/images/opencms_logo.svg:348222e4-5217-11e9-98ba-0242ac11002b)" title="The Alkacon OpenCms homepage"/>
								</mercury:link>
							</div>

                            <div class="col col-head-info"><%----%>

                                <mercury:heading level="${7}" ade="false" text="OpenCms Documentation" css="header-title hidden-fixed" />
								<div class="nav-main-container">
									<cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/nav-main.jsp:b9188568-521a-11e9-98ba-0242ac11002b)"/>
								</div>
                            </div><%----%>
                            <mercury:nl />

                        </div><%----%>
                    </div><%----%>
                    <mercury:nl />

                </div><%----%>
            </div><%----%>
            <mercury:nl />

            <div class="breadcrumbs-bg">
            	<cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/elements/nav-breadcrumb.jsp:90ca36ae-68b8-11e4-9296-005056b61161)"/>
            </div>
            <mercury:nl />

        </header><%----%>