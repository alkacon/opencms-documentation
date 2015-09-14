<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="topicGrabber" class="com.alkacon.opencms.documentation.topics.TopicGrabber">
 <% topicGrabber.init(pageContext, request, response); %>
 </jsp:useBean>

<cms:formatter var="content" val="value" rdfa="rdfa">
<cms:decorate file="/system/modules/com.alkacon.opencms.documentation/decoration/configuration.xml">
<div class="margin-bottom-30">

	<c:if test="${not cms.element.settings.hidetitle}">
		<div><h5 ${rdfa.Title}>${fn:escapeXml(value.Title)}</h5></div>
	</c:if>
	
	<div class="row">
		<c:forEach var="item" items="${content.valueList.Item}">
			<div class="${cms:lookup(fn:length(content.valueList.Item), '1:col-xs-12|2:col-sm-6|3:col-md-4')}">				
				<div>
					<!-- <h4 ${item.rdfa.Headline}>${item.value.Headline}</h4>  -->
					<ul class="topic-row-item">
						<c:forEach var="topicItem" items="${item.valueList.Topic}">
							<c:set var="pageLink" value="${topicItem.value.PageLink}" />
							<c:set var="internal" value="${not empty pageLink.xmlText['link/uuid']}" /> <%-- HACK: Determine internal by present uuid. --%>
							<c:if test="${internal}">
								<c:set var="topic" value="${topicGrabber.topicContent[pageLink]}" />
							</c:if>
							<c:set var="hasTeaser" value="${(cms.element.settings['showteaser']) and ((not topicItem.value.AltTeaser.isEmptyOrWhitespaceOnly) or (internal and (not empty topic) and topic.value.Teaser.isSet))}" />
							<li>
								<div>
									<h6 class="topic-row-item-header">
										<a href="<cms:link>${pageLink}</cms:link>">${topicItem.value.AltHeading.isEmptyOrWhitespaceOnly ? (internal ? fn:escapeXml(cms.vfs.property[pageLink]["Title"]) : pageLink) : fn:escapeXml(topicItem.value.AltHeading)}</a>
									</h6>
								</div>
								<c:if test="${hasTeaser}">
									<div class="topic-row-teaser">
										${topicItem.value.AltTeaser.isEmptyOrWhitespaceOnly ? topic.value.Teaser : topicItem.value.AltTeaser}
									</div>
								</c:if>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:forEach>	
	</div>

</div>
</cms:decorate>

</cms:formatter>
