<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" taglibs="c,cms,fn" %>
<cms:formatter var="con" rdfa="rdfa">
	<div>
		<div class="headline"><h3 ${rdfa.Title}><c:out value="${con.value.Title}" escapeXml="false" /></h3></div>
		<c:set var="folder">
			<c:choose>
			<c:when test="${fn:startsWith(param.folder,'/system') or fn:startsWith(param.folder,'/shared')}">
				${param.folder}
			</c:when>
			<c:otherwise>
				${cms.requestContext.siteRoot}${param.folder}
			</c:otherwise>
			</c:choose>
		</c:set>
		<%-- Define a Solr query --%>
		<c:set var="solrQuery">fq=parent-folders:"${folder}"&fq=type:${param.type}&rows=${param.count}&sort=lastmodified desc</c:set>
		<%-- Define a create path --%>
		<c:set var="createPath">${param.folder}</c:set>
		<%-- Collect the resources --%>
		<cms:contentload collector="byContext" param='${solrQuery}|createPath=${createPath}article_%(number).xml' 
		                 preload="true" >
			<cms:contentinfo var="info" />
			<c:choose>
			<c:when test="${info.resultSize > 0}">
				<cms:contentload editable="true">
					<cms:contentaccess var="content" />
					<div>
						<h4><a href="<cms:link>${content.filename}</cms:link>">${content.value.Title}</a></h4>
						<hr />
					</div>
				</cms:contentload>
			</c:when>
			<c:otherwise>
				Nothing found for query:<br/><em>${solrQuery}</em>
			</c:otherwise>
			</c:choose>
		</cms:contentload>
	</div>
</cms:formatter>