<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="org.opencms.file.CmsObject, org.opencms.file.CmsResource" %>
<cms:formatter var="content">
	<div class="documentation-demo-source">
		<c:set var="showSource" value="${((cms.element.settings['display'] eq 'linkandsource') or (cms.element.settings['display'] eq 'source'))?true:false}" />
		<c:set var="showLink" value="${((cms.element.settings['display'] eq 'linkandsource') or (cms.element.settings['display'] eq 'link'))?true:false}" />
		<c:choose>
		<%-- ONLINE RENDERING --%>
		<c:when test="${cms.isOnlineProject}">
			<%-- Get Source for online mode --%>
			<c:choose>
				<c:when test="${content.value.Online.exists}">
					<c:set var="canShowOnline" value="${true}" />
					<c:set var="source" value="${content.value.Online}" />
				</c:when>
				<c:otherwise>
					<c:if test="${content.value.Offline.exists}">
						<c:set var="source" value="${content.value.Offline}" />
						<c:set var="canShowOnline" value="${not (source.value.ContentEditor.exists and source.value.SitemapEditor.exists)}" />
					</c:if>
				</c:otherwise>
			</c:choose>

			<%-- Render source if possible --%>
			<c:choose>
				<c:when test="${canShowOnline}">
					<c:set var="heightSetting" value="${cms.element.settings['heightonline']}" />
					<c:set var="sourceHeight">
						<c:if test="${heightSetting > 0}" >
							height="${heightSetting}"
						</c:if>
					</c:set>
					<c:choose>
						<c:when test="${source.value.Image.isSet}">
							<c:if test="${showLink}">
								<div class="documentation-source-link">${source.value.Image.value.Link}</div>
							</c:if>
							<c:if test="${showSource}">
								<div ${sourceHeight}>
									<cms:img src="${source.value.Image.value.Image}" cssclass="img-responsive" />
								</div>
							</c:if>
						</c:when>
						<c:when test="${source.value.SourceCode.isSet}">
							<c:set var="sourcecode">${source.value.SourceCode}</c:set>
							<c:set var="resource" value="${cms.vfs.resource[sourcecode]}"/>
							<c:set var="cmsObject" value="${cms.vfs.cmsObject}" />
							<%
								CmsObject cmsObject = (CmsObject) pageContext.getAttribute("cmsObject");
								CmsResource resource = (CmsResource) pageContext.getAttribute("resource");
								pageContext.setAttribute("code", new String(cmsObject.readFile(resource).getContents(), "UTF-8"));
							%>
							<c:if test="${showLink}">
								<div class="documentation-source-link">${source.value.SourceCode}</div>
							</c:if>
							<c:if test="${showSource}">
								<div ${sourceHeight}><pre><code><c:out value="${code}" escapeXml="true"/></code></pre></div>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${showLink}">
								<div class="documentation-source-link">
									<c:if test="${source.value.ContentEditor.isSet}">
										${source.value.ContentEditor}
									</c:if>
									<c:if test="${source.value.SitemapEditor.isSet}">
										${source.value.SitemapEditor}
									</c:if>
									<c:if test="${source.value.Explorer.isSet}">
										${source.value.Explorer}
									</c:if>
								</div>
							</c:if>
							<%-- Show nothing online --%>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:when test="${content.value.Offline.exists}">
					<div class="alert alert-info" role="alert">The content is only visible offline.</div>
				</c:when>
				<c:otherwise>
					<%-- Show nothing online --%>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${content.value.Offline.exists}">
					<c:set var="source" value="${content.value.Offline}" />
				</c:when>
				<c:otherwise>
					<c:set var="source" value="${content.value.Online}" />
				</c:otherwise>
			</c:choose>
			<c:choose>
			<c:when test="${not source.exists}">
				<div class="alert alert-info" role="alert">There is no content configured. Please add a content.</div>
			</c:when>
			<c:otherwise>
					<c:set var="heightSetting" value="${cms.element.settings['heightoffline']}" />
					<c:set var="sourceHeight">
						<c:if test="${heightSetting > 0}" >
							height="${heightSetting}"
						</c:if>
					</c:set>
				<c:choose>
					<c:when test="${source.value.SourceCode.isSet}">
						<c:if test="${showLink || showSource}">
							<c:set var="id">${source.value.SourceCode.toResource.structureId}</c:set>
							<c:set var="link"><cms:link>/workplace#!editor/!!resourceId::${id}!!plainText::true!!backLink::%23</cms:link></c:set>
						</c:if>
						<c:if test="${showLink}">
							<div class="documentation-source-link"><a target="_blank" href="${link}">${source.value.SourceCode}</a></div>
						</c:if>
						<c:if test="${showSource}">
							<iframe class="opencms-documentation-source" src="${link}" onload="this.style.display='block';" width="100%" ${sourceHeight}></iframe>
						</c:if>
					</c:when>
					<c:when test="${source.value.ContentEditor.isSet}">
						<c:if test="${showLink || showSource}">
							<c:set var="id">${source.value.ContentEditor.toResource.structureId}</c:set>
							<c:set var="link"><cms:link>/workplace#!editor/!!resourceId::${id}!!plainText::false!!backLink::%23</cms:link></c:set>
						</c:if>
						<c:if test="${showLink}">
							<div class="documentation-source-link"><a target="_blank" href="${link}">${source.value.ContentEditor}</a></div>
						</c:if>
						<c:if test="${showSource}">
							<div class="xscroll scroll-left" width="100%">
								<iframe class="opencms-documentation-source contenteditor" src="${link}" onload="this.style.display='block';" ${sourceHeight}></iframe>
							</div>
						</c:if>
					</c:when>
					<c:when test="${source.value.SitemapEditor.isSet}">
						<c:set var="sitemapEditorLink">
							<cms:link>/system/workplace/commons/sitemap.jsp</cms:link>
						</c:set>
						<c:if test="${showLink}">
							<div class="documentation-source-link"><a target="_blank" href="${sitemapEditorLink}?path=${source.value.SitemapEditor}">${source.value.SitemapEditor}</a></div>
						</c:if>
						<c:if test="${showSource}">
							<div class="xscroll scroll-left">
								<iframe class="opencms-documentation-source contenteditor" src="${sitemapEditorLink}?path=${source.value.SitemapEditor}&closefunction=top.cms_ade_closeEditorDialog()" onload="this.style.display='block';" ${sourceHeight}></iframe>
							</div>
						</c:if>
					</c:when>
					<c:when test="${source.value.Explorer.isSet}">
						<c:if test="${showLink || showSource}">
							<c:set var="res" value="${source.value.Explorer.toResource}" />
							<c:set var="isSameSite" value="${fn:startsWith(res.rootPath, cms.requestContext.siteRoot)}" />
							<c:set var="link"><cms:link>/workplace#!explorer/${res.structureId}!!${isSameSite ? cms.requestContext.siteRoot : ''}!!${res.sitePath}!!backLink::%23</cms:link></c:set>
						</c:if>
						<c:if test="${showLink}">
							<div class="documentation-source-link"><a target="${isSameSite ?  '_blank' : '_self'}" href="${link}">${source.value.Explorer}</a></div>
						</c:if>
						<c:if test="${showSource && isSameSite}"><%-- Problems with site switching if it's not the same site. --%>
							<div class="xscroll scroll-left">
								<iframe class="opencms-documentation-source explorer" src="${link}" onload="this.style.display='block';" ${sourceHeight}></iframe>
							</div>
						</c:if>
					</c:when>
					<c:when test="${source.value.Image.isSet}">
						<c:set var="image" value="${source.value.Image}" />
						<c:if test="${showLink}">
							<c:set var="showType">${image.value.Show}</c:set>
							<c:set var="originalLink" value="${image.value.Link}" />
							<c:choose>
							<c:when test="${showType eq 'contenteditor'}">
								<c:set var="id">${originalLink.toResource.structureId}</c:set>
								<c:set var="link"><cms:link>/workplace#!editor/!!resourceId::${id}!!plainText::false!!backLink::%23</cms:link></c:set>
							</c:when>
							<c:when test="${showType eq 'sitemapeditor'}">
								<c:set var="link"><cms:link>/system/workplace/commons/sitemap.jsp?path=${originalLink}"</cms:link></c:set>
							</c:when>
							<c:otherwise>
							</c:otherwise>
							</c:choose>
							<div class="documentation-source-link"><a target="_blank" href="${link}">${source.value.Image.value.Link}</a></div>
						</c:if>
						<c:if test="${showSource}">
							<div ${heightSetting}>
								<cms:img src="${image.value.Image}" cssclass="img-responsive" />
							</div>
						</c:if>
					</c:when>
				</c:choose>
			</c:otherwise>
			</c:choose>
		</c:otherwise>
		</c:choose>
	</div>
</cms:formatter>