<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<div class="margin-bottom-30">
	<% String uri = request.getRequestURI();
	   String name = uri.substring(uri.lastIndexOf("/")+1); %>
    <div class="headline"><h3>File: <%= name %></h3></div>
    <blockquote>
        <p>The Date is <b><%= new java.util.Date() %></b></p>
        <h4>Cache properties: <cms:property name="cache" file="this" default="(caching not set)"/></h4>
        <p><cms:include file="%(link.weak:/system/modules/com.alkacon.opencms.documentation/functions/demo/flex-cache/include-target1.jsp:1429249a-21e7-11e4-9aa0-d9f74955ba1b)"/></p>
    </blockquote>
</div>