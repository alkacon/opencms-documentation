<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="cms,c,fmt,fn" %>
<cms:formatter var="content">
<div>
	<c:set var="docuBranch"><cms:property name="opencms.documentation.branch" file="search"/></c:set>
	${cms.enableReload}
	<c:set var="isEditor">
		<cms:property name="opencms.documentation.editor" file="search" default="false" />
	</c:set>
	<c:set var="openCmsVersion">
		<cms:property name="opencms.documentation.version" file="search" />
	</c:set>
	<c:if test="${not cms.isOnlineProject and isEditor and cms.vfs.exists['/documentation-editor-tools/']}">
		<div class="alert alert-info">
			Edit me to change the topic's metadata.
		</div>
		<c:set var="todoList" value="${content.value.StatusMetaData.value.Todos.valueList.Todo}" />
		<c:if test="${not empty todoList}">
			<div class="alert alert-block alert-info">
				<h4>TODOs</h4>
				<ul>
					<c:forEach var="todo" items="${todoList}">
						<li>${todo}</li>
					</c:forEach>
				</ul>
			</div>
		</c:if>
	</c:if>
	<c:if test="${content.value.NewInVersion.exists || content.value.NewInDocuVersion.exists || content.value.RevisedForVersion.exists}">
		<div class="topic-status-tags">
			<c:if test="${not empty docuBranch}">
				<a id="documentation-github-links-show" class="pull-left github-links-switcher" title="Show links for editing contents on GitHub."><span class="glyphicon glyphicon-edit"></span>&nbsp;Show GitHub edit links</a>
				<a id="documentation-github-links-hide" class="pull-left github-links-switcher active" title="Hide links for editing contents on GitHub."><span class="glyphicon glyphicon-edit"></span>&nbsp;Hide GitHub edit links</a>
			</c:if>
			<div class="topic-status-tags-inner">
				<c:if test="${content.value.NewInVersion.exists}">
					<span class="label label-info">In OpenCms since: ${content.value.NewInVersion}</span>
				</c:if>
				<c:if test="${isEditor && content.value.NewInDocuVersion.exists}">
					<span class="label label-default">Documented since: ${content.value.NewInDocuVersion}</span>
				</c:if>
				<c:if test="${isEditor && (content.value.RevisedForVersion.exists || content.value.NewInDocuVersion.exists)}">
					<span class="label label-orange">Latest revision for: ${content.value.RevisedForVersion.exists ? content.value.RevisedForVersion : content.value.NewInDocuVersion}</span>
				</c:if>
				<c:if test="${not empty openCmsVersion}">
					<span class="label label-success">Valid for OpenCms: ${openCmsVersion}</span>
				</c:if>
			</div>
		</div>
	</c:if>
	
	<c:if test="${not empty docuBranch}">
		<a href="https://github.com/alkacon/opencms-documentation/blob/${docuBranch}/com.alkacon.opencms.documentation.content/resources/${content.filename}" target="_blank" title="Edit topic content on GitHub" class="glyphicon glyphicon-edit pull-right github-link"></a>
	</c:if>
	
	<div class="tag-box tag-box-v3" ${content.rdfa.Overview}>${content.value.Overview}</div>
	<c:set var="relatedLinks" value="${content.subValueList.RelatedLinks}" />
	<c:if test="${cms:getListSize(relatedLinks) > 0}">
		<div class="related-links margin-bottom-30">
			<h5>Related links</h5>
			<ul>
				<c:forEach var="linkItem" items="${relatedLinks}">
					<c:choose>
						<c:when test='${linkItem.name eq "Link"}'>
							<c:set var="link" value="${linkItem}" />
							<c:set var="uri"><cms:link>${link.value.URI}</cms:link></c:set>
							<li>
								<a href="${uri}">${link.value.LinkText.exists?link.value.LinkText:uri}</a>
								<c:if test="${link.value.LinkDescription.exists}">
									<div class="link-description">${link.value.LinkDescription}</div>
								</c:if>
							</li>
						</c:when>
						<c:otherwise>
						<li style="list-style-type:none;">
							<c:if test="${linkItem.value.Title.exists}">
								<h6>${linkItem.value.Title}</h6>
							</c:if>
							<c:if test="${linkItem.value.Description.exists}">
								<div class="link-description">${linkItem.value.Description}</div>
							</c:if>
								<ul>
									<c:forEach var="link" items="${linkItem.valueList.Link}">
										<c:set var="uri"><cms:link>${link.value.URI}</cms:link></c:set>
								<li>
									<a href="${uri}">${link.value.LinkText.exists?link.value.LinkText:uri}</a>
									<c:if test="${link.value.LinkDescription.exists}">
										<div class="link-description">${link.value.LinkDescription}</div>
									</c:if>
								</li>
									</c:forEach>
								</ul>
							<c:if test="${linkItem.value.ListInfo.exists}">
								<div class="link-description">${linkItem.value.ListInfo}</div>
							</c:if>
						</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ul>
		</div>
	</c:if>
</div>
</cms:formatter>