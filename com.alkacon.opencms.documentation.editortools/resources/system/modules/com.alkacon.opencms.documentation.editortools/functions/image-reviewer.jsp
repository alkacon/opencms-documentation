<%@page taglibs="c,cms,fn" %>
<div>
<c:choose>
<c:when test="${empty param.version}">
<h3>Enter the OpenCms version</h3>
<p>Please provide the OpenCms version for which the figures should fit.</p>
<c:set var="uri" value="${cms.requestContext.uri}" />
<c:set var="version" value="${cms.vfs.propertySearch[uri]['opencms.documentation.version']}" />
<c:if test="${empty version}">
    <c:set var="version"><cms:info property="opencms.version" /></c:set>
</c:if>
<form action="<cms:link>${uri}</cms:link>" method="get">
    <div class="form-group">
        <label for="version">OpenCms version</label>
        <input type="text" name="version" value="${version}" />
        <button type="submit" class="btn btn-default">Submit</button>
    </div>
</form>
</c:when>
<c:otherwise>
<c:set var="replaceDialog"><cms:link>/workplace/dialogs/org.opencms.ui.actions.CmsReplaceDialogAction</cms:link></c:set>
<c:set var="currentPage" value="${empty param.currentPage?0:param.currentPage}" />
<c:set var="pageSize" value="${20}" />
<c:set var="contentUpdaterLink"><cms:link>%(link.strong:/system/modules/com.alkacon.opencms.documentation.editortools/functions/dynamically-loaded/update-version.jsp:e070e350-31df-11e4-8511-d144f6bb3566)</cms:link></c:set>
<jsp:useBean id="pageFinder" class="com.alkacon.opencms.documentation.editortools.PageFinderBean">
    <% pageFinder.init(pageContext, request, response);%>
