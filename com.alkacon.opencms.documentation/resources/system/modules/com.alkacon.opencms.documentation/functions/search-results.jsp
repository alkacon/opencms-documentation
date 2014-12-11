<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="org.opencms.search.*
	,org.opencms.search.solr.*
	,org.opencms.main.OpenCms
	,org.opencms.file.CmsObject
	,org.apache.solr.client.solrj.response.FacetField
	,org.apache.solr.client.solrj.response.FacetField.Count" %>

<c:set var="cmsObject" value="${cms.vfs.cmsObject}" />
<%
CmsObject cmsObject = (CmsObject) pageContext.getAttribute("cmsObject");
CmsSolrIndex index = OpenCms.getSearchManager().getIndexSolr("Solr Offline");
String query = request.getParameter("query").trim();
if (query == null || query.equals("")) {
	query = "*:*";
}
String squery = "q=" + query 
	+ "&fq=parent-folders:\"/sites/default/\""
	+ "&fq=type:containerpage"
	+ "&facet=true"
	+ "&facet.field=newInVersion_en"
	;
CmsSolrResultList results = index.search(cmsObject, squery);
%>
<div>
	<div class="row">
		<!-- Search slot and facets -->
		<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
			<form role="form" class="form-horizontal" action="<cms:link>${cms.requestContext.uri}</cms:link>">
				<div class="input-group">
					<input name="query" class="form-control" type="text" autocomplete="off" placeholder="Enter query" value="${param.query}" />
						<span class="input-group-btn">
							<button class="btn btn-primary" type="submit">
								Go
							</button>
						</span>
				</div>
			</form>
		</div>
		<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
			<h2>TODO: search options</h2>
		</div>
	</div>
	<div class="row">
		<!-- Facets -->
		<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
			<% FacetField facetNewInVersion = results.getFacetField("newInVersion_en"); %>
			<c:if test="<%=facetNewInVersion.getValues().size() > 0%>">
				<div class="panel panel-default">
					<div class="panel-heading">New in version</div>
					<div class="panel-body">
						<% 	for (Count count : facetNewInVersion.getValues()) { %>
							<div><%=count.getName()%> (<%=count.getCount()%>)</div>
						<%	} %>
					</div>
				</div>
			</c:if>
		</div>
		<!-- Search results -->
		<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
			<h2>
				Search results
			</h2>
			<hr />
			<%for (CmsSearchResource result : results) { %>
				<div><a href='<cms:link><%=result.getField("path")%></cms:link>'><%=result.getField("Title_prop")%></a></div>
				<hr />
			<% } %>
		</div>
	</div>
</div>