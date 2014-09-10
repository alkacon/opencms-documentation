<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<div>
	<% String uri = request.getRequestURI();
	   String name = uri.substring(uri.lastIndexOf("/")+1); %>
    <blockquote>
        <h3 class="headline">File: <%= name %></h3>
        <p>The Date is <b><%= new java.util.Date() %></b></p>
        <h4>Cache properties: <cms:property name="cache" file="this" default="(caching not set)"/></h4>
    </blockquote>
</div>