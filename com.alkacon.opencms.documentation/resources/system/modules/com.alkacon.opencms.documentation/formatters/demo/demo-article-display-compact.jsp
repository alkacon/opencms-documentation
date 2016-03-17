<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content">
<div>
	<h3><a href="<cms:link>${content.filename}</cms:link>">${content.value.Title}</a></h3>
</div>
</cms:formatter>