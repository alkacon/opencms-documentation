<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content">
	<c:choose>
		<c:when test="${content.value.TypesToCollect.isEmptyOrWhitespaceOnly}">
			<div>Please edit the list and choose the resources you want to collect.</div>
		</c:when>
		<c:otherwise>
			<%-- Get the type of the resources to display --%>
			<c:set var="resType">${fn:substringBefore(content.value.TypesToCollect, ":")}</c:set>
			<%-- Get the path under which the resources should be searched (including subpathes) --%>
			<c:set var="path">${cms.requestContext.siteRoot}/</c:set>
			<%-- Create the configuration for <cms:search> --%>
			<c:set var="searchconfig">
				{
					"ignorequery" : true,
					"extrasolrparams" : "fq=parent-folders:\"${path}\"&fq=type:${resType}a",
					"sortoptions" : [
						{ "label" : "Ascending", "paramvalue" : "asc", "solrvalue" : "lastmodified asc" },
						{ "label" : "Descending", "paramvalue" : "desc", "solrvalue" : "lastmodified desc" }
					  ],
					"pagesize" : 3
				}	
			</c:set>
			<div style="margin-bottom: 20px">
				<div>
					<h2>${content.value.Headline}</h2>
				</div>
				<%-- Perform the search, the result object is stored in the variable "search" --%>
				<cms:search configString="${searchconfig}" var="search"
					addContentInfo="true" />
				<div>
					<%-- Get the sort controller from the search result object --%>
					<c:set var="sortController" value="${search.controller.sorting}" />
					<c:if
						test="${not empty sortController and not empty sortController.config.sortOptions}">
						Sort by date last modified:
						<%-- Render the sort options making heavy use of the sort controller --%>
						<select onchange="window.location.href='<cms:link>${cms.requestContext.uri}</cms:link>?'
											+ this.value">
							<c:forEach var="sortOption"
								items="${sortController.config.sortOptions}">
								<option ${sortController.state.checkSelected[sortOption] ? 
											' selected="selected"' : ""} 
										value="${search.stateParameters.setSortOption[sortOption.paramValue]}">
									${sortOption.label}
								</option>
							</c:forEach>						
						</select>
					</c:if>
				</div>
				<hr />
				<c:choose>
					<c:when test="${search.numFound > 0}">
						<%-- Iterate through the search results and render them via <cms:display> --%>
						<c:forEach var="result" items="${search.searchResults}">
							<cms:display value='${result.xmlContent.filename}'
								displayFormatters="${content.value.TypesToCollect}"
								editable="true" create="true" delete="true" />
								<hr />
						</c:forEach>
					</c:when>
					<c:otherwise>
						<%-- Show an option to create a new content via <cms:edit> --%>
						<cms:edit createType="${resType}" create="true">
							<div>
								Create a new list entry of type ${resType}.						
							</div>
						</cms:edit>
						<hr />
					</c:otherwise>
				</c:choose>
			</div>
		</c:otherwise>
	</c:choose>
</cms:formatter>