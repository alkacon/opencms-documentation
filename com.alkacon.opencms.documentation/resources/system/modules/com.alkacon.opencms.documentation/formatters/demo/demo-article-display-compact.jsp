<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content">
<c:set var="setting" value="${cms.element.setting}" />
<div>
	<h3>
		<a href="<cms:link>${content.filename}</cms:link>">
			<c:if test="${setting.showIndex.toBoolean}">${setting.index}${'. '}</c:if>
			${content.value.Title}
		</a>
	</h3>
	<c:if test="${setting.showHr.toBoolean}"><hr/></c:if>
</div>
</cms:formatter>