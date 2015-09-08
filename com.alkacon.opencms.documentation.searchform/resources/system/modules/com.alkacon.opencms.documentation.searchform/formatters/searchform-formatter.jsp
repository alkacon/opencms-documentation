<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- The import is only necessary to avoid highlighting snippets that destoy the HTML structure --%>
<%@ page import="org.opencms.util.CmsHtmlConverter"%>
<c:choose>
<c:when test="${cms.element.inMemoryOnly}">
	<div>	
		<h2>
			The content is not yet persisted. Please edit it.
		</h2>
	</div>
</c:when>
<c:when test="${cms.edited}">
	<div>
		<h2>
			The content has been edited.
		</h2>
		<p>
			The page will automatically reload.
			${cms.enableReload}
		</p>
	</div>
</c:when>
<c:otherwise>
<jsp:useBean id="versionConverter" class="com.alkacon.opencms.documentation.search.CmsVersionNumberConverterBean" />
<cms:formatter var="content">
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.opencms.documentation.topic">
<cms:search var="searchform"
	configFile="${content.filename}">
	<c:set var="controllers" value="${searchform.controller}" />
	<c:set var="common" value="${controllers.common}" />
	<div>
		<!-- Search slot and facets -->
		<form id="documentation-search-form" role="form" class="form-horizontal"
			action="<cms:link>${cms.requestContext.uri}</cms:link>">
			<c:set var="escapedQuery">${fn:replace(common.state.query,'"','&quot;')}</c:set>			
			<input type="hidden" name="${common.config.lastQueryParam}" value="${escapedQuery}" />
			<div class="row">
				<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
					<div class="input-group">
						<input name="${common.config.queryParam}" class="form-control"
							type="text" autocomplete="off" placeholder="Enter query"
							value="${escapedQuery}" /> <span class="input-group-btn">
							<button class="btn btn-primary" type="submit">Go</button>
						</span>
					</div>
				</div>
				<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
					<div class="input-group">
						<c:set var="sort" value="${controllers.sorting}" />
						<select name="${sort.config.sortParam}" class="form-control">
							<c:forEach var="option" items="${sort.config.sortOptions}">
								<option value="${option.paramValue}"
									${sort.state.checkSelected[option]?"selected":""}>${option.label}</option>
							</c:forEach>
						</select> <span class="input-group-btn">
							<button class="btn btn-primary" type="submit">Sort</button>
						</span>
					</div>
				</div>
			</div>
			<div class="row" style="margin-top: 20px;">
				<!-- Facets -->
				<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
					<c:set var="fieldFacetControllers"
						value="${controllers.fieldFacets.fieldFacetControllers}" />
					<c:forEach var="controller" items="${fieldFacetControllers}">
						<c:set var="facet" value="${searchform.fieldFacet[controller.config.name]}"/>
						<c:set var="valueCount" value="${cms:getListSize(facet.values)}"/>
						<c:if test=
							'${valueCount > 2 
							|| (facet.name != "newInVersion_en_l" || valueCount > 1 && facet.values[0].name != "0")
								&& (valueCount > 1 || (facet.name != "removedInVersion_en_l" || valueCount > 0 && facet.values[0].name != "0"))
								&& valueCount > 0}' >
							<div class="panel panel-default">
								<div class="panel-heading">${controller.config.label}</div>
								<div class="panel-body">
								<c:choose>
								<c:when test='${facet.name eq "newInVersion_en_l"}'>
									<c:set var="count" value="${facet.values[valueCount-1].count}" />
									<c:set var="end" value="${valueCount - 2}" />								
									<c:if test="${end >= 0}">
										<c:forEach var="i" begin="0" end="${end}" step="1" >
											<c:set var="facetItem" value="${facet.values[end-i]}"/>
											<c:if test='${facetItem.name != "0" }'>
												<div class="checkbox">
													<label> <input type="checkbox"
														name="${controller.config.paramKey}"
														value="${facetItem.name}"
														onclick="submitDocumentationForm()"
														${controller.state.isChecked[facetItem.name]?"checked":""} />
														${versionConverter.decode[facetItem.name]} (${count})
													</label>
												</div>
												<c:set var="count" value="${count + facetItem.count}" />
											</c:if>
										</c:forEach>
									</c:if>
								</c:when>
								<c:when test='${facet.name eq "removedInVersion_en_l"}'>
									<c:set var="count" value="0" />
									<c:set var="end" value="${valueCount-1}" />
									<c:forEach var="i" begin="0" end="${end}" step="1" >
										<c:set var="facetItem" value="${facet.values[end-i]}"/>
										<c:if test='${facetItem.name != "0" }'>
											<c:set var="count" value="${count + facetItem.count}" />
											<div class="checkbox">
												<label> <input type="checkbox"
													name="${controller.config.paramKey}"
													value="${facetItem.name}"
													onclick="submitDocumentationForm()"
													${controller.state.isChecked[facetItem.name]?"checked":""} />
													${versionConverter.decode[facetItem.name]} (${count})
												</label>
											</div>
										</c:if>
									</c:forEach>
								</c:when>
								<c:when test='${facet.name eq "interestingFor_en_cs"}'>
									<c:forEach var="facetItem" items="${facet.values}">
										<div class="checkbox">
											<label> <input type="checkbox"
												name="${controller.config.paramKey}"
												value="${facetItem.name}"
												onclick="submitDocumentationForm()"
												${controller.state.isChecked[facetItem.name]?"checked":""} />
												<fmt:message key="select.role.${facetItem.name}" /> (${facetItem.count})
											</label>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<c:forEach var="facetItem" items="${facet.values}">
										<div class="checkbox">
											<label> <input type="checkbox"
												name="${controller.config.paramKey}"
												value="${facetItem.name}"
												onclick="submitDocumentationForm()"
												${controller.state.isChecked[facetItem.name]?"checked":""} />
												${facetItem.name} (${facetItem.count})
											</label>
										</div>
									</c:forEach>
								</c:otherwise>
								</c:choose>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<!-- Search results -->
				<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
					<c:choose>
					<c:when test="${cms:getListSize(searchform.searchResults) > 0}">
						<h2>
							Search results <small>Results ${searchform.start} to
								${searchform.end} from ${searchform.numFound} (max. Score:
								${searchform.maxScore})</small>
						</h2>
						<hr />
						<c:forEach var="searchResult" items="${searchform.searchResults}">
							<div>
								<a href='<cms:link>${searchResult.fields["path"]}</cms:link>'>${searchResult.fields["Title_prop"]}</a>
								<p> <em>...</em>
									${fn:replace(fn:replace(fn:escapeXml(searchform.highlighting[searchResult.fields["id"]]["content_en"][0]),"@+@","<b>"),"@-@","</b>")}
									<em>...</em>
								</p>
							</div>
							<hr />
						</c:forEach>
						<c:if test="${searchform.numPages > 1}">
							<c:set var="pagination" value="${controllers.pagination}" />	
							<ul class="pagination">
								<li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}><a
									href="<cms:link>${cms.requestContext.uri}?${searchform.stateParameters.setPage['1']}</cms:link>"
									aria-label="First"><span aria-hidden="true">First</span></a></li>
								<c:set var="previousPage">${pagination.state.currentPage > 1 ? pagination.state.currentPage - 1 : 1}</c:set>
								<li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}><a
									href="<cms:link>${cms.requestContext.uri}?${searchform.stateParameters.setPage[previousPage]}</cms:link>"
									aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
								<c:forEach var="i" begin="${searchform.pageNavFirst}"
									end="${searchform.pageNavLast}">
									<c:set var="is">${i}</c:set>
									<li ${pagination.state.currentPage eq i ? "class='active'" : ""}><a
										href="<cms:link>${cms.requestContext.uri}?${searchform.stateParameters.setPage[is]}</cms:link>">${is}</a></li>
								</c:forEach>
								<c:set var="pages">${searchform.numPages}</c:set>
								<c:set var="next">${pagination.state.currentPage < searchform.numPages ? pagination.state.currentPage + 1 : pagination.state.currentPage}</c:set>
								<li
									${pagination.state.currentPage >= searchform.numPages ? "class='disabled'" : ""}><a
									aria-label="Next"
									href="<cms:link>${cms.requestContext.uri}?${searchform.stateParameters.setPage[next]}</cms:link>"><span
										aria-hidden="true">&raquo;</span></a>
								<li
									${pagination.state.currentPage >= searchform.numPages ? "class='disabled'" : ""}><a
									aria-label="Last"
									href="<cms:link>${cms.requestContext.uri}?${searchform.stateParameters.setPage[pages]}</cms:link>"><span
										aria-hidden="true">Last</span></a>
							</ul>
						</c:if>
					</c:when>
					<c:otherwise>
						<h2>
							<c:choose>
							<c:when test="${controllers.didYouMean.config.isEnabled && not empty searchform.didYouMean}" >
								Did you mean <a href='<cms:link>${cms.requestContext.uri}?${searchform.stateParameters.queryDidYouMean}</cms:link>'>${searchform.didYouMean}</a>?
							</c:when>
							<c:otherwise>
								No results found.
							</c:otherwise>
							</c:choose>
						</h2>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		</form>
		<script type="text/javascript">
			documentationSearchForm = document.forms["documentation-search-form"];
			function submitDocumentationForm() {
				documentationSearchForm.submit();
			}
		</script>
	</div>
</cms:search>
</cms:bundle>
</cms:formatter>
</c:otherwise>
</c:choose>