</jsp:useBean>
<div>
    <h3>
        Images to review for version ${param.version}
    </h3>
    <c:set var="siteRoot">${cms.requestContext.siteRoot}</c:set>
    <c:if test="${not fn:endsWith(siteRoot,'/')}">
        <c:set var="siteRoot">${siteRoot}/</c:set>
    </c:if>
    <c:set var="folders">${cms.element.settings['folders']}</c:set>
    <c:choose>
    <c:when test="${empty folders}">
        <c:set var="folderRestriction">"${siteRoot}"</c:set>
    </c:when>
    <c:otherwise>
        <c:set var="folderRestriction"></c:set>
        <c:forEach var="folder" items="${fn:split(folders,',')}">
            <c:set var="f">${fn:startsWith(folder,'/') ? fn:substringAfter(folder, '/') : folder}</c:set>
            <c:if test="${not fn:endsWith(f,'/')}"><c:set var="f">${f}/</c:set></c:if>
            <c:set var="folderRestriction">${folderRestriction} OR "${siteRoot}${f}"</c:set>
        </c:forEach>
        <c:set var="folderRestriction">(${folderRestriction.substring(3)})</c:set>
    </c:otherwise>
    </c:choose>
    <c:set var="queryString">fq=-version_${cms.locale}:${param.version}&fq=parent-folders:${folderRestriction}&fq=type:documentation-figure</c:set>
    <cms:contentload collector="byQuery" param='${queryString}&rows=100000000' preload="true">
        <cms:contentinfo var="info" />
        <c:set var="resultSize" value="${info.resultSize}" />
    </cms:contentload>
        <c:choose>
        <c:when test="${resultSize > 0}">
            <div class="iframe-overlay" style="display:none; z-index: 1000; margin:auto; position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; width: 100%; height:100%; border:1px solid black; background-color:rgba(0,0,0,0.8); ">
                <iframe class="iframe-dialog" style="z-index: 1001; margin:auto; position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; width: 700px; height:300px; border:1px solid black; background-color:rgba(0,0,0,0.8); " src=""></iframe>
            </div>
            <%-- <div class="waitindicator-overlay" style="cursor:wait; display:none; z-index: 2000; margin:auto; position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; width: 100%; height:100%; border:1px solid black; background-color:rgba(0,0,0,0.8); ">Please wait ...</div>  --%>

            <div style="clear:right;" class="alert alert-info">
                <a style="float:right;margin-top:4px;" class="btn btn-default" href="javascript:reloadPage();">Reload page</a>
                There are ${info.resultSize} figures that are not up to date. You see at most ${pageSize} pictures. Update them and reload the page to see more pictures.
            </div>
            <%-- TODO: Add pagination? --%>
            <cms:contentload collector="byQuery" param='${queryString}&rows=${pageSize}&start=${pagesize*currentPage}'>
                <cms:contentaccess var="content" />
                <hr />
                <div class="row">
                    <div class="col-lg-9 col-xl-9">
                        <div class="tag-box tag-box-v4">

                            <a name="fig_${fn:replace(fn:toLowerCase(content.value.Identifier)," ","_")}"></a>

                            <div class="text-center">
                                <cms:img src="${content.value.Image}" cssclass="img-fluid" />
                            </div>
                            <div>
                                <b>Fig. [<span ${content.rdfa.Identifier}>${content.value.Identifier}</span>]:</b> <span ${content.rdfa.Title}>${content.value.Title}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-xl-3">
                        <div class="well well-sm" style="text-align:center;margin: 5px;" >Current version: ${content.value.version.isSet?content.value.version:"unset"}</div>
                        <div style="text-align:center;margin: 5px;" class="update-${content.id}"><a class="btn btn-default btn-block" href='javascript:updateVersionNumber("${param.version}","${content.id}");'>Update to ${param.version}</a></div>
                        <div style="text-align:center;margin: 5px;"><a class="btn btn-default btn-block" href='javascript:showReplaceDialog("${content.value.Image.toImage.resource.structureId}");'>Replace picture</a></div>
                    </div>
                </div>
                <div>
                    <c:set var="contentId">${content.id}</c:set>
                    <c:set var="pages" value="${pageFinder.displayedOnLinks[contentId]}" />
                    <c:choose>
                    <c:when test="${empty pages}">
                        <p>The image is placed on no page.</p>
                    </c:when>
                    <c:otherwise>
                        <p>The image is placed on the pages:</p>
                        <ul>
                        <c:forEach var="page" items="${pages}">
                            <li><a href="<cms:link>${page.link}</cms:link>">${page.title}</a></li>
                        </c:forEach>
                        </ul>
                    </c:otherwise>
                    </c:choose>
                </div>
            </cms:contentload>
            <hr />
            <div style="clear:right;margin-top:20px;" class="alert alert-info">
                There are ${info.resultSize} figures that are not up to date. You see at most ${pageSize} pictures. Update them and reload the page to see more pictures.
                <a style="float:right;margin-top:-6px;" class="btn btn-default" href="javascript:reloadPage();">Reload page</a>
            </div>

            <script type="text/javascript">
                function updateVersionNumber(number, uuid) {
                    //setWaitIndicator(true);
                    $("div.update-" + uuid).html('<div class="btn btn-default btn-block" disabled="disabled">Updating ...</div>');
                    $("div.update-" + uuid).load("${contentUpdaterLink}?version=" + number + "&uuid=" + uuid
                            //, function() {setWaitIndicator(false);}
                    );
                }
                function reloadPage() {
                    window.scroll(0,0);
                    location.reload();
                }
                function showReplaceDialog(id) {
                    $("iframe.iframe-dialog").attr("src","${replaceDialog}?resources=" + id + "&contextType=0")
                    $("div.iframe-overlay").show();
                }
                function close() {
                    location.reload();
                }
                /* function setWaitIndicator(shouldSet) {
                    if(shouldSet) {
                        $("div.waitindicator-overlay").show();
                    } else {
                        $("div.waitindicator-overlay").hide();
                    }
                } */
            </script>
        </c:when>
        <c:otherwise>
            No results found.
        </c:otherwise>
        </c:choose>
</div>
</c:otherwise>
</c:choose>
</div>