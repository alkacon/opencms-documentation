<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
	<div class="tag-box tag-box-v2">
		<h4 class="heading">Autocorrect content</h4>
		<c:choose>
		<c:when test="${not content.value.Folder.isEmptyOrWhitespaceOnly || not content.value.Type.isEmptyOrWhitespaceOnly}">
			<p>
				content-type: <strong>${content.value.Type}</strong>
			</p>
			<p>
				folder: <strong>${content.value.Folder}</strong>
			</p>
			<button class="btn btn-default" id="go-${cms.element.id}">
				Go!
			</button>
			<div id="result-${cms.element.id}"></div>
			<script type="text/javascript">
				$('button#go-${cms.element.id}').click(function() {
				   $('button#go-${cms.element.id}').attr("disabled");
				   $('button#go-${cms.element.id}').html("correcting ...");
				   $('div#result-${cms.element.id}').load("<cms:link>dynamically-loaded/executeAutoCorrectContent.jsp?folder=${content.value.Folder}&typeName=${content.value.Type}</cms:link>", function() {
				       $('button#go-${cms.element.id}').html("Done.");
					   $('div#result-${cms.element.id}').prepend("<strong>Result:</strong> ");
				   });
				});
			</script>
		</c:when>
		<c:otherwise>
			Please select a folder and a type.
		</c:otherwise>
		</c:choose>
	</div>
</cms:formatter>