<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:useBean id="topicGrabber" class="com.alkacon.opencms.documentation.topics.TopicGrabber">
 <% topicGrabber.init(pageContext, request, response); %>
 </jsp:useBean>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div>

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
	</c:if>
	
	<div class="row servive-block servive-block-documentation">
		<c:forEach var="item" items="${content.valueList.Item}" varStatus="itemStatus">
			<c:set var="accId" value="acc-${cms.element.id}-${itemStatus.index}" />
			<div class="${cms:lookup(fn:length(content.valueList.Item), '1:col-xs-12|2:col-sm-6|3:col-sm-4|4:col-md-3 col-sm-6|5:col-md-2 col-sm-6|6:col-md-2 col-sm-4')}">				
				<div class="tag-box tag-box-v2" style="height:100%;">
					<h4 ${item.rdfa.Headline}>${item.value.Headline}</h4>
					<div id="${accId}" class="panel-group acc-v1">
						<c:set var="isFirst" value="true" />
						<c:forEach var="topicItem" items="${item.valueList.Topic}" varStatus="tabStatus">
							<c:set var="tabId" value="tab-${cms.element.id}-${itemStatus.index}-${tabStatus.index}" />
							<c:set var="pageLink" value="${topicItem.value.PageLink}" />
							<c:set var="topic" value="${topicGrabber.topicContent[pageLink]}" />
							<c:set var="hasTeaser" value="${(not topicLink.value.AltTeaser.isEmptyOrWhitespaceOnly) or ((not empty topic) && topic.value.Teaser.isSet)}" />
							<c:set var="startOpen">
								${(hasTeaser and cms.element.settings['showteaser'] and isFirst)?"in":""}
							</c:set>
							<div class="panel panel-default">
								<div class="panel-heading">
									<h4 class="panel-title panel-title-documentation">
										<c:if test="${hasTeaser}">
											<a style="float:right;" class="accordion-toggle collapsed" 
											   href="#${tabId}" 
											   data-parent="#${accId}" 
											   data-toggle="collapse"
											   title="Show topic teaser"> 
												<span class="glyphicon glyphicon-plus"></span>
											</a>
										</c:if>
										<a href="<cms:link>${pageLink}</cms:link>">${topicItem.value.AltHeading.isEmptyOrWhitespaceOnly ? cms.vfs.property[pageLink]["Title"] : topicItem.value.AltHeading}</a>
									</h4>
								</div>
								<div id="${tabId}" class="panel-collapse collapse ${startOpen}">
									<div class="panel-body panel-body-documentation">
										<a href="<cms:link>${pageLink}</cms:link>" title="Go to the topic">
										<c:choose>
										<c:when test="${hasTeaser}">
											${topicItem.value.AltTeaser.isEmptyOrWhitespaceOnly ? topic.value.Teaser : topicItem.value.AltTeaser}
										</c:when>
										<c:otherwise>
											<em>No teaser available</em>
										</c:otherwise>
										</c:choose>
										</a>
									</div>
								</div>
							</div>
							<c:set var="isFirst" value="false" />
						</c:forEach>
					</div>
				</div>
			</div>
		</c:forEach>	
	</div>

</div>

</cms:formatter>
