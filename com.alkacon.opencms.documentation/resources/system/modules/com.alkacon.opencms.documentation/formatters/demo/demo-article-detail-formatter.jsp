<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<cms:formatter var="content" val="value">
<div class="margin-bottom-30">
    <%-- Title of the article --%>
    <div class="headline"><h3>${value.Title}</h3></div>
    <%-- The text field of the article with image --%>
    <div class="paragraph">
	    <c:set var="showing" value="false" />
        <c:if test="${value.Image.isSet}">
            <c:set var="showing" value="true" />
			<cms:img src="${value.Image}" width="1000" height="100" scaleType="2" noDim="true" cssclass="img-responsive" />
        </c:if>
        ${value.Text}
    </div>
</div>
</cms:formatter>