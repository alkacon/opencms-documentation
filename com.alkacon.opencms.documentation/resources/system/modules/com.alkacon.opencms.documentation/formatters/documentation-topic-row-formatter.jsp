<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div>

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
	</c:if>
	
	<div class="row servive-block">
		<c:forEach var="item" items="${content.valueList.Item}" varStatus="status">
			<div ${item.rdfa.Link} class="${cms:lookup(fn:length(content.valueList.Item), '1:col-xs-12|2:col-sm-6|3:col-sm-4|4:col-md-3 col-sm-6|5:col-md-2 col-sm-6|6:col-md-2 col-sm-4')}">				
				<div class="tag-box tag-box-v2">
					<h4 ${item.rdfa.Headline}>${item.value.Headline}</h4>
					<ul>
					<c:forEach var="topic" items="${item.valueList.Topic}">
						<li>
							<a href="<cms:link>${topic.value.PageLink}</cms:link>">${cms.vfs.property[topic.value.PageLink]["Title"]}</a>
						</li>
					</c:forEach>
					</ul>
				</div>
			</div>
		</c:forEach>	
	</div>

</div>

</cms:formatter>
