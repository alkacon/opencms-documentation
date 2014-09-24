<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
	<div class="tag-box tag-box-v2">
		<c:choose>
		<c:when test="${cms.edited}">
			${cms.enableReload}
			<h4 class="headline">
				Content sanitizer
			</h4>
			Content has been edited. Please reload.
		</c:when>
		<c:when test="${not content.value.Folder.isEmptyOrWhitespaceOnly || not content.value.Type.isEmptyOrWhitespaceOnly}">
			<h4 class="heading"><small>Content sanitizer for</small> <em>${content.value.Type}</em></h4>
			<div class="margin-bottom-20">
				<c:forEach var="folder" items="${content.valueList.Folder}">
					folder: <strong>${folder}</strong><br />
				</c:forEach>
			</div>
			<div>
				<button class="btn btn-default" id="go-${cms.element.id}">
					Autocorrect contents!
				</button>
				<button class="btn btn-default" id="delete-${cms.element.id}">
					Delete unused!
				</button>
			</div>
			<div id="result-${cms.element.id}"></div>
			<c:set var="folderParams"></c:set>
				<c:forEach var="folder" items="${content.valueList.Folder}">
					<c:set var="folderParams">${folderParams}&folder=${folder}</c:set>
				</c:forEach>
			<script type="text/javascript">
				$('button#go-${cms.element.id}').click(function() {
				   $('button#go-${cms.element.id}').attr("disabled");
				   $('button#go-${cms.element.id}').html("correcting ...");
				   $('div#result-${cms.element.id}').load("<cms:link>dynamically-loaded/executeAutoCorrectContent.jsp?typeName=${content.value.Type}${folderParams}</cms:link>", function() {
				       $('button#go-${cms.element.id}').html("Autocorrection done.");
					   $('div#result-${cms.element.id}').prepend("<br /><strong>Result:</strong> ");
				   });
				});
				$('button#delete-${cms.element.id}').click(function() {
				   $('button#delete-${cms.element.id}').attr("disabled");
				   $('button#delete-${cms.element.id}').html("deleting ...");
				   $('div#result-${cms.element.id}').load("<cms:link>dynamically-loaded/executeDeleteContent.jsp?typeName=${content.value.Type}${folderParams}</cms:link>", function() {
				       $('button#delete-${cms.element.id}').html("Deletion done.");
					   $('div#result-${cms.element.id}').prepend("<br /><strong>Result:</strong> ");
				   });
				});
			</script>
		</c:when>
		<c:otherwise>
			<h4 class="headline">
				Content sanitizer
			</h4>
			Please select a folder and a type.
		</c:otherwise>
		</c:choose>
	</div>
</cms:formatter>