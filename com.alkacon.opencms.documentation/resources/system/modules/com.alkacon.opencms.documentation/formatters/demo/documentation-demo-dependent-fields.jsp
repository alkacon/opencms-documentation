<%@page taglibs="cms" %>
<cms:formatter var="content">
<div class="tag-box tag-box-v4">
	<cms:img src="${content.value.Image}" height="100" width="1000" scaleType="2" cssclass="img-responsive"/>
	Copyright notice: <em>${content.value.CopyText}</em>
</div>
</cms:formatter>