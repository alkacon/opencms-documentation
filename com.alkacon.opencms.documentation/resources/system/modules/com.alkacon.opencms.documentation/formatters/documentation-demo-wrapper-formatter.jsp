<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<cms:formatter var="content">
	<div class="tag-box tag-box-v4">
		<div style="height:35px;background-color:gray;">&nbsp;</div>
		<cms:container type="demo-content" name="demo-content-container" tagClass="documentation-demo-content" />
		<div style="height:35px;background-color:gray;">&nbsp;</div>
	</div>
</cms:formatter>