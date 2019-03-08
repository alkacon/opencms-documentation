<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content">
  <div style="margin-bottom: 20px">
    <div>
      <h2>${content.value.Title}</h2>
    </div>
    <%-- Check, if the list is sufficiently configured. --%>
    <c:choose>
    <c:when test="${empty content.value.TypesToCollect}">
      <h3>Your list is not configured correctly.</h3>
      <p>Please choose at least one display formatter.</p>
    </c:when>
    <c:otherwise>
      <%-- read the page size element setting as wrapper and convert it. --%>
      <c:set var="pageSize">${cms.element.setting.pageSize.toInteger}</c:set>
      <%--
        Perform the search, the result object is stored in the variable "search"
        Note that all configuration is read from the listconfig content.
        We only overwrite part of the configuration setting the page size as it is
        provided in the list's element setting.
      --%>
      <cms:simplesearch configFile="${content.filename}" var="search"
        configString="{pagesize: ${pageSize}}"
        addContentInfo="true" />
      <div>
        <%-- Get the sort controller from the search result object --%>
        <c:set var="sortController" value="${search.controller.sorting}" />
        Sort by:
        <%-- Render the sort options making heavy use of the sort controller --%>
        <select onchange="window.location.href='<cms:link>${cms.requestContext.uri}</cms:link>?'
                  + this.value">
          <c:forEach var="sortOption"
            items="${sortController.config.sortOptions}">
            <option ${sortController.state.checkSelected[sortOption] ?
                  ' selected="selected"' : ""}
                value="${search.stateParameters.setSortOption[sortOption.paramValue]}">
              <%--
              	You might use the option as (part of a) message key for localized labels
              	instead of adding a choice here.
              --%>
              <c:choose>
                <c:when test="${sortOption.label eq 'date.asc'}">Date ascending</c:when>
                <c:when test="${sortOption.label eq 'date.desc'}">Date ascending</c:when>
                <c:when test="${sortOption.label eq 'title.asc'}">Title ascending</c:when>
                <c:when test="${sortOption.label eq 'title.desc'}">Title descending</c:when>
                <c:when test="${sortOption.label eq 'order.asc'}">Order ascending</c:when>
                <c:when test="${sortOption.label eq 'order.desc'}">Order descending</c:when>
              </c:choose>
            </option>
          </c:forEach>
        </select>
      </div>
      <%-- If results are found, display them. Otherwise, show an option to add new contents. --%>
      <c:choose>
        <c:when test="${search.numFound > 0}">
          <%-- Iterate through the search results and render them via <cms:display> --%>
          <c:forEach var="result" items="${search.searchResults}" varStatus="status">

            <cms:display value="${result.fields['id']}"
              displayFormatters="${content.value.TypesToCollect}"
              editable="true"
              create="true"
              delete="true">
              <%--
                We pass all settings from the list to the display formatter.
                Note, that they are available as settings and parameters in the display formatter.
                Hence, we typically access them as "normal" settings in the display formatter's JSP.
              --%>
              <c:forEach var="parameter" items="${cms.element.settings}">
                 <cms:param name="${parameter.key}" value="${parameter.value}" />
              </c:forEach>

              <%-- We provide additional settings for the display formatter. --%>
              <cms:param name="index">${status.index + search.start}</cms:param>
                <cms:param name="showHr">${not status.last}</cms:param>

            </cms:display>

          </c:forEach>

          <%-- This is a simple example for a pagination using the pagination controller. --%>
          <c:set var="pagination" value="${search.controller.pagination}" />
          <!-- show pagination if it should be given and if it's really necessary -->
          <c:if test="${not empty pagination && search.numPages > 1}">
            <ul class="pagination">
              <li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
                <c:set var="params">${search.stateParameters.setPage['1']}</c:set>
                <a href="<cms:link>${cms.requestContext.uri}?${params}</cms:link>">
                  <span aria-hidden="true">First</span>
                </a>
              </li>
              <c:set var="previousPage">${pagination.state.currentPage > 1
                ? pagination.state.currentPage - 1 : 1}</c:set>
              <li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
                <c:set var="params">${search.stateParameters.setPage[previousPage]}</c:set>
                <a href="<cms:link>${cms.requestContext.uri}?${params}</cms:link>">
                  <span aria-hidden="true">Previous</span>
                </a>
              </li>
              <c:forEach var="i" begin="${search.pageNavFirst}"
                     end="${search.pageNavLast}">
                <c:set var="is">${i}</c:set>
                <li ${pagination.state.currentPage eq i ? "class='active'" : ""}>
                  <c:set var="params">${search.stateParameters.setPage[is]}</c:set>
                  <a href="<cms:link>${cms.requestContext.uri}?${params}</cms:link>">
                    ${is}
                  </a>
                </li>
              </c:forEach>
              <c:set var="pages">${search.numPages}</c:set>
              <c:set var="next">${pagination.state.currentPage < search.numPages ?
                pagination.state.currentPage + 1 : pagination.state.currentPage}</c:set>
              <li ${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
                <c:set var="params">${search.stateParameters.setPage[next]}</c:set>
                <a href="<cms:link>${cms.requestContext.uri}?${params}</cms:link>">
                  <span aria-hidden="true">Next</span>
                </a>
              </li>
              <%-- We do not place a link to the last page, since this is typically not needed.
                Moreover, there might be more results than are returned at most, depending on your
                search configuration. By default at most 400 results are returned.
               --%>
            </ul>
          </c:if>
        </c:when>
        <c:otherwise>
          <%-- Show an option to create a new content via <cms:edit> --%>
          <c:if test="${cms.isEditMode}">
            <%-- We could display resources of more than one type in the list. --%>
            <c:forEach var="type" items="${content.valueList.TypesToCollect}">
              <%--
                TypesToCollect uses the schema type OpenCmsDisplayFormatter where values are stored
                 in format "{type name:display formatter id}"
              --%>
              <c:set var="createType">${fn:substringBefore(type.stringValue, ':')}</c:set>
              <cms:edit createType="${createType}" create="true">
                <div>
                  Create a new list entry of type ${createType}.
                </div>
              </cms:edit>
            </c:forEach>
          </c:if>
        </c:otherwise>
      </c:choose>
    </c:otherwise>
    </c:choose>
  </div>
</cms:formatter>
